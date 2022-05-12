import 'package:flutter/material.dart';

import '../constants.dart';


class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  _TermsAndConditionsState createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms and Conditions"),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Container(
            margin: EdgeInsets.all(10),
            height: 750,
            child: ListView.builder(
                itemCount: termsAndConditionsList.length,
                itemBuilder: (context,index){
                  return Column(
                    children: [
                      SizedBox(height: 10,),
                      Text("${index+1}) ${termsAndConditionsList[index]}", style: TextStyle(
                        fontSize: 15,
                      ),),
                    ],
                  );
                }),
          ),
        ),
    );
  }
}

