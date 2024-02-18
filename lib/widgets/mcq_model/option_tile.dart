import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  final String option;
  final int correctAnswerIndex;
  final int currentIndex;
  final Function onTap;

  const OptionTile({super.key, 
    required this.option,
    required this.correctAnswerIndex,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _colorAnimation = ColorTween(
      begin: Colors.white,
      end: widget.currentIndex == widget.correctAnswerIndex
          ? Colors.green
          : Colors.red,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant OptionTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex == widget.correctAnswerIndex) {
      _animationController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
        _animate();
      },
      child: AnimatedBuilder(
        animation: _colorAnimation,
        builder: (context, child) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _colorAnimation.value,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.blue),
            ),
            child: Text(
              widget.option,
              style: TextStyle(
                fontSize: 14,
                color: widget.currentIndex == widget.correctAnswerIndex
                    ? Colors.black
                    : Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }

  void _animate() {
    _animationController.forward(from: 0.0);
  }
}
