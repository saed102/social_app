import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/stutes.dart';
import 'package:social_app/pages/chat_wih.dart';
import 'package:social_app/save_data/const.dart';
import 'package:social_app/styles/icons.dart';

class chats extends StatefulWidget {
  @override
  State<chats> createState() => _chatsState();
}

class _chatsState extends State<chats> {
  bool showsearch = true;
  var c=TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = mycubit.get(context);
    return BlocConsumer<mycubit, stutes>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: IconButton(
                  onPressed: () {
                    setState(() {

                      showsearch = !showsearch;
                      c.clear();
                    });
                  },
                  icon: Icon(
                    showsearch ? IconBroken.Search : Icons.close,
                    color: !mycubit.get(context).isdark
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              )
            ],
            title: Text(
              "chatss ",
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (showsearch == false)
                    SizedBox(
                      height: 5,
                    ),
                  if (showsearch == false)
                    TextFormField(
                        controller: c,
                        onChanged: (value) {
                          cubit.ksearch(value);
                          chat_search= cubit.allusers.where((element) =>  element["name"].startsWith(mycubit.get(context).c)).toList();
                          print(chat_search);
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
                                borderSide:
                                BorderSide(color: Colors.black12)))),
                  SizedBox(
                    height: 10,
                  ),
                  c.text.isEmpty?
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => _item(context,cubit.allusers[index],index),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 15,
                      ),
                      itemCount: cubit.allusers.length):
                  chat_search.length==0?
                  Center(child: Padding(
                    padding: const EdgeInsets.symmetric(vertical:  30.0),
                    child: Text("No result",style: Theme.of(context).textTheme.bodyText1,),
                  )):
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => _item(context,chat_search[index],index),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 15,
                      ),
                      itemCount: chat_search.length),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _item(context, model,index) {
    return InkWell(
      onTap: () {
         print(mycubit.get(context).allusers[index]["uid"]);
        Navigator.push(context, MaterialPageRoute(builder: (context) => chat_with(data: model),));
      },
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [

              CircleAvatar(
                backgroundImage: NetworkImage("${model["imageprofile"]}"),
                radius: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right:  0.0,bottom: 3),
                child: CircleAvatar(backgroundColor:model["stute"]=="offline"? Colors.grey: Colors.green,radius: 7,),
              )
            ],
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
