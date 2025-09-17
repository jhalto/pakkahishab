
import 'package:flutter/material.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';

class CustomTextField extends StatefulWidget {
  final String? hint;
  final Widget? prefixIcon;
  final bool isLoading;
  final bool isPassword;
  final VoidCallback? onDone; 
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final TextInputType? textInputType;
  const CustomTextField({
    super.key,
    this.hint,
    this.textInputAction,
    this.onDone,
    this.textInputType,
    this.prefixIcon,
    this.onChanged,
    this.isLoading = false,
    this.isPassword = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) => widget.onDone?.call(),
       keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      cursorColor: AppColors.primaryTextColor,
      style: TextStyle(
        fontSize: 14,
        color: widget.isLoading
            ? Colors.transparent
            : AppColors.primaryTextColor,
      ),
      
      onChanged: widget.onChanged,
      readOnly: widget.isLoading,
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        
        border: InputBorder.none,
        prefixIconConstraints: const BoxConstraints(minWidth: 50),
        prefixIcon: widget.prefixIcon,
        label: Text(widget.hint ?? ""),
        hintStyle: bodyMediumSecondary(context),
        filled: true,
        fillColor: AppColors.fillColor,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 19,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xffF4F4F4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xffF4F4F4)),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
