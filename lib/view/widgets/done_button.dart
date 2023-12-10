import 'package:flutter/material.dart';
import 'package:hive_course/view/styles/color_manager.dart';

class DoneButton extends StatelessWidget {
  const DoneButton({super.key,required this.colorCode,required this.onTap});
  final int colorCode;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          width: 60,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              "Done",
              style: TextStyle(color: Color(colorCode),fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}