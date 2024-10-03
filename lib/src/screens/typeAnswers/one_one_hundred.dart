import 'package:flutter/material.dart';

class OneToOneHundred extends StatefulWidget {
  final Function(String) nextQuestion;
  final Function() onChangedAnswer;
  final bool buttonState;
  const OneToOneHundred(
      {Key? key,
      required this.nextQuestion,
      required this.onChangedAnswer,
      required this.buttonState})
      : super(key: key);

  @override
  State<OneToOneHundred> createState() => _OneToOneHundredState();
}

class _OneToOneHundredState extends State<OneToOneHundred> {
  double _currentSliderValue = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Slider(
          value: _currentSliderValue,
          min: 0,
          max: 100,
          divisions: 10,
          label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() => _currentSliderValue = value);
            widget.onChangedAnswer();
          },
        ),
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
                    Text(' Enviar ',
                        style: TextStyle(color: Colors.white, fontSize: 17)),
                  ]),
              onPressed: () => widget.buttonState
                  ? widget.nextQuestion(_currentSliderValue.toString())
                  : null),
        ),
      ],
    );
  }
}