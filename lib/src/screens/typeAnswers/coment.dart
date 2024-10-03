import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Coment extends StatefulWidget {
  final Function(String) nextQuestion;
  final TextEditingController coment;
  final Function() onChangedAnswer;
  const Coment(
      {Key? key,
      required this.nextQuestion,
      required this.coment,
      required this.onChangedAnswer})
      : super(key: key);

  @override
  State<Coment> createState() => _ComentState();
}

class _ComentState extends State<Coment> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FocusNode focusNode = FocusNode();
  void _onFocusChange() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        overlays: []); // hide status + action buttons
  }

  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();
    focusNode.addListener(_onFocusChange);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                onChanged: (text) => widget.onChangedAnswer(),
                focusNode: focusNode,
                textInputAction: TextInputAction.done,
                onEditingComplete: () => {
                  if (formKey.currentState!.validate())
                    widget.nextQuestion(widget.coment.text)
                },
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  } else {
                    return 'Escribe un comentario';
                  }
                },
                controller: widget.coment,
                decoration: const InputDecoration(labelText: "Comentario"),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: MaterialButton(
                splashColor: Colors.transparent,
                minWidth: size.width * 0.35,
                height: 40,
                color: const Color(0xffF26522),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('  Enviar ',
                          style: TextStyle(color: Colors.white, fontSize: 17)),
                    ]),
                onPressed: () => {
                  if (formKey.currentState!.validate())
                    widget.nextQuestion(widget.coment.text)
                },
              ),
            ),
          ],
        ));
  }
}
