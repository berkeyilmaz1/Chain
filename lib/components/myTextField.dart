import 'package:flutter/material.dart';
import 'package:schallange/components/mySizedBox.dart';
import 'package:schallange/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.name,
    required this.obscureText,
     this.controllerName,
    this.validator,
    this.onSaved,
  });
  final String name;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? controllerName;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            name,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        const MySizedBox(height: 2, widht: 0),
        TextFormField(
          controller: controllerName,
          onSaved: onSaved,
          validator: validator,
          decoration: InputDecoration(
              fillColor: Colors.grey.shade300,
              contentPadding: const EdgeInsets.all(12),
              hintStyle: kTextStyle,
              filled: true,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide.none,
              )),
          obscureText: obscureText,
          cursorColor: Colors.grey,
          maxLines: 1,
          style: kTextStyle,
        ),
      ],
    );
  }
}