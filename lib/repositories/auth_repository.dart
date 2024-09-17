import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRepository {
  final String baseUrl;

  AuthRepository({required this.baseUrl});

  Future<String> login(
      {required String email, required String password}) async {
    final url = Uri.parse('$baseUrl/api/v1/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': email,
        'password': password,
      }),
    );
    // print(response.body);

    if (response.statusCode == 200) {
      // Assuming the response contains a JSON with a token or user data
      final data = jsonDecode(response.body);
      // For example, if the response has a 'token':
      if (data['auth-token'] != null) {
        return data['auth-token'];
      } else {
        throw Exception('Token not found in response');
      }
    } else {
      // Extract error message from response
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message'] ?? 'Failed to login');
    }
  }
 Future<void> signUp({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/api/v1/users');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'fullName': fullName,
        'email': email,
        'phoneNumber': phoneNumber,
        'password': password,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // Sign-up successful
      return;
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message'] ?? 'Failed to sign up');
    }
  }
}