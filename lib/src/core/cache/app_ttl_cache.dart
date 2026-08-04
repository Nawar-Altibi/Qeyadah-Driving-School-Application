/// Simple in-memory TTL cache entry for repository-level SWR.
class AppTtlCacheEntry<T> {
  AppTtlCacheEntry({required this.value, required this.expiresAt});

  final T value;
  final DateTime expiresAt;

  bool get isFresh => DateTime.now().isBefore(expiresAt);
}

/// Keyed in-memory TTL cache used by LazySingleton repositories.
class AppTtlCache<T> {
  AppTtlCache({required this.ttl});

  final Duration ttl;
  final Map<String, AppTtlCacheEntry<T>> _entries = {};

  AppTtlCacheEntry<T>? get(String key) => _entries[key];

  T? getFresh(String key) {
    final entry = _entries[key];
    if (entry == null || !entry.isFresh) return null;
    return entry.value;
  }

  void set(String key, T value) {
    _entries[key] = AppTtlCacheEntry(
      value: value,
      expiresAt: DateTime.now().add(ttl),
    );
  }

  void invalidate([String? key]) {
    if (key == null) {
      _entries.clear();
      return;
    }
    _entries.remove(key);
  }
}
