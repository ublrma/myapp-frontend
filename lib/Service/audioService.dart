import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final Dio dio = Dio();
  final AudioPlayer audioPlayer = AudioPlayer();

  Future<void> fetchAndPlayAudio(int fileId) async {
    try {
      // Adjust the URL to point to your actual server IP and endpoint
      Response<List<int>> response = await dio.get<List<int>>(
        'http://localhost:3000/audio/$fileId',
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
      print("asd");
      if (response.statusCode == 200 && response.data != null) {
        Uint8List audioBytes = Uint8List.fromList(response.data!);
        // Play audio from bytes
        await audioPlayer.play(BytesSource(audioBytes));
      } else {
        print("Failed to fetch file: Status code ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching file: $e");
    }
  }
}
