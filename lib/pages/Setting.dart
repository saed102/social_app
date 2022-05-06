import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/auth/login.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/stutes.dart';
import 'package:social_app/save_data/save_data.dart';
import 'package:social_app/styles/icons.dart';

class Setting extends StatefulWidget {
  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  var formkey = GlobalKey<FormState>();
  var name = TextEditingController();
  var college = TextEditingController();
  var from = TextEditingController();
  var join = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = mycubit.get(context);
    join.text = cubit.datauser["join"];
    college.text = cubit.datauser["college"];
    from.text = cubit.datauser["from"];
    name.text = cubit.datauser["name"];

    return BlocConsumer<mycubit, stutes>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Setting",
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                if (state is lodingstate)
                  LinearProgressIndicator(minHeight: 10),
                Container(
                  color:
                      mycubit.get(context).isdark ? Colors.black : Colors.white,
                  height: 250,
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
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            cubit.caverimage == null
                                ? Image.network(
                                    "${cubit.datauser["caverprofile"]}",
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    cubit.caverimage!,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: InkWell(
                                    onTap: () {
                                      cubit.getpcoverimage();
                                    },
                                    child: Icon(IconBroken.Camera,
                                        color:
                                            Color.fromARGB(248, 50, 122, 163)),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 56,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 56,
                                child: cubit.profileimage == null
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "${cubit.datauser["imageprofile"]}"),
                                        radius: 50,
                                      )
                                    : CircleAvatar(
                                        backgroundImage:
                                            FileImage(cubit.profileimage!),
                                        radius: 50,
                                      ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: InkWell(
                                onTap: () {
                                  cubit.getprofileimage();
                                },
                                child: Icon(
                                  IconBroken.Camera,
                                  color: Color.fromARGB(248, 50, 122, 163),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Positioned(
                        bottom: 0,
                        right: 20,
                        child: ElevatedButton(
                          onPressed: () {
                            if (cubit.profileimage == null &&
                                cubit.caverimage == null) {
                              cubit.updatedatauser(
                                college: college.text,
                                from: from.text,
                                join: join.text,
                                name: name.text,
                              );

                              print("data");
                            } else if (cubit.profileimage != null &&
                                cubit.caverimage == null) {
                              cubit.upluodeprofileimage(name.text, from.text,
                                  join.text, college.text);
                              print("profile");
                            } else if (cubit.profileimage == null &&
                                cubit.caverimage != null) {
                              cubit.upluodecoverimage(name.text, from.text,
                                  join.text, college.text);

                              print("caver");
                            } else if (cubit.caverimage != null &&
                                cubit.profileimage != null) {
                              cubit
                                  .upluodecoverimage(name.text, from.text,
                                      join.text, college.text)
                                  .then((value) {
                                cubit.upluodeprofileimage(name.text, from.text,
                                    join.text, college.text);
                              });

                              print("cover and pro");
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 5),
                            child: Text(
                              "Update",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
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
                                Text("${cubit.datauser["name"]}",
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
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
                                      " Study at the Faculty of ${cubit.datauser["college"]} at Cairo University",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(IconBroken.Location,
                                        color:
                                            Color.fromARGB(248, 50, 122, 163)),
                                    title: Text(
                                        "from ${cubit.datauser["from"]} ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                  ),
                                  ListTile(
                                    leading: Icon(IconBroken.Discovery,
                                        color:
                                            Color.fromARGB(248, 50, 122, 163)),
                                    title: Text(
                                        "Join on  ${cubit.datauser["join"]}",
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
                        height: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color:
                      mycubit.get(context).isdark ? Colors.black : Colors.white,
                  child: Column(
                    children: [
                      Form(
                        key: formkey,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                  controller: name,
                                  keyboardType: TextInputType.text,
                                  cursorColor: Color.fromARGB(255, 17, 75, 96),
                                  style: TextStyle(
                                      color: !cubit.isdark
                                          ? Colors.black
                                          : Colors.white),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "mustn't be empty";
                                    }
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Full Name",
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
                                                  248, 50, 122, 163))),
                                      prefixIcon: const Icon(
                                        Icons.person_outline_outlined,
                                        color:
                                            Color.fromARGB(248, 50, 122, 163),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                              color: Colors.black12)))),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                  controller: college,
                                  keyboardType: TextInputType.text,
                                  cursorColor: Color.fromARGB(255, 17, 75, 96),
                                  style: TextStyle(
                                      color: !cubit.isdark
                                          ? Colors.black
                                          : Colors.white),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "mustn't be empty";
                                    }
                                  },
                                  decoration: InputDecoration(
                                      labelText: "College",
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
                                                  248, 50, 122, 163))),
                                      prefixIcon: const Icon(
                                        Icons.work_outline_outlined,
                                        color:
                                            Color.fromARGB(248, 50, 122, 163),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                              color: Colors.black12)))),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                  controller: from,
                                  keyboardType: TextInputType.text,
                                  cursorColor: Color.fromARGB(255, 17, 75, 96),
                                  style: TextStyle(
                                      color: !cubit.isdark
                                          ? Colors.black
                                          : Colors.white),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "mustn't be empty";
                                    }
                                  },
                                  decoration: InputDecoration(
                                      labelText: "From",
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
                                                  248, 50, 122, 163))),
                                      prefixIcon: const Icon(
                                        Icons.location_on_outlined,
                                        color:
                                            Color.fromARGB(248, 50, 122, 163),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                              color: Colors.black12)))),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                  controller: join,
                                  keyboardType: TextInputType.text,
                                  cursorColor: Color.fromARGB(255, 17, 75, 96),
                                  style: TextStyle(
                                      color: !cubit.isdark
                                          ? Colors.black
                                          : Colors.white),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "mustn't be empty";
                                    }
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Year of joined",
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
                                                  248, 50, 122, 163))),
                                      prefixIcon: const Icon(
                                        Icons.person_outline_outlined,
                                        color:
                                            Color.fromARGB(248, 50, 122, 163),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                              color: Colors.black12)))),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      ListTile(
                        trailing: Switch(
                            value: cubit.isdark,
                            onChanged: (v) async {
                              cubit.change_mode();
                              await savedata.put_isdark("dark", v);
                            }),
                        leading: Text(
                          "Dark Mode",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Spacer(),
                            Container(
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => login()),
                                        (route) => false);
                                    mycubit.get(context).stuteuser("offline",mycubit.get(context).datauser["uid"]);
                                    savedata.remove_uid("uid").then((value) {
                                      Future.delayed(Duration(seconds: 1));
                                      cubit.movtoprofile(0);
                                    });
                                  },
                                  child: Text("Log Out",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontWeight: FontWeight.bold)),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 55,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  late var valur;

  var c = TextEditingController();
}
