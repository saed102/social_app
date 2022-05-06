
 import 'package:flutter/material.dart';

 class image extends StatelessWidget {
  String url;
   image({Key? key,required this.url}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
        backgroundColor: Colors.black,),
      backgroundColor: Colors.black,
      body: Center(child: Image.network(url,
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
        },),

      ),
    );
  }
}
