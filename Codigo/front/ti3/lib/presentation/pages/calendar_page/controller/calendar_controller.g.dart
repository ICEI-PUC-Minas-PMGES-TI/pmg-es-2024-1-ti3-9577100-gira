// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CalendarController on CalendarControllerStore, Store {
  late final _$feedItemsAtom =
      Atom(name: 'CalendarControllerStore.feedItems', context: context);

  @override
  List<String> get feedItems {
    _$feedItemsAtom.reportRead();
    return super.feedItems;
  }

  @override
  set feedItems(List<String> value) {
    _$feedItemsAtom.reportWrite(value, super.feedItems, () {
      super.feedItems = value;
    });
  }

  @override
  String toString() {
    return '''
feedItems: ${feedItems}
    ''';
  }
}
