import 'package:flutter/material.dart';

class MovieSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const MovieSearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Search for movies...',
        hintStyle: TextStyle(color: Colors.white60),
        prefixIcon: const Icon(Icons.search, color: Colors.white70),
        suffixIcon: const Padding(
          padding: EdgeInsets.only(right: 8),
          child: Icon(Icons.movie, color: Colors.indigo),
        ),
        filled: true,
        fillColor: Colors.white.withAlpha(10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.indigo.withAlpha(50)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.indigo.withAlpha(100)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.indigo, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      onChanged: onChanged,
    );
  }
}
