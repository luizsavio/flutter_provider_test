import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_provider_test/Controller/cliente_controller.dart';
import 'package:flutter_provider_test/Model/Cliente.dart';
import 'package:flutter_provider_test/View/cliente_screen.dart';
import 'package:flutter_provider_test/widgets/custom_modal.dart';
import 'package:provider/provider.dart';

class ClientesScreen extends StatefulWidget {
  ClientesScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ClientesScreenState createState() => _ClientesScreenState();
}

class _ClientesScreenState extends State<ClientesScreen> {

  @override
  void initState(){
    super.initState();
    print('1 - initState');
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    print('1 - didChangeDependencies');
  }

  @override
  void dispose(){
    super.dispose();
    print('1 - dispose');
  }

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
              children: data.listaCliente.map((e) => _customLisTile(e)).toList()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(context: context, builder: (ctx) => pageDetalheCliente(new Cliente(0, '', 0, 0))),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  ListTile _customLisTile(Cliente cli){
    return ListTile(
      onTap: () => showDialog(context: context, builder: (context) => pageDetalheCliente(cli)),
      title: Text(cli.nomcli),
      subtitle: Row(children: [
        Column(
          children: [
            Text('agcli : ${cli.agecli.toString()}'),
            Text('Contador : ${cli.contador.toString()}')
          ],
        )

      ], ),
    );
  }

  Widget pageDetalheCliente(Cliente cliente) {
    return CustomModal(
      modalTitleTxt: cliente.nomcli,
      modalTitleSz: 16,
      modalTitleBold: true,
      ellipsis: true,
      maxLines: 2,
      modalBody: ClienteScreen(title: 'user',cliente: cliente,),
      modalWidth: 800,
      modalHeight: 550,
      modalFooter: Container(height: 10,),
    );
  }
}
