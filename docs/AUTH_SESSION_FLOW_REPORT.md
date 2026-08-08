# تقرير فلو المصادقة والجلسة (Auth Session Flow)

تاريخ التحديث: 2026-08-07

## 1) المشكلة اللي ظهرت عندك

كل ما تطلع من التطبيق (force kill / swipe away) وترجع تفتحه، بترجع على صفحة تسجيل الدخول من الصفر — حتى لو سجّلت دخول قبل شوي.

**السبب الجذري:** بعد إصلاح تاجيل timeouts اللوغن، صار حفظ الجلسة على القرص `fire-and-forget` (بدون انتظار). الذاكرة (RAM) فيها التوكنات أثناء الجلسة، بس لما تقتل التطبيق الـ RAM بتمحى، وملف الجلسة على القرص ما كان مكتمل قبل الإغلاق → cold start ما يلاقي شيء يسترجعه → الراوت يوديك على اللوغن.

الراوتر والسبلاش كانوا شغالين صح؛ المشكلة كانت **ما في جلسة محفوظة على الديسك** لتعاد استعادتها.

---

## 2) كيف المفروض يشتغل الفلو (المعيار الصحيح)

أفضل ممارسة في Flutter (ومع `flutter_secure_storage` + Hive):

| الطبقة | ماذا تُحفظ | متى تُكتب |
|--------|------------|-----------|
| الذاكرة (AuthTokenManager) | access / refresh | فور نجاح HTTP login |
| Hive (`session_json`) | بيانات المستخدم + التوكنات للـ cold start | **قبل** اعتبار اللوغن ناجحًا (await) |
| Secure Storage | التوكنات فقط | best-effort؛ ما يعلق اللوغن على Samsung |

على cold start:

1. Splash يستنى `restoreSession` يخلص.
2. نقرأ `session_json` من Hive.
3. إذا وُجدت → نرجع التوكنات للذاكرة ونعتبر المستخدم مسجّل.
4. إذا ناقصة → نحاول التوكنات من Secure Storage + `/auth/me`.
5. إذا فشل كل شيء → صفحة اللوغن.

---

## 3) كيف عاملها muntaji - Copy (مرجع عملي)

المسار: `muntaji - Copy/lib/src/features/auth/`

### بعد اللوغن (مهم)

في `AuthRepositoryImpl.login`:

```dart
await _localDataSource.saveSession(model);  // ينتظر الكتابة
return right(model.toEntity);
```

نفس الشيء بعد `register` / `verifyOtp` / `initVisitorMode`.

يعني: **ما بيرجع نجاح للـ UI إلا بعد ما ينحفظ الـ session محليًا.**

### التخزين المحلي

`AuthLocalDataSourceImpl`:

- يحتفظ بـ `_memorySession` في الرام.
- يكتب JSON تحت مفتاح مثل `user_session` في Hive.
- عند القراءة: إذا الديسك فاضي/فشل، يرجع الـ memory كـ fallback لنفس العملية.

### التوكنات للـ API

`AuthTokenCoordinator.persist` → `AuthTokenManager.setTokens` — مصدر الحقيقة للـ Bearer عبر Coore interceptor.

### الاستعادة

`getPersistedSession()` يقرأ من المحلي فقط (بدون شبكة إلزامية):

```dart
final local = await _localDataSource.getSession();
return local.map((model) => model?.toEntity);
```

### التوجيه

`AppNavigationConfig` يستدعي `restoreSession()` عند الإنشاء، والـ `_redirect` ينتظر اكتمال الاستعادة قبل ما يقرر Login vs Home — نفس فكرة قيادة.

---

## 4) فلو تطبيق قيادة (Qeyadah) بالتفصيل

### 4.1 مكوّنات رئيسية

| الملف | الدور |
|-------|------|
| `auth_session_cubit.dart` | حالة الجلسة + `login` / `restoreSession` / `logout` |
| `app_navigation_config.dart` | `go_router` + `_redirect` + استدعاء `restoreSession` عند الإقلاع |
| `auth_repository_impl.dart` | تنسيق HTTP + حفظ/قراءة الجلسة |
| `auth_local_data_source.dart` | Hive `session_json` + كاش ذاكرة |
| `auth_token_manager.dart` (coore) | توكنات الذاكرة + Secure Storage |
| `auth_token_coordinator.dart` | جسر التطبيق → AuthTokenManager |
| `nosql_database_imp.dart` | فتح/قراءة/كتابة صناديق Hive |

### 4.2 تسلسل الإقلاع (Cold Start)

```
main_common
  → Core DI (Hive.init, AuthTokenManager, …)
  → AppNavigationConfig()
       ├─ AuthSessionCubit.restoreSession()   // يبدأ فورًا
       └─ SplashCubit (انتهاء الأنيميشن)

restoreSession (حتى 15 ثانية)
  → GetPersistedSessionUseCase
  → AuthRepositoryImpl.getPersistedSession()
       1. ensureInterceptorTokensFromLegacyStorage (مفاتيح قديمة اختيارية)
       2. readSession() من Hive session_json (+ memory fallback)
       3a. إن وُجدت جلسة صالحة → persist tokens في الذاكرة → return session
       3b. إن ناقصة → secure tokens + GET /auth/me ثم حفظ Hive

go_router._redirect
  !splashFinished                 → يبقى على Splash
  !hasCompletedInitialRestore     → يبقى على Splash
  !isAuthenticated                → LoginScreen
  authenticated + guest path      → Home حسب الدور (طالب / مدرب)
```

`isAuthenticated` = وجود `ApiState.succeeded` فيها `accessToken` غير فارغ.

### 4.3 تسلسل تسجيل الدخول (Login)

```
LoginScreen → AuthSessionCubit.login
  → FutureEitherTimeout (25s)
  → LoginUseCase → AuthRepositoryImpl.login
       1. POST /auth/login  (isAuthorized: false)
       2. فحص canUseMobileApp (STUDENT / INSTRUCTOR)
       3. AuthTokenCoordinator.persist → ذاكرة فورية
          (Secure Storage fire-and-forget حتى لا يعلّق OEM)
       4. await saveSession(Hive) مع timeout + retries قصيرة   ← الإصلاح
       5. return Right(session)
  → Cubit يصدر succeeded + AuthSessionEffectLoginSucceeded
  → redirect يودّي على الـ Home
  → push notifications تبدأ بعد النجاح (مش قبل اللوغن)
```

### 4.4 تسلسل تسجيل الخروج

```
logout / logoutAll
  → تفريغ الحالة فورًا (UI يروح على اللوغن)
  → clearTokens + clearSession محليًا
  → طلبات الريموت best-effort مع timeout
```

---

## 5) مقارنة سريعة: قيادة قبل الإصلاح × muntaji × بعد الإصلاح

| النقطة | قيادة (قبل) | muntaji | قيادة (بعد الإصلاح) |
|--------|-------------|---------|---------------------|
| انتظار حفظ Hive بعد اللوغن | لا (unawaited) | نعم `await saveSession` | نعم + retries قصيرة |
| كاش ذاكرة للجلسة | لا | نعم `_memorySession` | نعم |
| Secure Storage على مسار اللوغن الحرج | كان يمنع أحيانًا؛ صار unawaited | عبر AuthTokenManager | unawaited (آمن من التعليق) |
| Cold start إذا فشل `/me` | يمسح التوكنات دائمًا | يعتمد محليًا أساسًا | يمسح فقط عند `AuthFailure` |
| فشل فتح Hive مرة واحدة | يتخزّن Left ويُمنع أي حفظ لاحق | — | يعيد المحاولة (لا يثبّت Left) |

---

## 6) ما الذي تغيّر في الكود لإصلاح المشكلة

1. **`auth_repository_impl.dart`**
   - إرجاع `await` لحفظ `session_json` قبل اعتبار اللوغن ناجحًا.
   - retries سريعة (~2 ثانية مجموعًا) ثم خلفية إضافية إذا لزم.
   - timeout حفظ الجلسة 12s (أعلى من وقت فتح الصندوق ~10s).
   - عند استعادة من التوكنات: عدم مسح التوكنات إلا إذا فشل `/me` بـ `AuthFailure`.

2. **`auth_local_data_source.dart`**
   - `_memorySession` مثل muntaji.

3. **`nosql_database_imp.dart`**
   - إذا فشل `initialize`، يصفّر الكاش ليُعاد فتح الصندوق لاحقًا.

Secure Storage يبقى غير حاجب للوغن (مشاكل Samsung / Keystore).

---

## 7) كيف تختبر الإصلاح

1. `flutter run` كامل (مو hot restart فقط).
2. سجّل دخول وانتظر يدخل الـ Home.
3. اسحب التطبيق من الـ Recents (force kill).
4. افتح التطبيق من جديد.
5. **المتوقع:** Splash قصيرة ثم Home مباشرة — **بدون** صفحة لوغن.
6. سجّل خروج ثم force kill ثم افتح → يجب أن يظهر اللوغن (هذا صحيح).

إذا ظهر اللوغن بعد الخطوة 5، افتح اللوغز وابحث عن فشل `saveSession` / Hive init وقت اللوغن.

---

## 8) مراجع من الإنترنت (ممارسات عامة)

- حفظ **التوكنات** في `flutter_secure_storage` (Keystore / Keychain).
- حفظ **بيانات الجلسة الأكبر** في Hive / local DB.
- على الإقلاع: اقرأ المحلّي أولًا، ثم جدّد من الشبكة عند الحاجة.
- لا تعتمد على RAM وحدها للبقاء بعد الإغلاق الإجباري.
- امسح التوكنات عند 401 حقيقي / logout فاشل موثّق، وليس عند أي خطأ شبكة عابر.

---

## 9) خلاصة جملة واحدة

الفلو نفسه (Splash → restore → redirect) كان سليمًا؛ اللي انكسر هو **ديمومة الكتابة على الديسك بعد اللوغن**. صرنا زي muntaji: نضمن حفظ Hive قبل ما نعتبر المستخدم مسجّل، مع بقاء Secure Storage غير حاجب حتى ما يرجع “تيم أوت وهمي” على أجهزة معيّنة.
