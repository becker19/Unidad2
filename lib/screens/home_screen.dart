import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sesion9mod/routes/route.dart';
import 'package:sesion9mod/services/service_auth.dart';

import 'package:sesion9mod/widgets/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Almacenamiento'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              authService.cerrarSesion();
              Navigator.pushReplacementNamed(context, MyRoutes.rLOGIN);
            },
            icon: const Icon(
              Icons.login_outlined,
              color: Colors.red,
            ),
          ),
        ],
      ),
      drawer: const CustomDrawerWidget(),
      body: const Center(
        child: Text('BIENVENIDO'),
      ),
    );
  }
}
