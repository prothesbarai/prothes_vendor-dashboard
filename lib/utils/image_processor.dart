import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageProcessor{
  static final ImagePicker _imagePicker = ImagePicker();
  static Future<File?> pickImage(BuildContext context, int maxSizeKB,bool isFixedSquare,bool savePermanent, String imageName) async{
    return showModalBottomSheet<File?>(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10.r),),),
        builder: (context) {
          return SafeArea(
              child: Wrap(
                children: [
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text("Choose from Gallery"),
                    onTap: () async {
                      final file = await _handlePick(ImageSource.gallery, maxSizeKB, isFixedSquare,savePermanent,imageName);
                      if (context.mounted) {Navigator.pop(context, file);}
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text("Take a Photo"),
                    onTap: () async {
                      final file = await _handlePick(ImageSource.camera, maxSizeKB, isFixedSquare,savePermanent,imageName);
                      if (context.mounted) {Navigator.pop(context, file);}
                    },
                  ),
                ],
              )
          );
        },
    );
  }


  static Future<File?> _handlePick(ImageSource source, int maxSizeKB, bool isFixedSquare,bool savePermanent, String imageName) async {
    try{
      final originalImage = await _imagePicker.pickImage(source: source);
      if (originalImage == null) return null;

      // Now Print Original Image Size
      final originalImageSize = await File(originalImage.path).length();
      if(kDebugMode){print("Original Image Size : ${originalImageSize / 1024} KB");}


        // Crop
        final cropImage = await ImageCropper().cropImage(
            sourcePath: originalImage.path,
            compressFormat: ImageCompressFormat.jpg,
            aspectRatio: isFixedSquare ? const CropAspectRatio(ratioX: 1, ratioY: 1) : null,
            uiSettings: [
              AndroidUiSettings(
                  toolbarTitle: "Crop Image",
                  toolbarColor: Colors.blue,
                  toolbarWidgetColor: Colors.white,
                  lockAspectRatio: isFixedSquare,
                  hideBottomControls: !isFixedSquare,
                  initAspectRatio: isFixedSquare ? CropAspectRatioPreset.square : CropAspectRatioPreset.original,
              ),
              IOSUiSettings(
                  title: "Crop Image",
                  aspectRatioLockEnabled: isFixedSquare,
                  hidesNavigationBar: false,
                  aspectRatioPickerButtonHidden: isFixedSquare,
                  minimumAspectRatio: 1.0
              )
            ]
        );


      if(cropImage == null) return null;

      // Now Crop Image Size Print
      final cropImageSize = await File(cropImage.path).length();
      if(kDebugMode){print("Crop Image Size : ${cropImageSize / 1024} KB");}


      /// >>>  Now Image Compressed Start Here
      final tempDir = await getTemporaryDirectory();
      final tempPath = path.join(tempDir.path,"${imageName}_${DateTime.now().millisecondsSinceEpoch}.jpg");

      final firstCompressed = await FlutterImageCompress.compressAndGetFile(cropImage.path, tempPath,quality: 70,minHeight: 512,minWidth: 512);
      if(firstCompressed == null) return null;

      final firstCompressedImgSize = await firstCompressed.length();
      // Print First Compressed
      if(kDebugMode){print("First Compressed Size : ${firstCompressedImgSize / 1024} KB");}




      File? finalFile;



      // Now Check 300 KB
      if(firstCompressedImgSize > (maxSizeKB * 1024)){
        final againFinalCompressed = await FlutterImageCompress.compressAndGetFile(cropImage.path, tempPath,quality: 50,minHeight: 512,minWidth: 512);

        if(againFinalCompressed != null){
          // Print Final Compressed Image
          final finalCompressedSize = await againFinalCompressed.length();
          if(kDebugMode){print("Final Compressed Image is : ${finalCompressedSize/1024} KB");}
          finalFile = File(againFinalCompressed.path);
        }
      }else{
        finalFile = File(firstCompressed.path);
      }

      /// >>>  Save or not Permanent Directory
      if (savePermanent && finalFile != null) {
        final permanentDirectory = await getApplicationDocumentsDirectory();
        final permanentPath = "${permanentDirectory.path}/${imageName}_${DateTime.now().millisecondsSinceEpoch}.jpg";
        await finalFile.copy(permanentPath);
        return File(permanentPath);
      } else {
        return finalFile;
      }
    }catch(e){
      debugPrint("Something Error : $e");
      return null;
    }
  }
}