// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_user_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NewUserController on NewUserControllerStore, Store {
  late final _$codeControllerAtom =
      Atom(name: 'NewUserControllerStore.codeController', context: context);

  @override
  TextEditingController get codeController {
    _$codeControllerAtom.reportRead();
    return super.codeController;
  }

  @override
  set codeController(TextEditingController value) {
    _$codeControllerAtom.reportWrite(value, super.codeController, () {
      super.codeController = value;
    });
  }

  late final _$passwordControllerAtom =
      Atom(name: 'NewUserControllerStore.passwordController', context: context);

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

  late final _$userTypeAtom =
      Atom(name: 'NewUserControllerStore.userType', context: context);

  @override
  UserTypeEnum get userType {
    _$userTypeAtom.reportRead();
    return super.userType;
  }

  @override
  set userType(UserTypeEnum value) {
    _$userTypeAtom.reportWrite(value, super.userType, () {
      super.userType = value;
    });
  }

  late final _$classroomsAtom =
      Atom(name: 'NewUserControllerStore.classrooms', context: context);

  @override
  ObservableList<ClassroomModel> get classrooms {
    _$classroomsAtom.reportRead();
    return super.classrooms;
  }

  @override
  set classrooms(ObservableList<ClassroomModel> value) {
    _$classroomsAtom.reportWrite(value, super.classrooms, () {
      super.classrooms = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('NewUserControllerStore.init', context: context);

  @override
  Future<void> init(UserTypeEnum type) {
    return _$initAsyncAction.run(() => super.init(type));
  }

  @override
  String toString() {
    return '''
codeController: ${codeController},
passwordController: ${passwordController},
userType: ${userType},
classrooms: ${classrooms}
    ''';
  }
}
