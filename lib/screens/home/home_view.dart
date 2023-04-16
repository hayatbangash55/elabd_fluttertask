import 'package:elabd_fluttertask/screens/home/home_viewmodel.dart';
import 'package:elabd_fluttertask/widgets/custom_buttons.dart';
import 'package:elabd_fluttertask/widgets/custom_textfield.dart';
import 'package:elabd_fluttertask/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final HomeViewModel viewModel = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Form(
                  key: viewModel.formKey,
                  child: Column(
                    children: [
                      nameTextField(),
                      const SizedBox(height: 10),
                      mobileTextField(),
                    ],
                  ),
                ),
                addBtn(),
                const SizedBox(height: 10),
                const Divider(),
                listView()
              ],
            ),
          ),
          const Loader()
        ],
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      centerTitle: true,
      title: const Text('Flutter Task'),
    );
  }

  Widget nameTextField() {
    return CustomTextField1(
      title: 'Name',
      controller: viewModel.nameController,
      validator: (value) {
        return viewModel.validateDefaultTxtField(value);
      },
    );
  }

  Widget mobileTextField() {
    return CustomTextField1(
      title: 'Phone',
      controller: viewModel.phoneController,
      validator: (value) {
        return viewModel.validateDefaultTxtField(value);
      },
    );
  }

  addBtn() {
    return CustomTextBtn(
      backgroundColor: Colors.blue,
      child: const Text(
        'Add',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        viewModel.addData();
      },
    );
  }

  Widget listView() {
    return Obx(
      () => Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: viewModel.dataList.length,
          itemBuilder: (BuildContext context, int index) {
            return listViewItem(index);
          },
        ),
      ),
    );
  }

  Widget listViewItem(int index) {
    return Column(
      children: [
        Text(viewModel.dataList[index].name ?? 'skafnasf',style: TextStyle(color: Colors.blue),),
        Text(viewModel.dataList[index].phone ?? 'sajdasfuj'),
        const SizedBox(height: 10),
      ],
    );
  }
}
