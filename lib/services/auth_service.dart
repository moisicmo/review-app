// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class AuthService extends ChangeNotifier {

  final storage =  const FlutterSecureStorage();

  Future writeToken( String token ) async {
    await storage.write(key: 'token', value: token);
    return;
  }
  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }
  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }


  Future registerQuestions() async {
    await storage.write(key: 'Question', value: 'exist');
    return null;
  }
  Future<String> readQuestions() async {
    return await storage.read(key: 'Question') ?? '';
  }
  Future logoutQuestions() async {
    await storage.delete(key: 'Question');
    return;
  }
}