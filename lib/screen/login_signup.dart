// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_4/config/palette.dart';
import 'package:flutter_application_4/provider/login_provider.dart';
import 'package:flutter_application_4/style/custom_inputs.dart';
import 'package:provider/provider.dart';

class LoginSignup extends StatefulWidget {
  const LoginSignup({Key? key}) : super(key: key);

  @override
  State<LoginSignup> createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Provider.of<LoginProvider>(context, listen: false).initClear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<LoginProvider>(context);
    return Scaffold(
        backgroundColor: Palette.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image(
                    width: double.infinity,
                    height:
                        MediaQuery.of(context).size.height < 690 ? 300 : 360.0,
                    fit: BoxFit.cover,
                    image: const AssetImage('assets/menu.jpg'),
                  ),
                  Center(
                    child: Image(
                      width: size.height < 690 ? 250 : 300.0,
                      height: size.height < 690 ? 250 : 300.0,
                      fit: BoxFit.cover,
                      image: const AssetImage('assets/logo.png'),
                    ),
                  ),
                  Positioned(
                    top: size.height < 690 ? 250 : 300.0,
                    left: size.width < 420 ? size.width / 6 : size.width / 3.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Powered by Tecosistemas  Copyrigh (c) 2022',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 255, 254, 254),
                              fontSize: size.width < 420 ? 13 : 15),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50.0),
                  )
                ],
              ),
              Transform.translate(
                offset: const Offset(0.0, -20.0),
                child: Container(
                  width: double.infinity,
                  height: 600,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'CONTROL DE RUTAS',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0),
                          ),
                          const Text(
                            '',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15.0),
                          ),
                          Form(
                            key: _formKey,
                            child: Container(
                              margin: const EdgeInsets.only(top: 20),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  buildTextField('Usuario', Icons.person, false,
                                      true, provider.txtUsuario, ((p0) {
                                    if (provider.txtUsuario.text.isEmpty) {
                                      return "Requerido";
                                    }
                                    return null;
                                  })),
                                  buildTextField('Contraseña', Icons.lock, true,
                                      false, provider.txtPass, ((p0) {
                                    if (provider.txtUsuario.text.isEmpty) {
                                      return "Requerido";
                                    }
                                    return null;
                                  }))
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 14, 36, 77),
                                shape: const StadiumBorder()),
                            onPressed: () async {
                              provider.isLoanding(true);
                              if (_formKey.currentState!.validate()) {
                                bool response = await provider.login();
                                if (response) {
                                  await provider.fillEmp();
                                  provider.savePreferencias();
                                  Navigator.pushReplacementNamed(
                                      context, 'homePage');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Credenciales invalidas')),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Error.....')),
                                );
                              }
                              provider.isLoanding(false);
                            },
                            child: (provider.isLoading)
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 1.5,
                                    ))
                                : const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'Iniciar Session',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                          ),
                          const Text(
                            'versión: 2.0.0',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

Widget buildTextField(String hint, IconData icon, bool isPassword, bool isEmail,
    TextEditingController controller, String? Function(String?) fc) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15.0),
    child: TextFormField(
      obscureText: isPassword,
      validator: fc,
      textCapitalization: TextCapitalization.characters,
      inputFormatters: [LengthLimitingTextInputFormatter(4)],
      controller: controller,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      decoration: CustomInputs.loginInputDecoration(hint: hint, icon: icon),
    ),
  );
}
