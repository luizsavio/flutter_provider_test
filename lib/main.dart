import 'package:flutter/material.dart';
import 'package:flutter_provider_test/Controller/cliente_controller.dart';
import 'package:flutter_provider_test/View/clientes_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ClienteController())
        ],
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ClientesScreen(title: 'Usuarios'),
    ),);
  }
}
