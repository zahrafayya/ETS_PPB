final String tableMovies = 'movie';

class MovieFields {
  static final List<String> values = [
    id, title, imageUrl, description, time
  ];

  static final String id = '_id';
  static final String title = 'title';
  static final String imageUrl = 'image_url';
  static final String description = 'description';
  static final String time = 'time';
}

class Movie {
  final int? id;
  final String title;
  final String imageUrl;
  final String description;
  final DateTime createdTime;

  const Movie({
    this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.createdTime
  });

  Movie copy({
    int? id,
    String? title,
    String? imageUrl,
    String? description,
    DateTime? createdTime
  }) =>
      Movie(
          id: id ?? this.id,
          title: title ?? this.title,
          imageUrl: imageUrl ?? this.imageUrl,
          description: description ?? this.description,
          createdTime: createdTime ?? this.createdTime
      );

  static Movie fromJson(Map<String, Object?> json) => Movie(
    id: json[MovieFields.id] as int?,
    title: json[MovieFields.title] as String,
    imageUrl: json[MovieFields.imageUrl] as String,
    description: json[MovieFields.description] as String,
    createdTime: DateTime.parse(json[MovieFields.time] as String),
  );

  Map<String, Object?> toJson() => {
    MovieFields.id: id,
    MovieFields.title: title,
    MovieFields.imageUrl: imageUrl,
    MovieFields.description: description,
    MovieFields.time: createdTime.toIso8601String(),
  };
}