import 'package:hive/hive.dart';

part 'podcast_model.g.dart';

@HiveType(typeId: 12)
class PodcastModel extends HiveObject {
  @HiveField(0)
  final String topic;

  @HiveField(1)
  final String podcast;

  PodcastModel({required this.topic, required this.podcast});

  // to map
  Map<String, dynamic> toMap() {
    return {
      'topic': topic,
      'podcast': podcast,
    };
  }
}
