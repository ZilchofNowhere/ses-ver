import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  final bool elevated;
  final void Function() onPressed;
  final Widget child;
  final ButtonStyle? style;
  const WideButton({
    super.key,
    required this.elevated,
    required this.onPressed,
    required this.child,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: elevated
              ? ElevatedButton(
                  onPressed: onPressed,
                  style: style,
                  child: child,
                )
              : TextButton(
                  onPressed: onPressed,
                  style: style,
                  child: child,
                ),
        ),
      ],
    );
  }
}
