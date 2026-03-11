import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel {
  final String id;
  final String text;
  final List<String> options;
  final int correctAnswerIndex;

  QuestionModel({
    required this.id,
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
  });

  factory QuestionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final gabarito = (data['gabarito'] as String).toUpperCase();
    final correctAnswerIndex = gabarito.codeUnitAt(0) - 'A'.codeUnitAt(0);
    return QuestionModel(
      id: doc.id,
      text: data['enunciado'] as String,
      options: List<String>.from(data['alternativas'] as List),
      correctAnswerIndex: correctAnswerIndex,
    );
  }
}
