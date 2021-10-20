import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_provider_test/Model/Cliente.dart';

class Clientes2Screen extends StatefulWidget {
  Clientes2Screen({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _Clientes2ScreenState createState() => _Clientes2ScreenState();
}

class _Clientes2ScreenState extends State<Clientes2Screen> {

  StreamController<List<Cliente>> _streamController = StreamController<List<Cliente>>();
  late List<Cliente> listaCliente;
  int contador = 31;

  @override
  void initState(){
    super.initState();
    _carregarClientes();
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
    _streamController.close();
    print('1 - dispose');
  }

  _carregarClientes(){
    List<Cliente> clientes = <Cliente>[];
    for(int i = 1; i <= 30; i++){
      clientes.add(new Cliente(i, 'Teste $i', i, 0));
    }
    _streamController.add(clientes);
    /*Timer.periodic(Duration(seconds: 2), (timer) {
      clientes.add(new Cliente(contador, 'Teste $contador', contador, 0));
      contador++;
      if(contador == 55){
        clientes[9].nomcli = 'atualizado com sucesso';
      }
      if(contador > 60){
        timer.cancel();
      }
      _streamController.add(clientes);
    });*/

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Teste'),
      ),
      body: Center(
        child: Container(
          child: StreamBuilder<List<Cliente>>(
            stream: _streamController.stream,
            builder: (context, snapshot) {
               List<Cliente>? clientes;
               if(!snapshot.hasData){
                 return Center(
                     child: CircularProgressIndicator());
               }
              if(snapshot.hasData){
                clientes = snapshot.data;
              }
              return ListView.builder(
                itemCount: clientes!.length,
                itemBuilder: (context, index) {
                  Cliente cli = clientes![index];
                  print(index);
                  if(index % 20 == 0){
                    print('Resultado 0 aqui galera');
                  }
                    return _customLisTile(cli);
                });
            }
          ),
        ),
      ),
    );
  }

  ListTile _customLisTile(Cliente cli){
    return ListTile(
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
}
