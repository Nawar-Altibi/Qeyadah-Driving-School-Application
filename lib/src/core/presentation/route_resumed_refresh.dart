import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteResumedRefresh extends StatefulWidget {
  const RouteResumedRefresh({
    super.key,
    required this.child,
    required this.onInitialLoad,
    required this.onResumed,
  });

  final Widget child;
  final VoidCallback onInitialLoad;
  final VoidCallback onResumed;

  @override
  State<RouteResumedRefresh> createState() => _RouteResumedRefreshState();
}

class _RouteResumedRefreshState extends State<RouteResumedRefresh> {
  bool _didInitialLoad = false;
  bool _wasOnChildRoute = false;
  String? _ownerLocation;
  GoRouter? _router;
  VoidCallback? _routerListener;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _didInitialLoad = true;
      _ownerLocation = CoreNavigator.getCurrentLocation(context: context);
      widget.onInitialLoad();
      _attachRouterListener();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didInitialLoad && _router == null) {
      _attachRouterListener();
    }
  }

  void _attachRouterListener() {
    if (!mounted) return;

    final router = GoRouter.of(context);
    if (_router == router) return;

    if (_router != null && _routerListener != null) {
      _router!.routerDelegate.removeListener(_routerListener!);
    }

    _router = router;
    _routerListener = _onRouterChanged;
    router.routerDelegate.addListener(_routerListener!);
  }

  void _onRouterChanged() {
    if (!mounted || !_didInitialLoad || _ownerLocation == null) return;

    final location = CoreNavigator.getCurrentLocation(context: context);
    if (location != _ownerLocation) {
      _wasOnChildRoute = true;
      return;
    }

    if (_wasOnChildRoute) {
      _wasOnChildRoute = false;
      widget.onResumed();
    }
  }

  @override
  void dispose() {
    if (_router != null && _routerListener != null) {
      _router!.routerDelegate.removeListener(_routerListener!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
