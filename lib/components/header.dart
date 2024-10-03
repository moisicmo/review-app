import 'package:flutter/material.dart';

class ComponentHeader extends StatelessWidget {
  final String text;
  final bool stateBack;
  const ComponentHeader(
      {Key? key, required this.text, required this.stateBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (stateBack)
          Padding(
              padding: const EdgeInsets.all(5),
              child: GestureDetector(
                  onTap: () =>Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_ios))),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pasaporte Unifranz'),
            Text(text,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
