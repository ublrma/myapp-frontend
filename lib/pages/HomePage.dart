//HomePage.dart

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:my_app/pages/ResultsPage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  String? _fileName;

  Future<void> _pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'm4a'],
    );

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });
    }
  }

  Future<void> _uploadAudioFile() async {
    // Implement your upload logic here

    // You need to replace 'Your result text here' with the actual result text obtained from your AI model
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultsScreen(resultText: 'Your result text here')),
    );

    print('Uploading file: $_fileName');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Transform.translate(
                offset: Offset(0, -20), // Moves the image 20 pixels up
                child: Image.asset(
                  'assets/images/white_dragon.png',
                  width: 200, // Set the width to 100 pixels
                  height: 200, // Set the height to 100 pixels
                ),
              ),
              SizedBox(height: 1),
              const Text.rich(
                TextSpan(
                  text: 'Та өөрийн хөрвүүлэх аудио\n',
                  style: TextStyle(
                    color: Color(0xFF053140),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'файлаа доор оруулна уу',
                      style: TextStyle(
                        color: Color(0xFF053140),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
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
                  onPressed: _pickAudioFile,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Color(0xFF00c7c8)),
                    foregroundColor: WidgetStateProperty.all(Color(0xFF053140)),
                    padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Image.asset('assets/images/sounds.png',
                          width: 200, height: 50),
                      SizedBox(height: 10),
                      Text(
                        'Аудио оруулах\n',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(height: 5),
                      Icon(Icons.cloud_upload,
                          color: Color(0xFFFBCF0A), size: 50),
                      SizedBox(height: 10),
                      Text(_fileName ?? 'No file selected'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
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
                  onPressed: _uploadAudioFile,
                  child: Text(
                    'Хөрвүүлэх',
                    style: TextStyle(
                      color: Color(0xFF053140),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Color(0xFFFBCF0A)),
                    foregroundColor: WidgetStateProperty.all(Color(0xFF053140)),
                    padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 50, vertical: 25)),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
