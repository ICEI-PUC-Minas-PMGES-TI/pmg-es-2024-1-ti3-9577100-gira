// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on HomeControllerStore, Store {
  late final _$descriptionControllerAtom =
      Atom(name: 'HomeControllerStore.descriptionController', context: context);

  @override
  TextEditingController get descriptionController {
    _$descriptionControllerAtom.reportRead();
    return super.descriptionController;
  }

  @override
  set descriptionController(TextEditingController value) {
    _$descriptionControllerAtom.reportWrite(value, super.descriptionController,
        () {
      super.descriptionController = value;
    });
  }

  late final _$imageAtom =
      Atom(name: 'HomeControllerStore.image', context: context);

  @override
  String get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(String value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  late final _$HomeControllerStoreActionController =
      ActionController(name: 'HomeControllerStore', context: context);

  @override
  void reset() {
    final _$actionInfo = _$HomeControllerStoreActionController.startAction(
        name: 'HomeControllerStore.reset');
    try {
      return super.reset();
    } finally {
      _$HomeControllerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
descriptionController: ${descriptionController},
image: ${image}
    ''';
  }
}
