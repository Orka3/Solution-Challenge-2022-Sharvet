import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

Future<void> upload(String inputSource,name) async {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  final picker = ImagePicker();
  XFile? pickedImage;

  pickedImage = await picker.pickImage(
      source: inputSource == 'camera'
          ? ImageSource.camera
          : ImageSource.gallery,
      maxWidth: 1920);

  final String fileName = path.basename(pickedImage!.path);
  File imageFile = File(pickedImage.path);


  firebase_storage.Reference storageReference =
  firebase_storage.FirebaseStorage.instance.ref('myday/$fileName');
  // Uploading the selected image with some custom meta data
  await storageReference.putFile(
    imageFile,
  );
  String? returnURL;
  await storageReference.getDownloadURL().then((fileURL) {
    returnURL = fileURL;
  });
  fireStore
      .collection('posting')
      .doc(name)
      .update({
    'PicUrl': returnURL,
  });
}
