import 'documento.dart';
import 'rematricula.dart';

class Aluno {
  final String id;
  final String nome;
  final String email;
  final String senha;
  final String situacao;
  final int progresso;
  final List<Documento> documentos;
  final Rematricula rematricula;

  Aluno({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.situacao,
    required this.progresso,
    required this.documentos,
    required this.rematricula,
  });

  factory Aluno.fromJson(Map<String, dynamic> json) {
    return Aluno(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      senha: json['senha'],
      situacao: json['situacao'],
      progresso: json['progresso'],
      documentos: (json['documentos'] as List)
          .map((doc) => Documento.fromJson(doc))
          .toList(),
      rematricula: Rematricula.fromJson(json['rematricula']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'email': email,
    'senha': senha,
    'situacao': situacao,
    'progresso': progresso,
    'documentos': documentos.map((doc) => doc.toJson()).toList(),
    'rematricula': rematricula.toJson(),
  };
}
