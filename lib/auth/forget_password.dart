import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/stutes.dart';

class forget_pasword extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<mycubit, stutes>(
        builder: (context, state) => Scaffold(
              backgroundColor: Colors.white,

              body: Stack(
                alignment: Alignment.center,
                children: [

                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/30.jpg"))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0,right: 20,top: 20),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 60,),
                            Container(
                              child: Text(
                                "Don't Worry!!\n\nEnter Your Email to Reset Your Password",
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Form(
                              key: formkey,
                              child: TextFormField(
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
                                    labelText: "Email Address",
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
                                            color: Colors.black12))),
                              ),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  mycubit.get(context).resetpass(email.text);
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(248, 50, 122, 163),
                              )),
                              child: state is lodingstate
                                  ? Center(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  ))
                                  : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "Reset Your Password",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                  ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            if (state is getImagepoststate)
                              Container(
                                child: Text(
                                  "Chick Your mail Now please",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                          ]),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
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
                  ),



                ],
              ),
            ),
        listener: (context, state) {});
  }
}
