import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sesion9mod/routes/route.dart';
import 'package:sesion9mod/screens/index.dart';
import 'package:sesion9mod/services/service_auth.dart';

class VerifyAuthScreen extends StatelessWidget {
  const VerifyAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: authService.leerToken(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData)
                //ignore: curly_braces_in_flow_control_structures
                return const Text(
                  'Espere...',
                  style: TextStyle(fontSize: 28),
                );
              // return Text('');

              if (snapshot.data == '') {
                Future.microtask(
                  () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, MyRoutes.rLOGIN, (route) => false);
                  },
                );
              } else {
                Future.microtask(
                  () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, MyRoutes.rHOME, (route) => false);
                  },
                );
              }

              return Container();
            }),
      ),
    );

    // Scaffold(
    //   body: Center(
    //     child: FutureBuilder(
    //       future: authService.leerToken(),
    //       builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
    //         print(snapshot);
    //         if (!snapshot.hasData) {
    //           return const Text(
    //             'Espere...',
    //             style: TextStyle(fontSize: 28),
    //           );
    //         }

    //         if (snapshot.data == '') {
    //           print('RESULT: ' + snapshot.data!);
    //           Future.microtask(() {
    //             // Navigator.pushReplacement(
    //             //   context,
    //             //   PageRouteBuilder(
    //             //     pageBuilder: (_, __, ___) => const LoginScreen(),
    //             //     transitionDuration: const Duration(seconds: 0),
    //             //   ),
    //             // );
    //             Navigator.pushNamedAndRemoveUntil(
    //                 context, MyRoutes.rLOGIN, (route) => false);
    //           });
    //         } else {
    //           Future.microtask(() {
    //             // Navigator.pushReplacement(
    //             //   context,
    //             //   PageRouteBuilder(
    //             //     pageBuilder: (_, __, ___) => const HomeScreen(),
    //             //     transitionDuration: const Duration(seconds: 0),
    //             //   ),
    //             // );
    //             Navigator.pushNamedAndRemoveUntil(
    //                 context, MyRoutes.rHOME, (route) => false);
    //           });
    //         }
    //         return Container();
    //       },
    //     ),
    //   ),
    // );
  }
}
