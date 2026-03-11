// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nerd_quizz_flutter_final/components/buttons.dart';
import 'package:nerd_quizz_flutter_final/components/checkbox.dart';
import 'package:nerd_quizz_flutter_final/components/inputs.dart';
import 'package:nerd_quizz_flutter_final/screens/quizz_screen.dart';
import 'package:nerd_quizz_flutter_final/shared/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:nerd_quizz_flutter_final/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final savedEmail = context.read<AuthProvider>().savedEmail;
      if (savedEmail.isNotEmpty) {
        emailController.text = savedEmail;
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/svg/logo.svg'),
                const SizedBox(height: 24),

                if (authProvider.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      authProvider.errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),

                CustomTextField(
                  controller: emailController,
                  iconPath: 'assets/svg/Message.svg',
                  label: 'Email',
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  controller: passwordController,
                  iconPath: 'assets/svg/Lock.svg',
                  label: 'Senha',
                  isPassword: true,
                ),
                const SizedBox(height: 20.0),

                CheckBoxCustom(
                  label: 'Lembrar de mim',
                  value: authProvider.rememberMe,
                  onChanged: (novoValor) {
                    context.read<AuthProvider>().setRememberMe(novoValor);
                  },
                ),
                const SizedBox(height: 20.0),

                authProvider.isLoading
                    ? const CircularProgressIndicator()
                    : PrimaryButton(
                        label: 'Entrar',
                        onTap: () {
                          context.read<AuthProvider>().signIn(
                            emailController.text,
                            passwordController.text,
                            onSuccess: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const QuizzScreen(),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
