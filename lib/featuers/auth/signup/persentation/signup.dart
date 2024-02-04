import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:to_day_do/featuers/auth/widget/custom_text_field.dart';
import 'package:to_day_do/featuers/home_screen/persentation/home_screen.dart';
import 'package:to_day_do/busines_logic/user_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameTextController = TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();
  final TextEditingController _emailNameTextController = TextEditingController();
  final TextEditingController _passwordNameTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late UserProvider _userProvider;
  File? _imageFile; // Initialize _imageFile with null

  @override
  void initState() {
    super.initState();
    _userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  Future<void> _handleSignUp(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _userProvider.signUp(
          firstName: _firstNameTextController.text.trim(),
          lastName: _lastNameTextController.text.trim(),
          email: _emailNameTextController.text.trim(),
          password: _passwordNameTextController.text.trim(),
          imageFile: _imageFile, // Pass image file to signUp method
        );

        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
      } catch (e) {
        print('Error signing up: $e');
        _showErrorDialog('Error signing up: $e');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> chooseImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path); // Update _imageFile
        _userProvider.setImageFile(_imageFile!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;
    final sizeHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 121),
          InkWell(
            onTap: () async {
              await chooseImage(ImageSource.gallery);
            },
            child: CircleAvatar(
              radius: sizeWidth * 0.15,
              backgroundColor: Colors.red,
              backgroundImage: _imageFile == null ? null : FileImage(_imageFile!), // Access _imageFile directly
              child: _imageFile == null ? const Icon(Icons.image) : null, // Access _imageFile directly
            ),
          ),
          SizedBox(height: sizeHeight * 0.05),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: _firstNameTextController,
                  data: Icons.person,
                  hintText: 'First name',
                  isObsecure: false,
                ),
                CustomTextField(
                  controller: _lastNameTextController,
                  data: Icons.person,
                  hintText: 'Last name',
                  isObsecure: false,
                ),
                CustomTextField(
                  controller: _emailNameTextController,
                  data: Icons.email_outlined,
                  hintText: 'Email',
                  isObsecure: false,
                ),
                CustomTextField(
                  controller: _passwordNameTextController,
                  data: Icons.remove_red_eye_outlined,
                  hintText: 'Password',
                  isObsecure: true,
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => _handleSignUp(context),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
            ),
            child: const Text(
              'Sign up',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
