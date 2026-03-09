import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Precisamos de ambos os pacotes

// Esta é a função que sua QuizzScreen está tentando chamar.
// Note que ela retorna um Future<bool?>
// bool? = Pode ser true (Sim), false (Não), ou null (fechou clicando fora)
Future<bool?> showAdaptiveConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  String positiveButtonLabel = 'Sim', // Valor padrão
  String negativeButtonLabel = 'Não', // Valor padrão
}) async {
  // 1. Verificamos qual é a plataforma atual
  final platform = Theme.of(context).platform;

  // 2. Verificamos se é iOS para mostrar o CupertinoAlertDialog
  if (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS) {
    // Para iOS, usamos 'showCupertinoDialog'
    return showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            // Botão Negativo (iOS)
            CupertinoDialogAction(
              child: Text(negativeButtonLabel),
              onPressed: () {
                Navigator.of(context).pop(false); // Retorna 'false'
              },
            ),
            // Botão Positivo (iOS)
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(positiveButtonLabel),
              onPressed: () {
                Navigator.of(context).pop(true); // Retorna 'true'
              },
            ),
          ],
        );
      },
    );
  } else {
    // 3. Para Android (e outros), usamos 'showDialog' com AlertDialog
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            // Botão Negativo (Android)
            TextButton(
              child: Text(negativeButtonLabel),
              onPressed: () {
                Navigator.of(context).pop(false); // Retorna 'false'
              },
            ),
            // Botão Positivo (Android)
            TextButton(
              child: Text(positiveButtonLabel),
              onPressed: () {
                Navigator.of(context).pop(true); // Retorna 'true'
              },
            ),
          ],
        );
      },
    );
  }
}
