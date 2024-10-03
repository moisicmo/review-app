import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:review/main.dart';
import 'package:review/provider/answersData.dart';
import 'package:review/services/auth_service.dart';
import 'package:review/services/sendData.dart';
import 'package:review/services/service_method.dart';
import 'package:review/services/services.dart';
import 'package:review/services/update.dart';
import 'package:review/src/screens/settings/settings.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:review/components/button.dart';

class ScreenLogin extends StatefulWidget {
  final bool isback;
  const ScreenLogin({Key? key, this.isback = false}) : super(key: key);

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  CountdownController _controller = CountdownController(autoStart: false);
  final deviceInfo = DeviceInfoPlugin();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  bool hidePassword = true;
  FocusNode? _focus;
  String deviceId = '';
  bool stateLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isback) {
      _controller = CountdownController(autoStart: true);
    }
    getId();
  }

  Future<void> getId() async {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    debugPrint('androidDeviceInfo ${androidDeviceInfo.androidId}');
    prefs!.setString('deviceId', androidDeviceInfo.androidId!);
    return setState(() => deviceId = androidDeviceInfo.androidId!);
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    final answersProvider = Provider.of<AnswersProvider>(context);
    return Scaffold(
      body: Row(
        children: <Widget>[
          Countdown(
              controller: _controller,
              seconds: 10,
              build: (_, double time) => Container(),
              interval: const Duration(milliseconds: 100),
              onFinished: () {
                Navigator.pop(context);
              }),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          child: Center(
                              child: Image.asset("assets/icons/favico.png"))),
                      if (answersProvider.answers.isNotEmpty)
                        ButtonComponent(
                          text: 'ENVIAR DATOS',
                          onPressed: !stateLoading
                              ? () async {
                                  setState(() => stateLoading = !stateLoading);
                                  await sendData(context);
                                  await update(context);
                                  setState(() => stateLoading = !stateLoading);
                                }
                              : null,
                        ),
                    ],
                  ))),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: !stateLoading
                  ? Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Código del dispositivo: $deviceId'),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            focusNode: _focus,
                            onChanged: (text) {
                              if (widget.isback) _controller.restart();
                            },
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                if (value.contains('@unifranz.edu.bo')) {
                                  return null;
                                } else {
                                  return 'El correo no es valido';
                                }
                              } else {
                                return 'Ingrese su USUARIO';
                              }
                            },
                            controller: userName,
                            decoration:
                                const InputDecoration(labelText: "Usuario"),
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            onEditingComplete: () => sing(),
                            onChanged: (text) {
                              if (widget.isback) _controller.restart();
                            },
                            validator: (value) {
                              if (value!.length >= 6) {
                                return null;
                              } else {
                                return 'Ingrese su CONTRASEÑA';
                              }
                            },
                            controller: userPassword,
                            obscureText: hidePassword,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  onTap: () => setState(
                                      () => hidePassword = !hidePassword),
                                  child: Icon(
                                    hidePassword
                                        ? Icons.lock_outline
                                        : Icons.lock_open_sharp,
                                  ),
                                ),
                                labelText: "Contraseña"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ButtonComponent(
                            text: 'INICIAR SESIÓN',
                            onPressed: () => sing(),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Image.asset(
                      'assets/load.gif',
                      fit: BoxFit.cover,
                      height: 20,
                    )),
            ),
          ),
        ],
      ),
    );
  }

  sing() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      _controller.onPause!();
      setState(() => stateLoading = !stateLoading);
      final Map<String, dynamic> body = {
        'email': userName.text.trim(),
        'password': userPassword.text.trim(),
        'deviceId': deviceId
      };
      var response = await serviceMethod(
          mounted, context, 'post', body, serviceAuthSession(), false,true);
      setState(() => stateLoading = !stateLoading);
      if (response != null) {
        await authService.writeToken(json.decode(response.body)['token']);
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PageSettingQualifier(
                    data: json.decode(response.body),
                  )),
        );
      } else if (widget.isback) {
        _controller.onResume!();
      }
    }
  }
}
