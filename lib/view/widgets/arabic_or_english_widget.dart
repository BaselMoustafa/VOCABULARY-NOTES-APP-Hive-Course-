import 'package:flutter/material.dart';
import 'package:hive_course/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:hive_course/view/styles/color_manager.dart';

class ArabicOrEnglishWidget extends StatelessWidget {
  const ArabicOrEnglishWidget({super.key,required this.arabicIsSelected,required this.colorCode});
  final int colorCode;
  final bool arabicIsSelected;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _getContainerDesign(true,context), 
        const SizedBox(width: 5,),
        _getContainerDesign(false,context), 
      ],
    );
  }

  InkWell _getContainerDesign(bool buildIsArabic,BuildContext context) {
    return InkWell(
      onTap: ()=>WriteDataCubit.get(context).updateIsArabic(buildIsArabic),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2,color: ColorManager.white),
          color:buildIsArabic==arabicIsSelected  ?ColorManager.white  :  Color(colorCode),
        ),
        child: Center(
          child: Text(
            buildIsArabic?"ar":"en",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: !(buildIsArabic==arabicIsSelected)  ?ColorManager.white  :  Color(colorCode),
              ),
          ),
        ),
      ),
    );
  }
}