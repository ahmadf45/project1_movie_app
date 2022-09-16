// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class Helper {
  String durationToString(int? minutes) {
    if (minutes != null) {
      var d = Duration(minutes: minutes);
      List<String> parts = d.toString().split(':');
      return '${parts[0].padLeft(1, '0')}h ${parts[1].padLeft(2, '0')}m';
    } else {
      return '0';
    }
  }

  Future<File> compressImageFile(
      XFile file, String targetPath, String fileType) async {
    var _iii = File(file.path);
    var decodedImage = await decodeImageFromList(_iii.readAsBytesSync());
    // print(decodedImage.height);
    // print(decodedImage.width);
    try {
      var result = await FlutterImageCompress.compressAndGetFile(
          file.path, targetPath,
          minWidth:
              fileType != 'png' ? decodedImage.width : decodedImage.width ~/ 2,
          minHeight: fileType != 'png'
              ? decodedImage.height
              : decodedImage.height ~/ 2,
          quality: 50,
          format: fileType != 'png' ? CompressFormat.jpeg : CompressFormat.png
          //rotate: 180,
          );
      var fileSizeBefore = File(file.path).lengthSync();
      var fileSizeAfter = result!.lengthSync();
      print("File size before compressing : $fileSizeBefore");
      print("File size after compressing : $fileSizeAfter");

      return result;
    } catch (e) {
      print(e);
      return File(file.path);
    }
  }

  showLoading(BuildContext context, bool isLoading) async {
    isLoading
        ? showGeneralDialog(
            context: context,
            barrierDismissible: false,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            barrierColor: Colors.black45,
            transitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (context, animation, secondaryAnimation) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: WillPopScope(
                  onWillPop: () async => false,
                  child: const Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Center(
                      child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator()),
                    ),
                  ),
                ),
              );
            })
        : Navigator.pop(context);
  }

  handlingSuccess(BuildContext context, String responseMessage) {
    final screenSize = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (_) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              content: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            SizedBox(
                              width: screenSize.width * 0.3,
                              child: const Center(
                                child: Icon(
                                  Icons.thumb_up,
                                  size: 50,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width * 0.6,
                              child: const Text("Sukses",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 30)),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              width: screenSize.width * 0.5,
                              child: Text(responseMessage,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.lightGreen,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                            ),
                            const SizedBox(height: 20),
                          ],
                        )),
                  ),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(_);
                        },
                        child: const CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.lightGreen,
                          child: FittedBox(
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ))
                ],
              )),
        );
      },
    );
  }

  handlingError(BuildContext context, String responseMessage) {
    final screenSize = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              content: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            SizedBox(
                              width: screenSize.width * 0.3,
                              child: Center(
                                child: Image.asset("assets/icons/warning.png"),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width * 0.6,
                              child: const Text("Oooops!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.redAccent, fontSize: 30)),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              width: screenSize.width * 0.5,
                              child: Text(responseMessage,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                            ),
                            const SizedBox(height: 20),
                          ],
                        )),
                  ),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.redAccent,
                          child: FittedBox(
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ))
                ],
              )),
        );
      },
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
