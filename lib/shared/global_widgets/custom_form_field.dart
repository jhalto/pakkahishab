import 'package:flutter/material.dart';

import '../../core/const/app_colors.dart';
import '../../core/const/app_text_style.dart';

class CustomFormField extends StatefulWidget {
  final String? hint;
  final TextEditingController controller;
  final bool isPassword;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final VoidCallback? onComplete;
  const CustomFormField({
    super.key,
    this.hint,
    required this.controller,
    this.prefixIcon,
    this.isPassword = false,
    this.validator,
    this.textInputAction,
    this.onComplete,
  });

  @override
  CustomFormFieldState createState() => CustomFormFieldState();
}

class CustomFormFieldState extends State<CustomFormField> {
  // bool _isObscured = true;
  final ValueNotifier<String?> _errorText = ValueNotifier(null);
  final ValueNotifier<bool> _isObscured = ValueNotifier(true);
  late FocusNode _focusNode;
  void resetError() {
    _errorText.value = null;
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      // Clear error when typing
      _errorText.value = null;
    } else {
      // Validate only after typing is finished (focus lost)
      _validateInput();
    }
  }

  String? _validateInput() {
    final result = widget.validator?.call(widget.controller.text);
    if (_errorText.value != result) {
      _errorText.value = result;
    }
    return result;
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validateInput);
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _errorText.dispose();
    _isObscured.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder(
          valueListenable: _isObscured,
          builder: (context, value, child) => ValueListenableBuilder(
            valueListenable: _errorText,
            builder: (context, error, child) => TextFormField(
              focusNode: _focusNode,
              cursorColor: AppColors.primaryColor,
              validator: (value) {
                final result = widget.validator?.call(value);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_errorText.value != result) {
                    _errorText.value = result;
                  }
                });
                return result;
              },
              style: AppTextStyle.bodyLarge,
              onEditingComplete: widget.onComplete,
              textInputAction: widget.textInputAction,
              controller: widget.controller,
              obscureText: widget.isPassword ? _isObscured.value : false,

              decoration: InputDecoration(
                errorText: error,
                errorStyle: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                ),
                errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                // Error border when the field is focused
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                prefixIconConstraints: BoxConstraints(minWidth: 50),
                prefixIcon: widget.prefixIcon,
                hintText: widget.hint,
                hintStyle: AppTextStyle.bodyMediumSecondary,
                filled: true,

                fillColor: _errorText.value == null
                    ? AppColors.fillColor
                    : Color(0xfff9d1d1),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 19,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                suffixIcon: widget.isPassword
                    ? ValueListenableBuilder<bool>(
                        valueListenable: _isObscured,
                        builder: (context, value, child) {
                          return IconButton(
                            icon: Icon(
                              value ? Icons.visibility_off : Icons.visibility,
                              color: Colors.black87,
                              size: 24,
                            ),
                            onPressed: () {
                              _isObscured.value = !_isObscured.value;
                            },
                          );
                        },
                      )
                    : (_errorText.value != null
                          ? Icon(
                              Icons.report_problem_rounded,
                              color: Colors.black54,
                            )
                          : null),
              ),
            ),
          ),
        ),

        ValueListenableBuilder(
          valueListenable: _errorText,
          builder: (context, value, child) {
            if (value != null) {
              return Container(
                // margin: EdgeInsets.only(top: 2.h),
                height: 1,
                width: double.infinity,
                color: Color(0xfff9d1d1),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
