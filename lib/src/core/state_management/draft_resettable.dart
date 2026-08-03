/// Implemented by any cubit that holds a multi-step "draft" (booking
/// preferences, certificate request fields, ...) so the flow's cancel/back
/// action can clear it through one consistent method name instead of each
/// feature inventing its own reset/clear naming.
mixin DraftResettable {
  void resetDraft();
}
