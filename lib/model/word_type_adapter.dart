import 'package:hive_course/model/word_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WordTypeAdapter extends TypeAdapter<WordModel>{
  @override
  WordModel read(BinaryReader reader) {
    return WordModel(
      indexAtDatabase: reader.readInt(), 
      text: reader.readString(), 
      isArabic: reader.readBool(), 
      colorCode: reader.readInt(),
      arabicSimilarWords: reader.readStringList(),
      englishSimilarWords: reader.readStringList(),
      arabicExamples: reader.readStringList(),
      englishExamples: reader.readStringList(),
      );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, WordModel obj) {
    writer.writeInt(obj.indexAtDatabase);
    writer.writeString(obj.text);
    writer.writeBool(obj.isArabic);
    writer.writeInt(obj.colorCode);
    writer.writeStringList(obj.arabicSimilarWords);
    writer.writeStringList(obj.englishSimilarWords);
    writer.writeStringList(obj.arabicExamples);
    writer.writeStringList(obj.englishExamples);
  }

}