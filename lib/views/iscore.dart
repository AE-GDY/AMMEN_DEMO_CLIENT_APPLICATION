import 'package:flutter/material.dart';
import 'package:client_application/constants.dart';

class Iscore extends StatefulWidget {
  const Iscore({Key? key}) : super(key: key);

  @override
  _IscoreState createState() => _IscoreState();
}

class _IscoreState extends State<Iscore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mainColor,
        title: Container(
          width: globalWidth,
          height: globalWidth,
          child: Image(
            image: AssetImage('assets/logofinal.PNG'),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount:2,
            itemBuilder: (context,index){
              List<String> current = [];
              if(index == 0){
                current = history1;
              }
              else{
                current = history2;
              }
              return Padding(
                padding: EdgeInsets.all(15),
                child: Stack(
                  //alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 230,
                      width: 400,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 20,
                              // offset: Offset(0,3),
                            ),
                          ]
                      ),
                      child: Container(
                        margin: EdgeInsets.only(right: 3),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 30,
                      top: 20,
                      child: Text("مصر للتأمين", style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    Positioned(
                      right: 25,
                      top: 60,
                      child: Text("${current[0]} :${accidentDateWord}", style: TextStyle(
                        fontSize: 25,
                      ),),
                    ),
                    Positioned(
                      right: 30,
                      top: 100,
                      child: Text("${current[1]} :${suspensionWord}", style: TextStyle(
                        fontSize: 23,
                      ),),
                    ),
                    Positioned(
                      right: 25,
                      top: 140,
                      child: Text("${current[2]} :${clearedWord}", style: TextStyle(
                        fontSize: 23,
                      ),),
                    ),
                    Positioned(
                      right: 25,
                      top: 180,
                      child: Text("اللوحه:365  ا و ن", style: TextStyle(
                        fontSize: 23,
                      ),),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
