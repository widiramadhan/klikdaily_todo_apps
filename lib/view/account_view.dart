import 'package:apps_todo/constant/viewstate.dart';
import 'package:apps_todo/view/base_view.dart';
import 'package:apps_todo/viewmodel/account_viewmodel.dart';
import 'package:apps_todo/widget/modal_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<AccountViewModel>(
        onModelReady: (data) async {
          data.getAccount(context);
        },
        builder: (context, data, child) => Scaffold(
          appBar: AppBar(
            title: Text("Account"),
          ),
          body: ModalProgress(
            inAsyncCall: data.state == ViewState.Busy ?? ViewState.Idle,
            child: data.account == null ? Center(child: CircularProgressIndicator(),) : SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(30),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50,),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(data.account.results.first.picture.large, width: 100, height: 100,),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Center(
                        child: Text(
                            "${data.account.results.first.name.title} ${data.account.results.first.name.first} ${data.account.results.first.name.last}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),
                            textAlign: TextAlign.center
                        ),
                      ),
                      SizedBox(height: 10,),
                      Center(
                        child: Text(
                          "${data.account.results.first.email}",
                          style: TextStyle(
                              fontSize: 14
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Icon(
                              Icons.phone,
                              color: Colors.blueAccent,
                              size: 18,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Phone",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "${data.account.results.first.phone}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height: 1,
                        color: Colors.grey[300],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Icon(
                              Icons.transgender_outlined,
                              color: Colors.blueAccent,
                              size: 18,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Gender",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "${data.account.results.first.gender}",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height: 1,
                        color: Colors.grey[300],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Icon(
                              Icons.map_sharp,
                              color: Colors.blueAccent,
                              size: 18,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Location",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "${data.account.results.first.location.street} ${data.account.results.first.location.city} ${data.account.results.first.location.country}",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height: 1,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        )
    );
  }
}