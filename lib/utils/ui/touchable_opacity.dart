import 'package:flutter/material.dart';

class TouchableOpacity extends StatefulWidget {
  final Widget child;
  final void Function()? onTap;
  final Duration duration = const Duration(milliseconds: 50);
  final double opacity = 0.5;

  TouchableOpacity({Key? key, required this.child, required this.onTap})
      : super(key: key);

  @override
  _TouchableOpacityState createState() => _TouchableOpacityState();
}

class _TouchableOpacityState extends State<TouchableOpacity> {
  bool isDown = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isDown = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTapDown: (_) => setState(() => isDown = true),
        onTapUp: (_) => setState(() => isDown = false),
        onTapCancel: () => setState(() => isDown = false),
        onTap: widget.onTap,
        child: AnimatedOpacity(
            duration: widget.duration,
            opacity: isDown ? widget.opacity : 1,
            child: widget.child),
      );
}
