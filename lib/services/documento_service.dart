import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/documento.dart';

class DocumentoService {
  static const String baseUrl = 'https:6838f3bb6561b8d882aeaba0.mockapi.io/alunos';

  static Future<List<Documento>> getDocumentos() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List list = jsonDecode(response.body);
      return list.map((e) => Documento.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao carregar documentos');
    }
  }

  static Future<void> addDocumento(Documento documento) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(documento.toJson()),
    );
  }

  static Future<void> updateDocumento(String id, Documento documento) async {
    await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(documento.toJson()),
    );
  }

  static Future<void> deleteDocumento(String id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }
}
