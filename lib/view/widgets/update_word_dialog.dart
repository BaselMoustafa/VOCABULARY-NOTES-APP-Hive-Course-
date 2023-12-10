import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_course/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:hive_course/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:hive_course/controllers/write_data_cubit/write_data_cubit_states.dart';
import 'package:hive_course/view/styles/color_manager.dart';
import 'package:hive_course/view/widgets/arabic_or_english_widget.dart';
import 'package:hive_course/view/widgets/custom_form.dart';
import 'package:hive_course/view/widgets/done_button.dart';

class UpdateWordDialog extends StatefulWidget {
  const UpdateWordDialog({super.key,required this.isExample,required this.colorCode,required this.indexAtDatabase});
  final bool isExample;
  final int colorCode;
  final int indexAtDatabase;
  @override
  State<UpdateWordDialog> createState() => _UpdateWordDialogState();
}

class _UpdateWordDialogState extends State<UpdateWordDialog> {
  final GlobalKey<FormState>_formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding:const EdgeInsets.all(30),
      backgroundColor:Color(widget.colorCode),
      child: BlocConsumer<WriteDataCubit,WriteDataCubitStates>(
        listener: (context, state) {
          if(state is WriteDataCubitSuccessState){
            Navigator.pop(context);
          }
          if(state is WriteDataCubitFailedState){
            ScaffoldMessenger.of(context).showSnackBar(_getSnackBar(state));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ArabicOrEnglishWidget(
                  arabicIsSelected: WriteDataCubit.get(context).isArabic, 
                  colorCode: widget.colorCode,
                ),
                const SizedBox(height: 20,),
                CustomForm(
                  formKey: _formKey, 
                  label: widget.isExample?"New Example":"New Similar Word",
                ),
                const SizedBox(height: 20,),
                DoneButton(
                  colorCode: widget.colorCode, 
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      if(widget.isExample){
                        WriteDataCubit.get(context).addExample(widget.indexAtDatabase);
                      }else{
                        WriteDataCubit.get(context).addSimilarWord(widget.indexAtDatabase);
                      }
                      ReadDataCubit.get(context).getWords();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  SnackBar _getSnackBar(WriteDataCubitFailedState state) => SnackBar(
    backgroundColor: ColorManager.red,
    content: Text(
      state.message,
    )
  );
}