// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStoreBase, Store {
  late final _$loginResponseAtom =
      Atom(name: '_AuthStoreBase.loginResponse', context: context);

  @override
  BaseResponse<UserData?>? get loginResponse {
    _$loginResponseAtom.reportRead();
    return super.loginResponse;
  }

  @override
  set loginResponse(BaseResponse<UserData?>? value) {
    _$loginResponseAtom.reportWrite(value, super.loginResponse, () {
      super.loginResponse = value;
    });
  }

  late final _$logoutResponseAtom =
      Atom(name: '_AuthStoreBase.logoutResponse', context: context);

  @override
  BaseResponse<dynamic>? get logoutResponse {
    _$logoutResponseAtom.reportRead();
    return super.logoutResponse;
  }

  @override
  set logoutResponse(BaseResponse<dynamic>? value) {
    _$logoutResponseAtom.reportWrite(value, super.logoutResponse, () {
      super.logoutResponse = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_AuthStoreBase.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$selectedIndexAtom =
      Atom(name: '_AuthStoreBase.selectedIndex', context: context);

  @override
  int get selectedIndex {
    _$selectedIndexAtom.reportRead();
    return super.selectedIndex;
  }

  @override
  set selectedIndex(int value) {
    _$selectedIndexAtom.reportWrite(value, super.selectedIndex, () {
      super.selectedIndex = value;
    });
  }

  late final _$isFavoriteAtom =
      Atom(name: '_AuthStoreBase.isFavorite', context: context);

  @override
  bool get isFavorite {
    _$isFavoriteAtom.reportRead();
    return super.isFavorite;
  }

  @override
  set isFavorite(bool value) {
    _$isFavoriteAtom.reportWrite(value, super.isFavorite, () {
      super.isFavorite = value;
    });
  }

  late final _$isCheckAtom =
      Atom(name: '_AuthStoreBase.isCheck', context: context);

  @override
  bool get isCheck {
    _$isCheckAtom.reportRead();
    return super.isCheck;
  }

  @override
  set isCheck(bool value) {
    _$isCheckAtom.reportWrite(value, super.isCheck, () {
      super.isCheck = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('_AuthStoreBase.login', context: context);

  @override
  Future<dynamic> login(LoginRequestModel request) {
    return _$loginAsyncAction.run(() => super.login(request));
  }

  late final _$logoutAsyncAction =
      AsyncAction('_AuthStoreBase.logout', context: context);

  @override
  Future<dynamic> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$_AuthStoreBaseActionController =
      ActionController(name: '_AuthStoreBase', context: context);

  @override
  void setSelectedIndex(int index) {
    final _$actionInfo = _$_AuthStoreBaseActionController.startAction(
        name: '_AuthStoreBase.setSelectedIndex');
    try {
      return super.setSelectedIndex(index);
    } finally {
      _$_AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsFavorite() {
    final _$actionInfo = _$_AuthStoreBaseActionController.startAction(
        name: '_AuthStoreBase.setIsFavorite');
    try {
      return super.setIsFavorite();
    } finally {
      _$_AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsCheck() {
    final _$actionInfo = _$_AuthStoreBaseActionController.startAction(
        name: '_AuthStoreBase.setIsCheck');
    try {
      return super.setIsCheck();
    } finally {
      _$_AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loginResponse: ${loginResponse},
logoutResponse: ${logoutResponse},
errorMessage: ${errorMessage},
selectedIndex: ${selectedIndex},
isFavorite: ${isFavorite},
isCheck: ${isCheck}
    ''';
  }
}
