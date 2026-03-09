import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nerd_quizz_flutter_final/components/buttons.dart';
// O import corrigido
import 'package:nerd_quizz_flutter_final/components/quiz_option_card.dart';
import 'package:nerd_quizz_flutter_final/components/quiz_timer_bar.dart';
import 'package:nerd_quizz_flutter_final/screen/score_screen.dart';
import 'package:nerd_quizz_flutter_final/screen/login_screen.dart';
import 'package:nerd_quizz_flutter_final/shared/app_colors.dart';
import 'package:nerd_quizz_flutter_final/shared/ui.helpers.dart';

class QuizzScreen extends StatefulWidget {
  const QuizzScreen({super.key});

  @override
  State<QuizzScreen> createState() => _QuizzScreenState();
}

class _QuizzScreenState extends State<QuizzScreen> {
  String? _respostaSelecionada;
  final List<String> opcoes = ['Paris', 'Londres', 'Berlim', 'Madrid', 'Roma'];

  // --- MUDANÇA 1: CRIAMOS UMA FUNÇÃO ÚNICA PARA A LÓGICA DE SAÍDA ---
  Future<void> _showExitConfirmation() async {
    final shouldGoToLogin = await showAdaptiveConfirmationDialog(
      context: context,
      title: 'Confirmar',
      content: 'Tem certeza que deseja sair no meio do quizz?',
      positiveButtonLabel: 'Sair',
      negativeButtonLabel: 'Ficar',
    );

    if (shouldGoToLogin == true && context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) return;

        // --- MUDANÇA 2: O 'PopScope' (gesto de sistema) chama a função ---
        await _showExitConfirmation();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          leading: IconButton(
            color: AppColors.white,
            icon: const Icon(Icons.arrow_back_ios_new),
            // --- MUDANÇA 3: O 'IconButton' (clique manual) chama a MESMA função ---
            onPressed: _showExitConfirmation,
          ),
          actionsPadding: const EdgeInsets.only(right: 20),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const ScoreScreen()),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColors.white,
              ),
              child: Text(
                'Skip',
                style: GoogleFonts.urbanist(
                  color: AppColors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QuizTimerBar(
                totalTime: 20,
                onTimerEnd: () {
                  // TODO: Adicionar lógica de fim de tempo
                },
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Questão 1/4',
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
                        'Qual é a capital da França?',
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
                          itemCount: opcoes.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final opcao = opcoes[index];

                            return QuizOptionCard(
                              text: '${index + 1}. $opcao',
                              isSelected: _respostaSelecionada == opcao,
                              onTap: () {
                                setState(() {
                                  _respostaSelecionada = opcao;
                                });
                              },
                            );
                          },
                        ),
                      ),
                      const PrimaryButton(label: 'Selecionar'),
                      const SizedBox(), // TODO: Remover este SizedBox vazio?
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
