import 'package:flutter/material.dart';

class GenreChips extends StatelessWidget {
  final List<String> genres;
  final Set<String> selectedGenres;
  final Function(String, bool) onSelected;

  const GenreChips({
    super.key,
    required this.genres,
    required this.selectedGenres,
    required this.onSelected,
  });

  Color _getGenreColor(String genre) {
    switch (genre) {
      case 'Action':
        return Colors.red.shade600;
      case 'Drama':
        return Colors.purple.shade600;
      case 'Comedy':
        return Colors.yellow.shade600;
      case 'Sci-Fi':
        return Colors.blue.shade600;
      default:
        return Colors.indigo.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Filter by Genre',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white60,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: genres.map((genre) {
            final isSelected = selectedGenres.contains(genre);
            return FilterChip(
              label: Text(
                genre,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                onSelected(genre, selected);
              },
              backgroundColor: Colors.white.withAlpha(10),
              selectedColor: _getGenreColor(genre),
              side: BorderSide(
                color: isSelected
                    ? _getGenreColor(genre)
                    : Colors.white.withAlpha(50),
                width: 1.5,
              ),
              showCheckmark: true,
              checkmarkColor: Colors.white,
              elevation: isSelected ? 4 : 0,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            );
          }).toList(),
        ),
      ],
    );
  }
}
