import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_moviestagram/api_service.dart';
import 'package:flutter_moviestagram/register_page.dart';

import 'main_page.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = '/login';
  final ApiService apiService = ApiService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;
    bool loginSuccess = await apiService.loginUser(email, password);

    if (loginSuccess) {
      // Giriş başarılı, başka bir sayfaya yönlendirme yapabilirsiniz.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AnotherPage()),
      );
    } else {
      // Giriş başarısız, hata mesajı gösterme işlemleri
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hata'),
            content: Text('Giriş yapılamadı. Lütfen tekrar deneyin.'),
            actions: <Widget>[
              TextButton(
                child: Text('Tamam'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void navigateToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Moviestagram',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.6),
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 150),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'E-posta',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Şifre',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      border: InputBorder.none,
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Giriş Yap'),
                  onPressed: () => login(context),
                ),
                SizedBox(height: 16),
                TextButton(
                  child: Text('Kayıt Ol'),
                  onPressed: () => navigateToRegister(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
