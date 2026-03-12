// lib/screens/quizz_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nerd_quizz_flutter_final/components/buttons.dart';
import 'package:nerd_quizz_flutter_final/components/quiz_option_card.dart';
import 'package:nerd_quizz_flutter_final/components/quiz_timer_bar.dart';
import 'package:nerd_quizz_flutter_final/models/question_model.dart';
import 'package:nerd_quizz_flutter_final/screens/score_screen.dart';
import 'package:nerd_quizz_flutter_final/screens/login_screen.dart';
import 'package:nerd_quizz_flutter_final/services/firestore_service.dart';
import 'package:nerd_quizz_flutter_final/shared/app_colors.dart';
import 'package:nerd_quizz_flutter_final/shared/ui_helpers.dart';

class QuizzScreen extends StatefulWidget {
  const QuizzScreen({super.key});

  @override
  State<QuizzScreen> createState() => _QuizzScreenState();
}

class _QuizzScreenState extends State<QuizzScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  List<QuestionModel> _questions = [];
  bool _isLoading = true;
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedOptionIndex;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      final questions = await _firestoreService.getQuestions();
      setState(() {
        _questions = questions;
        _isLoading = false;
      });
    } catch (e, stackTrace) {
      debugPrint('Erro ao carregar questoes: $e');
      debugPrint('$stackTrace');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _showExitConfirmation() async {
    final shouldGoToLogin = await showAdaptiveConfirmationDialog(
      context: context,
      title: 'Confirmar',
      content: 'Tem certeza que deseja sair no meio do quizz?',
      positiveButtonLabel: 'Sair',
      negativeButtonLabel: 'Ficar',
    );

    if (shouldGoToLogin == true && mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  void _onSelectAnswer() {
    final currentQuestion = _questions[_currentQuestionIndex];
    if (_selectedOptionIndex != null &&
        _selectedOptionIndex == currentQuestion.correctAnswerIndex) {
      _score++;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOptionIndex = null;
      });
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ScoreScreen(
            score: _score,
            totalQuestions: _questions.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) return;
        await _showExitConfirmation();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          leading: IconButton(
            color: AppColors.white,
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: _showExitConfirmation,
          ),
          actionsPadding: const EdgeInsets.only(right: 20),
          actions: [
            TextButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => ScoreScreen(
                            score: _score,
                            totalQuestions: _questions.length,
                          ),
                        ),
                      );
                    },
              style: TextButton.styleFrom(
                foregroundColor: AppColors.white,
              ),
              child: Text(
                'Desistir',
                style: GoogleFonts.urbanist(
                  color: AppColors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _questions.isEmpty
                ? Center(
                    child: Text(
                      'Nenhuma pergunta encontrada.',
                      style: GoogleFonts.urbanist(color: AppColors.white),
                    ),
                  )
                : _buildQuizBody(),
      ),
    );
  }

  Widget _buildQuizBody() {
    final question = _questions[_currentQuestionIndex];

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuizTimerBar(
            key: ValueKey(_currentQuestionIndex),
            totalTime: 20,
            onTimerEnd: () {
              _onSelectAnswer();
            },
          ),
          const SizedBox(height: 24),
          Text(
            'Questão ${_currentQuestionIndex + 1}/${_questions.length}',
            style: GoogleFonts.urbanist(
              color: AppColors.white,
              fontSize: 24,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 16),
          Divider(
            color: AppColors.white.withAlpha(25),
            thickness: 1,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.text,
                    style: GoogleFonts.urbanist(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.separated(
                      itemCount: question.options.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        return QuizOptionCard(
                          text: '${index + 1}. ${question.options[index]}',
                          isSelected: _selectedOptionIndex == index,
                          onTap: () {
                            setState(() {
                              _selectedOptionIndex = index;
                            });
                          },
                        );
                      },
                    ),
                  ),
                  PrimaryButton(
                    label: 'Selecionar',
                    onTap:
                        _selectedOptionIndex != null ? _onSelectAnswer : null,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
