import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/stutes.dart';
import 'package:social_app/save_data/const.dart';
import 'package:social_app/styles/icons.dart';

class init_page extends StatefulWidget {
  const init_page({Key? key}) : super(key: key);

  @override
  State<init_page> createState() => _init_pageState();
}

class _init_pageState extends State<init_page> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      mycubit.get(context).stuteuser("online",mycubit.get(context).datauser["uid"]);
    } else {
      mycubit.get(context).stuteuser("offline",mycubit.get(context).datauser["uid"]);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = mycubit.get(context);
    return BlocConsumer<mycubit, stutes>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
            ) {
              final bool connected = connectivity != ConnectivityResult.none;
              if (connected) {
                return mycubit.get(context).body[cubit.index];
              } else {
                return Container(
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      color: Colors.red,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            Center(
                                child:
                                     Text("OFFLINE",style: TextStyle(color: Colors.white,fontSize: 33),)),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                          image: AssetImage("assets/images/20.png"),fit: BoxFit.cover)),
                    ))
                  ]),
                );
              }
            },
            child: Text(
              'There are no bottons to push :)',
            ),
          ),
          extendBody: true,
          bottomNavigationBar: CurvedNavigationBar(
            index: cubit.index,
            backgroundColor: Colors.transparent,
            onTap: (value) {
              cubit.changebody(value);
            },
            height: 60,
            animationDuration: Duration(milliseconds: 300),
            letIndexChange: (value) => true,
            color: mycubit.get(context).isdark ? Colors.black : Colors.white,
            buttonBackgroundColor: Color.fromARGB(248, 50, 122, 163),
            items: [
              Icon(
                IconBroken.Home,
                color:
                    !mycubit.get(context).isdark ? Colors.black : Colors.white,
              ),
              Icon(
                IconBroken.Chat,
                color:
                    !mycubit.get(context).isdark ? Colors.black : Colors.white,
              ),
              Icon(
                IconBroken.Plus,
                color:
                    !mycubit.get(context).isdark ? Colors.black : Colors.white,
              ),
              Icon(
                IconBroken.Setting,
                color:
                    !mycubit.get(context).isdark ? Colors.black : Colors.white,
              ),
              Icon(
                IconBroken.Profile,
                color:
                    !mycubit.get(context).isdark ? Colors.black : Colors.white,
              ),
              Icon(
                IconBroken.Info_Circle,
                color:
                    !mycubit.get(context).isdark ? Colors.black : Colors.white,
              ),
            ],
          ),
        );
      },
    );
  }
}
