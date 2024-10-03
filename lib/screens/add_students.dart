import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management_provider/model/db_model.dart';
import 'package:student_management_provider/provider/getx_controller.dart';

import '../provider/image_controller.dart';

class AddStudents extends StatefulWidget {
  const AddStudents({super.key});

  @override
  State<AddStudents> createState() => _AddStudentsState();
}

class _AddStudentsState extends State<AddStudents> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final classsController = TextEditingController();
  final admissionController = TextEditingController();
  final addressController = TextEditingController();
  final imageController = Get.put(AddImageController());
  final StudentController studentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 15),
              Obx(
                () => InkWell(
                  onTap: () async {
                    final pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      imageController.selectedImage.value =
                          File(pickedFile.path);
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      height: 150,
                      width: 150,
                      color: Colors.grey.withOpacity(.5),
                      child: imageController.selectedImage.value != null
                          ? Image.file(imageController.selectedImage.value!,
                              fit: BoxFit.cover)
                          : const Center(child: Icon(Icons.add_a_photo)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Enter your full name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name is required";
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: classsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Class",
                  hintText: "Enter your class",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Class is required";
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: admissionController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Admission Number",
                  hintText: "Enter your Admission Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Admission Number is required";
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: addressController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: "Address",
                  hintText: "Enter your full Address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Address is required";
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      clear();
                    },
                    child: const Text(
                      'Clear',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: saveStudent,
                    child: const Text(
                      'Save',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void clear() {
    setState(() {
      nameController.clear();
      classsController.clear();
      admissionController.clear();
      addressController.clear();
      imageController.selectedImage.value = null;
    });
  }

  void saveStudent() {
    if (formKey.currentState!.validate()) {
      final student = Student();
      student.name = nameController.text;
      student.classs = classsController.text;
      student.admissionNumber = admissionController.text;
      student.address = addressController.text;
      student.image = imageController.selectedImage.value!.path;

      studentController.postStudent(student);
      Get.back();
    }
  }
}
