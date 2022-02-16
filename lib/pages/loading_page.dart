import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/pages/usuarios_page.dart';
import 'package:chatapp/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chatapp/services/auth_services.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLogginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('Espere...'),
          );
        },
      ),
    );
  }

  Future checkLogginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);
    final autenticado = await authService.isLoggedIn();
    if (autenticado) {
      socketService.connect();
      //Navigator.pushReplacementNamed(context, 'usuarios');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => UsuariosPage(),
            transitionDuration: Duration(milliseconds: 0),
          ));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => LoginPage(),
            transitionDuration: Duration(milliseconds: 0),
          ));
    }
  }
}
