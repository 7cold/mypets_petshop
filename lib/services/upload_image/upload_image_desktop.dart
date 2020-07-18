// import 'dart:async';
// import 'dart:io';
// import 'package:file_picker_cross/file_picker_cross.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart' as Path;

class UrlUtils {
  static uploadImage() async {}

  static String getUrl() {
    return "url";
  }

  static String resetUrl() {
    return "url";
  }
}

// class UrlUtils {
//   UrlUtils._();
//   static void open() {
//     uploadImageDesk();
//   }
// }

// StorageReference reference = FirebaseStorage.instance
//     .ref()
//     .child('pets/${Path.basename(DateTime.now().toString() + '.jpg')}');
// double _porcentagem;
// FilePickerCross filePicker = FilePickerCross();
// int _fileLength = 0;
// String _filePath;

// uploadImageDesk() {
//   filePicker.pick().then((value) {
//     _filePath = filePicker.path;
//     _fileLength = filePicker.toUint8List().lengthInBytes;
//     try {
//       uploadToFirebaseDesk();
//       //_fileString = filePicker.toString();
//     } catch (e) {
//       // _fileString =
//       //     'Not a text file. Showing base64.\n\n' + filePicker.toBase64();
//       print(e);
//     }
//   });
// }

// Future uploadToFirebaseDesk() async {
//   StorageUploadTask uploadTask = reference.putFile(File(_filePath));

//   final StreamSubscription<StorageTaskEvent> streamSubscription =
//       uploadTask.events.listen((event) {
//     print('EVENT ${event.type}');

//     _porcentagem = event.snapshot.bytesTransferred.toDouble() /
//         event.snapshot.totalByteCount.toDouble();

//     print(_porcentagem);
//   });
//   await uploadTask.onComplete;
//   streamSubscription.cancel();
//   var downloadUrl = await reference.getDownloadURL();
//   print(downloadUrl);
//   return downloadUrl;
// }
