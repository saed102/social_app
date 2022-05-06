import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/stutes.dart';
import 'package:social_app/pages/user_tap.dart';
import 'package:social_app/save_data/const.dart';
import 'package:social_app/styles/icons.dart';

class search extends StatefulWidget {
  search({Key? key}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  var c= TextEditingController();
  @override
  Widget build(BuildContext context) {
    var cubit=mycubit.get(context);
    return Builder(
      builder: (context) {
        cubit.getallusers();
        return BlocConsumer<mycubit,stutes>(
           listener: (context, state) {

           },
          builder: (context, state){
            return Scaffold(
          appBar: AppBar(
            title: Text("Search for users",),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              TextFormField(
                controller: c,
                onChanged: (value) {
                  cubit.psearch(value);
                  user_search= cubit.allusers.where((element) =>  element["name"].startsWith(mycubit.get(context).p) ).toList();
                  print(user_search);
                },
                            cursorColor: !mycubit.get(context).isdark
                                ? Colors.black
                                : Colors.white,
                            style: TextStyle(
                              color: !mycubit.get(context).isdark
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  color: !mycubit.get(context).isdark
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: !mycubit.get(context).isdark
                                      ? Colors.black
                                      : Colors.white,
                                )),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: !mycubit.get(context).isdark
                                      ? Colors.black
                                      : Colors.white,
                                )),
                                labelText: 'Search',
                                prefixIcon: Icon(
                                  IconBroken.Search,
                                  color: !mycubit.get(context).isdark
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black12)))),
              SizedBox(height: 10,),

              c.text.isNotEmpty&&user_search.length==0?
              Center(child: Padding(
                padding: const EdgeInsets.symmetric(vertical:  30.0),
                child: Text("No result",style: Theme.of(context).textTheme.bodyText1,),
              )):
              Expanded(
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(height: 15,),
                  itemCount: user_search.length,
                  itemBuilder: (context, index) {
                  return _item(context, user_search[index], index);
                },),
              )
            ]),
          ),
        );
          },

           );
      }
    );
  }
  Widget _item(context, model,index) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  user_tap(),
            ));
        mycubit
            .get(context)
            .profiletap(model["uid"])
            .then((value) {
          mycubit
              .get(context)
              .getpoststap(model["uid"]);
        });

      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage("${model["imageprofile"]}"),
            radius: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text("${model["name"]}" ,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}