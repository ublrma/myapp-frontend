//HomePage.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:my_app/pages/ResultsPage.dart';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';

import 'package:http_parser/http_parser.dart';
import 'package:my_app/provider/provider.dart'; 
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  String? _fileName;

  Uint8List? fileBytes;
  String? fileName;


  Future<void> pickFile() async {
    
      print("file uploading start");
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['m4a'],
      withData: true, 
    );

      print("file uploading end");
    if (result != null) {
      
      setState(() {
        fileBytes = result.files.single.bytes;
        fileName = result.files.single.name;
      });
      print("setstated");
      // await audioPlayer.play(BytesSource(fileBytes!));
      
      try {
        int? usr_id = Provider.of<CommonProvider>(context, listen: false).usr!.userId;
        print("file uploading usr id"+ usr_id.toString());
        await uploadFile(fileBytes!, fileName! , usr_id! );
      } catch (e) {
        print(e);
      }
      
    }
    
  }

Future<void> uploadFile(Uint8List fileData, String fileName, int userId) async {
  Dio dio = Dio();
  String? mimeType = lookupMimeType(fileName);  // Use mime package to get MIME type
  MediaType? mediaType;

  if (mimeType != null) {
    List<String> typeSubtype = mimeType.split('/');
    if (typeSubtype.length == 2) {
      mediaType = MediaType(typeSubtype[0], typeSubtype[1]);  // Create MediaType
    }
  }

  FormData formData = FormData.fromMap({
    "audioFile": MultipartFile.fromBytes(
      fileData, 
      filename: fileName,
      contentType: mediaType ?? MediaType('audio', 'm4a')),  // Use MediaType
    "user_id": userId.toString(),  // Add user_id as part of the form data
  });

  try {
    
    var response = await dio.post(
      'http://localhost:3000/upload',
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
    if (response.statusCode == 200) {
      print("File uploaded successfully");
    } else {
      print("Failed to upload file with status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error uploading file: $e");
  }
}



  Future<void> Convert() async {
    print("asd");
    Dio dio = Dio();
    var res = await dio.get(
      'http://localhost:3000/audio_last',
    );
    if(res.statusCode == 200){
      
    print("200");
    int last_audio_id = res.data['id'] as int;
    print("last uploaded file id:" + last_audio_id.toString());

    }
    // try {
    //    var response = await dio.get(
    //   'http://localhost:3000/convert',
    //     queryParameters: {
    //     'userId': usr_id
    //   }
    // );
    // if (response.statusCode == 200) {
    //     print("File uploaded successfully");
    // } else {
    //     print("Failed to upload file with status code: ${response.statusCode}");
    // }
    // } catch (e) {
    //   print("Error uploading file: $e");
    // }
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => ResultsScreen(resultText: 'Солонго')),
    // );

    // print('Uploading file: $_fileName');
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
                  onPressed: pickFile,
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
                  onPressed: Convert,
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
