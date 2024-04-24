//SignUpPage.dart

import 'package:my_app/pages/LoginPage.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  void login() {
    print(
        'Username: ${_usernameController.text}, Password: ${_passwordController.text},  Password: ${_passwordController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF00C7C8),
        body: Padding(
            padding: EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/khanka.png',
                    width: 250, 
                    height: 90),
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/images/blue_dragon.png',
                  width: 150, 
                  height: 140, 
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Хэрэглэгчийн нэр',
                    filled: true, 
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: _phonenumberController,
                  decoration: InputDecoration(
                    labelText: 'Утасны дугаар',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  keyboardType: TextInputType.phone, 
                ),
                SizedBox(height: 15),
                TextField(
                  controller: _passwordController,
                  obscureText: true, 
                  decoration: InputDecoration(
                    labelText: 'Нууц үг',
                    filled: true, 
                    fillColor: Colors.white, 
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true, 
                  decoration: InputDecoration(
                    labelText: 'Нууц үг давтан оруулах',
                    filled: true, 
                    fillColor: Colors.white, 
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 20, 18, 40).withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 20,
                        offset: Offset(0, 5), 
                      ),
                    ],
                  ),
                  width: double.infinity, 
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      'Бүртгүүлэх',
                      style: TextStyle(
                        color:
                            Color(0xFF053140), 
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          Color(0xFFFBCF0A)),
                      foregroundColor: WidgetStateProperty.all(Color(
                          0xFF053140)), 
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}