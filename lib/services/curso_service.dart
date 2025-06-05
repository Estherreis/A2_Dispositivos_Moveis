import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/curso.dart';

class CursoService {
  static const String baseUrl = 'https:6838f3bb6561b8d882aeaba0.mockapi.io/alunos';

  static Future<List<Curso>> getCursos() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List list = jsonDecode(response.body);
      return list.map((e) => Curso.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao carregar cursos');
    }
  }
}
