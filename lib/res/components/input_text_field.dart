import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFiledSubmissionValue;
  final FormFieldValidator onValidator;
  final TextInputType keyboardType;
  final String hint;
  final bool obsecureText;
  final bool enable, autoFocus;

  const InputTextField({
    super.key,
    required this.myController,
    required this.focusNode,
    required this.onFiledSubmissionValue,
    required this.onValidator,
    required this.keyboardType,
    required this.hint,
    required this.obsecureText,
    this.enable = true,
    this.autoFocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: myController,
        focusNode: focusNode,
        obscureText: obsecureText,
        onFieldSubmitted: onFiledSubmissionValue,
        validator: onValidator,
        keyboardType: keyboardType,
        cursorColor: AppColors.primaryTextTextColor,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 19),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(
                color: AppColors.textFieldDefaultFocus, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColors.secondaryColor, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.alertColor, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: AppColors.textFieldDefaultBorderColor, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppColors.primaryTextTextColor.withOpacity(0.8),
              height: 0),
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }
}
