enum AccountStatus {
  active('ACTIVE'),
  blocked('BLOCKED'),
  archived('ARCHIVED');

  const AccountStatus(this.apiValue);

  final String apiValue;

  static AccountStatus fromValue(
    String? value, {
    AccountStatus fallback = AccountStatus.active,
  }) {
    if (value == null || value.isEmpty) return fallback;
    final normalized = value.trim().toUpperCase();
    return AccountStatus.values.firstWhere(
      (status) =>
          status.apiValue == normalized ||
          status.name.toUpperCase() == normalized,
      orElse: () => fallback,
    );
  }
}
