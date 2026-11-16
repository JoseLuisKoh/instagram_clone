import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class StorageMethods {
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    const String cloudName = 'oh0awpaj';
    const String uploadPreset = 'instagram_clone';

    final uri = Uri.parse(
        'https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    final request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = uploadPreset
      ..fields['folder'] = childName
      ..files.add(
        http.MultipartFile.fromBytes(
          'file',
          file,
          filename: 'upload.jpg',
        ),
      );

    final response = await request.send();
    final responseData = await response.stream.bytesToString();
    final jsonResponse = jsonDecode(responseData);

    if (response.statusCode == 200) {
      return jsonResponse['secure_url'] as String;
    } else {
      throw Exception(jsonResponse['error']['message']);
    }
  }
}