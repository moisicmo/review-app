import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerComponent extends StatelessWidget {
  final String textContainer;
  final Function() onTap;
  const ContainerComponent(
      {Key? key,
      required this.textContainer,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        minWidth:double.infinity,
          elevation: 0,
          focusElevation: 0,
          autofocus: true,
          onPressed: onTap,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                color: Colors.grey,
                width: 2.0,
              )),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Text(textContainer,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                  color:Colors.black
                  // color: ThemeProvider.themeOf(context).data.primaryColor,
                )))
    );
  }
}


class ContainerCom extends StatelessWidget {
  final Widget child;
  const ContainerCom(
      {Key? key,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        minWidth:double.infinity,
          elevation: 0,
          focusElevation: 0,
          autofocus: true,
          onPressed: (){},
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                color: Colors.grey,
                width: 2.0,
              )),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: child)
    );
  }
}
