import 'package:disease_tracker_app/Components/text_style.dart';
import 'package:disease_tracker_app/UI/LoginSignup/loginpage.dart';
import 'package:flutter/material.dart';

import '../UI/AccountVerification/accoutverification.dart';
import 'app_colors.dart';

class ApiButton extends StatefulWidget {
  final String text;
  final IconData? icon;
  final String? image;
  final Color color;
  final Color backgroundColor;
  final VoidCallback? onTap;
    ApiButton({
    super.key,
    this.image,
    this.icon,
    required this.text,
    required this.color,
    required this.backgroundColor,
    this.onTap,
  });




  @override
  State<ApiButton> createState() => _ApiButtonState();
}

class _ApiButtonState extends State<ApiButton> {
  @override
  Widget build(BuildContext context) {
    bool isPressed = false;

    Widget buildIconOrImage() {
      if (widget.icon != null) {
        return Icon(widget.icon, color: widget.color);
      } else if (widget.image != null) {
        return SizedBox(
          width: 50,
          height: 50,
          child: Image.asset(widget.image!),
        );
      } else {
        return const SizedBox();
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 23),
      child: GestureDetector(
        onTapDown: (_) => setState(() => isPressed = true),
        onTapUp: (_) {
          setState(() => isPressed = false);
          // Callback function call karen agar available hai
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
        onTapCancel: () => setState(() => isPressed = false),
        child: Container(
          width: 320,
          height: 60,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildIconOrImage(),
              SizedBox(width: 8),
              Text(
                widget.text,
                style: AppTextStyles.poppinsMedium.copyWith(
                  color: widget.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextLine extends StatelessWidget {
  final String name;
  final TextStyle style;
  final double size;
  const TextLine({
    super.key,
    required this.name,
    required this.style,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(),
      child: Text(name, style: style.copyWith(fontSize: size)),
    );
  }
}

class TextForm extends StatefulWidget {
  final String labelName;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  bool isPassword;
    TextForm({
    super.key,
    required this.labelName,
    required this.hintText,
    required this.controller,
    required this.validator,
      this.isPassword=false,
  });

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  var _obscureText = true;

  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.labelName,
              style: AppTextStyles.poppinsSemiBold.copyWith(fontSize: 12),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            obscureText: widget.isPassword ? _obscureText : false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppTextStyles.poppinsMedium.copyWith(fontSize: 12),
              suffixIcon: widget.isPassword ? IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  )
              ) : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomFieldRow extends StatelessWidget {
  final String text;
  final String action;
  final VoidCallback? onTap;
  const CustomFieldRow({super.key, required this.text, required this.action,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        InkWell(
          onTap: onTap,
          child: Text(
            action,
            style: AppTextStyles.poppinsMedium.copyWith(
              color: AppColors.primary2,
            ),
          ),
        ),
      ],
    );
  }
}
