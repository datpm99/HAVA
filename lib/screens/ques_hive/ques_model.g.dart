// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ques_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuesModelAdapter extends TypeAdapter<QuesModel> {
  @override
  final typeId = 4;

  @override
  QuesModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuesModel(
      listQues: (fields[0] as List).cast<QuestionModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, QuesModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.listQues);
  }
}

class QuestionModelAdapter extends TypeAdapter<QuestionModel> {
  @override
  final typeId = 3;

  @override
  QuestionModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionModel(
      id: fields[0] as int,
      idExam: fields[1] as int,
      title: fields[2] as String,
      index: fields[3] as String,
      labelId: fields[4] as int,
      valueLable: fields[5] as String,
      question: fields[6] as String,
      hints: fields[7] as String,
      answer: fields[8] as String,
      comments: fields[9] as String,
      answerTrue: fields[10] as int,
      answerA: fields[11] as String,
      answerB: fields[12] as String,
      answerC: fields[13] as String,
      answerD: fields[14] as String,
      categoryId: fields[15] as int,
      level: fields[16] as int,
      isLabel: fields[17] as int,
      labelOf: fields[18] as int,
    );
  }

  @override
  void write(BinaryWriter writer, QuestionModel obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idExam)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.index)
      ..writeByte(4)
      ..write(obj.labelId)
      ..writeByte(5)
      ..write(obj.valueLable)
      ..writeByte(6)
      ..write(obj.question)
      ..writeByte(7)
      ..write(obj.hints)
      ..writeByte(8)
      ..write(obj.answer)
      ..writeByte(9)
      ..write(obj.comments)
      ..writeByte(10)
      ..write(obj.answerTrue)
      ..writeByte(11)
      ..write(obj.answerA)
      ..writeByte(12)
      ..write(obj.answerB)
      ..writeByte(13)
      ..write(obj.answerC)
      ..writeByte(14)
      ..write(obj.answerD)
      ..writeByte(15)
      ..write(obj.categoryId)
      ..writeByte(16)
      ..write(obj.level)
      ..writeByte(17)
      ..write(obj.isLabel)
      ..writeByte(18)
      ..write(obj.labelOf);
  }
}
