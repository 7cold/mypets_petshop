import 'package:universal_html/prefer_universal/html.dart' as html;
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;

fb.UploadTask _uploadTask;
final fs.Firestore firestore = fb.firestore();
String url;

class UrlUtils {
  static uploadImage() async {
    await uploadImageWeb();
  }

  static String getUrl() {
    return url;
  }

  static String resetUrl() {
    url = "";
    return url;
  }
}

//pick image
uploadImageWeb() async {
  html.InputElement uploadInput = html.FileUploadInputElement();
  uploadInput.click();
  uploadInput.onChange.listen(
    (changeEvent) {
      final file = uploadInput.files.first;
      final reader = html.FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen(
        (loadEndEvent) async {
          await uploadToFirebaseWeb(file);
        },
      );
    },
  );
}

uploadToFirebaseWeb(html.File imageFile) async {
  if (imageFile.size > 5242880) {
    url = "error";
    UrlUtils.getUrl();
  } else {
    _uploadTask = fb
        .storage()
        .refFromURL('gs://betas-projects.appspot.com')
        .child('pets/${DateTime.now()}.jpg')
        .put(imageFile);

    _uploadTask.future.then((value) {
      value.ref.getDownloadURL().then((value) {
        url = value.toString();
        UrlUtils.getUrl();
      });
    });
  }
}
