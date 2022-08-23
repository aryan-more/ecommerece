import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:ecommerece/utils/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Hashing password even if they hashed again at server , to avoid man in middle attack
String _hashPassword(String password) {
  return sha256.convert(password.codeUnits).toString();
}

Future<http.Response> signUp({
  required BuildContext context,
  required String email,
  required String password,
  required String username,
  required String phone,
}) async {
  http.Response response = await http.post(
    Uri.parse("$domain/signup"),
    headers: jsonHeader,
    body: jsonEncode({
      "name": username,
      "email": email,
      "password": _hashPassword(password),
      "phone": phone,
    }),
  );

  log("${response.statusCode} ${response.body}");
  return response;
}

Future<http.Response> signIn({
  required BuildContext context,
  required String contact,
  required String password,
}) async {
  http.Response response = await http.post(
    Uri.parse("$domain/signin"),
    headers: jsonHeader,
    body: jsonEncode({
      "user_contact": contact,
      "password": _hashPassword(password),
    }),
  );

  log("${response.statusCode} ${response.body}");
  return response;
}
