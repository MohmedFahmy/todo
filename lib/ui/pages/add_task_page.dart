import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../theme.dart';
import '../widgets/button.dart';
import '../widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  //  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titelController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat(
    'hh:mm a',
  ).format(DateTime.now().add(const Duration(minutes: 15))).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.background,
      appBar: _customappbar(),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Add Task', style: headingStyle),
              const SizedBox(height: 20),
              InputField(
                title: 'Title',
                hint: 'Enter title here',
                controller: _titelController,
              ),
              SizedBox(height: 8),
              InputField(
                title: 'Note',
                hint: 'Enter note here',
                controller: _noteController,
              ),
              SizedBox(height: 8),
              InputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    color: Get.isDarkMode ? Colors.grey : darkGreyClr,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: 'Start Time',
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.access_time_outlined,
                          color: Get.isDarkMode ? Colors.grey : darkGreyClr,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InputField(
                      title: 'End Time',
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.access_time_outlined,
                          color: Get.isDarkMode ? Colors.grey : darkGreyClr,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              InputField(
                title: 'Remind',
                hint: '$_selectedRemind minutes early',
                widget: DropdownButton(
                  dropdownColor: Get.isDarkMode
                      ? Colors.grey[800]
                      : Colors.blueGrey,
                  borderRadius: BorderRadius.circular(20),
                  items: remindList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text('$value minutes early'),
                    );
                  }).toList(),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: 35,

                    color: Get.isDarkMode ? Colors.grey : darkGreyClr,
                  ),
                  elevation: 4,
                  underline: Container(height: 0),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRemind = int.parse(newValue!);
                    });
                  },
                ),
              ),
              SizedBox(height: 8),
              InputField(
                title: 'Repeat',
                hint: _selectedRepeat,
                widget: DropdownButton(
                  dropdownColor: Get.isDarkMode
                      ? Colors.grey[800]
                      : Colors.blueGrey,
                  borderRadius: BorderRadius.circular(20),
                  items: repeatList.map<DropdownMenuItem<String>>((
                    String value,
                  ) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: 35,
                    color: Get.isDarkMode ? Colors.grey : darkGreyClr,
                  ),
                  elevation: 4,
                  underline: Container(height: 0),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _colorPalete(),
                    MyButton(label: 'Create Task', onTap: () {}),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _customappbar() => AppBar(
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Get.isDarkMode ? Colors.white : Colors.black,
        size: 30,
      ),
      onPressed: () => Get.back(),
    ),
    elevation: 0,

    backgroundColor: context.theme.colorScheme.background,
    actions: [
      CircleAvatar(
        backgroundImage: AssetImage('images/person.jpeg'),
        radius: 20,
      ),
      SizedBox(width: 20),
    ],
  );

  Column _colorPalete() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Color', style: titleStyle),
      const SizedBox(height: 5),
      Wrap(
        children: List<Widget>.generate(4, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedColor = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                backgroundColor: index == 0
                    ? const Color(0xFF4CAF50) // أخضر جميل
                    : index == 1
                    ? const Color(0xFF009688) // Teal (أخضر مزرق)
                    : index == 2
                    ? const Color(0xFF2196F3) // أزرق سماوي
                    : const Color(0xFF7C4DFF), // بنفسجي مزرق خفيف (Lavender)
                radius: 14,
                child: _selectedColor == index
                    ? Icon(Icons.done, color: Colors.white)
                    : Container(),
              ),
            ),
          );
        }),
      ),
    ],
  );
}
