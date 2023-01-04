import 'package:flutter/material.dart';

class DefaultButtonWidget extends StatelessWidget {
  const DefaultButtonWidget({
    Key? key,
    required this.onTap,
    required this.buttonName,
  }) : super(key: key);

  final Function() onTap;
  final String buttonName;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                offset: Offset(-3, -3),
                color: Color(0xff4E4E4E),
                // blurStyle: BlurStyle.normal,
                blurRadius: 15.0,
                spreadRadius: 3,
              ),
              BoxShadow(
                offset: Offset(3, 3),
                color: Colors.black,
                // blurStyle: BlurStyle.normal,
                blurRadius: 15.0,
                spreadRadius: 3,
              ),
            ]),
        child: Center(
          child: Text(
            buttonName,
            style: const TextStyle(
                color: Color(0xff222222),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
