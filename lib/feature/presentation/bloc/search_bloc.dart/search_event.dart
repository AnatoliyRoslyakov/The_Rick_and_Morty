// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class PersonSearchEvent extends Equatable {
  const PersonSearchEvent();

  List<Object?> get props => [];
}

class SearchPersons extends PersonSearchEvent {
  final String personQuery;
  SearchPersons({
    required this.personQuery,
  });
}
