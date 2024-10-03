import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//  widget que se ajusta en la parte superior
class HedersComponent extends StatelessWidget {
  final String title;
  final String? titleExtra;
  final bool stateBack;
  final Function()? onPressMenu;
  final bool center;
  final GlobalKey? keyMenu;
  const HedersComponent(
      {Key? key,
      required this.title,
      this.titleExtra,
      this.stateBack = false,
      this.onPressMenu,
      this.center = false,
      this.keyMenu})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (stateBack)
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: const Icon(Icons.arrow_back_ios_sharp)
                    )),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('AJUSTES'),
                    Text(title,
                        textAlign: center ? TextAlign.center : TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.sp)),
                    if (titleExtra != null)
                      Text(titleExtra!,
                          style: const TextStyle(fontWeight: FontWeight.w500))
                  ],
                ),
              ),
            ],
          ),
        ),
        Image.asset(
          'assets/icons/favico.png',
          fit: BoxFit.cover,
          height: 40.sp,
        ),
      ],
    );
  }
}
