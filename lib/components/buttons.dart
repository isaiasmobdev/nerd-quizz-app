import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nerd_quizz_flutter_final/shared/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap; // Adicione isto para receber a ação de clique

  const PrimaryButton({
    super.key,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // 1. O Material é necessário para o efeito "tinta" (Ink) funcionar
    return Material(
      color: AppColors.primary, // A cor VEM PARA O MATERIAL
      borderRadius:
          BorderRadius.circular(100), // O Material precisa arredondar também
      child: InkWell(
        onTap: onTap, // A ação de clique vem aqui
        borderRadius: BorderRadius.circular(
            100), // O efeito de clique precisa ser arredondado
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          alignment: Alignment.center,
          // NOTA: Removemos a 'color' do BoxDecoration daqui,
          // senão ela cobre o efeito do InkWell!
          child: Text(
            label,
            style: GoogleFonts.urbanist(
              color: AppColors.textButtonPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap; // Adicione isto para receber a ação de clique

  const SecondaryButton({
    super.key,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.secoundary, // A cor VEM PARA O MATERIAL
      borderRadius:
          BorderRadius.circular(100), // O Material precisa arredondar também
      child: InkWell(
        onTap: onTap, // A ação de clique vem aqui
        borderRadius: BorderRadius.circular(
            100), // O efeito de clique precisa ser arredondado
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          alignment: Alignment.center,
          // NOTA: Removemos a 'color' do BoxDecoration daqui,
          // senão ela cobre o efeito do InkWell!
          child: Text(
            label,
            style: GoogleFonts.urbanist(
              color: AppColors.textButtonSecoundary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
