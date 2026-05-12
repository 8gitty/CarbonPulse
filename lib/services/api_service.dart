import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  static Future<Map<String, dynamic>>
  predictCarbon({

    required int electricity,
    required int travel,
    required int food,

  }) async {

    final url =
    Uri.parse('http://127.0.0.1:5000/predict');

    final response = await http.post(

      url,

      headers: {
        'Content-Type':
        'application/json',
      },

      body: jsonEncode({

        'electricity': electricity,
        'travel': travel,
        'food': food,
      }),
    );

    return jsonDecode(response.body);
  }
}