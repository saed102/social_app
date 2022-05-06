import 'dart:ui';

import 'package:better_player/better_player.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/pages/exam.dart';
import 'package:social_app/save_data/const.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/stutes.dart';
import 'package:social_app/styles/icons.dart';

class add_post extends StatefulWidget {
  @override
  State<add_post> createState() => _add_postState();
}

class _add_postState extends State<add_post>{

  var text = TextEditingController();
  var link = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = mycubit.get(context);
    return BlocConsumer<mycubit, stutes>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: () {
                  if (cubit.postimage == null &&
                      cubit.vedio == null &&
                      cubit.f == null) {
                    cubit.setposts(text.text, DateTime.now(), context);
                  } else if (cubit.postimage != null &&
                      cubit.vedio == null &&
                      cubit.f == null) {
                    cubit.upluodepostimage(text.text, DateTime.now(), context);
                  } else if (cubit.postimage == null &&
                      cubit.vedio != null &&
                      cubit.f == null) {
                    cubit.uplodepostveideo(text.text, DateTime.now(), context);
                  } else if (cubit.postimage == null &&
                      cubit.vedio == null &&
                      cubit.f != null) {
                    cubit.upluodepostfile(text.text, DateTime.now(), context);
                  } else if (cubit.postimage != null &&
                      cubit.vedio == null &&
                      cubit.f != null) {
                    cubit
                        .uplod_image_file(text.text, DateTime.now(), context);
                  } else if (cubit.postimage == null &&
                      cubit.vedio != null &&
                      cubit.f != null) {
                    cubit
                        .upluodepostimage(text.text, DateTime.now(), context)
                        .then((value) {
                      cubit.upluodepostfile(text.text, DateTime.now(), context);
                    });
                  }
                   //cubit.movtoprofile(0);
                },
                child: Text("Post Now",
                    style: TextStyle(
                        color: Color.fromARGB(248, 50, 122, 163),
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ],
            title: Text(
              "Add posts ",
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  if (state is lodingstate)
                    LinearProgressIndicator(minHeight: 10),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          mycubit.get(context).datauser["imageprofile"],
                        ),
                        radius: 22,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 4),
                              child: Text(mycubit.get(context).datauser["name"],
                                  style: Theme.of(context).textTheme.bodyText1),
                            ),
                            Row(
                              children: [
                                Text('Public ',
                                    style: Theme.of(context).textTheme.caption),
                                Icon(
                                  IconBroken.Lock,
                                  color: Colors.grey,
                                  size: 20,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: myDivider(),
                  ),
                  TextFormField(
                    controller: text,
                    decoration: InputDecoration(
                      hintText: "What's on your mind?",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                        fontSize: 18,
                        color: mycubit.get(context).isdark
                            ? Colors.white
                            : Colors.black),
                    cursorHeight: 20,
                    // this two lines =>> to enter a new line
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                  if (mycubit.get(context).f != null) _post_file(),
                  if (mycubit.get(context).postimage != null)
                    _post_image(context),
                  if (mycubit.get(context).vedio != null) _post_video(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            if (cubit.vedio == null)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      mycubit.get(context).getImagepost();
                                    },
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(
                                            Color.fromARGB(248, 50, 122, 163))),
                                    child: Icon(IconBroken.Image),
                                  ),
                                ),
                              ),
                            if (cubit.postimage == null)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      mycubit.get(context).getvedio();
                                    },
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(
                                            Color.fromARGB(255, 143, 143, 43))),
                                    child: Icon(IconBroken.Video),
                                  ),
                                ),
                              ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    cubit.getpostfile();
                                  },
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(
                                          Color.fromARGB(255, 115, 25, 25))),
                                  child: Icon(Icons.picture_as_pdf),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              navigateTo(context, exam());
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(248, 57, 109, 47))),
                            child: Text("Add Exam ",style: TextStyle(fontSize: 20),),
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  Widget _post_video() {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        AspectRatio(
          aspectRatio: 1 / 1,
          child: BetterPlayer.file(
            mycubit.get(context).vedio!.path,
            betterPlayerConfiguration: BetterPlayerConfiguration(
              aspectRatio: 1 / 1,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
              backgroundColor: Colors.red,
              child: IconButton(
                  onPressed: () {
                    mycubit.get(context).deletpostimage();
                  },
                  icon: Icon(Icons.close))),
        )
      ],
    );
  }

  Widget _post_image(context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          height: 400,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: FileImage(mycubit.get(context).postimage!),
                  fit: BoxFit.cover)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
              backgroundColor: Colors.red,
              child: IconButton(
                  onPressed: () {
                    mycubit.get(context).deletpostimage();
                  },
                  icon: Icon(Icons.close))),
        )
      ],
    );
  }

  Widget _post_file() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        "${mycubit.get(context).f!.path}",
        style: TextStyle(
            color: !mycubit.get(context).isdark ? Colors.black : Colors.white),
      ),
    );
  }
}
