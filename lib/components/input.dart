import 'package:flutter/material.dart';
class InputComponent extends StatelessWidget {
  final IconData? icon;
  final String labelText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController controllerText;
  final Function() onEditingComplete;
  final Function(String) validator;
  final bool obscureText;
  final Function()? onTap;
  final IconData? iconOnTap;
  final TextCapitalization textCapitalization;
  final Function(String)? onChanged;
  final Function()? onTapInput;
  const InputComponent({Key? key, 
    required this.labelText,
    required this.keyboardType,
    required this.textInputAction,
    required this.controllerText,
    required this.onEditingComplete,
    required this.validator,

    this.icon,
    this.obscureText=false,
    this.onTap,
    this.iconOnTap,
    this.textCapitalization=TextCapitalization.none,
    this.onChanged,
    this.onTapInput
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
    child:
    TextFormField(
      textCapitalization : textCapitalization,
      textInputAction: textInputAction,
      onEditingComplete: onEditingComplete,
      validator:(text)=>validator(text!),
      controller: controllerText,
      onChanged: onChanged,
      onTap:onTapInput,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
        suffixIcon: InkWell(
          onTap: onTap,
          child: Icon(iconOnTap),
        ),
        labelText: labelText),
    ));
  }
}

class ComponentSearch extends StatelessWidget {
  final IconData? icon;
  final String labelText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController controllerText;
  final bool obscureText;
  final Function()? onTap;
  final IconData? iconOnTap;
  final TextCapitalization textCapitalization;
  final Function(String)? onChanged;
  final Function()? onTapInput;
  const ComponentSearch({Key? key, 
    required this.labelText,
    required this.keyboardType,
    required this.textInputAction,
    required this.controllerText,

    this.icon,
    this.obscureText=false,
    this.onTap,
    this.iconOnTap,
    this.textCapitalization=TextCapitalization.none,
    this.onChanged,
    this.onTapInput
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
    child:
    TextFormField(
      textCapitalization : textCapitalization,
      textInputAction: textInputAction,
      controller: controllerText,
      onChanged: onChanged,
      onTap:onTapInput,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
          border: OutlineInputBorder( borderRadius: BorderRadius.circular(8.0)),
          labelStyle: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xffBCBCBC)),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Color(0xffBCBCBC),
              width: 2.0,
            ),
          ),
          labelText: labelText),
    ));
  }
}