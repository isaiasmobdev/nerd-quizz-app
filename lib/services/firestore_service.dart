import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nerd_quizz_flutter_final/models/question_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<QuestionModel>> getQuestions() async {
    final snapshot = await _db.collection('questoes').get();
    if (snapshot.docs.isEmpty) {
      await _seedQuestions();
      final seeded = await _db.collection('questoes').get();
      return seeded.docs.map(QuestionModel.fromFirestore).toList();
    }
    return snapshot.docs.map(QuestionModel.fromFirestore).toList();
  }

  Future<void> _seedQuestions() async {
    final collection = _db.collection('questoes');
    final batch = _db.batch();

    final questions = [
      {
        'enunciado': 'Qual linguagem de programação foi criada por Guido van Rossum?',
        'alternativas': ['Java', 'Python', 'Ruby', 'C++'],
        'gabarito': 'B',
      },
      {
        'enunciado': 'O que significa a sigla "HTTP"?',
        'alternativas': [
          'HyperText Transfer Protocol',
          'High Transfer Text Program',
          'Hyper Terminal Text Process',
          'Host Transfer Text Protocol',
        ],
        'gabarito': 'A',
      },
      {
        'enunciado': 'Qual empresa criou o sistema operacional Android?',
        'alternativas': ['Apple', 'Microsoft', 'Google', 'Samsung'],
        'gabarito': 'C',
      },
      {
        'enunciado': 'Em qual ano o primeiro iPhone foi lançado?',
        'alternativas': ['2005', '2006', '2007', '2008'],
        'gabarito': 'C',
      },
      {
        'enunciado': 'O que é "RAM" em um computador?',
        'alternativas': [
          'Read Access Memory',
          'Random Access Memory',
          'Rapid Access Module',
          'Remote Access Memory',
        ],
        'gabarito': 'B',
      },
      {
        'enunciado': 'Qual dessas linguagens é usada principalmente para estilizar páginas web?',
        'alternativas': ['HTML', 'CSS', 'JavaScript', 'PHP'],
        'gabarito': 'B',
      },
      {
        'enunciado': 'O que significa "CPU"?',
        'alternativas': [
          'Central Processing Unit',
          'Computer Power Unit',
          'Core Processing Utility',
          'Central Program Utility',
        ],
        'gabarito': 'A',
      },
      {
        'enunciado': 'Qual estrutura de dados segue o princípio LIFO (Last In, First Out)?',
        'alternativas': ['Fila', 'Lista', 'Pilha', 'Árvore'],
        'gabarito': 'C',
      },
    ];

    for (final q in questions) {
      batch.set(collection.doc(), q);
    }

    await batch.commit();
  }
}
