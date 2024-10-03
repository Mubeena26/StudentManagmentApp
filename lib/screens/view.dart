import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_management_provider/provider/getx_controller.dart';


class Profile extends StatelessWidget {
  final int studentId;
  const Profile({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    final studentController = Get.find<StudentController>();
    return Obx(() {
      final updatedStudent = studentController.getStudentById(studentId);

      if (updatedStudent == null) {
        return  Scaffold(
          appBar: AppBar(title: const Text("Student Not Found")),
          body: const Center(child: Text("Student not found")),
        );
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
         
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 150,
                  height: 150,
                  color: Colors.grey.withOpacity(0.5),
                  child: Image.file(
                    File(updatedStudent.image),
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return const Icon(Icons.broken_image, size: 100);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                updatedStudent.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                updatedStudent.classs,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Text(
                updatedStudent.admissionNumber,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Text(
                updatedStudent.address,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    });
  }
}