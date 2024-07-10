import 'package:flutter/material.dart';
import 'package:my_first_project/api.dart'; // cập nhật đường dẫn đúng cho file api.dart

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiClient _apiClient = ApiClient(baseUrl: 'https://erpblogs.com', db: 'elearning'); // Cập nhật baseUrl đúng

  void _login() async {
    try {
      final result = await _apiClient.authenticate(_accountController.text, _passwordController.text);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SuccessScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Đăng nhập thất bại: $e')));
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng nhập'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _accountController,
              decoration: InputDecoration(
                labelText: 'Account',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng nhập thành công'),
      ),
      body: Container(
        child: Center(
          child: Text(
            'Chào mừng bạn đã đăng nhập thành công!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
