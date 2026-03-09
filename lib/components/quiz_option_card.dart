import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nerd_quizz_flutter_final/shared/app_colors.dart';

class QuizOptionCard extends StatelessWidget {
  final String text; // O texto da resposta (ex: "1. Apple")
  final bool isSelected; // Se esta opção é a que está selecionada
  final VoidCallback onTap; // A função a ser chamada quando clicado

  const QuizOptionCard({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Usamos GestureDetector para fazer o card inteiro ser clicável
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          // MUDANÇA 1: Corrigindo 'withOpacity'
          // Trocamos '.withOpacity(0.1)' por '.withAlpha(25)' (10% de 255)
          color: isSelected
              ? AppColors.primary
                  .withAlpha(10) // Cor de fundo suave quando selecionado
              : AppColors.white, // Fundo branco padrão
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                    .withAlpha(50) // Borda primária quando selecionado
                : Colors.grey.shade300, // Borda cinza padrão
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Usamos Expanded para o texto não estourar a tela
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.urbanist(
                  color: isSelected ? AppColors.red : AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // MUDANÇA 2: Substituímos o widget 'Radio' obsoleto
            // por um 'Container' customizado que imita a bolinha.
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20, // Tamanho da bolinha
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Forma de círculo
                border: Border.all(
                  color: isSelected ? AppColors.red : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              // O padding cria o efeito da "bolinha" interna
              padding: const EdgeInsets.all(3.0),
              child: isSelected
                  ? Container(
                      // Bolinha interna preenchida
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                    )
                  : null, // Vazio se não estiver selecionado
            ),
          ],
        ),
      ),
    );
  }
}
