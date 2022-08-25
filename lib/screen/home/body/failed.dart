import 'package:flutter/material.dart';

class FailedBody extends StatelessWidget {
  final VoidCallback retry;
  const FailedBody({
    Key? key,
    required this.retry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Failed to load products"),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () => retry(),
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}
