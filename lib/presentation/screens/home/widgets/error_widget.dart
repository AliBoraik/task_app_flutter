import 'package:flutter/material.dart';

class OnError extends StatelessWidget {
  final String messgae;
  const OnError({
    super.key,
    required this.messgae,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("something wrong!"));
  }
}
