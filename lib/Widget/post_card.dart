import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/pages/comment1.dart';
import 'package:social_app/pages/image.dart';
import 'package:social_app/pages/pdf.dart';
import 'package:social_app/pages/user_tap.dart';
import 'package:social_app/save_data/const.dart';
import 'package:social_app/styles/icons.dart';
import 'package:url_launcher/url_launcher.dart';

class post_card extends StatefulWidget {
  Map model;

  int indxe;

  post_card({required this.model, required this.indxe});

  @override
  State<post_card> createState() => _post_cardState();
}

class _post_cardState extends State<post_card> {

  @override
  Widget build(BuildContext context) {

    return Card(
      color: mycubit.get(context).isdark ? Colors.black : Colors.white,
      margin: const EdgeInsets.all(8),
      elevation: 5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(

                  backgroundImage: NetworkImage(
                    widget.model["postimage"],
                  ),
                  radius: 30,
                  onBackgroundImageError: (context, stackTrace) {
                     Container(

                      color: Colors.grey,
                      alignment: Alignment.center,

                    );
                  },
                ),
                 SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                           if (mycubit.get(context).datauser["uid"] !=
                                          widget.model["uid"]) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  user_tap(),
                                            ));
                                        mycubit
                                            .get(context)
                                            .profiletap(widget.model["uid"])
                                            .then((value) {
                                          mycubit
                                              .get(context)
                                              .getpoststap(widget.model["uid"]);
                                        });
                                      } else {
                                        mycubit.get(context).movtoprofile(4);
                                      }
                                      print("usergfyguydag==$myuserid");
                                      print( widget.model["uid"]);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 2),
                          child: Text("${widget.model["name"]}",
                              style: Theme.of(context).textTheme.bodyText1),
                        ),
                      ),
                      Text(widget.model["showtime"],
                          style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                ),
                if(widget.model["uid"]==mycubit.get(context).datauser["uid"])
                IconButton(
                  tooltip: "Delete  Post",
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: AlertDialog(
                              actionsAlignment: MainAxisAlignment.end,
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);

                                    },
                                    child: Text("NO",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight:
                                            FontWeight.bold))),
                                TextButton(
                                    onPressed: () {
                                      mycubit
                                          .get(context)
                                          .deletpost(mycubit
                                          .get(context)
                                          .postid[widget.indxe])
                                          .then((value) {
                                        mycubit
                                            .get(context)
                                            .emitc()
                                            .then((value) {
                                          Navigator.pop(context);
                                          Fluttertoast.showToast(
                                              msg:
                                              "Post is will deleted ",
                                              backgroundColor:
                                              Colors.green);
                                        });
                                      });
                                    },
                                    child: Text("YES",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight:
                                            FontWeight.bold))),
                              ],
                              backgroundColor: Colors.white,
                              alignment: AlignmentDirectional.center,
                              title: Text(
                                "You want delete thit post",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              elevation: 17,
                            ),
                          );
                        });
                  },
                  icon: Icon(
                    Icons.clear,
                    size: 25,
                  ),
                ),
              ],
            ),
            buildDivider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SelectableText(widget.model["posttext"],
                      style: Theme.of(context).textTheme.bodyText1),
                  SizedBox(width:  4),
                  if (widget.model["examtitle"] != "no examtitle")
                  InkWell(
                    onTap: () {
                      _launchUrl();
                    },
                    child: Container(
                      color: Color.fromARGB(248, 50, 122, 163),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.model["examtitle"],
                          style: TextStyle(
                              color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  if (widget.model["file"] != "no file")
                    InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => pdf(url: widget.model["file"]),));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.picture_as_pdf_rounded,
                          color: Colors.red[400],
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "PDF File",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 21,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            if (widget.model["image"] != "no image")
              Container(
                width: double.infinity,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
                child: InkWell(
                  onTap: () {
                    navigateTo(context, image(url: widget.model["image"]));
                  },
                  child: Image(
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 210,
                        color: Colors.black,
                        alignment: Alignment.center,
                        child: const Text(
                          'Whoops!\nCheck your Network'
                              ,
                          style: TextStyle(fontSize: 30,color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      return child;
                    },
                    loadingBuilder: (context, child, lodeing) {
                      if (lodeing == null) {
                        return child;
                      } else {
                        return Container(
                            height: 200,
                            child: Center(child: CircularProgressIndicator()));
                      }
                    },
                    image: NetworkImage(
                      widget.model["image"],

                    ),
                  ),
                ),
              ),
            if (widget.model["video"] != "no video")
              AspectRatio(
                aspectRatio: 1 / 1,
                child: BetterPlayer.network(
                  widget.model["video"],
                  betterPlayerConfiguration: BetterPlayerConfiguration(
                    aspectRatio: 1/ 1,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 8,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(
                              IconBroken.Heart,
                              size: 22,
                            ),
                          ),
                          Text(
                            '${widget.model["like"].length}',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      splashColor: Colors.white.withOpacity(0),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(
                                IconBroken.Chat,
                                size: 22,
                              ),
                            ),
                            Text(widget.model["comment"].length.toString(), style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            buildDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          mycubit.get(context).datauser["imageprofile"],
                        ),
                        radius: 18,
                      ),
                       SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          navigateTo(context, comment1(podid: mycubit.get(context).postid[widget.indxe]));
                        },
                        child: Text('Write a comment...',
                            style: Theme.of(context).textTheme.caption),
                      ),
                    ],
                  ),
                  flex: 3,
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    splashColor: Colors.white.withOpacity(0),
                    onTap: () {
                      mycubit.get(context).Likes(mycubit.get(context).postid[widget.indxe],widget. model["like"]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: Icon(
                          widget. model["like"].contains(mycubit.get(context).datauser["uid"])?Icons.favorite: Icons.favorite_border_outlined,
                          color: Colors.red,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Divider(
        height: 16,
        thickness: 1,
        color: mycubit.get(context).isdark
            ? Colors.grey.shade300
            : Colors.grey[700],
      ),
    );
  }

  void _launchUrl() async {
    if (!await launchUrl(Uri.parse(widget.model["link"]))) throw 'Could not launch ';
  }
}
