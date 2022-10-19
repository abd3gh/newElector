import 'package:elector/provider/event_provider.dart';
import 'package:elector/screens/box_man_screen/bottom_navigation.dart';
import 'package:elector/screens/manager_group_screens/auth/launch_screen.dart';
import 'package:elector/screens/manager_group_screens/auth/login_screen.dart';
import 'package:elector/screens/manager_group_screens/main_screens/activist/activist_screen.dart';
import 'package:elector/screens/manager_group_screens/main_screens/bottom_navigation_bar.dart';
import 'package:elector/screens/manager_group_screens/main_screens/follower/follower_screen.dart';
import 'package:elector/screens/manager_group_screens/main_screens/follower/update_follower_phone.dart';
import 'package:elector/screens/manager_group_screens/main_screens/follower/view_voted_follower.dart';
import 'package:elector/screens/manager_group_screens/main_screens/groups/add_support_group.dart';
import 'package:elector/screens/manager_group_screens/main_screens/groups/create_group.dart';
import 'package:elector/screens/manager_group_screens/main_screens/groups/edit_grop_name.dart';
import 'package:elector/screens/manager_group_screens/main_screens/groups/group_option_screen.dart';
import 'package:elector/screens/manager_group_screens/main_screens/groups/groups_screen.dart';
import 'package:elector/screens/manager_group_screens/main_screens/groups/view_support_group.dart';
import 'package:elector/screens/manager_group_screens/main_screens/support/voter_from_contact.dart';
import 'package:elector/screens/manager_group_screens/main_screens/support/voterwithoutnum.dart';
import 'package:elector/screens/manager_group_screens/menu_screens/add_voter_manually.dart';
import 'package:elector/screens/manager_group_screens/menu_screens/calender.dart';
import 'package:elector/screens/manager_group_screens/menu_screens/contact_with_email.dart';
import 'package:elector/screens/manager_group_screens/menu_screens/demo_video.dart';
import 'package:elector/screens/manager_group_screens/menu_screens/main_menu.dart';
import 'package:elector/screens/manager_group_screens/menu_screens/manual_search.dart';
import 'package:elector/screens/manager_group_screens/menu_screens/search_for_Support_via_name.dart';
import 'package:elector/screens/manager_group_screens/menu_screens/search_for_support_via_id.dart';
import 'package:elector/screens/manager_group_screens/menu_screens/search_for_support_via_phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';

const supportedLocales = [
  //Locale('en', 'GB'),
  Locale('ar', 'AR'),
  Locale('he', 'HE'),
];
void _insertOverlay(BuildContext context) {
  return Overlay.of(context)?.insert(
    OverlayEntry(builder: (context) {
      final size = MediaQuery.of(context).size;
      return Positioned(
        top: 0,
        left: 0,
        width: size.width,
        height: size.height,
        child: Material(
          color: Colors.green,
          child: GestureDetector(
              onTap: () => print('ON TAP OVERLAY!'),
              child: Center(
                child: Container(
                    decoration: BoxDecoration(color: Colors.redAccent),
                    child: Text('BETA VERSION')),
              )),
        ),
      );
    }),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    KLocalizations.asChangeNotifier(
      locale: supportedLocales[1],
      defaultLocale: supportedLocales[1],
      supportedLocales: supportedLocales,
      //  loader: HttpLoader(),
      child: Phoenix(child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final klocalizations = KLocalizations.of(context);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, widget) {
        return LayoutBuilder(builder: (context, c) {
          return ChangeNotifierProvider(
            create: (context) => EventProvider(),
            child: MaterialApp(
              locale: klocalizations.locale,
              supportedLocales: klocalizations.supportedLocales,
              localizationsDelegates: [
                klocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              debugShowCheckedModeBanner: false,
              initialRoute: '/launch_screen',
              routes: {
                /*Auth Screens*/
                '/launch_screen': (context) => const LaunchScreen(),
                '/login_screen': (context) => const LoginScreen(),

                /*Bottom Navigation Screens*/
                '/bottom_navigator_screen': (context) =>
                    const BottomNavigatorScreen(),
                '/activist_screen': (context) => const ActivistScreen(),
                '/voter_without_num_screen': (context) =>
                    const VoterWithoutNumScreen(),
                '/voter_from_contact': (context) => VoterFromContact(),
                '/group_screen': (context) => const GroupScreen(),
                '/follower_Screen': (context) => const FollowerScreen(),
                '/view_voted_follower': (context) => ViewVotedFollower(),
                /*MainMenu*/
                '/main_menu': (context) => const MainMenu(),
                '/email_contact': (context) => const Email_contact(),
                'manual_search': (context) => const ManualSearch(),
                '/calender': (context) => const Calender(),
                '/demo_video': (context) => const DemoVideo(),
                '/add_voter_manually': (context) => const AddVoterManually(),
                '/UpdateFollowerPhone': (context) => UpdateFollowerPhone(),
                '/search_support_via_phone': (context) =>
                    const SearchSupportViaPhone(),
                '/search_support_via_id': (context) => SearchSupportViaID(),
                '/search_support_via_name': (context) =>
                    const SearchSupportViaName(),
                /*group*/
                '/group_option_screen': (context) => GroupOptionScreen(),
                '/add_support_to_group': (context) => AddSupportToGroup(),
                '/edit_group_name': (context) => EditGroupName(),
                '/view_support_group': (context) => ViewSupportGroup(),
                '/create_group': (context) => const CreateGroup(),

                /*CashierScreens*/
                '/bottom_navigator_cashier': (context) =>
                    const BottomNavigatorCashier(),
              },
            ),
          );
        });
      },
    );
  }
}
