import 'package:flutter/material.dart';
import 'package:review/components/animate.dart';
import 'package:review/components/button.dart';

callDialogAction(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return ComponentAnimate(
            child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Text(
            message,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            ButtonComponent(
                text: 'Aceptar', onPressed: () => Navigator.pop(context))
          ],
        ));
      });
}

class DialogAction extends StatelessWidget {
  final String message;
  const DialogAction({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ComponentAnimate(
        child: AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text(
        message,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        ButtonComponent(
            text: 'Aceptar', onPressed: () => Navigator.pop(context))
      ],
    ));
  }
}

class DialogOneAction extends StatelessWidget {
  final String message;
  final Function() actionCorrect;
  final String messageCorrect;

  const DialogOneAction(
      {Key? key,
      required this.message,
      required this.actionCorrect,
      required this.messageCorrect})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text(
        message,
      ),
      actions: <Widget>[
        ButtonComponent(
          text: messageCorrect,
          onPressed: actionCorrect,
        )
      ],
    );
  }
}

class DialogTwoAction extends StatelessWidget {
  final String message;
  final Function() actionCorrect;
  final String messageCorrect;

  const DialogTwoAction(
      {Key? key,
      required this.message,
      required this.actionCorrect,
      required this.messageCorrect})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ComponentAnimate(
        child: AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceAround,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text(
        message,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        ButtonWhiteComponent(
          text: 'Cancelar',
          onPressed: () => Navigator.of(context).pop(),
        ),
        ButtonWhiteComponent(
            text: messageCorrect, onPressed: () => actionCorrect())
      ],
    ));
  }
}
