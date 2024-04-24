import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FirebaseStorageService {
  Future<void> uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      try {
        await FirebaseStorage.instance
            .ref('uploads/${result.files.single.name}')
            .putFile(file);
      } on FirebaseException catch (e) {
        // Handle any errors
      }
    }
  }
}
