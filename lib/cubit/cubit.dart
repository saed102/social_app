import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:social_app/cubit/stutes.dart';
import 'package:social_app/pages/Setting.dart';
import 'package:social_app/pages/about.dart';
import 'package:social_app/pages/add_post.dart';
import 'package:social_app/pages/chat.dart';
import 'package:social_app/pages/home_page.dart';
import 'package:social_app/pages/profile.dart';
import 'package:social_app/save_data/const.dart';
import 'package:social_app/save_data/save_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class mycubit extends Cubit<stutes> {
  mycubit() : super(initstute());

  static mycubit get(context) => BlocProvider.of(context);

  String? college;
  String? from;
  String? gebder;

  dd(v) {
    college = v;
    emit(lodingstate());
  }

  List body = [home_page(), chats(), add_post(), Setting(), profil(), about()];
  int index = 0;

  changebody(newindex) {
    index = newindex;
    if (index == 1) {
      getallusers();
    }
    emit(changebodystate());
  }

  Future movtoprofile(v) async {
    index = v;
    emit(movtoprofilestate());
  }

  String? l;
  String? examtltle;

  link(v) {
    l = v;
    emit(change_modestate());
  }

  exam(v) {
    examtltle = v;
    emit(change_modestate());
  }

  bool isdark = true;

  change_mode({v}) {
    if (v != null) {
      isdark = v;
      emit(change_modestate());
    } else {
      isdark = !isdark;
      savedata.put_isdark("d", isdark).then((value) {
        emit(change_modestate());
      });
    }
  }

  deletpostimage() {
    postimage = null;
    vedio = null;
    l = null;
    examtltle = null;
    emit(deletpostimagestate());
  }

  Future<void> emitc() async {
    emit(emitcstate());
  }

  File? postimage;
  final picker = ImagePicker();

  Future getImagepost() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postimage = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    emit(getImagepoststate());
  }

  resetpass(email) {
    emit(lodingstate());
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      emit(getImagepoststate());
    }).catchError((onError) {
      emit(erorrcreatenewuserstate());
      showToast(onError.message.toString());
      print(onError.toString());
    });
  }

  stuteuser(v, uid) {
    FirebaseFirestore.instance.collection("myusers").doc(uid).update({
      "stute": v,
    }).then((value) {
      emit(stuteusers());
    });
  }

  void createnewuser(from, join, college, email, password, name) {
    emit(lodingstate());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      setdatausers(name, from, email, value.user!.uid, college, join);
      print("Done new user is created Please Login now");
      Fluttertoast.showToast(
          msg: "Done Login now",
          fontSize: 16,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 6);
      emit(createnewuserstate());
    }).catchError((onError) {
      emit(erorrcreatenewuserstate(error: onError));
    });
  }

  bool absurt = true;

  showpass() {
    absurt = !absurt;
    emit(showpasswordstate());
  }

  bool rabsurt = true;

  rshowpass() {
    rabsurt = !rabsurt;
    emit(rshowpassstate());
  }

  void userlogin(
    email,
    password,
  ) {
    emit(alodingstate());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      myuserid = value.user!.uid;
      getdatauser(value.user!.uid);
      getposts();
      print("login is done");
      emit(userloginstate(uid: value.user!.uid));
    }).catchError((onError) {
      emit(erorruserloginstate(error: onError));
      Fluttertoast.showToast(
          msg: onError.message.toString(),
          fontSize: 16,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 6);
      print("ERROE============= ${onError.message.toString()}");
    });
  }

  int? indexs = null;

  getindex(value) {
    indexs = value;
    emit(bottomnavigationbarstate());
  }

  setdatausers(name, from, email, uid, college, join) {
    FirebaseFirestore.instance.collection("myusers").doc(uid).set({
      "name": name,
      "email": email,
      "from": from,
      "join": join,
      "stute": "online",
      "college": college,
      "sub": [],
      "uid": uid,
      "imageprofile":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNIPYYgJ7PxsXO80x2RV-YMNUJN4ge2sV2Gw&usqp=CAU",
      "caverprofile":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNIPYYgJ7PxsXO80x2RV-YMNUJN4ge2sV2Gw&usqp=CAU",
    }).then((value) {
      getdatauser(uid);
      emit(setdatausersstate());
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  Future<void> getdatauser(o) async {
    datauser = {};
    if (myuserid != null) {
      emit(getpostslodingstate());
      FirebaseFirestore.instance
          .collection("myusers")
          .doc(o)
          .snapshots()
          .listen((value) {
        datauser = value.data()!;
        print("you data now is======  $datauser");
        emit(getdatauserstate());
      });
    }
  }

  Future updatedatauser({name, college, from, profile, cover, join}) {
    emit(lodingstate());
    return FirebaseFirestore.instance
        .collection("myusers")
        .doc(myuserid)
        .update({
      "name": name,
      "from": from,
      "college": college,
      "join": join,
      "imageprofile": profile ?? datauser["imageprofile"],
      "caverprofile": cover ?? datauser["caverprofile"],
    }).then((value) async {
      await updateposts(name, profile: profile);
    });
  }

  updateposts(
    name, {
    profile,
  }) {
    FirebaseFirestore.instance.collection("posts").get().then((value) {
      value.docs.forEach((element) {
        if (element.data()["uid"] == myuserid) {
          element.reference.update({
            "name": name,
            "postimage": profile ?? datauser["imageprofile"],
          });
        }
        element.reference.collection("comment").doc(datauser["uid"]).update({
          "name": name,
          "image": profile ?? datauser["imageprofile"],
        });
      });
      getposts();
    });
  }

  Future deletpost(p) {
    return FirebaseFirestore.instance
        .collection("posts")
        .doc(p)
        .delete()
        .then((value) {
      emit(deletpoststate());
    });
  }

  bool isshow = true;

  Future setposts(text, date, context, {image, video, file, link, examtitle}) {
    emit(lodingstate());
    return FirebaseFirestore.instance.collection("posts").add({
      "image": image ?? "no image",
      "video": video ?? "no video",
      "file": file ?? "no file",
      "islke": false,
      "uid": myuserid,
      "datetime": date,
      "link": link ?? "no link",
      "examtitle": examtitle ?? "no examtitle",
      "like": [],
      "comment": [],
      "showtime":
          "${DateFormat.yMMMd().format(DateTime.now())} ${TimeOfDay.now().format(context).toString()} ",
      "posttext": text,
      "name": datauser["name"],
      "postimage": datauser["imageprofile"],
    }).then((value) {
      getposts();
      index = 0;
    });
  }

  List<Map<String, dynamic>> postsdata = [];
  List<Map<String, dynamic>> profile = [];
  List<Map<String, dynamic>> tapprpfile = [];
  List<Map<String, dynamic>> massges = [];
  List<Map<String, dynamic>> allusers = [];
  List<Map<String, dynamic>> videol = [];
  Map<String, dynamic> datauser = {};
  List<String> postid = [];
  List<int> numberoflikes = [];
  List<int> numberofcomment = [];
  List islike = [];

  getposts() {
    emit(getpostslodingstate());
    FirebaseFirestore.instance
        .collection("posts")
        .orderBy("datetime", descending: true)
        .snapshots()
        .listen((value) {
      postsdata = [];
      profile = [];
      postid = [];

      value.docs.forEach((element) {
        if (element.data()["uid"] == datauser["uid"]) {
          profile.add(element.data());
        }

        postsdata.add(element.data());
        postid.add(element.id);
      });

      emit(getpostsstate());
    });
  }

  getpostsnoloding() {
    FirebaseFirestore.instance
        .collection("posts")
        .orderBy("datetime", descending: true)
        .snapshots()
        .listen((value) {
      postsdata = [];
      profile = [];
      postid = [];

      value.docs.forEach((element) {
        if (element.data()["uid"] == datauser["uid"]) {
          profile.add(element.data());
        }

        postsdata.add(element.data());
        postid.add(element.id);
      });

      emit(getpostsstate());
    });
  }

  bool g = false;

  String c = "";
  String t = "";
  String p = "";

  ksearch(value) {
    c = value;
    emit(movtoprofilestate());
  }

  psearch(value) {
    p = value;
    emit(movtoprofilestate());
  }

  Future getpoststap(o) async {
    emit(lodingstate());
    FirebaseFirestore.instance
        .collection("posts")
        .orderBy("datetime")
        .snapshots()
        .listen((value) {
      tapprpfile = [];
      value.docs.forEach((element) {
        if (element.data()["uid"] == o) {
          tapprpfile.add(element.data());
        }
      });
      print("your post now is $tapprpfile");
      emit(getpoststapstate());
    });
  }

  File? f;

  getpostfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      f = File(result.files.single.path.toString());
    } else {
      print('No file selected.');
    }
    emit(getvediostate());
  }

  File? vedio;

  Future getvedio() async {
    final pickedFile = await picker.getVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      vedio = File(pickedFile.path);
    } else {
      print('No video selected.');
    }
    emit(getvediostate());
  }

  File? chatimage;

  Future getImagechat() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      chatimage = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    emit(getImagechatstate());
  }

  File? profileimage;

  Future getprofileimage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileimage = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    emit(getImageprofilestate());
  }

  File? caverimage;

  Future getpcoverimage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      caverimage = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    emit(getImagecavertstate());
  }

  File? commentimage;

  Future getcommentimage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      commentimage = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    emit(getcommentimagestate());
  }

  Future upluodepostimage(text, date, context) {
    emit(lodingstate());
    return firebase_storage.FirebaseStorage.instance
        .ref()
        .child("myimages/${Uri.file(postimage!.path).pathSegments.last}")
        .putFile(postimage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        setposts(
          text,
          date,
          context,
          image: value,
        ).then((value) {
          postimage = null;
        });
        print("your post is set");
        emit(upluodepostimagestate());
      }).catchError((onError) {
        print(onError.toString());
        emit(errorupluodepostimagestate());
      });
    }).catchError((onError) {
      print(onError.toString());
      emit(errorupluodepostimagestate());
    });
  }

  uplod_image_file(text, date, context) {
    emit(lodingstate());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("myimages/${Uri.file(postimage!.path).pathSegments.last}")
        .putFile(postimage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value2) {
        emit(lodingstate());
        firebase_storage.FirebaseStorage.instance
            .ref()
            .child("myimages/${Uri.file(f!.path).pathSegments.last}")
            .putFile(f!)
            .then((p0) {
          p0.ref.getDownloadURL().then((value) {
            setposts(text, date, context, file: value, image: value2)
                .then((value) {
              f = null;
              postimage = null;
            });
            print("your post is set");
            emit(uplodepostveideostate());
          }).catchError((onError) {
            print(onError.toString());
            emit(errorupluodepostimagestate());
          });
        }).catchError((onError) {
          print(onError.toString());
          emit(errorupluodepostimagestate());
        });
        emit(upluodepostimagestate());
      }).catchError((onError) {
        print(onError.toString());
        emit(errorupluodepostimagestate());
      });
    }).catchError((onError) {
      print(onError.toString());
      emit(errorupluodepostimagestate());
    });
  }

  uplod_video_file(text, date, context) {
    emit(lodingstate());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("myimages/${Uri.file(vedio!.path).pathSegments.last}")
        .putFile(vedio!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value2) {
        emit(lodingstate());
        firebase_storage.FirebaseStorage.instance
            .ref()
            .child("myimages/${Uri.file(f!.path).pathSegments.last}")
            .putFile(f!)
            .then((p0) {
          p0.ref.getDownloadURL().then((value) {
            setposts(text, date, context, file: value, video: value2)
                .then((value) {
              f = null;
              vedio = null;
            });
            print("your post is set");
            emit(uplodepostveideostate());
          }).catchError((onError) {
            print(onError.toString());
            emit(errorupluodepostimagestate());
          });
        }).catchError((onError) {
          print(onError.toString());
          emit(errorupluodepostimagestate());
        });
        emit(upluodepostimagestate());
      }).catchError((onError) {
        print(onError.toString());
        emit(errorupluodepostimagestate());
      });
    }).catchError((onError) {
      print(onError.toString());
      emit(errorupluodepostimagestate());
    });
  }

  upluodeprofileimage(name, from, join, college) {
    emit(lodingstate());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("myimages/${Uri.file(profileimage!.path).pathSegments.last}")
        .putFile(profileimage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) async {
        await updatedatauser(
                college: college,
                from: from,
                profile: value,
                name: name,
                join: join)
            .then((value) {
          profileimage = null;
        });
        print("your post is set");
        emit(upluodepostimagestate());
      }).catchError((onError) {
        print(onError.toString());
        emit(errorupluodepostimagestate());
      });
    }).catchError((onError) {
      print(onError.toString());
      emit(errorupluodepostimagestate());
    });
  }

  uplodepostveideo(text, date, context) {
    emit(lodingstate());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("myimages/${Uri.file(vedio!.path).pathSegments.last}")
        .putFile(vedio!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        setposts(text, date, context, video: value).then((value) {
          vedio = null;
        });

        print("your post is set");
        emit(uplodepostveideostate());
      }).catchError((onError) {
        print(onError.toString());
        emit(errorupluodepostimagestate());
      });
    }).catchError((onError) {
      print(onError.toString());
      emit(errorupluodepostimagestate());
    });
  }

  upluodepostfile(text, date, context, {image, videp}) {
    emit(lodingstate());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("myimages/${Uri.file(f!.path).pathSegments.last}")
        .putFile(f!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        setposts(text, date, context, file: value).then((value) {
          f = null;
        });

        print("your post is set");
        emit(uplodepostveideostate());
      }).catchError((onError) {
        print(onError.toString());
        emit(errorupluodepostimagestate());
      });
    }).catchError((onError) {
      print(onError.toString());
      emit(errorupluodepostimagestate());
    });
  }

  upluodeImagechat(reseverid, datetime, context) {
    emit(lodingstate());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("myimages/${Uri.file(chatimage!.path).pathSegments.last}")
        .putFile(chatimage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        setmassge(reseverid, value, datetime, context);
        chatimage = null;
        print("your post is set");
        emit(upluodeImagechatstate());
      }).catchError((onError) {
        print(onError.toString());
        emit(errorupluodepostimagestate());
      });
    }).catchError((onError) {
      print(onError.toString());
      emit(errorupluodepostimagestate());
    });
  }

  Future upluodecommentimage(reseverid, datetime) {
    emit(lodingstate());
    return firebase_storage.FirebaseStorage.instance
        .ref()
        .child("myimages/${Uri.file(commentimage!.path).pathSegments.last}")
        .putFile(commentimage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        setcomment(reseverid, value, datetime);
        commentimage = null;
        print("your post is set");
        emit(upluodecommentimagestate());
      }).catchError((onError) {
        print(onError.toString());
        emit(errorupluodepostimagestate());
      });
    }).catchError((onError) {
      print(onError.toString());
      emit(errorupluodepostimagestate());
    });
  }

  Future upluodecoverimage(name, from, join, college) {
    emit(lodingstate());
    return firebase_storage.FirebaseStorage.instance
        .ref()
        .child("myimages/${Uri.file(caverimage!.path).pathSegments.last}")
        .putFile(caverimage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        updatedatauser(
                college: college,
                from: from,
                cover: value,
                name: name,
                join: join)
            .then((value) {
          caverimage = null;
        });
        print("your caver is set");
        emit(upluodepostimagestate());
      }).catchError((onError) {
        print(onError.toString());
        emit(errorupluodepostimagestate());
      });
    }).catchError((onError) {
      print(onError.toString());
      emit(errorupluodepostimagestate());
    });
  }

  Map tap = {};

  Future profiletap(t) async {
    tap = {};
    emit(lodingstate());
    FirebaseFirestore.instance
        .collection("myusers")
        .doc(t)
        .snapshots()
        .listen((value) {
      tap = value.data()!;
      print("prfiltap is======  $tap");
      emit(profiletapstate());
    });
  }

  getallusers({id}) {
    FirebaseFirestore.instance
        .collection("myusers")
        .snapshots()
        .listen((value) {
      allusers = [];
      value.docs.forEach((element) {
        if (element.data()["uid"] != datauser["uid"]) {
          allusers.add(element.data());
        }
      });

      emit(getallusersstate());
    });
  }

  List<Map<String, dynamic>> search = [];

  serach() {
    FirebaseFirestore.instance
        .collection("myusers")
        .where("name", isGreaterThanOrEqualTo: "saed")
        .get()
        .then((value) {
      value.docChanges;
    });
  }

  Future setlike(v, date) {
    return FirebaseFirestore.instance
        .collection("posts")
        .doc(v)
        .collection("likes")
        .doc(datauser["uid"])
        .set({"like": true, "datetime": date}).then((value) {
      emit(setlikesstate());
    });
  }

  setmassge(reseverid, ms, datetime, context) {
    FirebaseFirestore.instance
        .collection("myusers")
        .doc(datauser["uid"])
        .collection("chat")
        .doc(reseverid)
        .collection("massege")
        .add({
      "ms": ms,
      "reseverid": reseverid,
      "senderid": datauser["uid"],
      "datetime": datetime,
      "showtime": TimeOfDay.now().format(context)
    }).then((value) {
      emit(setmassgestate());
    });
    FirebaseFirestore.instance
        .collection("myusers")
        .doc(reseverid)
        .collection("chat")
        .doc(datauser["uid"])
        .collection("massege")
        .add({
      "ms": ms,
      "reseverid": reseverid,
      "senderid": datauser["uid"],
      "datetime": datetime,
      "showtime": TimeOfDay.now().format(context)
    }).then((value) {
      emit(setmassgestate());
    });
  }

  getmassege(reseverid) {
    FirebaseFirestore.instance
        .collection("myusers")
        .doc(datauser["uid"])
        .collection("chat")
        .doc(reseverid)
        .collection("massege")
        .orderBy("datetime", descending: true)
        .snapshots()
        .listen((event) {
      massges = [];
      event.docs.forEach((element) {
        massges.add(element.data());
      });
      emit(getmassegestate());
    });
  }

  Future setcomment(y, text, String datetime) {
    return FirebaseFirestore.instance
        .collection("posts")
        .doc(y)
        .collection("comment")
        .doc(datauser["uid"])
        .set({
      "text": text,
      "name": datauser["name"],
      "image": datauser["imageprofile"],
      "datetime": datetime,
    }).then((value) {});
  }

  List<Map<String, dynamic>> comment = [];
  List<Map<String, dynamic>> jjjjjj = [];

  showcommnet(y) async {
    emit(lodingstate());
    FirebaseFirestore.instance
        .collection("posts")
        .doc(y)
        .collection("comment")
        .orderBy("datetime")
        .snapshots()
        .listen((event) {
      comment = [];
      event.docs.forEach((element) {
        comment.add(element.data());
      });
      print("uuu $comment");
      emit(showcommnetstate());
    });
  }

  Likes(y, List o) {
    if (o.contains(datauser["uid"])) {
      FirebaseFirestore.instance.collection("posts").doc(y).update({
        "like": FieldValue.arrayRemove([datauser["uid"]]),
        "islke": false,
      });
    } else {
      FirebaseFirestore.instance.collection("posts").doc(y).update({
        "like": FieldValue.arrayUnion([datauser["uid"]]),
        "islke": true,
      });
    }
  }

  add_sub(v) {
    FirebaseFirestore.instance
        .collection("myusers")
        .doc(datauser["uid"])
        .update({
      "sub": FieldValue.arrayUnion([v]),
    });
  }

  remove_sub(v) {
    FirebaseFirestore.instance
        .collection("myusers")
        .doc(datauser["uid"])
        .update({
      "sub": FieldValue.arrayRemove([v]),
    });
  }

  comments(
    y,
  ) {
    FirebaseFirestore.instance.collection("posts").doc(y).update({
      "comment": FieldValue.arrayUnion([datauser["uid"]]),
    });
  }

  List<String> chat = [];
}
