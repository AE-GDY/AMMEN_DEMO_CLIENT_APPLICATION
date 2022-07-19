import 'package:client_application/services/database.dart';
import 'package:client_application/services/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:client_application/companies/first.dart';
import 'package:client_application/companies/second.dart';
import 'package:client_application/constants.dart';


class CompanyDetails extends StatefulWidget {
  const CompanyDetails({Key? key}) : super(key: key);

  @override
  _CompanyDetailsState createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {

  Storage _storage = Storage();

  bool secureText = true;
  String userName = "";
  String date = "";
  String iD = "";
  String email = "";
  String password = "";

  bool leftSelected = false;
  var formKey = GlobalKey<FormState>();
  DataBaseService databaseService = DataBaseService();


  Future<Map<String, dynamic>?> insuranceCompanies() async {
    return (await FirebaseFirestore.instance.collection('insurance-companies').
    doc('insurance-company-list').get()).data();
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Text(
            'الموقع الاول لمقارنه اسعار التامين في مصر',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }



  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                      ),
                    ),
                  ],
                ),
                //_buildOrRow(),
                // _buildSocialBtnRow(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          //  automaticallyImplyLeading: false,
          backgroundColor: mainColor,
          centerTitle: true,
          title: Container(
            width: globalWidth,
            height: globalWidth,
            child: Image(
              image: AssetImage('assets/logofinal.PNG'),
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: mainColor,//0xfff2f3f7
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: insuranceCompanies(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasError){
                  return const Text("There is an error");
                }
                else if(snapshot.hasData){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            height: MediaQuery.of(context).size.height * 0.75,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: const Radius.circular(10),
                                  bottomRight: const Radius.circular(10),
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 20,),
                                  Positioned(
                                    right: 20,
                                    top: 20,
                                    child: FutureBuilder(
                                      future: _storage.getImage('insurance_companies','$globalCurrentInsuranceCompany.png'),
                                      builder:  (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                                        if(snapshot.connectionState == ConnectionState.done){
                                          if(snapshot.hasError){
                                            return const Text("There is an error");
                                          }
                                          else if(snapshot.hasData){
                                            return Container(
                                                width: (globalCurrentInsuranceCompany == 0 || globalCurrentInsuranceCompany == 2)?70:(globalCurrentInsuranceCompany == 1)?80:100,
                                                height: (globalCurrentInsuranceCompany == 0 || globalCurrentInsuranceCompany == 2)?70:(globalCurrentInsuranceCompany == 1)?80:100,
                                                child: Image.network(snapshot.data, fit: BoxFit.cover,)
                                            );
                                          }
                                        }
                                        return const Text("Please wait");
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 20,),

                                  Text(insuranceCompanyName, style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                    textAlign: TextAlign.center,),
                                  const SizedBox(height: 40,),
                                  Text("Email: ${snapshot.data['$globalCurrentInsuranceCompany']['company-email']}", style: TextStyle(
                                    fontSize: 20,
                                  ),
                                    textAlign: TextAlign.end,
                                  ),
                                  const SizedBox(height: 20,),
                                  Text("Phone number: ${snapshot.data['$globalCurrentInsuranceCompany']['company-phone']}", style: TextStyle(
                                    fontSize: 20,
                                  ),
                                    textAlign: TextAlign.end,
                                  ),

                                  FutureBuilder(
                                    future: insuranceCompanies(),
                                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                      if(snapshot.connectionState == ConnectionState.done){
                                        if(snapshot.hasError){
                                          return const Text("There is an error");
                                        }
                                        else if(snapshot.hasData){
                                          return Column(
                                            children: [
                                              SizedBox(height: 10,),
                                              Text("Coverage Types",style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),),
                                              SizedBox(height: 10,),
                                              Center(
                                                child: Container(
                                                  height: 160,
                                                  child: ListView.builder(
                                                      itemCount: snapshot.data['$globalCurrentInsuranceCompany']['coverage-types-amount'],
                                                      itemBuilder: (context,index){
                                                        return Center(child: Container(margin:EdgeInsets.all(10),child: Text("${snapshot.data['$globalCurrentInsuranceCompany']['coverage-types'][index]}")));
                                                      }
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                      }
                                      return const Text("Please wait");
                                    },

                                  ),


                                  SizedBox(height: 20,),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green[500],
                        ),
                        child: TextButton(
                          // REMEMBER HERE
                          onPressed: () async {
                            setState(() {
                              globalIntendedInsuranceCompany = insuranceCompanyName;
                              fromHome = false;
                            });
                            await databaseService.updateData(insuranceCompanyName);
                            if(asGuest == false){
                              Navigator.pushNamed(context, '/userVehicles');
                            }
                            else{
                              print("SIGN UP LATER");
                              Navigator.pushNamed(context, '/signUpLater');
                            }
                          },
                          child: Text("Continue", style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),),
                        ),
                      ),
                      SizedBox(height: 20,),
                    ],
                  );
                }
              }
              return const Text("Please wait");
            },

          ),
        ),
      ),
    );
  }
}