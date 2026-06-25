import 'package:flutter/material.dart';

class ViewModelProvider<T extends ChangeNotifier> extends InheritedNotifier<T> {
  const ViewModelProvider({
    super.key,
    required T viewModel,
    required super.child,
  }) : super(notifier: viewModel);

  static T of<T extends ChangeNotifier>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<ViewModelProvider<T>>();
    if (provider == null) {
      throw FlutterError('ViewModelProvider of type $T no se encontró en el context.');
    }
    return provider.notifier!;
  }
}
