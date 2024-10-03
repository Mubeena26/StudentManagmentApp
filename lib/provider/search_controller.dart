import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:student_management_provider/model/db_model.dart';

class SearchControllerStudent extends GetxController {
  RxList<Student> results = <Student>[].obs;

  @override
  void onInit() {
    super.onInit();
    getStudents();
  }

  getStudents() async {
    final box = await Hive.openBox<Student>('students');
    results.assignAll(box.values.toList());
  }

  search(String query) {
    if (query.isEmpty) {
      getStudents();
    } else {
      results.value = results
          .where((element) =>
              element.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}