import 'package:apps_todo/constant/viewstate.dart';
import 'package:apps_todo/helper/db_helper.dart';
import 'package:apps_todo/model/category_model.dart';
import 'package:apps_todo/model/todo_model.dart';
import 'package:apps_todo/viewmodel/base_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryViewModel extends BaseViewModel {
  DBHelper dbHelper;
  List<CategoryModel> category;
  List<TodoModel> todo;


  Future getCategory(BuildContext context) async {
    setState(ViewState.Busy);

    List categoryList = List();
    //categoryList.add(["All", FontAwesomeIcons.file, Colors.blue]);
    categoryList.add(["Work", FontAwesomeIcons.suitcase, Colors.orangeAccent]);
    categoryList.add(["Music", FontAwesomeIcons.headset, Colors.deepOrange]);
    categoryList.add(["Travel", FontAwesomeIcons.plane, Colors.green]);
    categoryList.add(["Study", FontAwesomeIcons.book, Colors.purple]);
    categoryList.add(["Home", FontAwesomeIcons.home, Colors.red]);

    category = categoryList
        .asMap()
        .map((index, item) => MapEntry(
        index,
        CategoryModel(
          index,
          item[0],
          item[1],
          item[2],
          0
        )))
        .values
        .toList();
    setState(ViewState.Idle);
  }

  Future getTodoByCategoryId(int categoryId, BuildContext context) async {
    setState(ViewState.Busy);
    dbHelper = DBHelper();
    todo = await dbHelper.getTodoById(categoryId);
    notifyListeners();
    setState(ViewState.Idle);
  }
}