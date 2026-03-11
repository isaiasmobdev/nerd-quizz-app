import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nerd_quizz_flutter_final/components/buttons.dart';
import 'package:nerd_quizz_flutter_final/screen/login_screen.dart';
import 'package:nerd_quizz_flutter_final/screen/quizz_screen.dart';
import 'package:nerd_quizz_flutter_final/shared/app_colors.dart';

class ScoreScreen extends StatefulWidget {
  final int score;
  final int totalQuestions;

  const ScoreScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  String get _feedbackMessage {
    if (widget.totalQuestions == 0) return 'Sem perguntas!';
    final percent = widget.score / widget.totalQuestions;
    if (percent >= 0.8) return 'Você foi excelente!';
    if (percent >= 0.5) return 'Bom trabalho!';
    return 'Continue tentando!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/svg/logo.svg'),
              Column(
                children: [
                  Text(
                    'Pontuação',
                    style: GoogleFonts.urbanist(
                      color: AppColors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${widget.score} / ${widget.totalQuestions}',
                    style: GoogleFonts.urbanist(
                      color: AppColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _feedbackMessage,
                    style: GoogleFonts.urbanist(
                      color: AppColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                label: 'Jogar novamente',
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const QuizzScreen()),
                    (route) => false,
                  );
                },
              ),
              const SizedBox(height: 20),
              SecondaryButton(
                label: 'Sair',
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
