import 'package:memo_neet/MVVM/viewmodels/Auth/auth_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/User/user_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/base/base_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/mcqs/fillup_type_provider.dart';
import 'package:memo_neet/MVVM/viewmodels/mcqs/match_type_provider.dart';
import 'package:memo_neet/MVVM/viewmodels/mcqs/mcq_provider.dart';
import 'package:memo_neet/MVVM/viewmodels/navigation/navigation_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/npcm/npcm_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/revisionmodel/revision_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/subject/banner_provider.dart';
import 'package:memo_neet/MVVM/viewmodels/subject/subject_view_model.dart';
import 'package:memo_neet/repo/questions_services.dart';
import 'package:memo_neet/repo/revision_service.dart';
import 'package:memo_neet/utils/in_app_purchases/in_app_purchase.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => AuthViewModel()),
  ChangeNotifierProvider(create: (_) => UserViewModel()),
  ChangeNotifierProvider(create: (_) => BaseViewModel()),
  ChangeNotifierProvider(create: (_) => SubjectViewModel()),
  ChangeNotifierProvider(create: (_) => NavigationViewModel()),
  ChangeNotifierProvider(create: (_) => RevisionViewModel()),
  ChangeNotifierProvider(create: (_) => QuestionsServices()),
  ChangeNotifierProvider(create: (_) => MatchTypeProvider()),
  ChangeNotifierProvider(create: (_) => FillupTypeProvider()),
  ChangeNotifierProvider(create: (_) => McqProvider()),
  ChangeNotifierProvider(create: (_) => RevisionService()),
  ChangeNotifierProvider(create: (_) => BannerProvider()),
  ChangeNotifierProvider(create: (_) => InAppPurchaseManager()),
  ChangeNotifierProvider(create: (_) => NpcmViewModel())
];
