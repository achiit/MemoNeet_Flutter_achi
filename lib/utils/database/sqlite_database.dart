// ignore_for_file: depend_on_referenced_packages

import 'package:memo_neet/MVVM/models/questions/question_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../constants/constant.dart';

// Make sure to import your QuestionModel class

class SqliteDatabase {
  Database? _biologyDatabase;
  Database? _physicsDatabase;
  Database? _chemistryDatabase;
  Database? _npcmDatabse;
  Future<void> initDatabase() async {
    initBiologyDB();
    initChemistryDB();
    initPhysicsDB();
    initNpcmDB();
  }

  initBiologyDB() async {
    _biologyDatabase = await openDatabase(
      join(await getDatabasesPath(), 'biology_questions.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE biology("
          "uniqueId INT PRIMARY KEY,"
          "question TEXT,"
          "answer TEXT,"
          "explanation TEXT,"
          "topicName TEXT,"
          "difficultyLevel TEXT,"
          "optionA TEXT,"
          "optionB TEXT,"
          "optionC TEXT,"
          "optionD TEXT,"
          "quizType TEXT"
          ")",
        );
      },
      version: 1,
    );
  }

  initChemistryDB() async {
    _chemistryDatabase = await openDatabase(
      join(await getDatabasesPath(), 'chemistry_questions.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE chemistry("
          "uniqueId INT PRIMARY KEY,"
          "question TEXT,"
          "answer TEXT,"
          "explanation TEXT,"
          "topicName TEXT,"
          "difficultyLevel TEXT,"
          "optionA TEXT,"
          "optionB TEXT,"
          "optionC TEXT,"
          "optionD TEXT,"
          "quizType TEXT"
          ")",
        );
      },
      version: 1,
    );
  }

  initPhysicsDB() async {
    _physicsDatabase = await openDatabase(
      join(await getDatabasesPath(), 'physics_questions.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE physics("
          "uniqueId TEXT PRIMARY KEY,"
          "question TEXT,"
          "answer TEXT,"
          "explanation TEXT,"
          "topicName TEXT,"
          "difficultyLevel TEXT,"
          "optionA TEXT,"
          "optionB TEXT,"
          "optionC TEXT,"
          "optionD TEXT,"
          "quizType TEXT"
          ")",
        );
      },
      version: 1,
    );
  }

  initNpcmDB() async {
    _npcmDatabse = await openDatabase(
      join(await getDatabasesPath(), 'npcm_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE npcm("
          "uniqueId TEXT PRIMARY KEY,"
          "question TEXT,"
          "answer TEXT,"
          "explanation TEXT,"
          "topicName TEXT,"
          "difficultyLevel TEXT,"
          "optionA TEXT,"
          "optionB TEXT,"
          "optionC TEXT,"
          "optionD TEXT,"
          "quizType TEXT"
          ")",
        );
      },
      version: 1,
    );
  }

  Future<void> insertQuestion(Subject subject, QuestionModel question) async {
    switch (subject) {
      case Subject.biology:
        await insertBiologyQuestion(question);
        break;
      case Subject.chemistry:
        await insertChemistryQuestion(question);
        break;
      case Subject.physics:
        await insertPhysicsQuestion(question);
        break;
    }
  }

  Future<List<QuestionModel>> getQuestionsInRange(
      Subject subject, String startId, String endId) async {
    switch (subject) {
      case Subject.biology:
        return await getBiologyQuestionsInRange(startId, endId);
      case Subject.chemistry:
        return await getChemistryQuestionsInRange(startId, endId);
      case Subject.physics:
        return await getPhysicsQuestionsInRange(startId, endId);
    }
  }

  Future<int> getQuestionsCount(
      Subject subject, String startId, String endId) async {
    switch (subject) {
      case Subject.biology:
        return (await getBiologyQuestionsInRange(startId, endId)).length;
      case Subject.chemistry:
        return (await getChemistryQuestionsInRange(startId, endId)).length;
      case Subject.physics:
        return (await getPhysicsQuestionsInRange(startId, endId)).length;
    }
  }

  insertBiologyQuestion(QuestionModel question) async {
    if (_biologyDatabase == null) await initBiologyDB();
    await _biologyDatabase!.transaction((txn) async {
      await txn.insert(
        'biology',
        question.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  insertChemistryQuestion(QuestionModel question) async {
    if (_chemistryDatabase == null) await initChemistryDB();
    await _chemistryDatabase!.transaction((txn) async {
      await txn.insert(
        'chemistry',
        question.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  insertPhysicsQuestion(QuestionModel question) async {
    if (_physicsDatabase == null) await initPhysicsDB();
    await _physicsDatabase!.transaction((txn) async {
      await txn.insert(
        'physics',
        question.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  insertNpcmQuestions(QuestionModel question) async {
    if (_npcmDatabse == null) await initNpcmDB();
    await _npcmDatabse!.transaction((txn) async {
      await txn.insert(
        'npcm',
        question.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<List<QuestionModel>> getBiologyQuestionsInRange(
      String startId, String endId) async {
    if (_biologyDatabase == null) await initBiologyDB();
    final List<Map<String, dynamic>> maps = await _biologyDatabase!.query(
      'biology',
      where: 'uniqueId BETWEEN ? AND ?',
      whereArgs: [startId, endId],
    );

    return List.generate(maps.length, (i) {
      return QuestionModel.fromMap(maps[i]);
    });
  }

  Future<List<QuestionModel>> getChemistryQuestionsInRange(
      String startId, String endId) async {
    if (_chemistryDatabase == null) await initChemistryDB();
    final List<Map<String, dynamic>> maps = await _chemistryDatabase!.query(
      'chemistry',
      where: 'uniqueId BETWEEN ? AND ?',
      whereArgs: [startId, endId],
    );

    return List.generate(maps.length, (i) {
      return QuestionModel.fromMap(maps[i]);
    });
  }

  Future<List<QuestionModel>> getPhysicsQuestionsInRange(
      String startId, String endId) async {
    if (_physicsDatabase == null) await initPhysicsDB();
    final List<Map<String, dynamic>> maps = await _physicsDatabase!.query(
      'physics',
      where: 'uniqueId BETWEEN ? AND ?',
      whereArgs: [startId, endId],
    );

    return List.generate(maps.length, (i) {
      return QuestionModel.fromMap(maps[i]);
    });
  }

  Future<List<QuestionModel>> getNpcmQuestionInRange(
      String startId, String endId) async {
    if (_npcmDatabse == null) await initNpcmDB();
    final List<Map<String, dynamic>> maps = await _npcmDatabse!.query(
      'npcm',
      where: 'uniqueId BETWEEN ? AND ?',
      whereArgs: [startId, endId],
    );

    return List.generate(maps.length, (i) {
      return QuestionModel.fromMap(maps[i]);
    });
  }
}
