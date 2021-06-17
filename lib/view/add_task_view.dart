import 'package:apps_todo/model/category_model.dart';
import 'package:apps_todo/view/base_view.dart';
import 'package:apps_todo/viewmodel/category_viewmodel.dart';
import 'package:apps_todo/viewmodel/todo_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class AddTaskView extends StatefulWidget {
  @override
  _AddTaskViewState createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final _txtTitleController = TextEditingController();
  final _txtNoteController = TextEditingController();

  DateTime selectedDate = DateTime.now() ;
  TimeOfDay selectedTime = TimeOfDay.now();
  var customDateFormat = DateFormat('MMMM dd');
  int categoryId;
  String categoryName;

  @override
  void initState() {
    super.initState();
  }

  Future<Null> _selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate.subtract(Duration(days: 30)),
        lastDate: DateTime(selectedDate.year + 1));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      _selectedTime(context);
    }
  }

  Future<Null> _selectedTime(BuildContext context) async {
    final TimeOfDay picked_time = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child,
          );
        });

    if (picked_time != null && picked_time != selectedTime)
      setState(() {
        selectedTime = picked_time;
      });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CategoryViewModel>(
        onModelReady: (data) async {
          data.getCategory(context);
        },
        builder: (context, data, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("New Task", style: TextStyle(color: Colors.black),),
            centerTitle: true,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 24,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              )
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _txtTitleController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'What are you planning ?',
                      )
                    ),
                    SizedBox(height: 30,),
                    Row(
                      children: [
                        Icon(
                          Icons.notifications_none,
                          color: Colors.blueAccent
                        ),
                        SizedBox(width: 10,),
                        GestureDetector(
                          onTap: () async {
                            _selectedDate(context);
                          },
                          child: Text(
                            "${customDateFormat.format(selectedDate)}, ${selectedTime.format(context)}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(
                            Icons.note_outlined,
                            color: Colors.grey
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: _txtNoteController,
                            decoration: InputDecoration(
                              hintText: 'Add note',
                              border: InputBorder.none
                            )
                          )
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(
                            Icons.label_important_outline,
                            color: Colors.grey
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              _modalBottomSheet(data.category);
                            },
                            child: Text(
                              categoryId == null ? "Category" : "${categoryName}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey
                              ),
                            ),
                          )
                        )
                      ],
                    )
                  ]
                )
              ),
            ),
          ),
          bottomNavigationBar: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: RaisedButton(
              color: Colors.blueAccent,
              onPressed: () async {
                var success = await TodoViewModel().addTodo(_txtTitleController.text, _txtNoteController.text, customDateFormat.format(selectedDate)+", "+selectedTime.format(context), categoryId, context);
                if(success == true) {
                  Toast.show("Successfully adding data", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  Navigator.pop(context);
                }
              },
              child: Text(
                "Create",
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
    );
  }

  void _modalBottomSheet(List<CategoryModel> data) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.grey.withOpacity(0),
        builder: (BuildContext bc) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter state) {
                return Scaffold(
                  backgroundColor: Colors.grey.withOpacity(0),
                  body: SingleChildScrollView(
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(top: 50),
                        padding: EdgeInsets.only(
                            left: 16, top: 10, right: 16, bottom: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(20.0),
                                topRight: const Radius.circular(20.0)),
                            color: Colors.white),
                        child: Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      width: 80,
                                      height: 5,
                                      decoration:
                                      BoxDecoration(color: Color(0xffdddddd)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Category",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 14, height: 1.5),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ListView.builder(
                                    itemCount: data.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index){
                                      return GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            categoryId = data[index].categoryId;
                                            categoryName = data[index].categoryName;
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(20),
                                          margin: EdgeInsets.only(bottom: 10),
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 1, color: Colors.grey[300]),
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                data[index].icon,
                                                color: data[index].colors,
                                              ),
                                              SizedBox(width: 20,),
                                              Text("${data[index].categoryName}", style: TextStyle(fontSize: 16),)
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  )
                                ]))),
                  ),
                  bottomNavigationBar: Container(
                    padding: EdgeInsets.all(20),
                    height: 80,
                    color: Colors.white,
                    child: RaisedButton(
                      color: Colors.blueAccent,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Close",
                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              });
        });
  }
}