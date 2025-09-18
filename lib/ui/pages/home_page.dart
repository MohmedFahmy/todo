import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/task.dart';
import 'package:todo/ui/pages/add_task_page.dart';
import 'package:todo/ui/widgets/task_tile.dart';

import '../../controllers/task_controller.dart';
import '../../services/notification_services.dart';
import '../../services/theme_services.dart';
import '../size_config.dart';
import '../theme.dart';
import '../widgets/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskController _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.theme.colorScheme.background,
      appBar: _appBar(context),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          SizedBox(height: 10),
          _showTasks(),
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Icon(
            Get.isDarkMode
                ? Icons.wb_sunny_outlined
                : Icons.nightlight_round_sharp,

            color: Get.isDarkMode ? Colors.white : Colors.black,
            size: 30,
          ),
        ),
        onPressed: () {
          NotifyHelper().displayNotification(
            body: 'Theme changed',
            title: 'Theme changed',
          );

          NotifyHelper().scheduleNotificationAfterDelay(
            title: "⏳ إشعار متأخر",
            body: "ده إشعار ظهر بعد 5 ثواني من الضغط على الزر ✅",
            seconds: 15,
          );

          ThemeServices().switchTheme();
        },
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
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text('Today', style: headingStyle),
            ],
          ),
          Spacer(),
          MyButton(
            label: '+ Add Task',
            onTap: () async {
              await Get.to(() => const AddTaskPage());
              _taskController.getTasks();
            },
          ),
        ],
      ),
    );
  }

  _addDateBar() {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 12),
      child: SizedBox(
        height: 110,
        child: DatePicker(
          DateTime.now(),
          initialSelectedDate: _selectedDate,
          height: 110,
          width: 70,
          selectedTextColor: Colors.white, // النص المختار يتبع السيم
          selectionColor: primaryClr, // خلفية اليوم المختار
          monthTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
              color: Colors.grey, // ثابت رمادي
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
              color: Colors.grey, // ثابت رمادي
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          dateTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
              color: Colors.grey, // ثابت رمادي
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onDateChange: (newDate) {
            setState(() {
              _selectedDate = newDate;
            });
          },
        ),
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: ListView.builder(
        scrollDirection: SizeConfig.orientation == Orientation.landscape
            ? Axis.horizontal
            : Axis.vertical,
        itemBuilder: (context, index) {
          var task = _taskController.taskList[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              horizontalOffset: 300,
              child: FadeInAnimation(
                child: GestureDetector(
                  onTap: () {
                    showButtomSheet(context, task);
                  },
                  child: TaskTile(task: task),
                ),
              ),
            ),
          );
        },
        itemCount: _taskController.taskList.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
      ),
    );
  }

  _noTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 5000),
          // curve: Curves.bounceInOut,
          child: SingleChildScrollView(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.vertical,
              children: [
                SizedBox(height: 120),
                SvgPicture.asset(
                  'images/task.svg',
                  height: 110,
                  semanticsLabel: 'Task',
                  color: primaryClr.withOpacity(.5),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                  child: Text(
                    'you have no tasks yet!\nadd new tasks to make your days productive',
                    style: subtitleStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

_builedButtomSheet({
  required String label,
  required Function() onTap,
  required Color color,
  bool isClose = false,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: 65,
      width: SizeConfig.screenWidth * 0.9,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: isClose
              ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
              : color,
        ),
        borderRadius: BorderRadius.circular(20),
        color: isClose ? Colors.transparent : color,
      ),
      child: Center(
        child: Text(
          label,
          style: isClose
              ? titleStyle
              : titleStyle.copyWith(color: Colors.white),
        ),
      ),
    ),
  );
}

showButtomSheet(BuildContext context, Task task) {
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.only(top: 4),
      width: SizeConfig.screenWidth,
      color: Get.isDarkMode ? darkHeaderClr : Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // مهم عشان العمود ما يتمددش زيادة
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
              ),
            ),
            const SizedBox(height: 20),
            task.isCompleted == 1
                ? const SizedBox()
                : _builedButtomSheet(
                    label: 'Task Completed',
                    onTap: () {
                      // _taskController.markTaskCompleted(task.id!);
                      Get.back();
                    },
                    color: primaryClr,
                  ),
            _builedButtomSheet(
              label: 'Delete Task',
              onTap: () {
                // _taskController.deleteTask(task.id!);
                Get.back();
              },
              color: primaryClr,
            ),
            Divider(color: Get.isDarkMode ? Colors.grey : darkGreyClr),
            _builedButtomSheet(
              label: 'Cancel',
              onTap: () {
                Get.back();
              },
              color: primaryClr,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ),
    isScrollControlled:
        true, // يخلي الـ bottom sheet قابل للتمدد لو المحتوى طويل
  );
}
