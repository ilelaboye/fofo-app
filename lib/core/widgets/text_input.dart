import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/utils/input.dart';

class BaseTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefix;
  final String? initialValue;
  final TextInputType? keyboardType;
  final bool obscureText;

  BaseTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.validator,
    this.onSaved,
    this.inputFormatters,
    this.controller,
    this.initialValue,
    this.suffixIcon,
    this.prefix,
    this.keyboardType,
    this.obscureText = false,
  }) : super(key: key);

  final _border = OutlineInputBorder(
    borderRadius: Corners.xsBorder,
    borderSide: BorderSide(
      color: AppColors.palette[50]!,
      width: 1.2,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      inputFormatters: inputFormatters,
      onSaved: onSaved,
      validator: validator,
      initialValue: initialValue,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: context.textTheme.bodyMedium!.size(15).changeColor(
            AppColors.primary,
          ),
      decoration: InputDecoration(
        hintText: hintText,
        errorStyle:
            context.textTheme.bodyMedium!.size(15).changeColor(AppColors.error),
        hintStyle: context.textTheme.bodyMedium!
            .size(15)
            .changeColor(AppColors.palette[500]!),
        fillColor: AppColors.palette[50],
        filled: true,
        isDense: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: prefix,
        prefixIconConstraints:
            const BoxConstraints(minWidth: 48, minHeight: 48),
        suffixIcon: suffixIcon,
        border: _border,
        enabledBorder: _border,
        errorBorder: _border,
        focusedErrorBorder: _border,
        focusedBorder: _border.copyWith(
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 0.8,
          ),
        ),
      ),
    );
  }
}

class TextInputField extends BaseTextField {
  TextInputField({
    FormFieldSetter<String>? onSaved,
    String? initialValue,
    Widget? suffixIcon,
    Widget? prefix,
    String? labelText,
    TextEditingController? controller,
    String? hintText = "",
    String? Function(String?)? validator = defaultValidator,
    TextInputType? keyboardType = TextInputType.text,
    bool obscureText = false,
    Key? key,
  }) : super(
            key: key,
            labelText: labelText,
            hintText: hintText,
            onSaved: onSaved,
            initialValue: initialValue,
            suffixIcon: suffixIcon,
            prefix: prefix,
            keyboardType: keyboardType,
            obscureText: obscureText,
            validator: validator,
            controller: controller);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (labelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: Insets.sm),
            child: Text(
              labelText!,
              style: context.textTheme.bodyMedium!
                  .size(16)
                  .changeColor(AppColors.palette[900]!),
            ),
          ),
        super.build(context),
      ],
    );
  }
}
