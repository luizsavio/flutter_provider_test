import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_provider_test/Controller/cliente_controller.dart';
import 'package:flutter_provider_test/Model/Cliente.dart';
import 'package:flutter_provider_test/widgets/custom_modal.dart';
import 'package:provider/provider.dart';

class ClienteScreen extends StatefulWidget {
  ClienteScreen({Key? key, required this.title, this.cliente})
      : super(key: key);

  final String title;
  late Cliente? cliente;

  @override
  _ClienteScreenState createState() => _ClienteScreenState();
}

class _ClienteScreenState extends State<ClienteScreen> {
  TextEditingController _txtCodCliController = TextEditingController();
  TextEditingController _txtNomCliController = TextEditingController();
  TextEditingController _txtAgeCliController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.cliente!.codcli > 0) {
      print('to passando');
      _txtCodCliController.text = widget.cliente!.codcli.toString();
      _txtNomCliController.text = widget.cliente!.nomcli;
      _txtAgeCliController.text = widget.cliente!.agecli.toString();
    }
    final data = Provider.of<ClienteController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${widget.title} ${context.watch<ClienteController>().contador}'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _txtCodCliController,
                decoration: InputDecoration(labelText: 'Codigo'),
              ),
              TextField(
                  controller: _txtNomCliController,
                  decoration: InputDecoration(labelText: 'nome')),
              TextField(
                controller: _txtAgeCliController,
                decoration: InputDecoration(labelText: 'idade'),
              ),
              RaisedButton(
                  onPressed: () {
                    if (widget.cliente!.codcli > 0) {
                      context.read<ClienteController>().alteraItemLista(Cliente(codcli: int.parse(_txtCodCliController.text), nomcli: _txtNomCliController.text, agecli: int.parse(_txtAgeCliController.text), contador: 0, documentId: ''));
                    } else {
                      context.read<ClienteController>().adicionaItemLista(
                          Cliente(codcli: int.parse(_txtCodCliController.text), nomcli: _txtNomCliController.text, agecli: int.parse(_txtAgeCliController.text), contador: 0, documentId: ''));
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text('Vai filho'))
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
