// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NotificationController on NotificationControllerStore, Store {
  late final _$messageControllerAtom = Atom(
      name: 'NotificationControllerStore.messageController', context: context);

  @override
  TextEditingController get messageController {
    _$messageControllerAtom.reportRead();
    return super.messageController;
  }

  @override
  set messageController(TextEditingController value) {
    _$messageControllerAtom.reportWrite(value, super.messageController, () {
      super.messageController = value;
    });
  }

  late final _$notificationItemsAtom = Atom(
      name: 'NotificationControllerStore.notificationItems', context: context);

  @override
  List<NotificationModel> get notificationItems {
    _$notificationItemsAtom.reportRead();
    return super.notificationItems;
  }

  @override
  set notificationItems(List<NotificationModel> value) {
    _$notificationItemsAtom.reportWrite(value, super.notificationItems, () {
      super.notificationItems = value;
    });
  }

  late final _$NotificationControllerStoreActionController =
      ActionController(name: 'NotificationControllerStore', context: context);

  @override
  void reset() {
    final _$actionInfo = _$NotificationControllerStoreActionController
        .startAction(name: 'NotificationControllerStore.reset');
    try {
      return super.reset();
    } finally {
      _$NotificationControllerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reload() {
    final _$actionInfo = _$NotificationControllerStoreActionController
        .startAction(name: 'NotificationControllerStore.reload');
    try {
      return super.reload();
    } finally {
      _$NotificationControllerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
messageController: ${messageController},
notificationItems: ${notificationItems}
    ''';
  }
}
