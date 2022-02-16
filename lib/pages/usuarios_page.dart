import 'package:chatapp/models/usuario.dart';
import 'package:chatapp/services/auth_services.dart';
import 'package:chatapp/services/chat_service.dart';
import 'package:chatapp/services/socket_service.dart';
import 'package:chatapp/services/usuarios_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final usuariosService = new UsuariosService();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<Usuario> usuarios = [];

  @override
  void initState() {
    this._cargaUsuarios();
    super.initState();
  }

  /*final usuarios = [
    Usuario(uid: '1', nombre: 'Matea', email: 'test1@test.com', online: true),
    Usuario(uid: '2', nombre: 'Atenea', email: 'test2@test.com', online: false),
    Usuario(uid: '3', nombre: 'Monica', email: 'test3@test.com', online: true),
  ];*/
  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final usuario = authservice.usuario;
    return Scaffold(
        appBar: AppBar(
          title: Text(usuario.nombre,
              style: TextStyle(
                color: Colors.black45,
              )),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black54,
            ),
            onPressed: () {
              // desconecar del socker server
              socketService.disconnect();
              Navigator.pushReplacementNamed(context, 'login');
              AuthService.deleteToken();
            },
          ),
          actions: [
            Container(
                margin: EdgeInsets.only(right: 10),
                child: (socketService.serverStatus == ServerStatus.Online)
                    ? Icon(Icons.check_circle, color: Colors.blue[400])
                    : Icon(Icons.offline_bolt, color: Colors.red))
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _cargaUsuarios,
          header: WaterDropHeader(
              complete: Icon(Icons.check, color: Colors.blue[400]),
              waterDropColor: Colors.blue),
          child: _listViewUsuarios(),
        ));
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: usuarios.length,
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(usuario.nombre.substring(0, 2)),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: usuario.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.usuarioPara = usuario;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  _cargaUsuarios() async {
    this.usuarios = await usuariosService.getUsuarios();
    setState(() {});
    //await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
