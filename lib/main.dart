import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:musicrec/features/app/splash_screen/splash_screen.dart';
import 'package:musicrec/features/user_auth/presentation/pages/choose_music.dart';
import 'package:musicrec/features/user_auth/presentation/pages/home_page.dart';
import 'package:musicrec/features/user_auth/presentation/pages/login_page.dart';
import 'package:musicrec/features/user_auth/presentation/pages/delete.dart';
import 'package:musicrec/features/user_auth/presentation/pages/queue.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        '/': (context) => SplashScreen(

          child: LoginPage(),
        ),

        '/login': (context) => LoginPage(),

        '/home': (context) => HomePage(),
        '/delete': (context) => DeleteAccount(),
        '/choosemusic': (context) => ChooseMusic(),
        '/queue':(context) => SongListWidget(),
      },
    );
  }
}
