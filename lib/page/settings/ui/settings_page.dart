
import 'package:eqinsurance/page/settings/controller/settings_controller.dart';
import 'package:eqinsurance/resource/color_resource.dart';
import 'package:eqinsurance/resource/image_resource.dart';
import 'package:eqinsurance/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SettingsPage extends GetView<SettingsController>{
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResource.color_bg_settings,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorResource.color_appbar_settings,
        title: Text("Settings"),
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.all(7),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          child: Column(
            children: [
              SizedBox(height: 40),
              Image.asset(ImageResource.ic_settings_big, width: 100, height: 100,),
              SizedBox(height: 15),
              Text('Reset App Settings'.toUpperCase()),
              SizedBox(height: 10),
              Text(
                "By clicking on the Yes button, this will permanently delete the app's data on this device, including your preference and sign-in details.",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Do you want to clear the '),
                    TextSpan(
                      text: 'User Data?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              ButtonWidget.buttonNormal(context, "Yes", onTap: (){
                controller.onClickYes();
              }),
              SizedBox(height: 10),
              ButtonWidget.buttonBorder(context, "No", onTap: (){
                controller.onCLickNo();
              })
            ],
          ),
        ),
      ),
    );
  }

}