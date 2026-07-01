import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitEffectListener<C extends StateStreamable<S>, S, E>
    extends StatelessWidget {
  const CubitEffectListener({
    super.key,
    required this.child,
    required this.onEffect,
    required this.onClearEffect,
    required this.selectEffect,
    this.listenWhen,
  });

  final Widget child;
  final void Function(BuildContext context, E effect) onEffect;
  final void Function(BuildContext context) onClearEffect;
  final E? Function(S state) selectEffect;
  final bool Function(S previous, S current)? listenWhen;

  E? _effect(S state) => selectEffect(state);

  @override
  Widget build(BuildContext context) {
    return BlocListener<C, S>(
      listenWhen:
          listenWhen ??
          (S previous, S current) {
            final prev = _effect(previous);
            final curr = _effect(current);
            return curr != null && prev != curr;
          },
      listener: (BuildContext context, S state) {
        final effect = _effect(state);
        if (effect == null) return;
        onEffect(context, effect);
        onClearEffect(context);
      },
      child: child,
    );
  }
}
