import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String title;
  final String hint;
  final int minLines;
  final int? maxLength;
  final TextEditingController? controller;
  final Widget? widget;

  const CustomInputField({
    super.key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
    this.minLines = 1,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    cursorColor: Colors.grey[400],
                    controller: controller,
                    maxLength: maxLength,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                    ),
                    decoration: InputDecoration(
                      suffixIcon: widget,
                      hintText: hint,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                    ),
                    maxLines: minLines + 1,
                    minLines: minLines,
                    validator: (value) {
                      if (widget != null) return null;
                      if (value == null || value.isEmpty) {
                        return 'Please enter some ${title.toLowerCase()}';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
