import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class AppButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final String text;
  final bool isLoading;
  final VoidCallback onPressed;
  const AppButton({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    print(isLoading);
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(color: color),
        child: Center(
          child:
              isLoading
                  ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                  : Text(text, style: TextStyle()),
        ),
      ),
    );
  }
}
