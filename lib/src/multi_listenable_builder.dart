import 'package:flutter/material.dart';

/// Creates a widget that rebuilds when one of the given list of listenables changes.
class MultiListenableBuilder extends StatefulWidget {
  const MultiListenableBuilder({
    Key? key,
    required this.notifiers,
    required this.builder,
    this.child,
  }) : super(key: key);

  final List<Listenable?> notifiers;

  final Widget Function(
    BuildContext context,
    Widget? child,
  ) builder;

  final Widget? child;

  @override
  State<MultiListenableBuilder> createState() => _MultiListenableBuilderState();
}

class _MultiListenableBuilderState extends State<MultiListenableBuilder> {
  final Set<Listenable> _listenedNotifiers = {};

  @override
  void initState() {
    super.initState();
    for (var notifier in widget.notifiers) {
      if (notifier != null) {
        notifier.addListener(_handleChange);
        _listenedNotifiers.add(notifier);
      }
    }
  }

  @override
  void didUpdateWidget(MultiListenableBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    // store outdated items temporarily,
    // to avoid `Concurrent modification during iteration` error
    final Set<Listenable> itemsToRemove = {};
    for (var notifier in _listenedNotifiers) {
      // remove old notifiers
      if (!widget.notifiers.contains(notifier)) {
        notifier.removeListener(_handleChange);
        itemsToRemove.add(notifier);
      }
    }
    // remove all outdated items
    _listenedNotifiers.removeAll(itemsToRemove);
    for (var notifier in widget.notifiers) {
      if (notifier != null && !_listenedNotifiers.contains(notifier)) {
        notifier.addListener(_handleChange);
        _listenedNotifiers.add(notifier);
      }
    }
  }

  @override
  void dispose() {
    for (var notifier in _listenedNotifiers) {
      notifier.removeListener(_handleChange);
    }
    super.dispose();
  }

  void _handleChange() {
    setState(() {
      // The listenable's state is our build state, and it changed already.
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.child);
  }
}
