class Disciplina {
  final String? id;
  final String? alunoid;
  final String? codigo;
  final String? nome;
  final String? periodo;
  final int? ch;
  final int? faltas;
  final double? a1;
  final double? a2;
  final double? exameFinal;
  final double? mediaFinal;
  final String? status;

  Disciplina({
    this.id,
    this.alunoid,
    this.codigo,
    this.nome,
    this.periodo,
    this.ch,
    this.faltas,
    this.a1,
    this.a2,
    this.exameFinal,
    this.mediaFinal,
    this.status,
  });

  factory Disciplina.fromJson(Map<String, dynamic> json) {
    return Disciplina(
      id: json['id'] as String?,
      alunoid: json['alunoid'] as String?,
      codigo: json['codigo'] as String?,
      nome: json['nome'] as String?,
      periodo: json['periodo'] as String?,
      ch: json['ch'] is int ? json['ch'] as int : int.tryParse('${json['ch']}'),
      faltas: json['faltas'] is int ? json['faltas'] as int : int.tryParse('${json['faltas']}'),
      a1: (json['a1'] as num?)?.toDouble(),
      a2: (json['a2'] as num?)?.toDouble(),
      exameFinal: (json['exameFinal'] as num?)?.toDouble(),
      mediaFinal: (json['mediaFinal'] as num?)?.toDouble(),
      status: json['status'] as String?,
    );
  }
}
