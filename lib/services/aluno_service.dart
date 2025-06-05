import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/aluno.dart';

class AlunoService {
  static const String baseUrl = 'https:6838f3bb6561b8d882aeaba0.mockapi.io/alunos';

  static Future<List<Aluno>> getAlunos() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List list = jsonDecode(response.body);
      return list.map((e) => Aluno.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao carregar alunos');
    }
  }

  static Future<void> addAluno(Aluno aluno) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(aluno.toJson()),
    );
  }

  static Future<void> updateAluno(String id, Aluno aluno) async {
    await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(aluno.toJson()),
    );
  }

  static Future<void> deleteAluno(String id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }
}
