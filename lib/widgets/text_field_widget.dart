import 'package:eqinsurance/resource/image_resource.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final Function(String) onSubmit;
  final String hint;
  final bool isShowLeftIcon;
  final TextEditingController? controller;
  final String leftIcon;

  const TextFieldWidget({Key? key, required this.onSubmit, this.hint = "", this.controller, this.isShowLeftIcon = false, this.leftIcon = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(3.0)),
      ),
      height: 38,
      child: Row(
        children: [
          Visibility(
            visible: isShowLeftIcon,
            child: GestureDetector(
              child: Container(
                height: 12,
                width: 12,
                margin: EdgeInsets.only(left: 10),
                child: Image.asset(leftIcon),
              ),
              onTap: (){

              },
            ),
          ),
          Expanded(
            child: TextField(
                //controller: controller.searchController,
                autocorrect: true,
                maxLines: 1,
                onSubmitted: (value) {
                  onSubmit(value);
                },
                onChanged: (value){

                },
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: hint,
                  contentPadding: EdgeInsets.only(left: 10),
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w400),
                  filled: true,
                  fillColor: Colors.white70,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.transparent, width: 0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.transparent, width: 0),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}