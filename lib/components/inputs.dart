import 'package:flutter/material.dart';
import 'package:nerd_quizz_flutter_final/shared/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final String iconPath; // Caminho do SVG (ex: 'assets/svg/Message.svg')
  final String label; // Texto do label (ex: 'Email')
  final bool isPassword; // Se é um campo de senha ou não
  final TextEditingController? controller; // Para recuperar o texto digitado

  const CustomTextField({
    super.key,
    required this.iconPath,
    required this.label,
    this.isPassword = false, // Por padrão, NÃO é senha
    this.controller,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // Variável que controla se a senha está visível ou não.
  // Começa como true (obscurecida) se for senha.
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    // Se NÃO for um campo de senha, _obscureText deve ser sempre false.
    // Se FOR senha, ele usa o valor da variável _obscureText.
    final isObscure = widget.isPassword ? _obscureText : false;

    return Container(
      // Decoração opcional para o container do input (borda, cor de fundo, etc)
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16), // Bordas arredondadas
      ),
      padding: const EdgeInsets.all(12.0), // Espaçamento interno
      child: TextField(
        controller: widget.controller,
        obscureText: isObscure, // Controla se mostra bolinhas ou texto
        style: GoogleFonts.urbanist(
          color: AppColors.textPrimary,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          // Remove a linha padrão feia do TextField
          border: InputBorder.none,

          // Ícone da esquerda (SVG)
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              widget.iconPath,
              // Opcional: forçar uma cor para o ícone se necessário
              // colorFilter: ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
              width: 20,
              height: 20,
            ),
          ),

          // O texto principal (Label ou Hint)
          hintText: widget.label,
          hintStyle: GoogleFonts.urbanist(
            color: AppColors.grey, // Ou AppColors.grey
            fontSize: 16,
          ),

          // Ícone da direita (Olhinho), SÓ aparece se isPassword for true
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    // Alterna o ícone entre olho aberto e fechado
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.grey,
                  ),
                  onPressed: () {
                    // Ao clicar, inverte o valor de _obscureText
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null, // Se não for senha, suffixIcon é null (não mostra nada)
        ),
      ),
    );
  }
}
