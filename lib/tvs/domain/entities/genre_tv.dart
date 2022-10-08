import 'package:equatable/equatable.dart';

class GenreTV extends Equatable {
  final int id;
  final String name;

  const GenreTV({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
