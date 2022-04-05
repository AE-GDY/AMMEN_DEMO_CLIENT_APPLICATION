import 'package:client_application/services/database.dart';
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
  bool secureText = true;
  String userName = "";
  String date = "";
  String iD = "";
  String email = "";
  String password = "";

  bool leftSelected = false;
  var formKey = GlobalKey<FormState>();
  DataBaseService databaseService = DataBaseService();

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
          child:Column(
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
                          Container(
                            height: 100,
                            width: 100,
                            child: Image(image: AssetImage(
                                "${insuranceCompanyImage}"
                            ),
                            ),
                          ),
                          SizedBox(height: 20,),

                          Text("${insuranceCompanyName}", style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                            textAlign: TextAlign.center,),
                          SizedBox(height: 40,),
                          Text("${companyEmails[0]}", style: TextStyle(
                            fontSize: 20,
                          ),
                            textAlign: TextAlign.end,
                          ),
                          SizedBox(height: 20,),
                          Text("رقم الهاتف:${companyNumbers[0]}", style: TextStyle(
                            fontSize: 20,
                          ),
                            textAlign: TextAlign.end,
                          ),
                          SizedBox(height: 20,),
                          Text("رمز البريدي:${companyIds[0]}", style: TextStyle(
                            fontSize: 20,
                          ),
                            textAlign: TextAlign.end,
                          ),
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
                  child: Text("اختيار", style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),),
                ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}