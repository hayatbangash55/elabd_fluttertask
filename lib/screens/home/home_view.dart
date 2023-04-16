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

  Widget addBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      child: CustomTextBtn(
        backgroundColor: Colors.blue,
        child: const Text(
          'Add',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          viewModel.addData();
        },
      ),
    );
  }

  Widget listView() {
    return Obx(
      () => Expanded(
        child: ListView.separated(
          reverse: true,
          physics: const BouncingScrollPhysics(),
          itemCount: viewModel.dataList.length,
          itemBuilder: (BuildContext context, int index) {
            return listViewItem(index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(height: 20);
          },
        ),
      ),
    );
  }

  Widget listViewItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          listViewLayout(
            title: 'Name',
            value: viewModel.dataList[index].name ?? 'N/A',
          ),
          const SizedBox(width: 10),
          listViewLayout(
            title: 'Phone Number',
            value: viewModel.dataList[index].phone ?? 'N/A',
          ),
        ],
      ),
    );
  }

  Widget listViewLayout({required String title, required String value}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
