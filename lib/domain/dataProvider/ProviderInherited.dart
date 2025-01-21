import 'package:flutter/material.dart';

class ModelProvider<Model extends ChangeNotifier> extends InheritedNotifier {
  final Model model;
  final Widget child;
  const ModelProvider({
    super.key,
    required this.model,
    required this.child,
  }) : super(child: child, notifier: model);

  static Model? watch<Model extends ChangeNotifier>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ModelProvider<Model>>()
        ?.model;
  }

  static Model? read<Model extends ChangeNotifier>(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ModelProvider<Model>>()
        ?.widget;
    return widget is ModelProvider<Model> ? widget.model : null;
  }
}

class InheritedProvider<Model> extends InheritedNotifier {
  final Model model;
  final Widget child;
  const InheritedProvider({
    super.key,
    required this.model,
    required this.child,
  }) : super(
          child: child,
        );

  static Model? watch<Model extends ChangeNotifier>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedProvider<Model>>()
        ?.model;
  }

  static Model? read<Model extends ChangeNotifier>(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<InheritedProvider<Model>>()
        ?.widget;
    return widget is InheritedProvider<Model> ? widget.model : null;
  }
@override
  bool updateShouldNotify(InheritedProvider oldWidget) {
    return model != oldWidget.model;
  }
}

