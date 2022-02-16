import 'package:http/http.dart' as http;

import 'package:chatapp/global/environment.dart';
import 'package:chatapp/models/usuario.dart';
import 'package:chatapp/services/auth_services.dart';
import 'package:chatapp/models/usuarios_response.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final String? token = await AuthService.getToken();
      final uri = Uri.parse('${Environment.apiUrl}/usuarios');
      final resp = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'x-token': token.toString()
      });
      final usuariosResponse = usuariosResponseFromJson(resp.body);
      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
