import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_provider_test/Controller/cliente_controller.dart';
import 'package:flutter_provider_test/Model/Cliente.dart';
import 'package:provider/provider.dart';

class ClientesScreen extends StatefulWidget {
  ClientesScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ClientesScreenState createState() => _ClientesScreenState();
}

class _ClientesScreenState extends State<ClientesScreen> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ClienteController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${widget.title} ${context.watch<ClienteController>().contador}'),
      ),
      body: Center(
        child: Container(
          child: ListView(
              children: data.listaCliente.map((e) => Text(e.nomcli)).toList()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context
            .read<ClienteController>()
            .adicionaItemLista(new Cliente(60, 'Teste', 50, 0)),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  ListTile _customLisTile(Cliente cli){
    return ListTile(
      title: Text(cli.nomcli),
      subtitle: Column(children: [
        Text(cli.codcli.toString()),
        Text(cli.contador.toString())
      ], ),
    );
  }
}
