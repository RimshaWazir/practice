import 'dart:developer';
import 'dart:io';

import 'package:app/cubit/upload_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Upload ',
      home: BlocProvider(
        create: (context) => ProfileUpdateCubit(),
        child: const ProfileUpdateScreen(),
      ),
    );
  }
}

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({super.key});

  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = pickedFile.path;
      });
    }
  }

  void _update() {
    if (_formKey.currentState!.validate()) {
      if (selectedImage != null) {
        log("message");
        var body = {
          'name': 'name',
          'numberOfEmployes': 'owner',
        };
        context.read<ProfileUpdateCubit>().updateProfile(body, selectedImage);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('success fully updated ')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image Required')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Profile')),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selectedImage != null)
              Image.file(File(selectedImage!), height: 200),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
            ),
            ElevatedButton(
              onPressed: _update,
              child: const Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}


// class ProfileUpdateScreen extends StatefulWidget {
//   const ProfileUpdateScreen({super.key});

//   @override
//   _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
// }

// class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String? selectedImage;

//   void _updateProfile() async {
//     if (_formKey.currentState!.validate()) {
//       if (selectedImage != null) {
//         _update();
//         log("message");
//       } else {
//         final ImagePicker picker = ImagePicker();
//         final XFile? pickedFile =
//             await picker.pickImage(source: ImageSource.gallery);

//         if (pickedFile != null) {
//           setState(() {
//             selectedImage = pickedFile.path;
//           });
//           _update();
//           log(pickedFile.path);
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Image Required')),
//           );
//         }
//       }
//     }
//   }

//   void _update() {
//     var body = {
//       'name': 'name',
//       'numberOfEmployes': 'owner',
//     };

//     context.read<ProfileUpdateCubit>().updateProfile(body, selectedImage);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Update Profile')),
//       body: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: _updateProfile,
//               child: const Text('Update Profile'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
