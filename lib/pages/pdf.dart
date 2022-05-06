
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/stutes.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class pdf extends StatelessWidget {
  String url;
  pdf({required this.url});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<mycubit,stutes>(builder: (context, state) {
     return Scaffold(
          appBar: AppBar(
            title: Text("PDF"),
            centerTitle: true,
          ),
          body:  Container(
              child: SfPdfViewer.network(
                url,)));
    }, listener: (context, state) {});
  }
}
