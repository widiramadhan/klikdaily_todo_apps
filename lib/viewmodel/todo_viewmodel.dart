import 'package:apps_todo/constant/viewstate.dart';
import 'package:apps_todo/helper/db_helper.dart';
import 'package:apps_todo/model/category_model.dart';
import 'package:apps_todo/model/todo_model.dart';
import 'package:apps_todo/viewmodel/base_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TodoViewModel extends BaseViewModel {
  DBHelper dbHelper;

  Future<bool> addTodo(String title, String note, String date, int categoryId, BuildContext context) async {
    setState(ViewState.Busy);
    dbHelper = DBHelper();
    var success = await dbHelper.addTodo(TodoModel(
        todo_id: null,
        category_id: categoryId,
        title: title,
        note: note,
        date: date,
        status: 1
      )
    );
    if(!success){
      return false;
    }
    setState(ViewState.Idle);
    return true;
  }

  Future<bool> updateStatus(int todo_id, int status, BuildContext context) async {
    setState(ViewState.Busy);
    dbHelper = DBHelper();
    var success = await dbHelper.updateStatus(todo_id, status);
    if(!success){
      return false;
    }
    setState(ViewState.Idle);
    return true;
  }
}