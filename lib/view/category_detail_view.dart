import 'package:apps_todo/constant/viewstate.dart';
import 'package:apps_todo/model/category_model.dart';
import 'package:apps_todo/view/base_view.dart';
import 'package:apps_todo/viewmodel/category_viewmodel.dart';
import 'package:apps_todo/viewmodel/todo_viewmodel.dart';
import 'package:apps_todo/widget/modal_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryDetailView extends StatefulWidget {
  int categoryId;
  CategoryModel data;

  CategoryDetailView({Key key, @required this.categoryId, @required this.data});

  @override
  _CategoryDetailViewState createState() => _CategoryDetailViewState();
}

class _CategoryDetailViewState extends State<CategoryDetailView> {

  @override
  Widget build(BuildContext context) {
    return BaseView<CategoryViewModel>(
        onModelReady: (data) async {
          data.getTodoByCategoryId(widget.categoryId, context);
        },
        builder: (context, data, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              )
            ],
          ),
          body: ModalProgress(
            inAsyncCall: data.state == ViewState.Busy ?? ViewState.Idle,
            child: SafeArea(
              child: data.todo == null ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
                child: Container(
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 250,
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                          color: Colors.blueAccent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                child: Center(
                                  child: Icon(
                                    widget.data.icon,
                                    color: widget.data.colors,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,),
                              Text(
                                "${widget.data.categoryName}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 30,
                                    color: Colors.white
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                "${data.todo.length} Task",
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white
                                ),
                              )
                            ],
                          ),
                        ),

                        Container(
                            padding: EdgeInsets.only(top:180),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
                              ),
                              child: data.todo.isEmpty ? Container(
                                height: 100,
                                child: Center(
                                  child: Text("Data tidak ada", style: TextStyle(fontSize: 16, color: Colors.grey),),
                                ),
                              ) : ListView.builder(
                                itemCount: data.todo.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index){
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.todo[index].status == 1 ? "Today" :
                                          data.todo[index].status == 2 ? "Done" :
                                          "Late",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                "${data.todo[index].title}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  decoration: data.todo[index].status == 2 ? TextDecoration.lineThrough : TextDecoration.none,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Container(
                                              width: 100,
                                              child: Align(
                                                alignment: Alignment.centerRight,
                                                child: InkWell(
                                                  onTap: () async {
                                                    var update = await TodoViewModel().updateStatus(data.todo[index].todo_id, data.todo[index].status, context);
                                                    if(update == true){
                                                      await data.getTodoByCategoryId(widget.categoryId, context);
                                                    }
                                                  },
                                                  child: Container(
                                                      width: 25,
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(width: 1, color: Colors.grey)
                                                      ),
                                                      child: data.todo[index].status == 2 ? Icon(
                                                        Icons.check_box,
                                                        color: Colors.blueAccent,
                                                      ) : Container()
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Text(
                                          "${data.todo[index].date}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                        )
                      ],
                    )
                ),
              ),
            ),
          )
        )
    );
  }
}