import 'dart:io';
import 'package:e_com/exceptions/local_file_handling_exception.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:e_com/exceptions/image_picking_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<String> chooseImagesFromLocalFile(
  BuildContext context, {
  int maxSizeInKB = 1024,
  int minSizeInKB = 5,
}) async {
  // permision
  final PermissionStatus photoPermissionStatus =
      await Permission.photos.request();

  if (!photoPermissionStatus.isGranted) {
    throw LocalFileHandlingStorageReadPermissionDeniedException(
        message: "Permission required to read storage, please give permission");
  }
  final imgPicker = ImagePicker();
  final imgSource = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text("Choose image source"),
            actions: [
              // button for pick image from camera
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, ImageSource.camera);
                  },
                  child: Text('Camera')),
              // button for pick image from gallery
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, ImageSource.gallery);
                  },
                  child: Text('Gallery'))
            ],
          ));

  if (imgSource == null)
    throw LocalImagePickingInvalidImageException(
        message: "No image source selected");
  final PickedFile imgPicked = await imgPicker.getImage(source: imgSource);

  if (imgPicked == null) {
    throw LocalImagePickingInvalidImageException();
  } else {
    final fileLength = await File(imgPicked.path).length();
    if (fileLength > (maxSizeInKB * 1024) ||
        fileLength < (minSizeInKB * 1024)) {
      throw LocalImagePickingFileSizeOutOfBoundsException(
          message: "Image size should not exceed 1MB");
    } else {
      return imgPicked.path;
    }
  }
}
