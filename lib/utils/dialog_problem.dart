import 'package:flutter/material.dart';

class DialogMessage extends StatelessWidget {
  final String message;
  const DialogMessage({Key? key, required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Stack(
          // overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width <
                      MediaQuery.of(context).size.height
                  ? MediaQuery.of(context).size.width * 0.4
                  : MediaQuery.of(context).size.height * 0.4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  children: [
                    const Spacer(),
                    Text(
                      message,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width <
                                  MediaQuery.of(context).size.height
                              ? MediaQuery.of(context).size.width * 0.04
                              : MediaQuery.of(context).size.height * 0.04),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    MaterialButton(
                        splashColor: Colors.transparent,
                        minWidth: double.infinity,
                        color: const Color(0xffF26522),
                        shape: const StadiumBorder(),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('Aceptar',
                                  style: TextStyle(
                                      color: Colors.white)),
                            ]),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
