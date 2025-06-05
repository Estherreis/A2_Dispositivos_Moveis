import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/rematricula.dart';

class RematriculaService {
  static const String baseUrl = 'https:6838f3bb6561b8d882aeaba0.mockapi.io/alunos';

  static Future<List<Rematricula>> getRematriculas() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List list = jsonDecode(response.body);
      return list.map((e) => Rematricula.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao carregar rematrículas');
    }
  }

  static Future<void> addRematricula(Rematricula rematricula) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(rematricula.toJson()),
    );
  }

  static Future<void> updateRematricula(String id, Rematricula rematricula) async {
    await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(rematricula.toJson()),
    );
  }

  static Future<void> deleteRematricula(String id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }
}
