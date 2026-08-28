# Security Policy

## Reporting a vulnerability

If you discover a security issue, please **do not** open a public GitHub issue. Contact the repository owner directly with a description of the problem and steps to reproduce.

## What is safe to commit

| Item | Status |
|------|--------|
| Application source code | ✅ Public |
| Architecture docs & tests | ✅ Public |
| `.env.example` (placeholder values) | ✅ Public |
| `google-services.json` / `firebase_options.dart` (placeholders) | ✅ Public — regenerate locally via `flutterfire configure` |
| `.env.development` / `.env.staging` / `.env.production` | ❌ Never commit — contains API URLs |
| Android keystore (`.jks`) / `key.properties` | ❌ Never commit |
| Firebase Admin SDK JSON (`*-firebase-adminsdk-*.json`) | ❌ Never commit — server-only |
| Production API keys, tokens, or passwords | ❌ Never commit |

## Local development

1. Copy `.env.example` to `.env.development`, `.env.staging`, and `.env.production`.
2. Set `BASE_URL` to your backend — do not use production URLs in a public fork.
3. Run `flutterfire configure` to generate real Firebase client config on your machine only.

## Firebase client keys

Firebase API keys in mobile apps are not secret by design (they ship inside the APK/IPA). However, they **must** be restricted in the [Firebase Console](https://console.firebase.google.com/):

- **Android:** restrict by package name (`com.qeyadah.mobile`) and SHA-1 fingerprint
- **iOS:** restrict by bundle ID (`com.qeyadah.mobile`)
- Enable only the APIs you need (FCM, etc.)

## Backend responsibility

Even if an API base URL is discovered, the backend must enforce:

- Authentication on all protected endpoints
- Rate limiting and input validation
- No sensitive operations without valid tokens

The mobile app never embeds server-side secrets.

## If secrets were previously exposed

If this repository was ever public with real credentials:

1. Rotate all exposed API keys and tokens immediately
2. Invalidate demo/test accounts that were published
3. Review Firebase and backend access logs
4. Consider using `git filter-repo` to purge secrets from Git history

## Recommended GitHub settings

- Enable **two-factor authentication** on your GitHub account
- Use **branch protection** on `main` (require PR reviews, block force-push)
- Store CI secrets (keystore, env) in **GitHub Actions Secrets**, not in the repo
