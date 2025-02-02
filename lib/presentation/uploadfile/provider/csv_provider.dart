// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// // csv_provider.dart
// import 'dart:io';
// import 'package:flutter/foundation.dart';

// class FileUploadProvider extends ChangeNotifier {
//   PlatformFile? _selectedFile;

//   PlatformFile? get selectedFile => _selectedFile;

//   /// Picks a file using the file picker.
//   Future<void> pickFile() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         allowMultiple: false,
//       );
//       if (result != null && result.files.isNotEmpty) {
//         _selectedFile = result.files.first;
//         notifyListeners();
//       }
//     } catch (e) {
//       debugPrint('Error picking file: $e');
//     }
//   }

//   /// Processes a file dropped via drag and drop.
//   ///
//   /// Note: On desktop, the dropped file is provided as a [XFile] (from desktop_drop)
//   /// which exposes a path. We then create a [PlatformFile] from it.
//   Future<void> handleDroppedFile(dynamic droppedFile) async {
//     // droppedFile is of type DropDoneDetails.files.first,
//     // which on desktop is a [XFile] with a path.
//     if (droppedFile.path != null) {
//       // Create a PlatformFile using available data.
//       // For simplicity, we are not reading the file size or bytes.
//       _selectedFile = PlatformFile(
//         name: droppedFile.name,
//         size: await File(droppedFile.path!).length(),
//         path: droppedFile.path,
//       );
//       notifyListeners();
//     }
//   }

//   /// Clears the selected file.
//   void clearFile() {
//     _selectedFile = null;
//     notifyListeners();
//   }
// }

import 'dart:typed_data';

import 'package:flutter/material.dart';

class FileUploadProvider extends ChangeNotifier {
  Uint8List? _uploadedFile;
  String? _fileName;

  Uint8List? get uploadedFile => _uploadedFile;
  String? get fileName => _fileName;

  double _uploadProgress = 0.0;

  double get uploadProgress => _uploadProgress;
  bool _isUploading = false;
  bool get isUploading => _isUploading;

  int _selectedValue = 0;
  String _selectedTitle = '';
  int get selectedValue => _selectedValue;
  String get selectedTitle => _selectedTitle;

  Map<String, bool> isHovorButton = {};
  bool isHovorButtonState(String buttonId) => isHovorButton[buttonId] ?? false;

  void hovorButtonProvider(String buttonId, bool isHovorButtonState) {
    isHovorButton[buttonId] = isHovorButtonState;
    notifyListeners();
  }

  @override
  notifyListeners();
  // ApiResponse<GetFileInfoModel>? get fileInfo => _fileInfo;

  bool isFileImported = false;

  // ApiResponse<dynamic>? _uploadedFileResponse;
  // ApiResponse<dynamic>? get uploadedFileResponse =>
  //     _uploadedFileResponse ?? ApiResponse.loading('Loading...');

  bool _itemSelected = false;
  bool get itemSelected => _itemSelected;

  String? _selectedDateDropDownValue;

  String? get selectedDateDropDownValue => _selectedDateDropDownValue;

  fileUploadProvider() {
    // _repository = SummaryRepository();
  }

  void setSelectedValue(int value, String newTitle) {
    _selectedValue = value;
    _selectedTitle = newTitle;
    notifyListeners();
  }

  setUploadedFile(Uint8List fileBytes, String fileName) {
    _uploadedFile = fileBytes;
    _fileName = fileName;
    notifyListeners();
  }

  void clearFile() {
    _uploadedFile = null;
    _fileName = null;
    notifyListeners();
  }

  void setUploading(bool value) {
    _isUploading = value;
    _uploadProgress = 0.0;
    //'setUploading');
    notifyListeners();
  }

  // Future<ApiResponse<dynamic>?> uploadFile(
  //     {required Uint8List file,
  //     required String fileName,
  //     required String system,
  //     required String object,
  //     required String file_type,
  //     required bool is_deleted,
  //     String? objectName}) async {
  //   _uploadedFileResponse = ApiResponse.loading('Uploading file...');
  //   notifyListeners();

  //   try {
  //     var resp = await _repository!.uploadFile(
  //       url: ConstantURLs.UPLOAD_FILE,
  //       fileBytes: file,
  //       fileName: fileName,
  //       system: system,
  //       object: object,
  //       file_type: file_type,
  //       is_deleted: is_deleted,
  //     );

  //     for (var i = 0; i <= 100; i++) {
  //       _uploadProgress = i / 100.0;
  //       notifyListeners();
  //       await Future.delayed(const Duration(milliseconds: 10));
  //     }

  //     fileName = '$objectId.csv';

  //     isFileImported = true;

  //     _uploadedFileResponse = ApiResponse.completed(resp);
  //     notifyListeners();

  //     return _uploadedFileResponse;
  //   } catch (e) {
  //     _uploadedFileResponse = ApiResponse.error('Error uploading file: $e');
  //     notifyListeners();

  //     throw Exception("Error uploading file: $e");
  //   }
  // }

  String? _uploadedFileName;

  String? get uploadedFileName => _uploadedFileName;

  void setuploadedFileName(String upldFileName) {
    _uploadedFileName = upldFileName;
    notifyListeners();
  }

  // Future<void> getFileInfo(String id) async {
  //   _fileInfo = ApiResponse.loading('Loading...');
  //   notifyListeners();

  //   try {
  //     GetFileInfoModel fileInfoModel = await _repository!.getFileInfo(id: id);
  //     _fileInfo = ApiResponse.completed(fileInfoModel);
  //     notifyListeners();
  //     // //'File Info fetched successfully $_fileInfo');

  //     // notifyListeners();
  //     // return fileInfoModel;
  //   } catch (e) {
  //     _fileInfo = ApiResponse.error(e.toString());

  //     throw Exception("Error fetching file info: $e");
  //   }
  //   notifyListeners();
  // }
}
