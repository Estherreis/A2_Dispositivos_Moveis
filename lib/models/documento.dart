class Documento {
  final String nome;
  final String status;

  Documento({
    required this.nome,
    required this.status,
  });

  factory Documento.fromJson(Map<String, dynamic> json) {
    return Documento(
      nome: json['nome'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'status': status,
  };
}
