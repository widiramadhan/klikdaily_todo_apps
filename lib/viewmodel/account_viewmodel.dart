import 'package:apps_todo/constant/viewstate.dart';
import 'package:apps_todo/helper/db_helper.dart';
import 'package:apps_todo/helper/locator.dart';
import 'package:apps_todo/model/account_model.dart';
import 'package:apps_todo/model/category_model.dart';
import 'package:apps_todo/model/todo_model.dart';
import 'package:apps_todo/repository/account_repository.dart';
import 'package:apps_todo/viewmodel/base_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountViewModel extends BaseViewModel {
  AccountRepository accountRepository = locator<AccountRepository>();
  AccountModel account;

  Future getAccount(BuildContext context) async {
    setState(ViewState.Busy);
    account = await accountRepository.getAccount(context);
    notifyListeners();
    setState(ViewState.Idle);
  }
}