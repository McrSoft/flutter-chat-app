import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chatapp/models/mensajes_response.dart';
import 'package:chatapp/services/auth_services.dart';

import 'package:chatapp/models/usuario.dart';
import 'package:chatapp/global/environment.dart';

class ChatService with ChangeNotifier {
  late Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    final uri = Uri.parse('${Environment.apiUrl}/mensajes/$usuarioID');
    final token = await AuthService.getToken();
    final resp = await http.get(uri,
        headers: {'Content-Type': 'application/json', 'x-token': token});

    final mensajesResp = mensajesResponseFromJson(resp.body);

    return mensajesResp.mensajes;
  }
}
