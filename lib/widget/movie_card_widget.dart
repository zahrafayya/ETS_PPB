import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/movie.dart';

final _lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100
];

class MovieCardWidget extends StatelessWidget {
  const MovieCardWidget({
    Key? key,
    required this.movie,
    required this.index
  }) : super(key: key);

  final Movie movie;
  final int index;

  @override
  Widget build(BuildContext context) {
    final color = _lightColors[index % _lightColors.length];
    final time = DateFormat.yMMMd().format(movie.createdTime);
    final minHeight = getMinHeight(index);

    return Card(
        color: color,
        child: Container(
            constraints: BoxConstraints(minHeight: minHeight),
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(time, style: TextStyle(color: Colors.grey.shade700)),
                const SizedBox(height: 4),
                Image.network(
                    movie.imageUrl
                ),
                const SizedBox(height: 4),
                Text(
                    movie.title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    )
                )
              ],
            )
        )
    );
  }

  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}