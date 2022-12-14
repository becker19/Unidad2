import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sesion9mod/providers/provider_login.dart';
import 'package:sesion9mod/routes/route.dart';
import 'package:sesion9mod/services/index.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          final FocusScopeNode focus = FocusScope.of(context);
          if (!focus.hasPrimaryFocus && focus.hasFocus) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  child: Lottie.network(
                      'https://assets2.lottiefiles.com/packages/lf20_ucbyrun5.json'),
                ),
                ChangeNotifierProvider(
                  create: (context) => ProviderLogin(),
                  child: _LoginForm(),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, MyRoutes.rREGISTER);
                  },
                  child: const Text(
                    'Crear nueva cuenta',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  @override
  State<_LoginForm> createState() => __LoginFormState();
}

class __LoginFormState extends State<_LoginForm> {
  bool _ispassword = true;

  void _viewPassword() {
    setState(() {
      _ispassword = !_ispassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<ProviderLogin>(context);
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: loginProvider.formkey,
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.black),
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: _buildDecoration(
                  hintText: 'dev@flutter.com',
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Colors.green,
                  ),
                ),
                onChanged: (value) => loginProvider.email = value,
                validator: (value) {
                  String caracteres =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                  RegExp regExp = RegExp(caracteres);

                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'No es un correo NO valido';
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                autocorrect: false,
                obscureText: _ispassword,
                keyboardType: TextInputType.text,
                decoration: _buildDecoration(
                  hintText: '********',
                  prefixIcon: const Icon(
                    Icons.key_outlined,
                    color: Colors.green,
                  ),
                  suffixIcon: InkWell(
                    onTap: _viewPassword,
                    child: Icon(
                        _ispassword ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
                onChanged: (value) => loginProvider.password = value,
                validator: (value) {
                  return (value != null && value.length >= 8)
                      ? null
                      : 'Debe tener minimo 8 caracteres';
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 250,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  disabledColor: Colors.green,
                  elevation: 1,
                  color: Colors.green,
                  onPressed: loginProvider.isLoading
                      ? null
                      : () async {
                          FocusScope.of(context).unfocus();

                          final authService =
                              Provider.of<AuthService>(context, listen: false);

                          if (!loginProvider.isValidForm()) return;

                          loginProvider.isLoading = true;

                          final String? errorMessage = await authService.login(
                              loginProvider.email, loginProvider.password);

                          if (errorMessage == null) {
                            MsgAuth.verSnackbar('Bienvenido!');
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacementNamed(
                                context, MyRoutes.rHOME);
                          } else {
                            MsgAuth.verSnackbar(
                                'Correo y/o contrase??a invalido!');
                            loginProvider.isLoading = false;
                          }
                        },
                  child: (loginProvider.isLoading)
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          'INGRESAR',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

InputDecoration _buildDecoration({
  final String? hintText,
  final Widget? prefixIcon,
  final Widget? suffixIcon,
}) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 2, color: Colors.green),
      borderRadius: BorderRadius.circular(15),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 2, color: Colors.green),
      borderRadius: BorderRadius.circular(15),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 2, color: Colors.green),
      borderRadius: BorderRadius.circular(15),
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(width: 2, color: Colors.green),
      borderRadius: BorderRadius.circular(15),
    ),
    filled: true,
    fillColor: Colors.white,
    hintText: hintText,
    hintStyle: const TextStyle(color: Colors.grey),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    contentPadding: const EdgeInsets.all(18),
  );
}
