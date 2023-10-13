import 'package:hive/hive.dart';
import 'package:memo_neet/MVVM/models/npcm/podcast_model.dart';

import 'crossword_model.dart';

class NPCMModel extends HiveObject {
  final String chapterName;
  final String uidStart;
  final String uidEnd;
  String? notes;
  List<PodcastModel> listOfPodcasts;
  List<CrosswordModel> listOfCrosswords;
  String? memes;
  bool isFree;

  NPCMModel({
    required this.chapterName,
    required this.uidStart,
    required this.uidEnd,
    this.notes,
    required this.listOfPodcasts,
    required this.listOfCrosswords,
    this.memes,
    this.isFree = false,
  });

  // to map
  Map<String, dynamic> toMap() {
    return {
      'chapterName': chapterName,
      'uidStart': uidStart,
      'uidEnd': uidEnd,
      'notes': notes,
      'listOfPodcasts': listOfPodcasts.map((x) => x.toMap()).toList(),
      'listOfCrosswords': listOfCrosswords.map((x) => x.toMap()).toList(),
      'memes': memes,
    };
  }
}
