import 'dart:developer';
import 'dart:io';

import 'package:app/cubit/upload_cubit.dart';
import 'package:app/cubit/upload_state.dart';

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
        create: (context) => DummyCubit(),
        child: const DummyScreen(),
      ),
    );
  }
}

class DummyScreen extends StatefulWidget {
  const DummyScreen({super.key});

  @override
  _DummyScreenState createState() => _DummyScreenState();
}

class _DummyScreenState extends State<DummyScreen> {
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
          'name': 'rimsha',
          'numberOfEmployes': 'owner',
        };
        context.read<DummyCubit>().addData(body: body, images: [selectedImage]);
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
            BlocConsumer<DummyCubit, DummyState>(
              listener: (context, state) {
                if (state is DummyLoading) {
                  const CircularProgressIndicator();
                }
              },
              builder: (context, state) {
                return state is DummyLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _update,
                        child: const Text('Update Profile'),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
