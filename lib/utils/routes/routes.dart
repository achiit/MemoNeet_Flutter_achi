import 'package:flutter/material.dart';
import 'package:memo_neet/MVVM/views/Auth/Login/View/login_screen.dart';
import 'package:memo_neet/MVVM/views/Auth/Login/phone_verification/phone_verification.dart';
import 'package:memo_neet/MVVM/views/ChaptersView/chapters_view.dart';
import 'package:memo_neet/MVVM/views/ChaptersView/npcm/Crossword/crossword_view.dart';
import 'package:memo_neet/MVVM/views/ChaptersView/npcm/Notes/notes_view.dart';
import 'package:memo_neet/MVVM/views/ChaptersView/npcm/Podcast/podcast_player.dart';
import 'package:memo_neet/MVVM/views/ChaptersView/npcm/Podcast/podcast_view.dart';
import 'package:memo_neet/MVVM/views/ChaptersView/npcm/npcm_view.dart';
import 'package:memo_neet/MVVM/views/HomeView/home_view.dart';
import 'package:memo_neet/MVVM/views/LandingView/onboarding/on_boarding_screen.dart';
import 'package:memo_neet/MVVM/views/McqsView/mcqs_screen.dart';
import 'package:memo_neet/MVVM/views/ProfileDetailPage/profile_detail_view.dart';
import 'package:memo_neet/MVVM/views/SubTopicView/subtopic_view.dart';
import 'package:memo_neet/MVVM/views/TopicView/topic_view.dart';
import 'package:memo_neet/MVVM/views/plans/buy_now.dart';
import 'package:memo_neet/utils/widgets/navigation_bar/custom_navigation_bar.dart';
import 'package:memo_neet/MVVM/views/LandingView/splash_screen/splash_screen.dart';
import 'package:memo_neet/MVVM/views/settings/contact_support.dart';
import 'package:memo_neet/MVVM/views/settings/faqs_view.dart';
import 'package:memo_neet/MVVM/views/settings/my_profile.dart';

import '../../MVVM/views/ChaptersView/npcm/Crossword/crossword_player.dart';
import '../../MVVM/views/ChaptersView/npcm/Memes/memes_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // splash screen
      case SplashScreen.route:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      // on boarding
      case OnBoardingScreen.route:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingScreen(),
        );

      case ProfileDetialView.route:
        return MaterialPageRoute(
          builder: (_) => const ProfileDetialView(),
        );

      // home screen
      case HomeView.route:
        return MaterialPageRoute(
          builder: (_) => const HomeView(),
        );
      // login screen
      case LoginScreen.route:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      // phone verification
      case PhoneVerification.route:
        return MaterialPageRoute(
          builder: (_) => const PhoneVerification(),
        );
      // custom navigation bar
      case CustomNavigationBar.route:
        return MaterialPageRoute(
          builder: (_) => const CustomNavigationBar(),
        );
      // faqs screen
      case FaQsView.route:
        return MaterialPageRoute(
          builder: (_) => const FaQsView(),
        );
      // contact support
      case ContactSupport.route:
        return MaterialPageRoute(
          builder: (_) => const ContactSupport(),
        );
      // my profile
      case MyProfile.route:
        return MaterialPageRoute(
          builder: (_) => const MyProfile(),
        );

      // buy now screen
      case BuyNow.route:
        return MaterialPageRoute(
          builder: (_) => const BuyNow(),
        );
      // unit screen
      case ChaptersView.route:
        return MaterialPageRoute(
          builder: (_) => const ChaptersView(),
        );
      // mcq screen
      case McqsScreen.route:
        return MaterialPageRoute(
          builder: (_) => const McqsScreen(),
        );

      // topic screen
      case TopicView.route:
        return MaterialPageRoute(
          builder: (_) => const TopicView(),
        );

      // subtopic screen
      case SubTopicView.route:
        return MaterialPageRoute(
          builder: (_) => const SubTopicView(),
        );

      case NPCMView.route:
        return MaterialPageRoute(builder: (_) => const NPCMView());

      case NotesView.route:
        return MaterialPageRoute(builder: (_) => const NotesView());
      case PodcastView.route:
        return MaterialPageRoute(builder: (_) => const PodcastView());
      case PodcastPlayer.route:
        return MaterialPageRoute(builder: (_) => const PodcastPlayer());
      case CrosswordView.route:
        return MaterialPageRoute(builder: (_) => const CrosswordView());
      case CrosswordPlayer.route:
        return MaterialPageRoute(builder: (_) => const CrosswordPlayer());
      case MemesView.route:
        return MaterialPageRoute(builder: (_) => const MemesView());

      default:
        return _errorRoute();
    }
  }

// handling the error
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text('Error: Invalid route'),
        ),
      ),
    );
  }
}
