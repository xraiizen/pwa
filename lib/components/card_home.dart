// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

typedef CartCallback = void Function(bool param);

class cardHome extends StatelessWidget {
  final String imageUrl;
  final String categorie;
  final String title;
  final double? star;
  final String desc;
  final double prix;
  final CartCallback onCallback;

  const cardHome({
    super.key,
    required this.imageUrl,
    required this.categorie,
    required this.title,
    required this.star,
    required this.desc,
    required this.prix,
    required this.onCallback,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius:
          BorderRadius.circular(10.0), // Le rayon de la bordure arrondie
      child: Container(
        color: const Color.fromARGB(70, 226, 226, 226),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                    10.0), // Le rayon de la bordure arrondie
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    fit: BoxFit.cover,
                    imageUrl,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              Text(
                categorie,
                style: TextStyle(fontSize: 12),
              ),
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              RatingBar.builder(
                initialRating: star ?? 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 48, 48, 48),
                ),
                onRatingUpdate: (rating) {},
              ),
              Text(desc),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "$prix€",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                      onPressed: () {
                        onCallback(true);
                      },
                      icon: const Icon(
                        Icons.add_shopping_cart_outlined,
                        size: 36,
                      ))
                ],
              )
            ]),
      ),
    );
  }
}
