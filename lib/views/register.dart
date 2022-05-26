import 'package:flutter/material.dart';

import '../constants.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  bool secureText = true;
  String userName = "";
  String date = "";
  String iD = "";
  String email = "";
  String password = "";

  bool leftSelected = false;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text("امان", style: TextStyle(
          fontSize: 25,
        ),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                SizedBox(height: 10,),
                Container(
                  child: Text("الموقع الاول لمقارنه اسعار التامين في مصر", style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                    textAlign: TextAlign.center,),
                ),
                /*Row(
                  children: [
                    SizedBox(width:20,),
                    Container(
                      height: 50,
                      width: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: leftSelected?Colors.grey[500]: Colors.grey[300],
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            leftSelected = true;
                          });
                        },
                        child: Text("تامين ضد الغير",textAlign: TextAlign.center,style: TextStyle(
                          color: Colors.black,
                        //  fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Container(
                      height: 50,
                      width: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: leftSelected?Colors.grey[300]: Colors.grey[500],
                      ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              leftSelected = false;
                            });
                          },
                          child: Text("تامين شامل",textAlign: TextAlign.center,style: TextStyle(
                            color: Colors.black,
                           // fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),*/
                SizedBox(height: 30,),
                buildUserName(),
                SizedBox(height: 10,),
                buildId(),
                SizedBox(height: 10,),
                buildDate(),
                SizedBox(height: 10,),
                buildEmail(),
                SizedBox(height: 10,),
                buildPassword(),
                SizedBox(height: 30,),
                Container(
                  height: 60,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed:() {
                      FocusScope.of(context).unfocus();
                      final isValid = formKey.currentState!.validate();
                      if(isValid){
                        formKey.currentState!.save();
                        setState(() {
                          fullName  = userName;
                          nationalID  = iD;
                          insuranceDate = date;
                          userEmail = email;
                          userPassword = password;
                        });
                        print("$userName");
                        print("$iD");
                        print("$date");
                        print("$email");
                        print("$password");
                        Navigator.pushNamed(context, '/home');
                      }
                    }, child: Text("اشتر الآن", style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget buildUserName() => TextFormField(
    decoration: InputDecoration(
      hintText: 'Full Name',
      border: OutlineInputBorder(),
    ),
    validator: (value){
      if(value!.length < 4){
        return "Enter at least 4 characters";
      }
      else{

        return null;
      }
    },
    onSaved: (value) => setState(() => userName = value!),
  );
  Widget buildId() => TextFormField(
    decoration: InputDecoration(
      hintText: 'National ID',
      border: OutlineInputBorder(),
    ),
    validator: (value){
      if(value!.length < 4){
        print("ERROR");
        return "Enter at least 4 characters";
      }
      else{
        return null;
      }
    },
    onSaved: (value) => setState(() => iD = value!),
  );
  Widget buildEmail() => TextFormField(
    decoration: InputDecoration(
      hintText: 'Email',
      border: OutlineInputBorder(),
    ),
    validator: (value){
      if(value!.length < 4){
        print("ERROR");
        return "Enter at least 4 characters";
      }
      else{
        return null;
      }
    },
    onSaved: (value) => setState(() => email = value!),
  );
  Widget buildDate() => TextFormField(
    decoration: InputDecoration(
      hintText: 'Date',
      border: OutlineInputBorder(),
    ),
    validator: (value){
      if(value!.length < 4){
        return "Enter at least 4 characters";
      }
      else{
        return null;
      }
    },
    onSaved: (value) => setState(() => date = value!),
  );
  Widget buildPassword() => TextFormField(
    decoration: InputDecoration(
      hintText: 'Password',
      border: OutlineInputBorder(),
    ),
    validator: (value){
      if(value!.length < 4){
        return "Enter at least 4 characters";
      }
      else{
        return null;
      }
    },
    onSaved: (value) => setState(() => password = value!),
  );
}


