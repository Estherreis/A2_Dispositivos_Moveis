import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/disciplina.dart';

class DisciplinaService {
  static const String baseUrl = 'https://6838f3bb6561b8d882aeaba0.mockapi.io/disciplinas';

  static Future<List<Disciplina>> getDisciplinasByAluno(String alunoId) async {
    final response = await http.get(Uri.parse('$baseUrl?alunoid=$alunoId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Disciplina.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar disciplinas');
    }
  }


  static Future<List<Disciplina>> getDisciplinasPorPeriodo(String alunoId, int periodo) async {
    final response = await http.get(Uri.parse('$baseUrl?alunoid=$alunoId&periodo=$periodo'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Disciplina.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar disciplinas por período');
    }
  }


  static Future<void> enviarRematricula(String alunoId, int periodo, List<Disciplina> disciplinas) async {
    final List<Map<String, dynamic>> payload = disciplinas.map((disc) {
      return {
        "alunoid": alunoId,
        "codigo": disc.codigo,
        "nome": disc.nome,
        "periodo": periodo.toString(),
        "ch": disc.ch ?? 0,
        "faltas": 0,
        "a1": 0,
        "a2": 0,
        "exameFinal": 0,
        "mediaFinal": 0,
        "status": "Matriculado",
      };
    }).toList();

    final response = await http.post(
      Uri.parse('$baseUrl/rematricula'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Falha ao enviar rematrícula');
    }
  }
}
