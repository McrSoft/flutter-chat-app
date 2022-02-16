import 'package:chatapp/helpers/mostrar_alerta.dart';
import 'package:chatapp/services/auth_services.dart';
import 'package:chatapp/services/socket_service.dart';
import 'package:chatapp/widgets/buton_azul.dart';
import 'package:chatapp/widgets/custom_input.dart';
import 'package:chatapp/widgets/custom_label.dart';
import 'package:chatapp/widgets/custom_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomLogo(
                      imagen: AssetImage('assets/logoico.png'),
                      titulo: 'Registro'),
                  _Form(),
                  CustomLabel(
                    ruta: 'login',
                    titulo: '¿Ya tienes cuenta?',
                    subtitulo: 'Ingresa Ahora',
                  ),
                  Text('Términos y Condiciones de uso',
                      style: TextStyle(fontWeight: FontWeight.w200)),
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
            textController: nameCtrl,
          ),
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Password',
            isPassword: true,
            textController: passCtrl,
          ),
          ButonAzul(
              text: 'Crear Cuenta',
              onPressed: authService.registrando
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();

                      final registerOk = await authService.register(
                          nameCtrl.text.trim(),
                          emailCtrl.text.trim(),
                          passCtrl.text.trim());

                      if (registerOk == true) {
                        socketService.connect();
                        Navigator.pushReplacementNamed(context, 'usuarios');
                      } else {
                        mostrarAlerta(
                            context, 'Registro incorrecto', registerOk);
                      }
                    })
        ],
      ),
    );
  }
}
