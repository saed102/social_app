

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/stutes.dart';

class comment1 extends StatelessWidget {
  var text = TextEditingController();
  String podid;

  comment1({required this.podid});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
         mycubit.get(context).showcommnet(podid);
        return BlocConsumer<mycubit, stutes>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              // backgroundColor: Colors.grey[900],
              appBar: AppBar(
                elevation: 10,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Comment",
                      style:
                      Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    mycubit.get(context).comment = [];
                  },
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                ),
                // backgroundColor: Colors.black,
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  Expanded(
                      child:
                      ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return hh(context, mycubit.get(context).comment[index]);
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                        itemCount: mycubit.get(context).comment.length,
                      )),
                  if (mycubit.get(context).commentimage != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          child: Image.file(
                            mycubit.get(context).commentimage!,
                            fit: BoxFit.cover,
                          ),
                          color: Colors.transparent,
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        border: Border.all(color:  Color.fromARGB(248, 50, 122, 163)),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 18.0),
                            child: TextFormField(
                              controller: text,
                              maxLines: 10,
                              minLines: 1,
                              cursorColor: Color.fromARGB(248, 50, 122, 163),
                              style: Theme.of(context).textTheme.bodyText1,
                              onFieldSubmitted: (value) {
                                mycubit.get(context).setcomment(podid, text.text,
                                    TimeOfDay.now().format(context));

                                text.clear();
                              },
                              decoration: InputDecoration(
                                  hintText: "Type your comment ",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: IconButton(
                              onPressed: () {
                                mycubit.get(context).getcommentimage();
                              },
                              icon: Icon(
                                Icons.camera_alt,
                                color: Color.fromARGB(248, 50, 122, 163),
                                size: 26,
                              )),
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(248, 50, 122, 163),
                            ),
                            child: IconButton(
                              onPressed: () {
                                if (mycubit.get(context).commentimage == null) {
                                  mycubit.get(context).setcomment(
                                      podid,
                                      text.text,
                                      TimeOfDay.now().format(context)).then((value) {
                                    mycubit.get(context).comments(podid);
                                  });

                                  text.clear();
                                } else {
                                  mycubit.get(context).upluodecommentimage(
                                      podid, TimeOfDay.now().format(context)).then((value) {
                                    mycubit.get(context).comments(podid);
                                  });

                                  text.clear();
                                }
                              },
                              icon: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  )
                ]),
              ),
            );
          },
        );
      },
    );
  }

  Widget hh(context, model) {
    String j = model["text"];
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              foregroundImage: NetworkImage(model["image"]),
              radius: 30,
            ),
            SizedBox(width: 8,),
            Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            model["name"],
                            textDirection: j.contains(RegExp('[A-Z]'))
                                ? TextDirection.ltr
                                : TextDirection.rtl,
                            style: TextStyle(fontSize: 21, color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          !j.startsWith("https://firebase")?
                          Text(
                            j,
                            textDirection: j.contains(RegExp('[A-Z]'))
                                ? TextDirection.ltr
                                : TextDirection.rtl,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ):Image.network(j,fit: BoxFit.cover,
                            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                              return child;
                            },
                            loadingBuilder:( context,  child, lodeing) {
                              if(lodeing==null){
                                return child;
                              }else{
                                return Container(
                                    height: 200,
                                    child: Center(child: CircularProgressIndicator()));
                              }
                            } ,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                model["datetime"],
                                style: TextStyle(fontSize: 13, color:mycubit.get(context).isdark? Colors.grey:Colors.black54),
                              ),
                            ],
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          color:mycubit.get(context).isdark?Colors.black:Color.fromARGB(248, 50, 122, 163)),
                    ),
                  ],
                ))
          ],
        ));
  }
}
