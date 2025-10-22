class Movie {
  final String title;
  final String year;
  final String poster;

  Movie({
    required this.title,
    required this.year,
    required this.poster,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'] ?? 'Unknown Title',
      year: json['Year'] ?? 'N/A',
      poster: json['Poster'] ?? '',
    );
  }
}
