import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class ApiService {
  Future<bool> registerUser(
      String name, String surname, String email, String password) async {
    final response = await http.post(
      Uri.parse('https://moviestagram.azurewebsites.net/api/User/Register'),
      body: {
        'name': name,
        'surname': surname,
        'email': email,
        'password': password,
      },
    );
    final resp = await ApiService;
    inspect(resp);

    if (response.statusCode == 200) {
      return true; // Kayıt başarılı
    } else {
      return false; // Kayıt başarısız
    }
  }

  Future<bool> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('https://moviestagram.azurewebsites.net/api/User/Login'),
      headers: {
        'Content-Type':
            'application/json', // Veri türü olarak JSON kullanıyoruz
      },
      body: json.encode({
        'EMail': email,
        'Password': password,
      }),
    );

    if (response.statusCode == 200) {
      return true; // Giriş başarılı
    } else {
      return false; // Giriş başarısız
    }
  }

  Future<Map<String, dynamic>> getPopularMovies(int currentPage) async {
    final response = await http.get(
      Uri.parse(
          'https://moviestagram.azurewebsites.net/api/Movie/Movie/GetPopular$currentPage'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to fetch popular movies');
    }
  }

  Future<List<dynamic>> getPopularTVSeries() async {
    final response = await http.get(
      Uri.parse('https://moviestagram.azurewebsites.net/api/TVSeries/Popular1'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData;
    } else {
      return []; // Boş bir liste döndürüyoruz
    }
  }
}
