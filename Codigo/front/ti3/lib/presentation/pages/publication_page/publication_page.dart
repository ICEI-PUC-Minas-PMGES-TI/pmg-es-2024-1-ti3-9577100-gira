import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:ti3/presentation/pages/publication_page/controller/publication_controller.dart';

class PublicationPage extends StatefulWidget {
  const PublicationPage({super.key});

  @override
  State<PublicationPage> createState() => _PublicationPageState();
}

class _PublicationPageState extends State<PublicationPage> {
  final PublicationController controller = Get.find<PublicationController>();

  String imagePath = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Publicar"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.publish();
              setState(() {
                imagePath = '';
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.descriptionController,
            decoration: const InputDecoration(
              labelText: "Descrição",
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final result = await FilePicker.platform.pickFiles(
                type: FileType.image,
              );

              if (result == null) {
                return;
              }

              setState(() {
                imagePath = result.files.single.path!;
              });
            },
            child: const Text("Selecionar imagem"),
          ),
          const SizedBox(height: 20),
          if (imagePath.isNotEmpty) Image.file(File(imagePath)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (controller.descriptionController.text.isEmpty) {
                return;
              }
              if (imagePath.isEmpty) {
                return;
              }

              final imageFile = File(imagePath);
              final imageMimeType = lookupMimeType(imagePath);
              if (imageMimeType == null) {
                return;
              }

              final imageBytes = await imageFile.readAsBytes();
              final base64Image = base64Encode(imageBytes);

              controller.image = imagePath;

              controller.publish();
              Get.back();
            },
            child: const Text("Publicar"),
          ),
        ],
      ),
    );
  }
}
