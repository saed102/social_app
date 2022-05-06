import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/stutes.dart';
import 'package:social_app/pages/image.dart';
import 'package:social_app/pages/user_tap.dart';
import 'package:social_app/save_data/const.dart';

var ms = TextEditingController();

class chat_with extends StatelessWidget {
  final data;

  chat_with({required this.data});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      mycubit.get(context).getmassege(data["uid"]);
      mycubit.get(context).getallusers();
      return BlocConsumer<mycubit, stutes>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey[900],
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.black,
              title: Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: ListTile(leading: CircleAvatar(
                    radius: 22,
                    backgroundImage:
                    NetworkImage("${data!["imageprofile"]}"),
                  ),
                    title:   InkWell(
                        onTap: () {
                          if (mycubit.get(context).datauser["uid"] !=
                              data!["uid"]) {
                            mycubit
                                .get(context)
                                .profiletap(data!["uid"])
                                .then((value) {
                              mycubit
                                  .get(context)
                                  .getpoststap(data!["uid"])
                                  .then((value) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => user_tap(),
                                    ));
                              });
                            });
                          } else {
                            mycubit.get(context).movtoprofile(4);
                          }
                          print("usergfyguydag==$myuserid");
                          print(data!["uid"]);
                        },
                        child: Text(
                          "${data!["name"]}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20, color: Colors.white),
                        )),
                    subtitle: Text(data!["stute"],style: TextStyle(color: Colors.white,fontSize: 15),) ,
                      ),

                  ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Column(children: [
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    reverse: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      var mage = mycubit.get(context).massges[index];
                      if (mycubit.get(context).datauser["uid"] ==
                          mage["senderid"])
                        return me(mycubit.get(context).massges[index], context);

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            foregroundImage: NetworkImage(data["imageprofile"]),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: sender(
                                mycubit.get(context).massges[index], context),
                          )
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                    itemCount: mycubit.get(context).massges.length,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (mycubit.get(context).chatimage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        child: Image.file(
                          mycubit.get(context).chatimage!,
                          fit: BoxFit.cover,
                        ),
                        color: Colors.transparent,
                        width: 200,
                        height: 200,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  child: TextFormField(
                                    onChanged: (v) {

                                 },
                                    controller: ms,
                                    maxLines: 5,
                                    minLines: 1,
                                    cursorColor: Colors.white,
                                    style: TextStyle(color: Colors.white),
                                    onFieldSubmitted: (value) {
                                      mycubit.get(context).setmassge(
                                          data!["uid"],
                                          ms.text,
                                          DateTime.now(),
                                          context);

                                      ms.clear();
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Type your massge ",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: IconButton(
                                    onPressed: () {
                                      mycubit.get(context).getImagechat();
                                    },
                                    icon: Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey,
                                      size: 26,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[800],
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                if (mycubit.get(context).chatimage == null) {
                                  if (ms.text != "") {
                                    mycubit.get(context).setmassge(data!["uid"],
                                        ms.text, DateTime.now(), context);

                                    ms.clear();
                                  } else {
                                    print("no ms");
                                  }
                                } else {
                                  mycubit.get(context).upluodeImagechat(
                                      data!["uid"], DateTime.now(), context);
                                  ms.text = "";
                                }
                              },
                              icon: Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          )),
                    ],
                  ),
                )
              ]),
            ),
          );
        },
      );
    });
  }
}

Widget me(Map m, context) {
  String d = "${m["ms"]}";
  return Column(
    children: [
      d.startsWith("https://")
          ? Align(
              alignment: AlignmentDirectional.centerEnd,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      InkWell(
                        onTap: () {
                          navigateTo(context, Hero(
                            tag: d,
                              child: image(url: d)));
                        },
                        child: Image.network(
                          d,
                          width: 200,
                          height: 200,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${m["showtime"]}",
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  )),
            )
          : Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Container(
                margin: EdgeInsets.only(left: 50),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: Text(
                          d,
                          textDirection: d.contains(RegExp('[A-Z]'))
                              ? TextDirection.ltr
                              : TextDirection.rtl,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            child: Text(
                              "${m["showtime"]}",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: Colors.cyan.withOpacity(0.2)),
              ),
            )
    ],
  );
}

Widget sender(Map m, context) {
  String d = "${m["ms"]}";
  return Column(
    children: [
      d.startsWith("https://")
          ? Align(
              alignment: AlignmentDirectional.centerStart,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        d,
                        width: 200,
                        height: 200,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${m["showtime"]}",
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ))
          : Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                margin: EdgeInsets.only(right: 50),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: Text(
                          d,
                          textDirection: d.contains(RegExp('[A-Z]'))
                              ? TextDirection.ltr
                              : TextDirection.rtl,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            child: Text(
                              "${m["showtime"]}",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: Colors.white.withOpacity(0.1)),
              ),
            )
    ],
  );
}
