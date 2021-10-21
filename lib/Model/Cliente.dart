class Cliente{
  late int codcli;
  late String nomcli;
  late int agecli;
  late int contador;
  late String documentId;

  Cliente({required this.codcli, required this.nomcli, required this.agecli, required this.contador, required this.documentId});

  Map<String, dynamic> toMap() {
    return {
      'codcli': codcli,
      'nomcli': nomcli,
      'agecli': agecli,
      'contador': contador,
      'documentId' : documentId
    };
  }

  static Cliente fromMap(Map<String, dynamic> map, dynamic documentId) {

    return Cliente(
      codcli: int.parse(map['codcli'].toString()),
      nomcli: map['nomcli'].toString(),
      agecli: int.parse(map['agecli'].toString()),
      contador: int.parse(map['contador'].toString()),
      documentId: documentId,
    );
  }
}