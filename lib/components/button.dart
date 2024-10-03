import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonComponent extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const ButtonComponent({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        minWidth:double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 19),
        color: const Color(0xffF26522),
        disabledColor: Colors.grey,
        onPressed: onPressed,
        child: 
          Text(text,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
         );
  }
}

class ButtonWhiteComponent extends StatelessWidget {
  final String text;
  final Color? colorText;
  final Function() onPressed;
  const ButtonWhiteComponent(
      {Key? key, required this.text, required this.onPressed, this.colorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onPressed,
        child: Text(
          text,
        ));
  }
}

class ButtonComponentIcon extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color color;
  final IconData icon;
  final Color? colorText;
  const ButtonComponentIcon(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.color,
      required this.icon,
      this.colorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth:double.infinity,
        splashColor: Colors.transparent,
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: onPressed,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            icon,
            color: colorText ?? Colors.white,
          ),
          Text(text, style: TextStyle(color: colorText ?? Colors.white)),
        ]));
  }
}
