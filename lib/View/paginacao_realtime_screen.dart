import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_test/Controller/cliente_controller.dart';
import 'package:flutter_provider_test/Model/Cliente.dart';
import 'package:flutter_provider_test/Services/firestore_meujeito_service.dart';
import 'package:provider/provider.dart';

class PaginacaoRealtimeScreen extends StatefulWidget {
  @override
  _PaginacaoRealtimeScreenState createState() =>
      _PaginacaoRealtimeScreenState();
}

class _PaginacaoRealtimeScreenState extends State<PaginacaoRealtimeScreen> {
  ScrollController _scrollController = ScrollController();
  late Stream streamController;
  List<Cliente> ts = <Cliente>[];
  bool vai = false;


  @override
  initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('pixel: ${_scrollController.position.pixels}, max : ${_scrollController.position.maxScrollExtent}');
        setState(() {
          vai = true;
        });

      }
    });

    streamController = FirestoreMeuJeitoService.listenToPostsRealTime();
    print('1 - initState');
  }

  Future<void> teste() async {
    for (int i = 0; i < 90; i++) {
      await FirebaseFirestore.instance.collection('teste').doc(i.toString()).set(Cliente(
          codcli: i,
          nomcli: 'nomcli $i',
          agecli: i,
          contador: i,
          documentId: 'i').toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    //var data = Provider.of<ClienteController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Teste'),
      ),
      body: Center(
        child: Container(
          child: StreamBuilder(
              stream: streamController,
              builder: (context, snapshot) {
                List<Cliente>? clientes;
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  clientes = snapshot.data as List<Cliente>?;
                  print('tamanho lista ${clientes!.length}');
                }
                //return Container();
                return ListView.builder(
                    controller: _scrollController,
                    itemCount: clientes!.length,
                    itemBuilder: (context, index) {

                      Cliente cli = clientes![index];
                      //print(index);

                      if(index == clientes.length-1 && vai){
                        print('Resultado pau aqui galera');
                        FirestoreMeuJeitoService.listenToPostsRealTime();
                        vai = false;
                      }
                      return _customLisTile(cli);
                    });
              }),
        ),
      ),
    );
  }

  ListTile _customLisTile(Cliente cli) {
    return ListTile(
      title: Text(cli.nomcli),
      subtitle: Row(
        children: [
          Column(
            children: [
              Text('agcli : ${cli.agecli.toString()}'),
              Text('Contador : ${cli.contador.toString()}')
            ],
          )
        ],
      ),
    );
  }
}
