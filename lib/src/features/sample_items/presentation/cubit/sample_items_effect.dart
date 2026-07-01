part of 'sample_items_cubit.dart';

sealed class SampleItemsEffect {
  const SampleItemsEffect();
}

final class SampleItemsEffectShowMessage extends SampleItemsEffect {
  const SampleItemsEffectShowMessage(this.message);

  final String message;
}
