// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:the_rick_and_morty/common/app_colors.dart';

import 'package:the_rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:the_rick_and_morty/feature/presentation/widgets/person_cache_image_widget.dart';

class PersonDetailPage extends StatelessWidget {
  final PersonEntity person;
  const PersonDetailPage({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Character'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            SizedBox(height: 24),
            Text(
              person.name,
              style: const TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              child: PersonCacheImage(
                width: 260,
                height: 260,
                imageUrl: person.image,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                      color:
                          person.status == 'Alive' ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(8)),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  person.status,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 1,
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            if (person.type.isNotEmpty) ..._buildText('Type:', person.type),
            ..._buildText('Gender:', person.gender),
            ..._buildText(
                'Number of erisodes:', person.episode.length.toString()),
            ..._buildText('Species:', person.species),
            ..._buildText('Last know location:', person.location.name),
            ..._buildText('Origin:', person.origin.name),
            ..._buildText('Was created:', person.created.toString()),
          ]),
        ),
      ),
    );
  }

  List<Widget> _buildText(String text, String value) {
    return [
      Text(text, style: const TextStyle(color: AppColors.greyColor)),
      const SizedBox(
        height: 4,
      ),
      Text(
        value,
        style: const TextStyle(color: Colors.white),
      ),
      const SizedBox(
        height: 12,
      ),
    ];
  }
}
