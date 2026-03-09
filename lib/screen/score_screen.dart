import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nerd_quizz_flutter_final/components/buttons.dart';
import 'package:nerd_quizz_flutter_final/screen/login_screen.dart';
import 'package:nerd_quizz_flutter_final/screen/quizz_screen.dart';
import 'package:nerd_quizz_flutter_final/shared/app_colors.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
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
              //Logo Quizz
              SvgPicture.asset('assets/svg/logo.svg'),

              //Text Score and points
              Column(
                children: [
                  Text(
                    'Score',
                    style: GoogleFonts.urbanist(
                      color: AppColors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Score',
                    style: GoogleFonts.urbanist(
                      color: AppColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              //PrimaryButton
              PrimaryButton(
                label: 'Play again',
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const QuizzScreen()),
                    (route) => false,
                  );
                },
              ),
              const SizedBox(height: 20),
              //SecondaryButton
              SecondaryButton(
                label: 'Exit',
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
