
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFormField extends StatelessWidget {

  final String? label;
  final bool? isSecure;
  final String? predefineText;
  final ValueChanged<String>? onTextChanged;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final TextInputType input;
  final List<TextInputFormatter>? inputFormatter;
  final TextEditingController? txtController;
  final AutovalidateMode? autovalidate;
  final String? initValue;
  final bool error;

  const AppTextFormField({
    this.label,
    this.isSecure = false,
    this.predefineText,
    required this.input,
    this.onTextChanged,
    this.inputFormatter,
    this.onTap,
    this.validator,
    this.initValue,
    this.txtController,
    this.autovalidate,
    this.error = false,
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: txtController,
      textInputAction: input == TextInputType.multiline ? TextInputAction.newline : TextInputAction.next,
      validator: validator,
      onTap: onTap,
      keyboardType: input,
      inputFormatters: inputFormatter,
      autovalidateMode: autovalidate,
      onChanged: onTextChanged,
      initialValue: initValue,
      obscureText: isSecure ?? false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        labelText: label,
        suffixText: predefineText,
        isDense: true,
        border: const OutlineInputBorder(),
        enabledBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: error ? Colors.red : Colors.grey),
        ),
      ),
    );
  }

}