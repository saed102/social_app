import 'package:flutter/material.dart';
import 'package:social_app/pages/courses.dart';
import 'package:social_app/save_data/const.dart';

class about extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Departments"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:  20.0,vertical: 30),
        child: ListView.separated(
           separatorBuilder: (context, index) => SizedBox(height: 20,),
          physics: BouncingScrollPhysics(),

          itemBuilder: (context, index) {
          return _item(partment[index], context,index);
        },
          itemCount: partment.length,
        )
      ),
    );
  }



  Widget _item(model,context,index) {
    return InkWell(
      onTap: () {
        navigateTo(context, courses(slectedindex: index,));
        print(index);
      },
      child: Container(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
            Container(
              height: 85,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(model["image"],),fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    width: 1.5,
                    color: Color.fromARGB(248, 50, 122, 163),
                  )),
            ),
            SizedBox(
              width: 14,
            ),
            Expanded(
              child: Container(
                child: Text(
                  model["name"],
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 23, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ]),
        )),
        height: 110,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              width: 1.5,
              color: Color.fromARGB(248, 50, 122, 163),
            )),
      ),
    );
  }
}
