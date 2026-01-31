import 'package:flutter/material.dart';
import '../data/sample_movies.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/genre_chips.dart';
import '../widgets/sort_dropdown.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  String searchQuery = '';
  String selectedSort = 'A-Z';
  Set<String> selectedGenres = {};

  final List<String> genres = ['Action', 'Drama', 'Comedy', 'Sci-Fi'];

  List<Movie> get visibleMovies {
    List<Movie> movies = allMovies.where((movie) {
      final matchSearch = movie.title.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );

      final matchGenre =
          selectedGenres.isEmpty || movie.genres.any(selectedGenres.contains);

      return matchSearch && matchGenre;
    }).toList();

    movies.sort((a, b) {
      switch (selectedSort) {
        case 'A-Z':
          return a.title.compareTo(b.title);
        case 'Z-A':
          return b.title.compareTo(a.title);
        case 'Year':
          return a.year.compareTo(b.year);
        case 'Rating':
          return b.rating.compareTo(a.rating);
        default:
          return 0;
      }
    });

    return movies;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🎬 CineHub'), elevation: 0),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F172A), Color(0xFF1E1B4B)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Discover Movies',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Find your next favorite film',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Search Bar
                MovieSearchBar(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),

                const SizedBox(height: 24),

                // Genre Filter Section
                GenreChips(
                  genres: genres,
                  selectedGenres: selectedGenres,
                  onSelected: (genre, selected) {
                    setState(() {
                      selected
                          ? selectedGenres.add(genre)
                          : selectedGenres.remove(genre);
                    });
                  },
                ),

                const SizedBox(height: 24),

                // Sort Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sort By',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: SortDropdown(
                          value: selectedSort,
                          onChanged: (value) {
                            setState(() {
                              selectedSort = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Movies Count
                Text(
                  '${visibleMovies.length} movie${visibleMovies.length != 1 ? 's' : ''} found',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white60,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 12),

                // Movies Grid/List
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (visibleMovies.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.movie,
                                size: 64,
                                color: Colors.white30,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No movies found',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white60,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Try adjusting your filters',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      if (constraints.maxWidth < 800) {
                        // Mobile: Single column list
                        return ListView.builder(
                          itemCount: visibleMovies.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: MovieCard(movie: visibleMovies[index]),
                            );
                          },
                        );
                      } else {
                        // Desktop: Multi-column grid
                        int crossAxisCount = 2;
                        if (constraints.maxWidth > 1200) {
                          crossAxisCount = 3;
                        }
                        if (constraints.maxWidth > 1600) {
                          crossAxisCount = 4;
                        }

                        return GridView.count(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: 0.75,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          children: visibleMovies
                              .map((movie) => MovieCard(movie: movie))
                              .toList(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
