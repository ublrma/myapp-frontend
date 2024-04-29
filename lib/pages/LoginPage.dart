//LoginPage.dart


import 'package:my_app/Model/User.dart';
import 'package:my_app/Service/api.dart';
import 'package:my_app/provider/provider.dart';
import 'package:my_app/widgets/mainscreen.dart';
import 'package:my_app/pages/SignUpPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatelessWidget {

    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

  void login() {
    print(
        'Username: ${_emailController.text}, Password: ${_passwordController.text}'
    );
  }


  @override
  Widget build(BuildContext context) {
    
  void checkLogin()async{
    try {
      final api = ApiService();
        final res = await api.login(_emailController.text, _passwordController.text);
        if(res.statusCode == 200){
          
          User a = User.fromJson(res.data);
          print(a.name);
          print(a.userId);
          Provider.of<CommonProvider>(context, listen: false).updateUser(a);
          try {
            int? usr_id = Provider.of<CommonProvider>(context, listen: false).usr!.userId;
            print("file uploading usr id"+ usr_id.toString());
          } catch (e) {
            print(e);
          }
          Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen()),
                    );
        }else{
       
        }
    } catch (e) {
         ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Нууц үр, имэйл буруу"),
                backgroundColor: Colors.red,
              ),
            );
      print(e);
    }
        
  }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF00C7C8),
        body: Padding(
          padding: EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/khanka.png'),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Хэрэглэгчийн нэр',
                  filled: true, 
                  fillColor: Colors.white, 
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
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
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      print("Text clicked!");
                    },
                    child: Text(
                      "Нууц үг сэргээх",
                      style: TextStyle(
                        color: Color(0xFF057D8E),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 40),
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
                    checkLogin();
                  },
                  child: Text(
                    'НЭВТРЭХ',
                    style: TextStyle(
                      color: Color(0xFF053140),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(Color(0xFFFBCF0A)),
                    foregroundColor:
                        WidgetStateProperty.all(Color(0xFF053140)),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
                    },
                    child: Text(
                      "ШИНЭЭР БҮРТГҮҮЛЭХ",
                      style: TextStyle(
                        color: Color(0xFF053140),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Image.asset('assets/images/blue_dragon.png'),
            ],
          ),
        ),
      ),
    );
  }
}