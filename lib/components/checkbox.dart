import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nerd_quizz_flutter_final/shared/app_colors.dart';

class CheckBoxCustom extends StatelessWidget {
  // 1. Ele recebe o valor atual de quem está usando ele
  final bool value;
  // 2. Ele avisa quem está usando quando foi clicado
  final ValueChanged<bool> onChanged;
  final String label;

  const CheckBoxCustom({
    super.key,
    required this.value, // Obrigatório receber o estado atual
    required this.onChanged, // Obrigatório receber a função de callback
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Quando clicado, ele NÃO muda o valor sozinho.
      // Ele avisa o pai: "Ei, meu novo valor deveria ser o inverso do atual!"
      onTap: () => onChanged(!value),

      // Comportamento opaco garante que o clique funcione mesmo na área transparente
      behavior: HitTestBehavior.opaque,

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // O QUADRADO
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              // Se true = fundo rosa. Se false = fundo transparente
              color: value ? AppColors.red : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.red,
                width: 2.5, // Ajustei a espessura para ficar igual à imagem
              ),
            ),
            child: value
                ? const Icon(
                    Icons.check,
                    size: 16,
                    color: AppColors.white,
                  )
                : null,
          ),
          const SizedBox(width: 12),
          // O TEXTO
          Text(
            label,
            style: GoogleFonts.urbanist(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
