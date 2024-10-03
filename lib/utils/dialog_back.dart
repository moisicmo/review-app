import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:review/components/button.dart';
class DialogBack extends StatelessWidget {

  const DialogBack(
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: const Text(
            '¿Estas seguro de salir?',
          ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ButtonWhiteComponent(
              text: 'Salir',
              onPressed: ()=>SystemNavigator.pop(),
            ),
            ButtonComponent(
              text: 'Cancelar',
              onPressed: ()=>Navigator.of(context).pop(),
            )
          ],
        )
      ],
    );
  }
}