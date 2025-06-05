import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'https://6838f3bb6561b8d882aeaba0.mockapi.io';

  static Future<Map<String, dynamic>?> getAlunoByEmail(String email) async {
    final response = await http.get(Uri.parse('$baseUrl/alunos'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.firstWhere(
            (user) => user['email'] == email,
        orElse: () => null,
      );
    } else {
      throw Exception('Erro ao buscar alunos');
    }
  }
}
