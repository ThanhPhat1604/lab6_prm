import 'package:flutter/material.dart';

class SortDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String?> onChanged;

  const SortDropdown({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.indigo.withAlpha(100), width: 1.5),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withAlpha(10),
      ),
      child: DropdownButton<String>(
        value: value,
        items: const [
          DropdownMenuItem(
            value: 'A-Z',
            child: Row(
              children: [
                Icon(Icons.sort_by_alpha, size: 18, color: Colors.indigo),
                SizedBox(width: 8),
                Text('A-Z'),
              ],
            ),
          ),
          DropdownMenuItem(
            value: 'Z-A',
            child: Row(
              children: [
                Icon(Icons.sort_by_alpha, size: 18, color: Colors.indigo),
                SizedBox(width: 8),
                Text('Z-A'),
              ],
            ),
          ),
          DropdownMenuItem(
            value: 'Year',
            child: Row(
              children: [
                Icon(Icons.calendar_today, size: 18, color: Colors.indigo),
                SizedBox(width: 8),
                Text('Year'),
              ],
            ),
          ),
          DropdownMenuItem(
            value: 'Rating',
            child: Row(
              children: [
                Icon(Icons.star, size: 18, color: Colors.orange),
                SizedBox(width: 8),
                Text('Rating'),
              ],
            ),
          ),
        ],
        onChanged: onChanged,
        underline: const SizedBox(),
        dropdownColor: const Color(0xFF1E1B4B),
        style: const TextStyle(color: Colors.white, fontSize: 16),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.indigo),
      ),
    );
  }
}
