// ignore_for_file: use_build_context_synchronously, avoid_print
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project1_movie_app/config/helper.dart';
import 'package:project1_movie_app/config/variables.dart';
import 'package:project1_movie_app/controller/auth_class.dart';
import 'package:project1_movie_app/models/detail_video_model.dart';
import 'package:project1_movie_app/widgets/shimmering_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imgFile;
  File? _imgCompressed;
  User? _user;
  String? _profileUrl;
  List<DetailVideoModel?> listFile = [];

  _changeImage(BuildContext context) async {
    showModalBottomSheet<void>(
      enableDrag: true,
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(_);
                  _getImageCamera();
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: activeColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black54.withOpacity(0.2),
                          spreadRadius: 0.1,
                          blurRadius: 2,
                          offset: const Offset(0, 1))
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Take Photo",
                        style: GoogleFonts.rubik(
                            color: Colors.white, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(_);
                  _getImageGallery();
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black54.withOpacity(0.2),
                          spreadRadius: 0.1,
                          blurRadius: 2,
                          offset: const Offset(0, 1))
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.photo_library,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Choose from Gallery",
                        style: GoogleFonts.rubik(
                            color: Colors.white, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _getImageCamera() async {
    await EasyLoading.show(
      status: 'Loading...',
      dismissOnTap: false,
    );
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
      );
      _imgFile = pickedFile!;
      final directory = await getTemporaryDirectory();
      final fileType = pickedFile.name.substring(pickedFile.name.length - 3);
      _imgCompressed = await Helper().compressImageFile(pickedFile,
          '${directory.path}/compressed_${pickedFile.name}', fileType);
      if (_imgCompressed != null) {
        var res = await AuthController().updatePhoto(_imgCompressed!, fileType);
        if (res) {
          _getProfilePicture();
        }
        await EasyLoading.dismiss();
        setState(() {});
      } else {
        await EasyLoading.dismiss();
        setState(() {});
      }
    } catch (e) {
      print(e);
      await EasyLoading.dismiss();
    }
  }

  _getImageGallery() async {
    await EasyLoading.show(
      status: 'Loading...',
      dismissOnTap: false,
    );
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      _imgFile = pickedFile!;
      final directory = await getTemporaryDirectory();
      final fileType = pickedFile.name.substring(pickedFile.name.length - 3);
      _imgCompressed = await Helper().compressImageFile(pickedFile,
          '${directory.path}/compressed_${pickedFile.name}', fileType);
      if (_imgCompressed != null) {
        var res = await AuthController().updatePhoto(_imgCompressed!, fileType);
        if (res) {
          _getProfilePicture();
        }
        await EasyLoading.dismiss();
      } else {
        await EasyLoading.dismiss();
      }
    } catch (e) {
      print(e);
      await EasyLoading.dismiss();
    }
  }

  _getProfilePicture() async {
    if (_user!.photoURL != null) {
      var downloadUrl = FirebaseStorage.instance.refFromURL(_user!.photoURL!);
      var uurl = await downloadUrl.getDownloadURL();
      setState(() {
        _profileUrl = uurl;
      });
    }
  }

  _getLiked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String likesVideo = prefs.getString("likesVideo") ?? '';
    if (likesVideo != '') {
      Map<String, dynamic> jsonFile = jsonDecode(likesVideo);

      //find userId from saved json
      if (jsonFile.containsKey(userId)) {
        if (jsonFile[userId].length > 0) {
          for (var i = 0; i < jsonFile[userId].length; i++) {
            var ff = DetailVideoModel.fromJson(jsonFile[userId][i]);
            setState(() {
              listFile.add(ff);
            });
          }
          //inspect(listFile);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    inspect(_user);
    _getProfilePicture();
    _getLiked();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(elevation: 0, actions: [
        GestureDetector(
          onTap: () async {
            var res = await AuthController().signOut();
            if (res) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
            }
          },
          child: const Padding(
            padding: EdgeInsets.all(15),
            child: Icon(Icons.logout),
          ),
        )
      ]),
      body: Container(
        width: screenSize.width,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                _user!.photoURL != null
                    ? (_profileUrl != null
                        ? CachedNetworkImage(
                            imageUrl: _profileUrl!,
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.transparent,
                              foregroundImage: imageProvider,
                            ),
                            placeholder: (context, url) =>
                                const AvatarProfileShimmer(),
                            errorWidget: (context, url, error) =>
                                const AvatarProfileShimmer(),
                          )
                        : const AvatarProfileShimmer())
                    : const CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.transparent,
                        backgroundImage:
                            AssetImage('assets/icons/male-avatar.png'),
                      ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        _changeImage(context);
                      },
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: activeColor,
                        child: FittedBox(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              _user!.displayName.toString(),
              style: GoogleFonts.nunitoSans(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              _user!.email.toString(),
              style: GoogleFonts.nunitoSans(
                fontSize: 14,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
