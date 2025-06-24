import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  // For Android emulator use: http://10.0.2.2:8000
  // For real device use: http://<your-pc-ip>:8000 (e.g. http://192.168.1.5:8000)
  static const String baseUrl = 'http://10.0.2.2:8000'; // Change as needed

  static Future<String> uploadReport(File file) async {
    var uri = Uri.parse('$baseUrl/analyze-report/');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('file', file.path));
    var response = await request.send();
    if (response.statusCode == 200) {
      var respStr = await response.stream.bytesToString();
      return jsonDecode(respStr)['result'];
    } else {
      throw Exception('Failed to upload report');
    }
  }

  static Future<String> sendMessage(String message) async {
    var uri = Uri.parse('$baseUrl/chat/');
    var response = await http.post(
      uri,
      body: {'message': message},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['reply'];
    } else {
      throw Exception('Failed to send message');
    }
  }
}
