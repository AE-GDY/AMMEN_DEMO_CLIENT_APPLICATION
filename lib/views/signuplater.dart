import 'package:client_application/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants.dart';


class SignUpLater extends StatefulWidget {
  const SignUpLater({Key? key}) : super(key: key);

  @override
  _SignUpLaterState createState() => _SignUpLaterState();
}

class _SignUpLaterState extends State<SignUpLater> {
  final _formKey = GlobalKey<FormState>();
  String policyHolderID = '';
  String policyHolderName = '';
  String mobile = '';
  String address = '';
  String email = '';
  String drivingLicense = '';
  String dateOfBirth = '';

  DataBaseService dataBaseService = DataBaseService();

  Future<Map<String, dynamic>?> usersSignedUpIndex() async {
    return (await FirebaseFirestore.instance.collection('users-signed-up').
    doc('users').get()).data();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children:  [
              const SizedBox(height: 10,),
              const SizedBox(height: 20,),
              const Text("Please sign up to continue!", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),),
              Container(
                margin: EdgeInsets.all(10),
                child: Card(
                  elevation: 10.0,
                  child: Form(
                  //  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 20.0,),
                        Row(
                          children: [
                            SizedBox(width: 55,),
                            Container(
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                color: onCompany?Colors.blueGrey[50]:mainColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: (){
                                  setState(() {
                                    onCompany = false;
                                  });
                                },
                                child: Text("User",
                                  style: TextStyle(
                                    color: onCompany?Colors.black:Colors.white,
                                    fontSize: 18,
                                  ),),
                              ),
                            ),
                            SizedBox(width: 30,),
                            Container(
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                color: onCompany?mainColor:Colors.blueGrey[50],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: (){
                                  setState(() {
                                    onCompany = true;
                                  });
                                },
                                child: Text("Company",
                                  style: TextStyle(
                                    color: onCompany?Colors.white:Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),

                        Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: onCompany?'Company Name':'Full name',
                                ),
                                validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
                                //obscureText: true,
                                onChanged: (val){
                                  setState(() {
                                    policyHolderName = val;
                                  });
                                },
                              ),
                              SizedBox(height: 20.0,),
                              buildDateRow(),
                              buildSizedBox(),
                              buildNationalId(),
                              buildSizedBox(),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Mobile',
                                ),
                                validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
                                // obscureText: true,
                                onChanged: (val){
                                  setState(() {
                                    mobile = val;
                                  });
                                },
                              ),
                              SizedBox(height: 20.0,),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Address',
                                ),
                                validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
                                //obscureText: true,
                                onChanged: (val){
                                  address = val;
                                },
                              ),
                              SizedBox(height: 20.0,),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                ),
                                validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
                                //obscureText: true,
                                onChanged: (val){
                                  email = val;
                                },
                              ),
                              SizedBox(height: 20.0,),
                              buildDrivingLicense(),

                              SizedBox(height: 10,),
                              _buildBeneficiaryRow(),

                              SizedBox(height: 20,),
                              buildAttachId(),
                            ],
                          ),
                        ),



                        SizedBox(height: 50,),

                        FutureBuilder(
                          future: usersSignedUpIndex(),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        //    print(snapshot.connectionState == ConnectionState.done);
                            if (snapshot.connectionState == ConnectionState.done) {
                              if (snapshot.hasError) {
                                return const Center(
                                  child: Text('there is an error'),
                                );
                              }
                              else if(snapshot.hasData){
                                return Container(
                                  width: 250,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: mainColor,
                                  ),
                                  child: TextButton(
                                    onPressed: () async {
                                      FocusScope.of(context).unfocus();
                                      final isValid = _formKey.currentState!.validate();
                                      print(isValid);
                                      if(isValid) {
                                        print("REAACHED");
                                        setState(() {
                                          asGuest = false;
                                          globalPolicyHolderID = policyHolderID;
                                          globalPolicyHolderName = policyHolderName;
                                          globalUserMobile = mobile;
                                          globalUserAddress = address;
                                          globalUserEmail = email;
                                          globalDateOfBirth = dateOfBirth;
                                          globalDrivingLicenseId = drivingLicense;
                                          snapshot.data['total-user-amount'] += 1;
                                          globalCurrentUserLoggedInIndex = snapshot.data['total-user-amount'];
                                        });
                                        await dataBaseService.updateSignedUpUsers(
                                          onCompany,
                                          snapshot.data['total-user-amount'],
                                          globalPolicyHolderName,
                                          globalPolicyHolderID,
                                          globalDateOfBirth,
                                          globalUserEmail,
                                          globalUserPassword,
                                          globalUserMobile,
                                          globalDrivingLicenseId,
                                          globalBeneficiary,
                                        );
                                        Navigator.pushNamed(context, '/userVehicles');
                                      }
                                    },
                                    child: const Text("Sign up",style: TextStyle(
                                      color: Colors.white,
                                    ),),
                                  ),
                                );
                              }
                            }
                            return const Text("Please wait");
                          },

                        ),

                        SizedBox(height: 50,),

                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }


  Widget buildDateRow(){
    if(!onCompany){
      return TextFormField(
        decoration: const InputDecoration(
          hintText: 'Date of Birth',
        ),
        validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
        //obscureText: true,
        onChanged: (val){
          setState(() {
            dateOfBirth = val;
          });
        },
      );
    }
    else{
      return Container(

      );
    }
  }

  Widget buildNationalId(){
    if(!onCompany){
      return TextFormField(
        decoration: const InputDecoration(
          hintText: 'National ID',
        ),
        validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
        //obscureText: true,
        onChanged: (val){
          setState(() {
            policyHolderID = val;
          });
        },
      );
    }
    else{
      return Container();
    }
  }


  Widget buildDrivingLicense(){
    if(!onCompany){
      return TextFormField(
        decoration: InputDecoration(
          hintText: 'Driving license',
        ),
        validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
        //obscureText: true,
        onChanged: (val){
          setState(() {
            drivingLicense = val;
          });
        },
      );
    }
    else{
      return Container();
    }
  }

  Widget buildSizedBox(){
    if(!onCompany){
      return SizedBox(height: 20,);
    }
    else{
      return Container();
    }
  }

  Widget buildAttachId(){
    if(onCompany){
      return Container();
    }
    else{
      return Container(
        height: 100,
        width: 250,
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          border: Border.all(width: 1.0,),
        ),
        child: Center(child: Text("Attach National ID", style: TextStyle(
          fontSize: 20,
        ),)),
      );
    }
  }

  Widget _buildBeneficiaryRow(){
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Beneficiary',
      ),
      validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
      //obscureText: true,
      onChanged: (val){
        setState(() {
          globalBeneficiary = val;
        });
      },
    );
  }


}
