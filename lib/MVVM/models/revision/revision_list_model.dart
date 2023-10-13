import 'package:hive/hive.dart';
import 'package:memo_neet/MVVM/models/revision/revision_model.dart';

part 'revision_list_model.g.dart';

@HiveType(typeId: 9)
class RevisionListModel {
  @HiveField(0)
  String subject;
  @HiveField(1)
  List<RevisionModel> revisionQuestions;

  RevisionListModel({required this.subject, required this.revisionQuestions});
}
