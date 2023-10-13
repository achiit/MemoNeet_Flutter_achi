import 'package:hive/hive.dart';

part 'crossword_model.g.dart';

@HiveType(typeId: 10)
class CrosswordModel extends HiveObject {
  @HiveField(0)
  final String topic;

  @HiveField(1)
  final String crossword;

  CrosswordModel({
    required this.topic,
    required this.crossword,
  });

  // to map
  Map<String, dynamic> toMap() {
    return {
      'topic': topic,
      'crossword': crossword,
    };
  }
}
