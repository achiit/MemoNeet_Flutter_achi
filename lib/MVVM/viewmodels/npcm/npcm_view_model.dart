// ignore_for_file: prefer_final_fields, avoid_print

import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:memo_neet/MVVM/models/npcm/npcm_model.dart';
import 'package:memo_neet/MVVM/models/npcm/podcast_model.dart';
import 'package:memo_neet/repo/npcm_data.dart';
import 'package:memo_neet/repo/npcm_services.dart';

import '../../models/npcm/crossword_model.dart';

class NpcmViewModel with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<NPCMModel> npcmTopics = [];

  NPCMModel? _selectedNpcm;
  NPCMModel? get selectedNpcm => _selectedNpcm;

  List<String> _notesUrls = [];
  List<String> get notesUrls => _notesUrls;

  List<String> _memesUrls = [];
  List<String> get memesUrl => _memesUrls;

  PodcastModel? _selectedPodcast;
  PodcastModel get selectedPodcast => _selectedPodcast!;
  set setSelectedPodcast(int index) {
    _selectedPodcast = selectedNpcm!.listOfPodcasts[index];
    notifyListeners();
  }

  CrosswordModel? _selectedCrossword;
  CrosswordModel get selectedCrossword => _selectedCrossword!;
  set setSelectedCrossword(int index) {
    _selectedCrossword = selectedNpcm!.listOfCrosswords[index];
    notifyListeners();
  }

  setSelectedNpcm(int i) async {
    _selectedNpcm = npcmTopics[i];
    await getNpcmTopic();
  }

  AudioPlayer player = AudioPlayer();
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  set isPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }

  String _podcastUrl = '';
  String get podcastUrl => _podcastUrl;
  Future getNpcmTopic() async {
    try {
      _selectedNpcm = await NPCMServices().getNpcmTopic(selectedNpcm!);
    } catch (e) {
      log(e.toString());
    }
  }

  getNpcmData() {
    npcmTopics = NpcmData().npcmTopics;
  }

  getNotesUrl() async {
    _isLoading = true;
    notifyListeners();
    final storage = FirebaseStorage.instance;
    final reference = storage.ref().child('/npcm/NOTES/light');
    try {
      _notesUrls.clear();
      final notes = _selectedNpcm?.notes?.split(",") ?? [];
      for (var each in notes) {
        final fileRef = reference.child("${each.trim()}.jpg");
        final url = await fileRef.getDownloadURL();
        _notesUrls.add(url);
        notifyListeners();
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Error fetching notes image: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  getMemesUrls() async {
    _isLoading = true;
    notifyListeners();
    final storage = FirebaseStorage.instance;
    final reference = storage.ref().child('/npcm/meme');
    try {
      _memesUrls.clear();
      final memes = _selectedNpcm?.memes?.split(",") ?? [];
      for (var each in memes) {
        final fileRef = reference.child("${each.trim()}.jpg");
        final url = await fileRef.getDownloadURL();
        _memesUrls.add(url);
        notifyListeners();
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Error fetching notes image: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  getPodcastUrl() async {
    _isLoading = true;
    notifyListeners();
    final storage = FirebaseStorage.instance;
    final reference = storage.ref().child('/npcm/podcast');
    try {
      final fileRef =
          reference.child("${_selectedPodcast!.podcast.trim()}.mp3");
      _podcastUrl = await fileRef.getDownloadURL();
      log(_podcastUrl);
      notifyListeners();
      play();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Error fetching podcast: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  void play() async {
    log("play");
    _isPlaying = true;
    player.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        isPlaying = false;
      } else if (event.processingState == ProcessingState.ready) {
        isPlaying = true;
      }
    });

    await player.setUrl(podcastUrl);
    await player.play();
    notifyListeners();
  }

  void pause() async {
    log("paused");
    await player.pause();
    isPlaying = false;
    notifyListeners();
  }

  void resume() {
    log("resumed");
    player.play();
    isPlaying = true;
    notifyListeners();
  }

  void stop() {
    log("stopped");
    player.stop();
    isPlaying = false;
    notifyListeners();
  }

  void next() {
    log("next");
    int currentIndex = selectedNpcm!.listOfPodcasts
        .indexWhere((e) => e.podcast == _selectedPodcast!.podcast);

    _selectedPodcast = selectedNpcm!.listOfPodcasts[
        (currentIndex >= selectedNpcm!.listOfPodcasts.length - 1)
            ? 0
            : (currentIndex + 1)];
    getPodcastUrl();
  }

  void previous() {
    log("previous");
    int currentIndex = selectedNpcm!.listOfPodcasts
        .indexWhere((e) => e.podcast == _selectedPodcast!.podcast);

    _selectedPodcast = selectedNpcm!.listOfPodcasts[(currentIndex <= 0)
        ? selectedNpcm!.listOfPodcasts.length - 1
        : (currentIndex - 1)];
    log(_selectedPodcast!.topic);
    getPodcastUrl();
  }
}
