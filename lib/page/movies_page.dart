import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../db/movies_database.dart';
import '../model/movie.dart';
import '../widget/movie_card_widget.dart';
import 'movie_detail_page.dart';
import 'edit_movie_page.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late List<Movie> movies;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshMovies();
  }

  @override
  void dispose() {
    MoviesDatabase.instance.close();

    super.dispose();
  }

  Future refreshMovies() async {
    setState(() => isLoading = true);

    movies = await MoviesDatabase.instance.readAllMovies();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
          appBar: AppBar(
              title: const Text(
                'movies',
                style: TextStyle(fontSize: 24),
              ),
              actions: const [Icon(Icons.search), SizedBox(width: 12)]
          ),
          body: isLoading
              ? Center(
                child: const CircularProgressIndicator(),
              )
              : movies.isEmpty
              ? Center(
                child: const Text(
                  'No movies',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              )
              : buildMovies(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            child: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const AddEditMoviePage()),
              );

              refreshMovies();
            },
          )
      );

  Widget buildMovies() => StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      children: List.generate(
          movies.length,
              (index) {
            final movie = movies[index];

            return StaggeredGridTile.fit(
              crossAxisCellCount: 1,
              child: GestureDetector(
                onTap: () async {
                  await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MovieDetailPage(movieId: movie.id!),
                  ));

                  refreshMovies();
                },
                child: MovieCardWidget(movie: movie, index: index),
              ),
            );
          }
      )
  );
}