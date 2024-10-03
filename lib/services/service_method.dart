import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:review/services/auth_service.dart';
import 'package:review/utils/dialog_action.dart';

Future<dynamic> serviceMethod(
    bool mounted,
    BuildContext context,
    String method,
    Map<String, dynamic>? body,
    String urlAPI,
    bool accessToken,
    bool errorState) async {
  final authService = Provider.of<AuthService>(context, listen: false);
  final Map<String, String> headers = {
    "Content-Type": "application/json",
  };
  if (accessToken) {
    headers["Authorization"] = "Bearer ${await authService.readToken()}";
  }
  if (await InternetConnectionChecker().connectionStatus ==
      InternetConnectionStatus.disconnected) {
    if (errorState) {
      if (!mounted) return;
      callDialogAction(context, 'Verifique su conexión a Internetttt');
    }
  }
  try {
    var url = Uri.parse(urlAPI);
    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    debugPrint('==========================================');
    debugPrint('== method $method');
    debugPrint('== url $url');
    debugPrint('== body $body');
    debugPrint('== headers $headers');
    debugPrint('==========================================');
    switch (method) {
      case 'get':
        return await http
            .get(url, headers: headers)
            .timeout(const Duration(seconds: 40))
            .then((value) {
          switch (value.statusCode) {
            case 200:
              return value;
            default:
              if (errorState) {
                callDialogAction(context, json.decode(value.body)['msg']);
              }
              return null;
          }
        }).catchError((err) {
          debugPrint('errA $err');
          if ('$err'.contains('html')) {
            callDialogAction(context,
                'Tenemos un problema con nuestro servidor, intente luego');
          } else if ('$err' == 'Software caused connection abort') {
            callDialogAction(context, 'Verifique su conexión a Internet');
          } else if (!errorState) {
            return null;
          } else {
            callDialogAction(
                context, 'Lamentamos los inconvenientes, intentalo de nuevo');
          }
          return null;
        });
      case 'post':
        debugPrint('headers $headers');
        debugPrint('url $url');
        return await http
            .post(url, headers: headers, body: json.encode(body))
            .timeout(const Duration(seconds: 40))
            .then((value) {
          debugPrint('statusCode ${value.statusCode}');
          debugPrint('value ${value.body}');
          switch (value.statusCode) {
            case 200:
              return value;
            default:
              if (errorState) {
                callDialogAction(context, json.decode(value.body)['msg']);
              }
              return null;
          }
        }).catchError((err) {
          debugPrint('errA $err');
          if ('$err'.contains('html')) {
            callDialogAction(context,
                'Tenemos un problema con nuestro servidor, intente luego');
          } else if ('$err' == 'Software caused connection abort') {
            callDialogAction(context, 'Verifique su conexión a Internet');
          } else if (!errorState) {
            return null;
          } else {
            callDialogAction(
                context, 'Lamentamos los inconvenientes, intentalo de nuevo');
          }
          return null;
        });
    }
  } on TimeoutException catch (e) {
    debugPrint('errB $e');

    if (!mounted) return;
    return callDialogAction(
        context, 'Tenemos un problema con nuestro servidor, intente luego');
  } on SocketException catch (e) {
    debugPrint('errC $e');
    if (!mounted) return;
    return callDialogAction(context, 'Verifique su conexión a Internet');
  } on ClientException catch (e) {
    debugPrint('errD $e');
    if (!mounted) return;
    return callDialogAction(context, 'Verifique su conexión a Internet');
  } on MissingPluginException catch (e) {
    debugPrint('errF $e');
    if (!mounted) return;
    return callDialogAction(context, 'Verifique su conexión a Internet');
  } catch (e) {
    debugPrint('errG $e');
    if (!mounted) return;
    callDialogAction(context, '$e');
  }
}

void callDialogAction(BuildContext context, String message) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => DialogAction(message: message));
}
