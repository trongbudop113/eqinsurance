import 'package:eqinsurance/resource/color_resource.dart';
import 'package:eqinsurance/resource/style_resource.dart';
import 'package:eqinsurance/widgets/safe_button.dart';
import 'package:flutter/material.dart';

class ButtonWidget{
  static Widget buttonNormal(BuildContext context, String text,
      {Color textColor = Colors.white,
        Color buttonColor = ColorResource.color_button_user,
        double radius = 18,
        required bool isDisable,
        required VoidCallback onTap}){
    return SafeOnTap(
      onSafeTap: onTap,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          color: buttonColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 0.5,
              offset: Offset(0.5, 0.5), // changes position of shadow
            ),
          ],
        ),
        child: Text(text, style: StyleResource.TextStyleBlack(context).copyWith(color: textColor, fontWeight: FontWeight.bold, fontSize: 14)),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 15),
      ),
    );
  }

  static Widget buttonBorder(BuildContext context, String text,
      {Color textColor = ColorResource.color_button_partner,
        Color buttonColor = Colors.transparent,
        Color borderColor = ColorResource.color_button_partner,
        required VoidCallback onTap}){
    return SafeOnTap(
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: buttonColor,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        child: Text(text, style: StyleResource.TextStyleBlack(context).copyWith(color: textColor, fontWeight: FontWeight.bold, fontSize: 14)),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 15),
      ),
      onSafeTap: onTap,
    );
  }
}