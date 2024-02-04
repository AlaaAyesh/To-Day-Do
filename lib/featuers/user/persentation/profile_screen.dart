import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../busines_logic/user_provider.dart';
import '../../../core/global/colors/app_color.dart';
import '../widget/profile_app_bar.dart';
import '../widget/profile_screen_body.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _firstNameTextController =
      TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();
  final TextEditingController _emailNameTextController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _userId;
  late String _imageUrl;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      setState(() {
        _userId = currentUser.uid;
        _firstNameTextController.text = userData['firstName'];
        _lastNameTextController.text = userData['lastName'];
        _emailNameTextController.text = userData['email'];
        _imageUrl = userData['imageUrl'];
      });
    }
  }

  Future<void> _chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Provider.of<UserProvider>(context, listen: false)
          .setImageFile(File(pickedFile.path));
    }
  }

  Future<void> _uploadImage() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.imageFile != null) {
      try {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          final ref = FirebaseStorage.instance
              .ref()
              .child('user_images')
              .child('$userId.png');
          await ref.putFile(userProvider.imageFile!);
          final imageUrl = await ref.getDownloadURL();
          setState(() async {
            _imageUrl = imageUrl;
          });
        } else {
          print('User not logged in');
        }
      } catch (error) {
        print('Error uploading image: $error');
      }
    }
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      try {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .update({
            'firstName': _firstNameTextController.text,
            'lastName': _lastNameTextController.text,
            'email': _emailNameTextController.text,
          });
          await _uploadImage();
          final userProvider =
              Provider.of<UserProvider>(context, listen: false);
          await userProvider.updateUserProfile(
            userId: userId,
            firstName: _firstNameTextController.text,
            lastName: _lastNameTextController.text,
            email: _emailNameTextController.text,
            imageFile: userProvider
                .imageFile, // Use the image file from the userProvider
          );
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')));
        } else {
          print('User not logged in');
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update profile')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final gradientColors = isDarkMode ? darkThemeGradientColors : lightThemeGradientColors;
    return SafeArea(
      child: Scaffold(
        body: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: gradientColors,
                ),
              ),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  const ProfileScreenAppBar(),
                  ProfileScreenBody(
                      firstNameTextController: _firstNameTextController,
                      lastNameTextController: _lastNameTextController,
                      emailNameTextController: _emailNameTextController,
                      formKey: _formKey,
                      chooseImage: _chooseImage,
                      saveChanges: _saveChanges),
                ],
              ),
            );
          },
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
  List<Color> get lightThemeGradientColors => [
    AppColors.mainColor1,
    AppColors.mainColor2,
  ];

  List<Color> get darkThemeGradientColors => [
    AppColors.mainColor5,
    AppColors.mainColor4,
  ];
}

