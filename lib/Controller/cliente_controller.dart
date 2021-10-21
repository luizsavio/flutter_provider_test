import 'package:flutter/material.dart';
import 'package:flutter_provider_test/Model/Cliente.dart';

class ClienteController with ChangeNotifier {

  ClienteController(){
    _contador = listaCliente.length;
  }

  int _count = 0;

  int get count => _count;

  set count(int value) {
    _count = value;
    notifyListeners();
  }

  int _contador = 0;

  int get contador => _contador;

  late List<Cliente> listaCliente = <Cliente>[
    Cliente(codcli: 1, nomcli: 'Savio', agecli: 25, contador: 0, documentId: ''),
    Cliente(codcli: 1, nomcli: 'Gabriel', agecli: 23, contador: 0, documentId: ''),
    Cliente(codcli: 1, nomcli: 'Sarah', agecli: 42, contador: 0, documentId: ''),
    Cliente(codcli: 1, nomcli: 'Marcos', agecli: 20, contador: 0, documentId: ''),
    Cliente(codcli: 1, nomcli: 'Fabricio', agecli: 25, contador: 0, documentId: ''),
  ];

   void adicionaItemLista(Cliente cli){
     this.listaCliente.add(cli);
     _contador = this.listaCliente.length;
     print(this.listaCliente.asMap());
     notifyListeners();
   }

   void alteraItemLista(Cliente cli){
     Cliente cliEnc = this.listaCliente.singleWhere((element) => element.codcli == cli.codcli);
     if(cliEnc.codcli > 0){
       /*for (var value in this.listaCliente) {
         if(value.codcli == cli.codcli){
           value = cli;
         }
       }*/
       this.listaCliente.asMap().forEach((index, element) {
         if(element.codcli == cli.codcli){
           this.listaCliente[index] = cli;
         }
       });
     }
     notifyListeners();
   }
}
