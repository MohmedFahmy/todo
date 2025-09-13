import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../size_config.dart';
import '../theme.dart';


class InputField extends StatelessWidget {
  InputField({
    Key? key,
    required this.title,
    required this.hint,
    this.widget,
    this.controller,
  }) : super(key: key);
  final TextEditingController? controller;
  final String title;
  final String hint;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(left: 10),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: titleStyle),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.only(top: 4, bottom: 4, left: 6),

            width: SizeConfig.screenWidth,
            height: 55,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    style: subtitleStyle,
                    cursorColor: Get.isDarkMode ? Colors.grey : Colors.black,
                    readOnly: widget == null ? false : true,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: context.theme.primaryColor,
                          width: 0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: context.theme.primaryColor,
                          width: 0,
                        ),
                      ),
                      hintText: hint,
                      hintStyle: subtitleStyle,
                    ),
                    autofocus: false,
                  ),
                ),
                widget ?? Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
