import 'package:chatapp/helpers/mostrar_alerta.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chatapp/services/auth_services.dart';
import 'package:chatapp/widgets/buton_azul.dart';
import 'package:chatapp/widgets/custom_input.dart';
import 'package:chatapp/widgets/custom_label.dart';
import 'package:chatapp/widgets/custom_logo.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomLogo(
                      imagen: AssetImage('assets/logoico.png'),
                      titulo: 'Mensajero'),
                  _Form(),
                  CustomLabel(
                    ruta: 'register',
                    titulo: 'No tienes Cuenta?',
                    subtitulo: 'Crea una ahora!!',
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
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
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
              text: 'Ingrese',
              onPressed: authService.autenticando
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();

                      final loginOk = await authService.login(
                          emailCtrl.text.trim(), passCtrl.text.trim());

                      if (loginOk) {
                        // conecetar al socket serice
                        Navigator.pushReplacementNamed(context, 'usuarios');
                      } else {
                        mostrarAlerta(context, 'Login incorrecto',
                            'Revise informacion por favor!');
                      }
                    })
        ],
      ),
    );
  }
}
