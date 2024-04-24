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
                _buildSettingOption(context, Icons.edit, 'Edit Profile', [
                  _buildSubSettingOption(context, 'Edit User Name', () => _editUserName(context)),
                  _buildSubSettingOption(context, 'Edit Password', () => _editPassword(context)),
                  _buildSubSettingOption(context, 'Change Phone Number', () => _changePhoneNumber(context)),
                  _buildSubSettingOption(context, 'Delete Account', () => _deleteAccount(context)),
                ]),
                _buildSettingOption(context, Icons.contact_mail, 'Contacts', [
                  _buildSubSettingOption(context, 'Instagram', () => _openInstagram()),
                  _buildSubSettingOption(context, 'Facebook', () => _openFacebook()),
                ]),
                _buildSettingOption(context, Icons.info, 'User Guide', [
                  _buildSubSettingOption(context, 'Long Text Information', () => _showUserGuide(context)),
                ]),
                _buildSettingOption(context, Icons.logout, 'Logout', [
                  _buildSubSettingOption(context, 'Yes', () => _logout(context)),
                  _buildSubSettingOption(context, 'No', () => Navigator.pop(context)),
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
              'Your App Title',
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
        title: Text('Edit User Name'),
        content: TextField(
          decoration: InputDecoration(hintText: 'Enter new user name'),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Save'),
            onPressed: () {
              // Implement logic to save new user name
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Cancel'),
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
        title: Text('Edit Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Enter current password'),
              obscureText: true,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Enter new password'),
              obscureText: true,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Confirm new password'),
              obscureText: true,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Save'),
            onPressed: () {
              // Implement logic to save new password
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Cancel'),
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
        title: Text('Change Phone Number'),
        content: TextField(
          decoration: InputDecoration(hintText: 'Enter new phone number'),
          keyboardType: TextInputType.phone,
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Save'),
            onPressed: () {
              // Implement logic to save new phone number
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Cancel'),
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
        title: Text('Delete Account'),
        content: Text('Are you sure you want to delete your account? This action cannot be undone.'),
        actions: <Widget>[
          TextButton(
            child: Text('Delete'),
            onPressed: () {
              // Implement logic to delete account
              Navigator.pop(context);
              Navigator.pop(context); // Close the settings screen after deleting account
            },
          ),
          TextButton(
            child: Text('Cancel'),
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
        title: Text('User Guide'),
        content: Text('Here is a long text with user instructions.'),
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