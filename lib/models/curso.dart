class Curso {
  final String nome;
  final String modalidade;
  final String status;

  Curso({
    required this.nome,
    required this.modalidade,
    required this.status,
  });

  factory Curso.fromJson(Map<String, dynamic> json) {
    return Curso(
      nome: json['nome'],
      modalidade: json['modalidade'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'modalidade': modalidade,
    'status': status,
  };
}
