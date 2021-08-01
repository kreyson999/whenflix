class MovieModel {
  final String id;
  final String title;
  final String description;
  final String dateTime;
  final int rating;
  final String cast;
  final bool popular;
  final String writers;
  final List genres;
  final List images;
  final String trailerVideoId;

  MovieModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.rating,
    required this.cast,
    required this.popular,
    required this.writers,
    required this.genres,
    required this.images,
    required this.trailerVideoId,
  });

  factory MovieModel.fromJson(Map<String, dynamic> item) {
    return MovieModel(
      id: item["id"],
      title: item["title"],
      description: item["description"],
      dateTime: item["dateTime"],
      rating: item["rating"],
      cast: item["cast"],
      popular: item["popular"],
      writers: item["writers"],
      genres: item["genres"],
      images: item["images"],
      trailerVideoId: item["trailerVideoId"],
    );
  }
}
