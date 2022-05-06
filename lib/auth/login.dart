import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/auth/forget_password.dart';
import 'package:social_app/auth/regester.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/stutes.dart';
import 'package:social_app/pages/init_page.dart';
import 'package:social_app/save_data/const.dart';
import 'package:social_app/save_data/save_data.dart';

class login extends StatefulWidget {
  login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  var formkey = GlobalKey<FormState>();
  var paswword=TextEditingController();
  var email=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<mycubit, stutes>(
      listener: (context, state) {
         if (state is userloginstate ) {
           savedata.set_uid("uid", state.uid);
           mycubit.get(context).getdatauser(state.uid).then((value) {
             mycubit.get(context).stuteuser("online",state.uid);

             Navigator.pushAndRemoveUntil(context,
                 MaterialPageRoute(builder: (context) => init_page(),), (
                     route) => false);
           });

          }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Container(
                    height: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft:Radius.circular(15) ,bottomRight:Radius.circular(15) ),
                      image: const DecorationImage(
                          image: AssetImage("assets/images/11.jpg"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    height: 100,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      image: const DecorationImage(
                        image: AssetImage("assets/images/12.jpg"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: email,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Color.fromARGB(255, 17, 75, 96),
                            style: const TextStyle(color: Colors.black),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "mustn't be empty";
                              }
                            },
                            decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: const TextStyle(
                                    color: Color.fromARGB(248, 50, 122, 163)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(248, 50, 122, 163))),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(248, 50, 122, 163))),
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                  color: Color.fromARGB(248, 50, 122, 163),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                        color: Colors.black12)))),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: paswword,
                          obscureText: mycubit.get(context).absurt,
                            keyboardType: TextInputType.visiblePassword,
                            cursorColor: Color.fromARGB(255, 17, 75, 96),
                            style: const TextStyle(color: Colors.black),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "mustn't be empty";
                              }
                            },
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    mycubit.get(context).showpass();
                                  },
                                  icon: Icon(
                                    !mycubit.get(context).absurt
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Color.fromARGB(248, 50, 122, 163),
                                  ),
                                ),
                                labelText: "Pssword",
                                labelStyle: const TextStyle(
                                    color: Color.fromARGB(248, 50, 122, 163)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(248, 50, 122, 163))),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(248, 50, 122, 163))),
                                prefixIcon: const Icon(
                                  Icons.lock_outlined,
                                  color: Color.fromARGB(248, 50, 122, 163),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                        color: Colors.black12)))),
                                        SizedBox(height: 10,),
                        Row(
                          children: [
                            const Spacer(),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, forget_pasword());
                                },
                                child: const Text("Forget Pssword ?",
                                    style: TextStyle(
                                        color:Color.fromARGB(248, 50, 122, 163),
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold)))
                          ],
                        ),
                         SizedBox(height: 10,),
                        InkWell(
                          onTap: () {
                            if (formkey.currentState!.validate()) {
                              mycubit.get(context).userlogin(email.text, paswword.text);
                            }
                          },
                          child: Container(
                            padding:  EdgeInsets.symmetric(horizontal: 22),
                            child:  Center(
                                child: state is alodingstate || state is getpostslodingstate?
                             CircularProgressIndicator(): Text(
                              "Login",
                              style:  TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            )
                          ),
                            height: 41,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 81, 103, 141),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Row(
                            children: [
                              const Text(
                                "Don't Have account? ",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateTo(context,regester() );
                                },
                                child: const Text(
                                  "Register Now",
                                  style: const TextStyle(
                                      color: Color.fromARGB(248, 50, 122, 163),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
