import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/stutes.dart';
import 'package:social_app/save_data/const.dart';
import 'package:social_app/styles/icons.dart';

class mysub extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<mycubit,stutes>(
        listener: (context,state){

        },
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Your Courses"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 20,),
              physics: BouncingScrollPhysics(),

              itemBuilder: (context, index) {
                return Container(
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(children: [

                          const SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                mycubit.get(context).datauser["sub"][index],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 23, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                mycubit.get(context).remove_sub(mycubit.get(context).datauser["sub"][index]);
                                print(mycubit.get(context).datauser["sub"][index]);
                              },
                              child: Icon(Icons.close,size: 40,color: Colors.red,))
                        ]),
                      )),
                  height: 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        width: 1.5,
                        color: const Color.fromARGB(248, 50, 122, 163),
                      )),
                );
              },
              itemCount: mycubit.get(context).datauser["sub"].length,
            )),
      );
    }
    );
  }




}

