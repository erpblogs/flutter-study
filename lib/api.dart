import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final String db;

  ApiClient({required this.baseUrl, required this.db});

  Future<Map<String, dynamic>> authenticate(
      String login, String password) async {
    // final csrfToken = await getCsrfToken();
    final url = Uri.parse('$baseUrl/web/session/authenticate');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'jsonrpc': '2.0',
        'method': 'call',
        'params': {'db': db, 'login': login, 'password': password},
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData.containsKey('result')) {
        return responseData['result'];
      } else if (responseData.containsKey('error')) {
        throw Exception(responseData['error']['message']);
      } else {
        throw Exception('Unknown error');
      }
    } else {
      throw Exception('Failed to authenticate');
    }
  }
}
