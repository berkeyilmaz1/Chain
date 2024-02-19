import 'package:flutter/material.dart';
import 'package:schallange/constants/constants.dart';

class myPostButton extends StatelessWidget {
  const myPostButton({super.key, this.onTap});
  final  Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
            color: ufo_green,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        padding: EdgeInsets.all(18),
        margin: const EdgeInsets.only(left: 10),
        child: const Center(child: Icon(Icons.done_rounded)),
      ),
    );
  }
}
