import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class MovieFormWidget extends StatelessWidget {
  final String? title;
  final String? imageUrl;
  final String? description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedImageUrl;
  final ValueChanged<String> onChangedDescription;

  const MovieFormWidget({
    Key? key,
    this.title = '',
    this.imageUrl = '',
    this.description = '',

    required this.onChangedTitle,
    required this.onChangedImageUrl,
    required this.onChangedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              const SizedBox(height: 8),
              buildImageUrl(),
              const SizedBox(height: 8),
              buildDescription(),
              const SizedBox(height: 16),
            ],
          )
      )
  );

  Widget buildTitle() => TextFormField(
    maxLines: 1,
    initialValue: title,
    style: const TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Title',
      hintStyle: TextStyle(color: Colors.white70),
    ),
    validator: (title) => title != null && title.isEmpty ? 'The title cannot be empty' : null,
    onChanged: onChangedTitle,
  );

  Widget buildImageUrl() => TextFormField(
    maxLines: 1,
    initialValue: imageUrl,
    style: const TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Image URL',
      hintStyle: TextStyle(color: Colors.white70),
    ),
    validator: (imageUrl) => imageUrl != null && imageUrl.isEmpty ? 'The image URL cannot be empty' : null,
    onChanged: onChangedImageUrl,
  );

  Widget buildDescription() => TextFormField(
    maxLines: 5,
    initialValue: description,
    style: const TextStyle(color: Colors.white60, fontSize: 18),
    decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Type something...',
        hintStyle: TextStyle(color: Colors.white60)
    ),
    validator: (title) => title != null && title.isEmpty
        ? 'The description cannot be empty'
        : null,
    onChanged: onChangedDescription,
  );
}

