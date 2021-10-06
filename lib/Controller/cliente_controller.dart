import 'package:flutter/material.dart';
import 'package:flutter_provider_test/Model/Cliente.dart';

class ClienteController with ChangeNotifier {

  ClienteController(){
    _contador = listaCliente.length;
  }

  int _contador = 0;

  int get contador => _contador;

  late List<Cliente> listaCliente = <Cliente>[
    Cliente(1, 'Savio', 25, 0),
    Cliente(2, 'Gabriel', 23, 0),
    Cliente(3, 'Sarah', 42, 0),
    Cliente(4, 'Marcos', 20, 0),
    Cliente(5, 'Fabricio', 18, 0)
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
