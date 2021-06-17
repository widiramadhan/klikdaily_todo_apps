import 'package:apps_todo/model/category_model.dart';
import 'package:apps_todo/view/account_view.dart';
import 'package:apps_todo/view/add_task_view.dart';
import 'package:apps_todo/view/base_view.dart';
import 'package:apps_todo/view/category_detail_view.dart';
import 'package:apps_todo/viewmodel/category_viewmodel.dart';
import 'package:apps_todo/viewmodel/todo_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive/flutter_responsive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class HomeView extends StatefulWidget {
@override
_HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CategoryViewModel>(
      onModelReady: (data) async {
        data.getCategory(context);
      },
      builder: (context, data, child) =>  Scaffold(
        body: SafeArea(
          child: data.category == null ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () {

                            },
                            icon: Icon(
                              Icons.list,
                              size: 32,
                            ),
                          ),
                        )
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AccountView(),
                                ),
                              ).then((value) {

                              });
                            },
                            icon: Icon(
                              Icons.account_circle,
                              size: 32,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "Lists",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 32
                    ),
                  ),
                  SizedBox(height: 10,),
                  ResponsiveRow(
                    children: <Widget>[]..addAll(List<int>.generate(data.category.length, (index) => index).map((index) {
                      return ResponsiveCol(
                          margin: EdgeInsets.only(bottom: 10),
                          gridSizes: {
                            'xs': 6,
                            'sm': 4,
                            'lg': 3,
                            'xl': 3,
                          },
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CategoryDetailView(
                                          categoryId: data.category[index].categoryId,
                                          data: data.category[index],),
                                  ),
                                ).then((value) {

                                });
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(20),
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey[300]),
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Icon(
                                        data.category[index].icon,
                                        color: data.category[index].colors,
                                      ),
                                      SizedBox(height: 20,),
                                      Text(
                                        "${data.category[index].categoryName}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Text(
                                        "${data.category[index].total} Task",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16
                                        ),
                                      ),
                                    ]
                                ),
                              ),
                            )
                          ]
                      );
                    }
                    )
                  ))
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTaskView(),
              ),
            ).then((value) {

            });
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blueAccent,
        ),
      )
    );
  }

}