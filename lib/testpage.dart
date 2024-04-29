import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http_parser/http_parser.dart';
import 'package:my_app/Service/audioService.dart'; 

class AudioUploadPage extends StatefulWidget {
  @override
  _AudioUploadPageState createState() => _AudioUploadPageState();
}

class _AudioUploadPageState extends State<AudioUploadPage> {
  Uint8List? fileBytes;
  String? fileName;
  final AudioPlayer audioPlayer = AudioPlayer();

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['m4a'],
      withData: true, // Ensure that file byte data is fetched
    );

    if (result != null) {
      setState(() {
        fileBytes = result.files.single.bytes;
        fileName = result.files.single.name;
      });
      // await audioPlayer.play(BytesSource(fileBytes!));
        await uploadFile(fileBytes!, fileName! , 1 );
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

 final AudioService audioService = AudioService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload and Play M4A'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: pickFile,
              child: Text('Pick M4A File'),
            ),
            if (fileName != null) Text('Playing: $fileName'),
            ElevatedButton(
              onPressed: (){
                audioService.fetchAndPlayAudio(1);
              },
              child: Text('play'),
            ),
          ],
        ),
      ),
    );
  }
}