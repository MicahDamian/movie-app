import 'dart:async';
import 'package:flutter/material.dart';
import 'models/movie.dart';
import 'widgets/movie_card.dart';
import 'widgets/search_bar.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
      ),
      home: const MovieHomePage(),
    );
  }
}

class MovieHomePage extends StatefulWidget {
  const MovieHomePage({super.key});

  @override
  State<MovieHomePage> createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Movie> allMovies = [];
  List<Movie> filteredMovies = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    allMovies = [
      Movie(title: "The Cat in the Hat", year: "2003", imageUrl: "https://m.media-amazon.com/images/M/MV5BMTI5MDU3MTYyMF5BMl5BanBnXkFtZTYwODgyODc3._V1_FMjpg_UX1000_.jpg"),
      Movie(title: "The Cat Returns", year: "2002", imageUrl: "https://upload.wikimedia.org/wikipedia/en/8/8e/Cat_Returns.jpg"),
      Movie(title: "Black Cat, White Cat", year: "1998", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRq98jeL17Ff_qheRP5rO1QOBfKjGRPbbiKDg&s"),
      Movie(title: "Cat on a Hot Tin Roof", year: "1958", imageUrl: "https://upload.wikimedia.org/wikipedia/commons/5/51/Cat_roof.jpg"),
      Movie(title: "A Street Cat Named Bob", year: "2016", imageUrl: "https://m.media-amazon.com/images/M/MV5BMDk3ZGE2OTItY2JkYi00NWEzLWI1NjQtZGZlMzdkNjJlNmYxXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg"),
      Movie(title: "Cat People", year: "1942", imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/aa/Cat_People_%281942_poster%29.jpg/500px-Cat_People_%281942_poster%29.jpg"),
    ];
    filteredMovies = allMovies;
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      setState(() {
        filteredMovies = allMovies
            .where((movie) =>
                movie.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie app'),
        centerTitle: true,
        backgroundColor: AppColors.background,
      ),
      body: Column(
        children: [
          CustomSearchBar(
            controller: _searchController,
            onChanged: _onSearchChanged,
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredMovies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                return MovieCard(movie: filteredMovies[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
