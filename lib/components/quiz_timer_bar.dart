import 'dart:async'; // Precisamos disso para o Timer
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nerd_quizz_flutter_final/shared/app_colors.dart';

class QuizTimerBar extends StatefulWidget {
  final int totalTime; // Tempo total em segundos (ex: 20)
  final VoidCallback onTimerEnd; // Função a ser chamada quando o tempo acabar

  const QuizTimerBar({
    super.key,
    required this.totalTime,
    required this.onTimerEnd,
  });

  @override
  State<QuizTimerBar> createState() => _QuizTimerBarState();
}

class _QuizTimerBarState extends State<QuizTimerBar> {
  late int _remainingTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // 1. Define o tempo restante inicial
    _remainingTime = widget.totalTime;
    // 2. Inicia o timer
    _startTimer();
  }

  void _startTimer() {
    // Cria um timer que "dispara" a cada 1 segundo
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // 3. Verifica se o tempo ainda não acabou
      if (_remainingTime > 0) {
        // Usa o setState para "forçar" a tela a se redesenhar com o novo valor
        setState(() {
          _remainingTime--;
        });
      } else {
        // 4. O tempo acabou. Pare o timer e avise o "pai" (a tela do Quiz)
        timer.cancel();
        widget.onTimerEnd();
      }
    });
  }

  @override
  void dispose() {
    // 5. ESSENCIAL: Cancela o timer quando o widget é destruído
    // Se não fizer isso, o timer continua rodando em segundo plano (memory leak)
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 6. Usamos um LayoutBuilder para saber a largura total disponível
    return LayoutBuilder(
      builder: (context, constraints) {
        // Largura máxima que a barra pode ter
        final double totalWidth = constraints.maxWidth;

        // 1. Calcular o tempo que JÁ PASSOU
        final double timeElapsed =
            (widget.totalTime - _remainingTime).toDouble();

        // 2. Calcular a porcentagem do progresso (0.0 a 1.0)
        final double progressPercent =
            timeElapsed / widget.totalTime.toDouble();

        // 3. Calcular a largura da barra de progresso
        final double progressWidth = progressPercent * totalWidth;

        return Container(
          width: totalWidth,
          height: 44, // Altura da barra
          decoration: BoxDecoration(
            // Cor de fundo (roxo escuro)
            color: Colors.transparent,
            // Borda semi-transparente (a "pista" da barra)
            border: Border.all(color: AppColors.white.withAlpha(50), width: 2),
            borderRadius: BorderRadius.circular(30), // Borda arredondada
          ),
          // Stack permite empilhar os widgets
          child: Stack(
            alignment: Alignment.center,
            children: [
              // --- 1. A Barra de Progresso Vermelha ---
              // Alinha a barra à esquerda para que ela cresça
              // da esquerda para a direita.
              Align(
                alignment: Alignment.centerLeft,
                child: AnimatedContainer(
                  duration:
                      const Duration(milliseconds: 300), // Duração da animação
                  curve: Curves.linear, // Curva de animação
                  width: progressWidth,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.red, // Cor vermelha da imagem
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),

              // --- 2. O Texto do Timer ---
              // Colocamos o texto à esquerda, dentro de um Padding
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    '$_remainingTime sec',
                    style: GoogleFonts.urbanist(
                      color: AppColors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              // --- 3. O Ícone do Relógio ---
              // Colocamos o ícone à direita, dentro de um Padding
              // Como ele é o último filho do Stack, ele fica NA FRENTE de tudo
              const Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 44,
                  child: Icon(
                    CupertinoIcons.clock_fill, // Ícone de relógio
                    color: AppColors.white, // Cor roxa
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
