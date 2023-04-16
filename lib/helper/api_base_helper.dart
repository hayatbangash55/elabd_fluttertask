import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:elabd_fluttertask/helper/errors.dart';
import 'package:elabd_fluttertask/helper/getx_helper.dart';
import 'package:elabd_fluttertask/widgets/loader.dart';
import 'package:http/http.dart' as http;

class ApiBaseHelper {
  Future<dynamic> getMethod({required String url}) async {
    try {
      Uri urlValue = Uri.parse(url);
      http.Response response =
          await http.get(urlValue).timeout(const Duration(seconds: 30));
      print(response.body);
      var parsedJSON = jsonDecode(response.body);

      log('*********************** Response **********************************');
      log(urlValue.toString());
      log(response.body);
      return parsedJSON;
    } on SocketException catch (_) {
      Loader.loader.value = false;
      GetxHelper.showSnackBar1(title: 'Error', message: Errors.noInternetError);
      throw Errors.noInternetError;
    } on TimeoutException catch (_) {
      Loader.loader.value = false;
      GetxHelper.showSnackBar1(title: 'Error', message: Errors.generalApiError);
      throw Errors.generalApiError;
    } on FormatException catch (_) {
      Loader.loader.value = false;
      GetxHelper.showSnackBar1(title: 'Error', message: Errors.generalApiError);
      throw Errors.generalApiError;
    } catch (e) {
      Loader.loader.value = false;
      GetxHelper.showSnackBar1(title: 'Error', message: Errors.generalApiError);
      throw e.toString();
    }
  }
}
