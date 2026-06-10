import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';
import '../widgets/movie_details_sidebar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Movie? selectedMovie;

  // Dummy movie data
  final List<Movie> movies = [
    Movie(
      id: 1,
      title: 'Inception',
      description: 'A skilled thief who steals corporate secrets through the use of dream-sharing technology.',
      genre: 'Sci-Fi, Thriller',
      rating: 8.8,
      year: 2010,
    ),
    Movie(
      id: 2,
      title: 'The Dark Knight',
      description: 'When the menace known as the Joker wreaks havoc and chaos on Gotham City.',
      genre: 'Action, Crime',
      rating: 9.0,
      year: 2008,
    ),
    Movie(
      id: 3,
      title: 'Interstellar',
      description: 'A team of explorers travel through a wormhole in space to ensure humanity survival.',
      genre: 'Adventure, Sci-Fi',
      rating: 8.6,
      year: 2014,
    ),
    Movie(
      id: 4,
      title: 'Pulp Fiction',
      description: 'The lives of two mob hitmen, a boxer, a gangster and his wife intertwine in four tales.',
      genre: 'Crime, Drama',
      rating: 8.9,
      year: 1994,
    ),
    Movie(
      id: 5,
      title: 'Forrest Gump',
      description: 'The presidencies of Kennedy and Johnson unfold from the perspective of an Alabama man.',
      genre: 'Drama, Romance',
      rating: 8.8,
      year: 1994,
    ),
    Movie(
      id: 6,
      title: 'The Matrix',
      description: 'A computer hacker learns from mysterious rebels about the true nature of his reality.',
      genre: 'Action, Sci-Fi',
      rating: 8.7,
      year: 1999,
    ),
    Movie(
      id: 7,
      title: 'Gladiator',
      description: 'A former Roman General sets out to exact vengeance against the corrupt emperor.',
      genre: 'Action, Adventure, Drama',
      rating: 8.5,
      year: 2000,
    ),
    Movie(
      id: 8,
      title: 'Avatar',
      description: 'A paraplegic Marine dispatched to the moon Pandora on a unique mission.',
      genre: 'Action, Adventure, Fantasy',
      rating: 7.8,
      year: 2009,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWideScreen = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          widget.title,
          style: TextStyle(color: theme.colorScheme.onPrimary),
        ),
      ),
      body: Row(
        children: [
          // Left side: Movie Grid
          Expanded(
            flex: 3,
            child: Container(
              color: theme.colorScheme.surface,
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isWideScreen ? 4 : 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  final isSelected = selectedMovie?.id == movie.id;

                  return MovieCard(
                    movie: movie,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        selectedMovie = movie;
                      });
                    },
                  );
                },
              ),
            ),
          ),
          // Right side: Movie Details Sidebar (only on wide screens or when movie selected)
          if (selectedMovie != null && isWideScreen)
            Expanded(
              flex: 1,
              child: MovieDetailsSidebar(
                movie: selectedMovie!,
                onClose: () {
                  setState(() {
                    selectedMovie = null;
                  });
                },
              ),
            ),
        ],
      ),
      // Show details in dialog on mobile
      floatingActionButton: selectedMovie != null && !isWideScreen
          ? FloatingActionButton(
              tooltip: 'View Details',
              child: const Icon(Icons.info),
              onPressed: () {
                _showMovieDetailsDialog(context, selectedMovie!);
              },
            )
          : null,
    );
  }

  void _showMovieDetailsDialog(BuildContext context, Movie movie) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(movie.title),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Genre: ${movie.genre}'),
              const SizedBox(height: 8),
              Text('Year: ${movie.year}'),
              const SizedBox(height: 8),
              Text('Rating: ⭐ ${movie.rating}/10'),
              const SizedBox(height: 16),
              Text('Description:\n${movie.description}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
