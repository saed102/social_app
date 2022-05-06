import 'package:flutter/material.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/save_data/const.dart';
import 'package:social_app/styles/icons.dart';

class courses extends StatelessWidget {
  int slectedindex;
  courses({required this.slectedindex});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Courses"),
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
                              partment[slectedindex]["sub"][index],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                         InkWell(
                           onTap: () {

                             mycubit.get(context).add_sub(partment[slectedindex]["sub"][index]);
                             print(partment[slectedindex]["sub"][index]);
                             showDialog(context: context, builder: (context){
                               return AlertDialog(
                                 actions: [
                                   TextButton(onPressed: (){pop(context);}, child: Text("Ok",style: TextStyle(color: Colors.black,fontSize: 20)))
                                 ],
                                 title: Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                     children: [
                                   Image.asset("assets/images/19.jpg",height: 100,width: 100,),
                                   Text("You have registered successfully",textAlign: TextAlign.center, style: TextStyle(color: Colors.black,fontSize: 18),),
                                 ]),
                               );
                             });
                           },
                             child: Icon(IconBroken.Plus,size: 40,))
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
            itemCount: partment[slectedindex]["sub"].length,
          )),
    );
  }




}

