import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String hint_text;
  final Icon prefixIcon;
  final bool obsc;

  const InputField({
    super.key,
    required this.controller,
    required this.hint_text,
    required this.prefixIcon,
    required this.obsc,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool obscure = true; // Initialize with true

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: colorScheme.surface, // Use surface color for background
        borderRadius: BorderRadius.circular(40),
      ),
      child: TextField(
        style: TextStyle(color: colorScheme.onSurface), // Text color
        obscureText: widget.obsc ? obscure : false,
        decoration: InputDecoration(
          hintText: widget.hint_text,
          hintStyle: TextStyle(
              color: colorScheme.onSurface.withOpacity(0.6)), // Hint text color
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.obsc
              ? IconButton(
                  icon: Icon(
                    obscure ? Icons.visibility : Icons.visibility_off,
                    color: colorScheme.onSurface.withOpacity(0.6), // Icon color
                  ),
                  onPressed: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(40),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorScheme.primary),
            borderRadius: BorderRadius.circular(40),
          ),
          filled: true,
          fillColor: colorScheme.surface,
        ),
        controller: widget.controller,
        onSubmitted: (String value) {
          debugPrint(value);
        },
      ),
    );
  }
}
