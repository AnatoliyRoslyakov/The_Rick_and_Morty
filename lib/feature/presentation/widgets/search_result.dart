import 'package:flutter/material.dart';
import 'package:the_rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:the_rick_and_morty/feature/presentation/pages/person_detail_page.dart';
import 'package:the_rick_and_morty/feature/presentation/widgets/person_cache_image_widget.dart';

class SearchResult extends StatelessWidget {
  final PersonEntity personResult;

  const SearchResult({Key? key, required this.personResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PersonDetailPage(person: personResult),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: PersonCacheImage(
                imageUrl: personResult.image,
                height: 300,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                personResult.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                personResult.location.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
