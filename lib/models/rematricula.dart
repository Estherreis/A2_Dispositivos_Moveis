class Rematricula {
  final bool confirmada;
  final List<String> disciplinasSelecionadas;

  Rematricula({
    required this.confirmada,
    required this.disciplinasSelecionadas,
  });

  factory Rematricula.fromJson(Map<String, dynamic> json) {
    return Rematricula(
      confirmada: json['confirmada'],
      disciplinasSelecionadas:
      List<String>.from(json['disciplinasSelecionadas']),
    );
  }

  Map<String, dynamic> toJson() => {
    'confirmada': confirmada,
    'disciplinasSelecionadas': disciplinasSelecionadas,
  };
}
