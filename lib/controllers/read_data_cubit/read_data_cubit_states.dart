import 'package:hive_course/model/word_model.dart';

abstract class ReadDataCubitStates {}

class ReadDataCubitInitialState extends ReadDataCubitStates{}

class ReadDataCubitLoadingState extends ReadDataCubitStates{}

class ReadDataCubitSuccessState extends ReadDataCubitStates{
  final List<WordModel>words;
  ReadDataCubitSuccessState({required this.words});
}
class ReadDataCubitFailedState extends ReadDataCubitStates{
  final String message;
  ReadDataCubitFailedState({required this.message});
}