import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_course/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:hive_course/view/styles/color_manager.dart';

import 'package:hive_course/view/widgets/arabic_or_english_widget.dart';
import 'package:hive_course/view/widgets/colors_widget.dart';
import 'package:hive_course/view/widgets/custom_form.dart';
import 'package:hive_course/view/widgets/done_button.dart';

import '../../controllers/write_data_cubit/write_data_cubit.dart';
import '../../controllers/write_data_cubit/write_data_cubit_states.dart';

class AddWordDialog extends StatefulWidget {
  const AddWordDialog({super.key});
  @override
  State<AddWordDialog> createState() => _AddWordDialogState();
}

class _AddWordDialogState extends State<AddWordDialog> {
  final GlobalKey<FormState>formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child:BlocConsumer<WriteDataCubit,WriteDataCubitStates>(
        listener: (context,state){
          if(state is WriteDataCubitSuccessState){
            Navigator.pop(context);
          }
          if(state is WriteDataCubitFailedState){
            ScaffoldMessenger.of(context).showSnackBar(_getSnackBar(state.message));
          }
        },
        builder: (context,state){
          return AnimatedContainer(
            padding:const EdgeInsets.all(15),
            duration: const Duration(milliseconds: 750),
            color: Color(WriteDataCubit.get(context).colorCode),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  ArabicOrEnglishWidget(
                    colorCode: WriteDataCubit.get(context).colorCode,
                    arabicIsSelected: WriteDataCubit.get(context).isArabic,
                  ),
                  const SizedBox(height: 8,),

                  ColorsWidget(activeColorCode: WriteDataCubit.get(context).colorCode),
                  const SizedBox(height: 10,),

                  CustomForm(formKey: formKey, label: "New Word"),
                  const SizedBox(height: 15,),

                  DoneButton(
                    colorCode: WriteDataCubit.get(context).colorCode, 
                    onTap: (){
                      if(formKey.currentState!.validate()){
                        WriteDataCubit.get(context).addWord();
                        ReadDataCubit.get(context).getWords();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        }, 
        
        ),
      
    );
  }

  SnackBar _getSnackBar(String message) => SnackBar(content: Text(message),backgroundColor: ColorManager.red,);
}