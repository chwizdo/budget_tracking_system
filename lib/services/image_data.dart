import 'package:file_picker/file_picker.dart';

class ImageData {
  // Initialized local variables for file attachment
  String fileName = '';
  String filePath = '';
  String path = '';

  FileType pickingType = FileType.image;

  ImageData({this.path});
}