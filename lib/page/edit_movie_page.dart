import 'package:flutter/material.dart';
import '../db/movies_database.dart';
import '../model/movie.dart';
import '../widget/movie_form_widget.dart';

class AddEditMoviePage extends StatefulWidget {
  final Movie? movie;

  const AddEditMoviePage({
    Key? key,
    this.movie,
  }) : super(key: key);

  @override
  State<AddEditMoviePage> createState() => _AddEditMoviePageState();
}

class _AddEditMoviePageState extends State<AddEditMoviePage> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String imageUrl;
  late String description;

  @override
  void initState() {
    super.initState();

    title = widget.movie?.title ?? '';
    imageUrl = widget.movie?.imageUrl ?? 'https://m.media-amazon.com/images/I/61Q6coo3EIL._AC_UF1000,1000_QL80_.jpg';
    description = widget.movie?.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [buildButton()],
    ),
    body: Form(
      key: _formKey,
      child: MovieFormWidget(
        title: title,
        imageUrl: imageUrl,
        description: description,
        onChangedTitle: (title) => setState(() => this.title = title),
        onChangedImageUrl: (imageUrl) => setState(() => this.imageUrl = imageUrl),
        onChangedDescription: (description) => setState(() => this.description = description),
      ),
    ),
  );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && imageUrl.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: isFormValid ? null : Colors.grey.shade700
          ),
          onPressed: addOrUpdateMovie,
          child: const Text('Save')
      ),
    );
  }

  void addOrUpdateMovie() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.movie != null;

      if (isUpdating) {
        await updateMovie();
      } else {
        await addMovie();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateMovie() async {
    final movie = widget.movie!.copy(
      title: title,
      imageUrl: imageUrl,
      description: description,
    );

    await MoviesDatabase.instance.updateMovie(movie);
  }

  Future addMovie() async {
    final movie = Movie(
        title: title,
        imageUrl: imageUrl,
        description: description,
        createdTime: DateTime.now()
    );

    await MoviesDatabase.instance.createMovie(movie);
  }
}