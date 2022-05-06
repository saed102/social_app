import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/auth/login.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/stutes.dart';

import '../save_data/const.dart';

class regester extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var college = TextEditingController();
  var from = TextEditingController();
  var join = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<mycubit, stutes>(
      listener: (context, state) {
        if (state is createnewuserstate) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => login(),
              ),
              (route) => false);
          Fluttertoast.showToast(
              msg: "Done Login now",
              fontSize: 18,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 6);
        }
        if (state is erorrcreatenewuserstate) {
          showToast(state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/30.jpg"))),
              ),
              Center(
                child: Padding(
                  padding:  EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    physics:  BouncingScrollPhysics(),
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              "Regester Now ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 17, 75, 96),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "jannah"),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              controller: name,
                              keyboardType: TextInputType.text,
                              cursorColor: Color.fromARGB(255, 17, 75, 96),
                              style: TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "mustn't be empty";
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: "Full Name",
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(248, 50, 122, 163)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(248, 50, 122, 163))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(248, 50, 122, 163))),
                                  prefixIcon: Icon(
                                    Icons.person_outline_outlined,
                                    color: Color.fromARGB(248, 50, 122, 163),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: Colors.black12)))),
                           SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                              controller: college,
                              keyboardType: TextInputType.text,
                              cursorColor: Color.fromARGB(255, 17, 75, 96),
                              style: TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "mustn't be empty";
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: "College",
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(248, 50, 122, 163)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(248, 50, 122, 163))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(248, 50, 122, 163))),
                                  prefixIcon: Icon(
                                    Icons.work_outline_outlined,
                                    color: Color.fromARGB(248, 50, 122, 163),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: Colors.black12)))),
                           SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                              controller: from,
                              keyboardType: TextInputType.text,
                              cursorColor: Color.fromARGB(255, 17, 75, 96),
                              style: TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "mustn't be empty";
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: "From",
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(248, 50, 122, 163)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(248, 50, 122, 163))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(248, 50, 122, 163))),
                                  prefixIcon: Icon(
                                    Icons.location_on_outlined,
                                    color: Color.fromARGB(248, 50, 122, 163),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: Colors.black12)))),
                           SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                              controller: join,
                              keyboardType: TextInputType.number,
                              cursorColor: Color.fromARGB(255, 17, 75, 96),
                              style: TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "mustn't be empty";
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: "Year of joined",
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(248, 50, 122, 163)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(248, 50, 122, 163))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(248, 50, 122, 163))),
                                  prefixIcon: Icon(
                                    Icons.date_range_outlined,
                                    color: Color.fromARGB(248, 50, 122, 163),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: Colors.black12)))),
                           SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                              controller: email,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Color.fromARGB(255, 17, 75, 96),
                              style: TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "mustn't be empty";
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: "Email",
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(248, 50, 122, 163)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(248, 50, 122, 163))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(248, 50, 122, 163))),
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: Color.fromARGB(248, 50, 122, 163),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: Colors.black12)))),
                           SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                              controller: password,
                              obscureText: mycubit.get(context).rabsurt,
                              keyboardType: TextInputType.visiblePassword,
                              cursorColor: Color.fromARGB(255, 17, 75, 96),
                              style: TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "mustn't be empty";
                                }
                              },
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      mycubit.get(context).rshowpass();
                                    },
                                    icon: Icon(
                                      !mycubit.get(context).rabsurt
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Color.fromARGB(248, 50, 122, 163),
                                    ),
                                  ),
                                  labelText: "Pssword",
                                  labelStyle:  TextStyle(
                                      color: Color.fromARGB(248, 50, 122, 163)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(248, 50, 122, 163))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(248, 50, 122, 163))),
                                  prefixIcon: Icon(
                                    Icons.lock_outlined,
                                    color: Color.fromARGB(248, 50, 122, 163),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: Colors.black12)))),
                          SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              if (formkey.currentState!.validate()) {
                                mycubit.get(context).createnewuser(
                                    from.text,
                                    join.text,
                                    college.text,
                                    email.text,
                                    password.text,
                                    name.text);
                              }
                            },
                            child: Container(

                              padding:  EdgeInsets.symmetric(horizontal: 22,vertical: 5),
                              child:  Center(
                                  child: state is lodingstate?CircularProgressIndicator()  :Text(
                                "Register",
                                style:  TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold),
                              )),
                              height: 41,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 81, 103, 141),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
