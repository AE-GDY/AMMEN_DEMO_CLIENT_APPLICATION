import 'package:flutter/material.dart';
import 'package:client_application/companies/first.dart';
import 'package:client_application/companies/second.dart';
//import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import '../constants.dart';
//import 'package:intl/intl.dart';


class SuccessfulBooking extends StatelessWidget {
  const SuccessfulBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 140,),
          Center(
            child: Text("Request Completed", style: TextStyle(
              fontSize: 35,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
              textAlign: TextAlign.center,),
          ),
          /*
          Center(
            child: Text("${insuranceCompanyName}", style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
              textAlign: TextAlign.center,),
          ),
          */
          SizedBox(height: 100,),
          Container(
            child: Icon(Icons.check, color: Colors.white, size: 100,),
          ),
          Expanded(child: SizedBox(height: 70,),),

          Container(
            margin: EdgeInsets.only(bottom: 30,),
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: MaterialButton(
              onPressed: (){
                Navigator.pushNamed(context, '/home');
              },
              child: Text("Continue", style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
            ),
          ),

        ],
      ),
    );
  }
}
