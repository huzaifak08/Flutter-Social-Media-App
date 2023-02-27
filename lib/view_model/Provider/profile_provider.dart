import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_media/res/color.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view_model/services/session_controller.dart';

class ProfileProvider with ChangeNotifier {
  // Loading:

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // Storing images to Firebase:

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('users');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  // Picking Images:
  final picker = ImagePicker();

  File? _image;
  File? get image => _image;

  // Get image from Gallery:
  Future pickGalleryImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }

  // Get image from Camera:
  Future pickCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }

  // Pick Image Method:
  void pickImage(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          content: SizedBox(
            height: 120,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    pickCameraImage(context);
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.camera,
                      color: AppColors.primaryIconColor),
                  title: const Text('Camera'),
                ),
                ListTile(
                  onTap: () {
                    pickGalleryImage(context);
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.image,
                      color: AppColors.primaryIconColor),
                  title: const Text('Gallery'),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // Upload Image to Firebase Storage:
  void uploadImage(BuildContext context) async {
    // loading :
    setLoading(true);

    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref('/profileImage' + SessionController().userId.toString());

    firebase_storage.UploadTask uploadTask =
        storageReference.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);

    // Get the Url
    final newUrl = await storageReference.getDownloadURL();

    // Now update that 'profile' section in firebase database:

    ref.child(SessionController().userId.toString()).update({
      'profile': newUrl,
    }).then((value) {
      Utils.toastMessage('Profile Image Uploaded');
      setLoading(false);

      _image = null;
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
    });
  }
}
