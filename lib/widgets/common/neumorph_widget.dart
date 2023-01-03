import 'package:flutter/material.dart';

class NeumorphWidget extends StatelessWidget {
const NeumorphWidget({ Key? key, required this.child }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(boxShadow: [

        BoxShadow(
          offset: Offset(-2, -2),
          color: Color(0xff4E4E4E),
          // blurStyle: BlurStyle.normal,
          blurRadius: 10.0,
          spreadRadius: 1
        ),

        BoxShadow(
          offset: Offset(3, 3),
          color: Colors.black,
          // blurStyle: BlurStyle.normal,
          blurRadius: 10.0,
          spreadRadius: 3
        ),
      ]),
      child: child,
    );
  }
}