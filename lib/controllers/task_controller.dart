import 'package:get/get.dart';
import 'package:todo/db/db_helper.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  final taskList = <Task>[].obs;
  Future<void> getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
    update();
  }

  Future<int> addTask({required Task task}) async {
    return DBHelper.insert(task);
  }

  void deleteTask(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }

  markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }
}
