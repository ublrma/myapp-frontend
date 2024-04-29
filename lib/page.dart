import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerPage extends StatefulWidget {
  @override
  _AudioPlayerPageState createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  List<String> audioPaths = [];

  Uint8List? fileBytes;
  String? fileName;
  final AudioPlayer audioPlayer = AudioPlayer();


  @override
  void initState() {
    super.initState();
    // fetchAudioPaths();
  }

  Future<void> fetchAudioPaths() async {

    final response = await http.get(Uri.parse('http://localhost:3000/audio:1'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        audioPaths = List<String>.from(data);
      });
    } else {
      throw Exception('Failed to fetch audio paths');
    }
  }

  Future<void> _pickAndUploadFile() async {
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
        await audioPlayer.play(BytesSource(fileBytes!));
      }
  } 
  Future<void> uploadFile(String path) async {
    var dio = Dio();
    FormData formData = FormData.fromMap({
      "audioFile": await MultipartFile.fromFile(path, filename: basename(path)),
    });
    try {
      var response = await dio.post('http://localhost/upload', data: formData);
      if (response.statusCode == 200) {
        fetchAudioPaths(); // Refresh the list of audio files
      } else {
        print("Failed to upload file: ${response.statusCode}");
      }
    } catch (e) {
      print("Error uploading file: $e");
    }
  }

  Future<void> playAudio(String audioPath) async {
    final FlutterSoundPlayer player = FlutterSoundPlayer();
    await player.startPlayer(
      fromURI: audioPath,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              _pickAndUploadFile();
            },
            child: Text('Upload Audio File'),
            style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 65, 100, 100)),),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: audioPaths.length,
              itemBuilder: (context, index) {
                final audioPath = audioPaths[index];
                return ListTile(
                  title: Text('Audio $index'),
                  onTap: () {
                    playAudio(audioPath);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}
