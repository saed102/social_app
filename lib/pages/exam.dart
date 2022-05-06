import 'dart:ui';

import 'package:better_player/better_player.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/pages/init_page.dart';
import 'package:social_app/save_data/const.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/stutes.dart';
import 'package:social_app/styles/icons.dart';

class exam extends StatelessWidget {
  var text = TextEditingController();
  var title = TextEditingController();
  var link = TextEditingController();
  var formkey = GlobalKey<FormState>();

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
                  cubit
                      .setposts(text.text, DateTime.now(), context,link:cubit.l,examtitle: cubit.examtltle).then((value) {
                        cubit.movtoprofile(0).then((value) {
                          navigateTo(context, init_page());
                        });
                  })
                      .then((value) {
                    text.clear();
                    cubit.l = null;
                    cubit.examtltle = null;
                  });
                },
                child: Text("Post Now",
                    style: TextStyle(
                        color: Color.fromARGB(248, 50, 122, 163),
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ],
            title: Text(
              "Add Exam ",
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
                  SizedBox(
                    height: 4,
                  ),
                  if(cubit.examtltle!=null)
                  _exam(context),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Form(
                                          key: formkey,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                  controller: title,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  cursorColor: Color.fromARGB(
                                                      255, 17, 75, 96),
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "mustn't be empty";
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                      labelText: "Exam Title",
                                                      labelStyle: const TextStyle(
                                                          color: Color.fromARGB(
                                                              248, 50, 122, 163)),
                                                      focusedBorder: const OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color.fromARGB(
                                                                  248, 50, 122, 163))),
                                                      enabledBorder: const OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color.fromARGB(
                                                                  248,
                                                                  50,
                                                                  122,
                                                                  163))),
                                                      prefixIcon: const Icon(
                                                        Icons.title,
                                                        color: Color.fromARGB(
                                                            248, 50, 122, 163),
                                                      ),
                                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.black12)))
                                              ,),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              TextFormField(
                                                  controller: link,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  cursorColor: Color.fromARGB(
                                                      255, 17, 75, 96),
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "mustn't be empty";
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                      labelText: "Exam link",
                                                      labelStyle: const TextStyle(
                                                          color: Color.fromARGB(
                                                              248, 50, 122, 163)),
                                                      focusedBorder: const OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color.fromARGB(
                                                                  248, 50, 122, 163))),
                                                      enabledBorder: const OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color.fromARGB(
                                                                  248,
                                                                  50,
                                                                  122,
                                                                  163))),
                                                      prefixIcon: const Icon(
                                                        Icons.link,
                                                        color: Color.fromARGB(
                                                            248, 50, 122, 163),
                                                      ),
                                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.black12)))),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(onPressed: (){
                                            pop(context);
                                            link.clear();
                                            title.clear();
                                          }, child: Text("Cancel")),
                                          TextButton(onPressed: (){
                                            if(formkey.currentState!.validate()
                                            ){
                                              cubit.link(link.text);
                                              cubit.exam(title.text);
                                              pop(context);
                                              link.clear();
                                              title.clear();
                                            }

                                          }, child: Text("Ok")),
                                        ],
                                      );
                                    });
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(248, 57, 109, 47))),
                              child: Text(
                                "Add Exam ",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
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

  Widget _exam(context) {
    return Column(
      children: [
        Container(
          color: Color.fromARGB(248, 50, 122, 163),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              mycubit.get(context).examtltle!,
              style: TextStyle(
                  color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold),
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
}
