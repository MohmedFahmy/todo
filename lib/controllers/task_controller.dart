import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  final taskList = <Task>[
    Task(
      id: 1,
      title: 'Task 1',
      note: 'Note 1',
      isCompleted: 1,
      date: '2023-06-01',
      startTime: '10:00',
      endTime: '12:00',
      color: 1,
      remind: 5,
      repeat: 'Daily',
    ),
    Task(
      id: 1,
      title: 'Task 2',
      note: 'Note 2',
      isCompleted: 0,
      date: '2023-06-01',
      startTime: '10:00',
      endTime: '12:00',
      color: 0,
      remind: 5,
      repeat: 'Daily',
    ),
    Task(
      id: 1,
      title: 'Task 3',
      note: 'Note 3',
      isCompleted: 0,
      date: '2023-06-01',
      startTime: '10:00',
      endTime: '12:00',
      color: 2,
      remind: 5,
      repeat: 'Daily',
    ),
    Task(
      id: 1,
      title: 'Task 4',
      note: 'Note 4',
      isCompleted: 1,
      date: '2023-06-01',
      startTime: '10:00',
      endTime: '12:00',
      color: 3,
      remind: 5,
      repeat: 'Daily',
    ),
  ];
  getTasks() {}
}
