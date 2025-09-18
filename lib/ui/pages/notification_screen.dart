import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen(String payload, {Key? key, required this.notificationLoad})
    : super(key: key);
  final String notificationLoad;
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _notificationLoad = '';
  @override
  void initState() {
    super.initState();
    _notificationLoad = widget.notificationLoad;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        elevation: 0,

        backgroundColor: context.theme.primaryColor,
        title: Text(
          _notificationLoad.split('|')[0],
          style: TextStyle(color: Get.isDarkMode ? Colors.white : darkGreyClr),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Column(
              children: [
                Text(
                  'Hello, Mohamed',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: Get.isDarkMode ? Colors.white : darkGreyClr,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'this is Your Notifications',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Get.isDarkMode ? Colors.grey[200] : darkGreyClr,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: primaryClr,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.text_format,
                            color: Colors.white,
                            size: 35,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Title',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ],
                      ),
                      Text(
                        _notificationLoad.split('|')[0],
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(height: 20),
                      Divider(color: Colors.white, thickness: 1),
                      Row(
                        children: [
                          Icon(
                            Icons.description,
                            color: Colors.white,
                            size: 35,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Description',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ],
                      ),
                      Text(
                        _notificationLoad.split('|')[1],
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 20),
                      Divider(color: Colors.white, thickness: .5),
                      Row(
                        children: [
                          Icon(Icons.date_range, color: Colors.white, size: 35),
                          SizedBox(width: 5),
                          Text(
                            'Date',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ],
                      ),
                      Text(
                        _notificationLoad.split('|')[2],
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
