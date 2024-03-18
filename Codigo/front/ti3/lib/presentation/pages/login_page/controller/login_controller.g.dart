// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginController on LoginControllerStore, Store {
  late final _$emailControllerAtom =
      Atom(name: 'LoginControllerStore.emailController', context: context);

  @override
  TextEditingController get emailController {
    _$emailControllerAtom.reportRead();
    return super.emailController;
  }

  @override
  set emailController(TextEditingController value) {
    _$emailControllerAtom.reportWrite(value, super.emailController, () {
      super.emailController = value;
    });
  }

  late final _$passwordControllerAtom =
      Atom(name: 'LoginControllerStore.passwordController', context: context);

  @override
  TextEditingController get passwordController {
    _$passwordControllerAtom.reportRead();
    return super.passwordController;
  }

  @override
  set passwordController(TextEditingController value) {
    _$passwordControllerAtom.reportWrite(value, super.passwordController, () {
      super.passwordController = value;
    });
  }

  late final _$passwordIsVisibleAtom =
      Atom(name: 'LoginControllerStore.passwordIsVisible', context: context);

  @override
  bool get passwordIsVisible {
    _$passwordIsVisibleAtom.reportRead();
    return super.passwordIsVisible;
  }

  @override
  set passwordIsVisible(bool value) {
    _$passwordIsVisibleAtom.reportWrite(value, super.passwordIsVisible, () {
      super.passwordIsVisible = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('LoginControllerStore.login', context: context);

  @override
  Future<void> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  late final _$LoginControllerStoreActionController =
      ActionController(name: 'LoginControllerStore', context: context);

  @override
  void reset() {
    final _$actionInfo = _$LoginControllerStoreActionController.startAction(
        name: 'LoginControllerStore.reset');
    try {
      return super.reset();
    } finally {
      _$LoginControllerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void togglePasswordVisibility() {
    final _$actionInfo = _$LoginControllerStoreActionController.startAction(
        name: 'LoginControllerStore.togglePasswordVisibility');
    try {
      return super.togglePasswordVisibility();
    } finally {
      _$LoginControllerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
emailController: ${emailController},
passwordController: ${passwordController},
passwordIsVisible: ${passwordIsVisible}
    ''';
  }
}
