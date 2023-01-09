// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Home on _Home, Store {
  late final _$currentPageAtom =
      Atom(name: '_Home.currentPage', context: context);

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$_HomeActionController =
      ActionController(name: '_Home', context: context);

  @override
  dynamic updateCurrentPage(int index) {
    final _$actionInfo =
        _$_HomeActionController.startAction(name: '_Home.updateCurrentPage');
    try {
      return super.updateCurrentPage(index);
    } finally {
      _$_HomeActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPage: ${currentPage}
    ''';
  }
}
