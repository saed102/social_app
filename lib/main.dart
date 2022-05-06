import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/auth/login.dart';
import 'package:social_app/auth/regester.dart';
import 'package:social_app/cubit/bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/stutes.dart';
import 'package:social_app/pages/Setting.dart';
import 'package:social_app/pages/about.dart';
import 'package:social_app/pages/init_page.dart';
import 'package:social_app/save_data/const.dart';
import 'package:social_app/save_data/save_data.dart';
import 'package:social_app/styles/icons.dart';
import 'package:social_app/styles/theme.dart';

void main(context) async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();

  await savedata.init();
  bool ?isdark = true;
  if (savedata.get_isdark("d") != null) {
    print("object");
    isdark = true;
  }else{
    isdark=await savedata.get_isdark("d");
  }
  Widget go;
  myuserid = await savedata.get_uid("uid");

  if (myuserid == null) {
    go = login();
  } else {
    go = init_page();
  }

  runApp(MyApp(
    go: go,
    isdark: isdark!,
  ));
}

class MyApp extends StatelessWidget with WidgetsBindingObserver{
  bool isdark;
  Widget go;

  MyApp({Key? key, required this.isdark, required this.go}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => mycubit()
        ..change_mode(v: isdark)
        ..getdatauser(myuserid)..getposts(),
      child: BlocConsumer<mycubit, stutes>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightMode(),
            darkTheme: darkMode(),
            themeMode:
                mycubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light,
            home: go,
          );
        },
      ),
    );
  }
}
