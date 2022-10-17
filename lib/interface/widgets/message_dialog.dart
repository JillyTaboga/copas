import 'package:flutter/material.dart';

class MessageDialog extends StatelessWidget {
  const MessageDialog({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          boxShadow: kElevationToShadow[3],
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: child,
      ),
    );
  }
}
