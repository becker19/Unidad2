import 'package:flutter/material.dart';
import 'package:sesion9mod/services/index.dart';

import 'package:sesion9mod/share_prefences/preferences.dart';
import 'package:provider/provider.dart';
import 'package:sesion9mod/routes/route.dart';

import 'package:sesion9mod/providers/provider_login.dart';
import 'package:sesion9mod/providers/provider_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => ProviderTheme(isDarkMode: Preferences.theme),
      ),
      ChangeNotifierProvider(
        create: (_) => ProviderLogin(),
      ),
      ChangeNotifierProvider(
        create: (_) => AuthService(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      scaffoldMessengerKey: MsgAuth.msgkey,
      onGenerateRoute: MyRoutes.generateRoute,
      initialRoute: MyRoutes.rVerify,
      theme: Provider.of<ProviderTheme>(context).currentTheme,
    );
  }
}
