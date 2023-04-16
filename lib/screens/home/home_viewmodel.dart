import 'package:elabd_fluttertask/helper/api_base_helper.dart';
import 'package:elabd_fluttertask/helper/getx_helper.dart';
import 'package:elabd_fluttertask/helper/urls.dart';
import 'package:elabd_fluttertask/screens/home/home_model.dart';
import 'package:elabd_fluttertask/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeViewModel extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  List<HomeModel> dataList = <HomeModel>[].obs;

  @override
  void onReady() {
    loadData();
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  String? validateDefaultTxtField(String? value) {
    if (GetUtils.isBlank(value)!) {
      return "Field required";
    } else {
      return null;
    }
  }

  loadData() {
    Loader.loader.value = true;
    ApiBaseHelper().getMethod(url: Urls.readData).then((parsedJson) {
      Loader.loader.value = false;
      if (parsedJson['success'] == "true") {
        var data = parsedJson['data'] as List;
        dataList.addAll(data.map((e) => HomeModel.fromJson(e)));
      }
    }).catchError((e) {
      Loader.loader.value = false;
      print(e);
    });
  }

  addData() {
    if (formKey.currentState!.validate()) {
      Loader.loader.value = true;
      String url =
          "${Urls.writeData}?name=${nameController.text}&phone=${phoneController.text}";
      ApiBaseHelper().getMethod(url: url).then((parsedJson) {
        Loader.loader.value = false;
        if (parsedJson['success'] == "true") {
          GetxHelper.showSnackBar1(
              title: "Success", message: parsedJson["message"]);
          HomeModel model = HomeModel();
          model.name = nameController.text;
          model.phone = phoneController.text;
          dataList.add(model);
        } else {
          GetxHelper.showSnackBar1(
              title: "Error", message: "Something went wrong");
        }
      }).catchError((e) {
        Loader.loader.value = false;
      });
    }
  }
}
