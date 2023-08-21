import 'package:flutter/material.dart';

class CustomWidgets{

  CustomWidgets();

  Widget customTextField({required FontWeight fontWeight, required TextEditingController ctrl, required String hint}){
    return TextField(
      controller: ctrl,
      style: TextStyle(fontSize: 17, fontWeight: fontWeight),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500, fontWeight: FontWeight.normal),
      ),
    );
  }

  Widget customElevatedButton({required VoidCallback voidCallback, required String btnText, required Color btnClr}){
    return ElevatedButton(onPressed: voidCallback, style: ElevatedButton.styleFrom(
      backgroundColor: btnClr,
    ), child: Text(btnText));
  }

}