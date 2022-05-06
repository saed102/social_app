import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Widget/post_card.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/stutes.dart';
import 'package:social_app/pages/mysub.dart';
import 'package:social_app/save_data/const.dart';
import 'package:social_app/styles/icons.dart';

class profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = mycubit.get(context);
    return BlocConsumer<mycubit, stutes>(
      listener: (context, state) {},
      builder: (context, state) {
        var cuibt= mycubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Profile",
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            child: Column(children: [
              Container(
                height: 250,
                color:
                    mycubit.get(context).isdark ? Colors.black : Colors.white,
                width: double.infinity,
                child: Stack(alignment: Alignment.bottomLeft, children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: mycubit.get(context).isdark
                            ? Colors.black
                            : Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(6),
                          topLeft: Radius.circular(6),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Image.network("${cuibt.datauser["caverprofile"]}", width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: InkWell(
                      onTap: () {},
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 56,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage("${cuibt.datauser["imageprofile"]}"),
                          radius: 50,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text( cubit.profile.length.toString(),
                                style: TextStyle(
                                    color: mycubit.get(context).isdark
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold)),
                            Text("Post",
                               style: TextStyle(
                                    color: mycubit.get(context).isdark
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        SizedBox(width: 15,),
                        InkWell(
                          onTap: () {
                             navigateTo(context, mysub());
                          },
                          child: Column(
                            children: [
                              Text(cuibt.datauser["sub"].length.toString(),
                                  style: TextStyle(
                                      color: mycubit.get(context).isdark
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Text("registered Subject",
                                 style: TextStyle(
                                      color: mycubit.get(context).isdark
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),

                      ],
                    ),
                  )
                ]),
              ),
              Container(
                color:
                    mycubit.get(context).isdark ? Colors.black : Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("${cuibt.datauser["name"]}",
                                  style: Theme.of(context).textTheme.bodyText1),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.verified,
                                color: Colors.blue,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Icon(
                                    IconBroken.Work,
                                    color: Color.fromARGB(248, 50, 122, 163),
                                  ),
                                  title: Text(
                                    " Study at the Faculty of ${cuibt.datauser["college"]} at Cairo University",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(IconBroken.Location,
                                      color: Color.fromARGB(248, 50, 122, 163)),
                                  title: Text("from  ${cuibt.datauser["from"]} ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                ),
                                ListTile(
                                  leading: Icon(IconBroken.Discovery,
                                      color: Color.fromARGB(248, 50, 122, 163)),
                                  title: Text("Join on   ${cuibt.datauser["join"]}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              state is getpostslodingstate && state is getdatauserstate
                  ? Center(child: CircularProgressIndicator())
                  : cubit.profile.length == 0
                  ? Text("no posts Now")
                  : ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => post_card(
                    model: cubit.profile[index], indxe: index),
                itemCount: cubit.profile.length,
              )
            ]),
          ),
        );
      },
    );
  }
}
