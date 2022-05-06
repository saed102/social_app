import 'package:firebase_auth/firebase_auth.dart';

abstract class stutes {}


class initstute extends stutes{}
class emitcstate extends stutes{}
class changebodystate extends stutes{}
class change_modestate extends stutes{}
class getImagepoststate extends stutes{}
class deletpostimagestate extends stutes{}
class getvideopoststate extends stutes{}
class alodingstate extends stutes{}
class stuteusers extends stutes{}
class createnewuserstate extends stutes{}
class rshowpassstate extends stutes{}
class lastmsstute extends stutes{}
class erorrcreatenewuserstate extends stutes{
  dynamic error ;
  erorrcreatenewuserstate({this.error});
}
class userloginstate extends stutes{
  dynamic uid;
  userloginstate({this.uid});
}
class erorruserloginstate extends stutes{
  FirebaseAuthException error ;
  erorruserloginstate({required this.error});

}
class erorrgooglestate extends stutes{
  dynamic error ;
  erorrgooglestate({this.error});

}
class googlestate extends stutes{
  dynamic gid ;
  googlestate({this.gid});
}
class bottomnavigationbarstate extends stutes{}
class getpostslodingstate extends stutes{}
class showpasswordstate extends stutes{}
class followerstute extends stutes{}
class intsstute extends stutes{}
class setdatausersstate extends stutes{}
class getdatauserstate extends stutes{}
class lodingstate extends stutes{}
class changetextstate extends stutes{}
class getpostsstate extends stutes{}
class movtoprofilestate extends stutes{}
class kinitstute extends stutes{}
class getpoststapstate extends stutes{}
class getImagechatstate extends stutes{}
class getImageprofilestate extends stutes{}
class getImagecavertstate extends stutes{}
class getcommentimagestate extends stutes{}
class upluodepostimagestate extends stutes{}
class errorupluodepostimagestate extends stutes{}
class upluodeImagechatstate extends stutes{}
class upluodecommentimagestate extends stutes{}
class getallusersstate extends stutes{}
class profiletapstate extends stutes{}
class setlikesstate extends stutes{}
class setmassgestate extends stutes{}
class getmassegestate extends stutes{}
class showcommnetstate extends stutes{}
class deletpoststate extends stutes{}
class getlikestate extends stutes{}
class textimagechangestate extends stutes{}
class getvediostate extends stutes{}
class uplodepostveideostate extends stutes{}
class intcontrolnalstate extends stutes{}
class inshalizestate extends stutes{}
class stackisshowstate extends stutes{}
class vedietimestate extends stutes{}



