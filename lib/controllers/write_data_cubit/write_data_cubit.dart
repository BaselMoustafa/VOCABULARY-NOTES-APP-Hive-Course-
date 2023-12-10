import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_course/controllers/write_data_cubit/write_data_cubit_states.dart';
import 'package:hive_course/hive_constants.dart';
import 'package:hive_course/model/word_model.dart';

class WriteDataCubit extends Cubit<WriteDataCubitStates>{
  WriteDataCubit():super(WriteDataCubitIntialState());
  static WriteDataCubit get(context)=>BlocProvider.of(context);

  final Box box=Hive.box(HiveConstants.wordsBox);

  String text="";
  bool isArabic=true;
  int colorCode=0XFF4A47A3;

  void updateText(String text){
    this.text=text;
  }

  void updateIsArabic(bool isArabic){
    this.isArabic=isArabic;
    emit(WriteDataCubitIntialState());
  }

  void updateColorCode(int colorCode){
    this.colorCode=colorCode;
    emit(WriteDataCubitIntialState());
  }
  
  void addSimilarWord(int indexAtDatabase){
    _tryAndCatchBlock(() {
      List<WordModel>words=_getWordsFromDataBase();
      words[indexAtDatabase]=words[indexAtDatabase].addSimilarWord(text, isArabic);
      box.put(HiveConstants.wordsList, words);
    },
     "We Have problems when we add similar word,Please try again"
    );
  }

  void addExample(int indexAtDatabase){
    _tryAndCatchBlock(() {
      List<WordModel>words=_getWordsFromDataBase();
      words[indexAtDatabase]=words[indexAtDatabase].addExample(text, isArabic);
      box.put(HiveConstants.wordsList, words);
    },
    "We Have problems when we add example,Please try again" 
    );
  }

  void deleteSimilarWord(int indexAtDatabase,int indexAtSimilarWord,bool isArabicSimilarWord){
    _tryAndCatchBlock(() {
      List<WordModel>words=_getWordsFromDataBase();
      words[indexAtDatabase]=words[indexAtDatabase].deleteSimilarWord(indexAtSimilarWord, isArabicSimilarWord);
      box.put(HiveConstants.wordsList, words);
    }, 
    "We Have problems when we delete similar word,Please try again" 
    );
  }

  void deleteExample(int indexAtDatabase,int indexAtExamples,bool isArabicExample){
    _tryAndCatchBlock(() {
      List<WordModel>words=_getWordsFromDataBase();
      words[indexAtDatabase]=words[indexAtDatabase].deleteExample(indexAtExamples, isArabicExample);
      box.put(HiveConstants.wordsList, words);
    },
    "We Have problems when we delete Example,Please try again" 
    );
  }

  void addWord(){
    _tryAndCatchBlock(() {
      List<WordModel>words=_getWordsFromDataBase();
      words.add(WordModel(indexAtDatabase: words.length, text: text, isArabic: isArabic, colorCode: colorCode));
      box.put(HiveConstants.wordsList, words);
    }, 
    "We Have problems when we add word,Please try again"
    );
   
  }

  void deleteWord(int indexAtDatabase){
    _tryAndCatchBlock((){ 
        List<WordModel>words=_getWordsFromDataBase();
        words.removeAt(indexAtDatabase);
        for (var i = indexAtDatabase; i < words.length; i++) {
          words[i]=words[i].decrementIndexAtDataBase();
        }
        box.put(HiveConstants.wordsList, words);
      }, 
      "We Have problems when we Delete word,Please try again",
    );

  }

  void _tryAndCatchBlock(VoidCallback methodToExcute,String message){
    emit(WriteDataCubitLoadingState());
    try {
      methodToExcute.call();
      emit(WriteDataCubitSuccessState());
    } catch (error) {
      emit(WriteDataCubitFailedState(message: message));
    }
  }

  List<WordModel> _getWordsFromDataBase()=>List.from(box.get(HiveConstants.wordsList,defaultValue: [])).cast<WordModel>();

}