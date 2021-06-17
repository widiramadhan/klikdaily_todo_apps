import 'package:apps_todo/helper/dio_exception.dart';
import 'package:apps_todo/model/account_model.dart';
import 'package:apps_todo/services/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

class AccountRepository extends ChangeNotifier {
  Response response;
  Dio dio = new Dio();

  Future<AccountModel> getAccount(BuildContext context) async {
    try {
      response = await dio.get(Api().getAccount,
          options: Options(headers: {
            "Accept": "application/json"
          })).timeout(Duration(seconds: Api().timeout)
      );
      if (response.statusCode == 200) {
        notifyListeners();
        final Map parsed = response.data;
        final dataProfile = AccountModel.fromJson(parsed);
        return dataProfile;
      } else {
        Toast.show("Error get api", context, duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);
        return null;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      Toast.show(errorMessage, context, duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);
      return null;
    }
  }
}