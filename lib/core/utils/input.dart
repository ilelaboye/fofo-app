import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void hideKeyboard() {
  SystemChannels.textInput.invokeMethod<String>('TextInput.hide');
}

void unFocus() {
  primaryFocus?.unfocus();
}

/// default validator, used when no validator is provided to the textinput
String? defaultValidator(String? fieldValue) {
  const reqText = "field is required";
  if (fieldValue != null && fieldValue.isNotEmpty) return null;
  return reqText;
}
