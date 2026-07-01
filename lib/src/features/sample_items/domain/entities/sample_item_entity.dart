import 'package:coore/lib.dart';
import 'package:equatable/equatable.dart';

class SampleItemEntity extends Equatable implements Identifiable {
  const SampleItemEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  @override
  final String id;
  final String title;
  final String body;
  final int userId;

  @override
  List<Object?> get props => [id, title, body, userId];
}
