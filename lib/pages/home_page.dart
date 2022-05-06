import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Widget/post_card.dart';
import 'package:social_app/Widget/slider.dart';
import 'package:social_app/pages/search.dart';
import 'package:social_app/save_data/const.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/stutes.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:social_app/styles/icons.dart';

class home_page extends StatefulWidget {
  home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  final ke =PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    var cubit = mycubit.get(context);
    return Builder(
      builder: (context) {
        cubit.getpostsnoloding();
        return BlocConsumer<mycubit, stutes>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: IconButton(
                      onPressed: () {
                        navigateTo(context, search());
                      },
                      icon: Icon(
                        IconBroken.Search,
                        color: !mycubit.get(context).isdark
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  )
                ],
                title: Text(
                  "New fedds ",
                ),
              ),
              body: PageStorage(
                bucket:ke ,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [

                      slider(),
                      state is getpostslodingstate
                          ? Center(child: CircularProgressIndicator(color:mycubit.get(context).isdark? Colors.white:Colors.black,))
                          : cubit.postsdata.isEmpty&&cubit.datauser.isEmpty
                              ? Text("no posts Now")
                              : ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => post_card(
                                      model: cubit.postsdata[index], indxe: index),
                                  itemCount: cubit.postsdata.length,
                                )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    );
  }
}
