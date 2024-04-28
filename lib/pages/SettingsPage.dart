//SettingPage.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Settings UI',
      home: SettingsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildHeader(),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSettingOption(context, Icons.edit, 'Хэрэглэгчийн тохиргоо', [
                  _buildSubSettingOption(context, 'Нэр өөрчлөх', () => _editUserName(context)),
                  _buildSubSettingOption(context, 'Нууц үг солих', () => _editPassword(context)),
                  _buildSubSettingOption(context, 'Утасны дугаар солих', () => _changePhoneNumber(context)),
                  _buildSubSettingOption(context, 'Хэрэглэгчийн бүртгэл устгах', () => _deleteAccount(context)),
                ]),
                _buildSettingOption(context, Icons.contact_mail, 'Холбоо барих', [
                  _buildSubSettingOption(context, 'Instagram', () => _openInstagram()),
                  _buildSubSettingOption(context, 'Facebook', () => _openFacebook()),
                ]),
                _buildSettingOption(context, Icons.info, 'Хэрэглэгчийн заавар', [
                  _buildSubSettingOption(context, 'Энэхүү гар утсаны аппликейшныг хэрэглэхдээ бүртгүүлээд нэвтэрч орно. Мөн аудио файл оруулад хөрвүүлэх товч дээр дарж үр дүнгээ харна.Түүх хэсэгт дарж өмнө нь хөрвүүлсэн аудионы бүртгэлээ удирдана. Тохиргоо хэсэгт дарж хэрэглэгчийн бүртгэлээ устгана. ', () => _showUserGuide(context)),
                ]),
                _buildSettingOption(context, Icons.logout, 'Системээс гарах', [
                  _buildSubSettingOption(context, 'Тийм', () => _logout(context)),
                  _buildSubSettingOption(context, 'Үгүй', () => Navigator.pop(context)),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Color(0xFF00c7c8),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(150),
          topRight: Radius.circular(150),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/blue_dragon.png'),
              radius: 50,
            ),
            SizedBox(height: 10),
            Text(
              'Хангэрэл',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingOption(BuildContext context, IconData icon, String title, List<Widget> subOptions) {
    return ExpansionTile(
      leading: Icon(icon),
      title: Text(title),
      children: subOptions,
    );
  }

  Widget _buildSubSettingOption(BuildContext context, String title, Function onTap) {
    return ListTile(
      title: Text(title),
      onTap: () {
        onTap();
        Navigator.pop(context); // Close the settings screen after performing the action
      },
    );
  }
void _editUserName(BuildContext context) {
  // Simulate editing user name with a dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Хэрэглэгчийн нэрийг солох'),
        content: TextField(
          decoration: InputDecoration(hintText: 'Шинэ нэр оруулах'),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Хадгалах'),
            onPressed: () {
              // Implement logic to save new user name
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Болих'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

void _editPassword(BuildContext context) {
  // Simulate editing password with a dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Нууц үг солих'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Хуучин нууц үгээ оруулна уу'),
              obscureText: true,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Шинэ нууц үгээ оруулна уу'),
              obscureText: true,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Шинэ нууц үгээ дахин оруулна уу'),
              obscureText: true,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Хадгалах'),
            onPressed: () {
              // Implement logic to save new password
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Болих'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

void _changePhoneNumber(BuildContext context) {
  // Simulate changing phone number with a dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Утасны дугаараа солих'),
        content: TextField(
          decoration: InputDecoration(hintText: 'Шинэ утасны дугаар оруулах'),
          keyboardType: TextInputType.phone,
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Хадгадлах'),
            onPressed: () {
              // Implement logic to save new phone number
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Болих'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

void _deleteAccount(BuildContext context) {
  // Simulate deleting account with a confirmation dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Хэргэлэгчийн бүртгэл устгах'),
        content: Text('Та үнэхээр устгахдаа итгэлтэй байна уу?'),
        actions: <Widget>[
          TextButton(
            child: Text('Устгах'),
            onPressed: () {
              // Implement logic to delete account
              Navigator.pop(context);
              Navigator.pop(context); // Close the settings screen after deleting account
            },
          ),
          TextButton(
            child: Text('Болих'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

void _showUserGuide(BuildContext context) {
  // Simulate showing user guide with a dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('хэрэглэгчийн туслах'),
        content: Text('Энэхүү гар утсаны аппликейшныг хэрэглэхдээ бүртгүүлээд нэвтэрч орно. Мөн аудио файл оруулад хөрвүүлэх товч дээр дарж үр дүнгээ харна.Түүх хэсэгт дарж өмнө нь хөрвүүлсэн аудионы бүртгэлээ удирдана. Тохиргоо хэсэгт дарж хэрэглэгчийн бүртгэлээ устгана..'),
        actions: <Widget>[
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

void _openInstagram() async {
  const url = 'https://www.instagram.com/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void _openFacebook() async {
  const url = 'https://www.facebook.com/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void _logout(BuildContext context) {
  // Implement logic to log out
  Navigator.pop(context); // Close the settings screen after logging out
}
}