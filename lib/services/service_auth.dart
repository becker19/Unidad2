import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebasekey = 'AIzaSyAC7EIQeNxGzxMGd1WN-fuTs-hHBUIp8cI';

  final storage = const FlutterSecureStorage();

  //REGISTRAR NUEVO USUARIO
  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebasekey});
    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResponse = json.decode(response.body);

    if (decodeResponse.containsKey('idToken')) {
      storage.write(key: 'token', value: decodeResponse['idtoken']);
      return null;
    } else {
      return decodeResponse['error']['message'];
    }
  }

  //LOGIN
  // Future<String?> login(String email, String password) async {
  //   final Map<String, dynamic> authData = {
  //     'email': email,
  //     'password': password,
  //   };

  //   final url = Uri.https(
  //       _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebasekey});

  //   final resp = await http.post(url, body: json.encode(authData));
  //   final Map<String, dynamic> decodedResp = json.decode(resp.body);

  //   if (decodedResp.containsKey('idToken')) {
  //     //GUARDAR EL TOKEN
  //     storage.write(key: 'token', value: decodedResp['idToken']);
  //     // return decodedResp['idToken'];
  //     return null;
  //   } else {
  //     return decodedResp['error']['message'];
  //   }
  // }
  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebasekey});
    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResponse = json.decode(response.body);

    if (decodeResponse.containsKey('idToken')) {
      storage.write(key: 'token', value: decodeResponse['idToken']);
      return null;
    } else {
      return decodeResponse['error']['message'];
    }
  }

  //CERRAR SESION
  Future cerrarSesion() async {
    await storage.delete(key: 'token');
    return;
  }

  //VERIFICAR TOKEN
  Future<String> leerToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
