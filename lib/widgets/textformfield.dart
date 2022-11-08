import 'package:locpay/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void _toggle() {}

textFormField(
  TextEditingController controller,
  TextInputType keyboardType,
  String labelText,
  String hintText, {
  String? Function(String?)? validator,
  Widget? suffixIcon = const IconButton(
    splashRadius: 0.1,
    splashColor: Color(0x00000000),
    color: kIconColour,
    icon: Icon(
      Icons.circle_rounded,
    ),
    onPressed: _toggle,
  ),
  bool obscureText = false,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 15.0, right: 14, left: 14, bottom: 6),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          // borderSide: BorderSide(
          //   color: kContainerColour,
          // ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(
            color: kContainerColour,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          // borderSide: BorderSide(
          //   color: kContainerColour,
          // ),
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          fontFamily: 'Ubuntu',
          fontSize: 17,
          color: kContainerColour,
        ),
        floatingLabelStyle: const TextStyle(
          fontFamily: 'Ubuntu',
          fontSize: 17,
          color: kContainerColour,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontFamily: 'Ubuntu',
          fontSize: 17,
          color: kHintColour,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 2.0),
        suffixIcon: suffixIcon,
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      style: const TextStyle(
        color: kContainerColour,
        fontFamily: 'Ubuntu',
        fontWeight: FontWeight.bold,
        fontSize: 17,
      ),
      cursorColor: kContainerColour,
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      obscureText: obscureText,
    ),
  );
}
