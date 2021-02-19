// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ItemStore on _ItemStoreBase, Store {
  Computed<bool> _$isCheckComputed;

  @override
  bool get isCheck => (_$isCheckComputed ??=
          Computed<bool>(() => super.isCheck, name: '_ItemStoreBase.isCheck'))
      .value;

  final _$nameAtom = Atom(name: '_ItemStoreBase.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$checkAtom = Atom(name: '_ItemStoreBase.check');

  @override
  bool get check {
    _$checkAtom.reportRead();
    return super.check;
  }

  @override
  set check(bool value) {
    _$checkAtom.reportWrite(value, super.check, () {
      super.check = value;
    });
  }

  final _$_ItemStoreBaseActionController =
      ActionController(name: '_ItemStoreBase');

  @override
  void setName(String value) {
    final _$actionInfo = _$_ItemStoreBaseActionController.startAction(
        name: '_ItemStoreBase.setName');
    try {
      return super.setName(value);
    } finally {
      _$_ItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCheck(bool value) {
    final _$actionInfo = _$_ItemStoreBaseActionController.startAction(
        name: '_ItemStoreBase.setCheck');
    try {
      return super.setCheck(value);
    } finally {
      _$_ItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
check: ${check},
isCheck: ${isCheck}
    ''';
  }
}
