import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:client_application/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Complains extends StatefulWidget {
  const Complains({Key? key}) : super(key: key);

  @override
  _ComplainsState createState() => _ComplainsState();
}

class _ComplainsState extends State<Complains> {

  String selectedCompany = 'المجموعة العربية المصرية للتأمين';
  String complain = '';

  DataBaseService dataBaseService = DataBaseService();


  List<String> companyList = insuranceCompanyList;
  bool insuranceSelected = true;

  Future<Map<String, dynamic>?> usersComplains() async {
    return (await FirebaseFirestore.instance.collection('user-complains').
    doc('complains').get()).data();
  }

  Future<Map<String, dynamic>?> usersSignedUp() async {
    return (await FirebaseFirestore.instance.collection('users-signed-up').
    doc('users').get()).data();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complains"),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40,),
              Row(
                children: [
                  SizedBox(width: 40,),
                  Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                      color: insuranceSelected?Colors.blue:Colors.blueGrey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          insuranceSelected = true;
                          selectedCompany = 'المجموعة العربية المصرية للتأمين';
                          companyList = insuranceCompanyList;
                        });
                      },
                      child: Text("Insurance Company", style: TextStyle(
                        color: insuranceSelected?Colors.white:Colors.black,
                      ),),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                      color: insuranceSelected?Colors.blueGrey[100]:Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          insuranceSelected = false;
                          selectedCompany = 'Deraya Insurance Brokerage';
                          companyList = brokerCompanyList;
                        });
                      },
                      child: Text("Broker Company",style: TextStyle(
                        color: insuranceSelected?Colors.black:Colors.white,
                      ),),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Text(insuranceSelected?"Select Insurance Company":"Select Broker Company", style: TextStyle(
                fontSize: 18,
              ),),
              SizedBox(height: 20,),
              buildDropDownMenu(companyList, selectedCompany),
              SizedBox(height: 30,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.0),
                ),
                child: TextFormField(
                  minLines: 5,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: 'Enter your complain here',
                  ),
                  validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
                  //obscureText: true,
                  onChanged: (val){
                    complain = val;
                  },
                ),
              ),
              SizedBox(height: 180,),
              FutureBuilder(
                future: Future.wait([usersComplains(), usersSignedUp()]),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){
                      return const Text("There is an error");
                    }
                    else if(snapshot.hasData){
                      return Container(
                        width: 180,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            await dataBaseService.updateUserComplains(
                                snapshot.data[0][selectedCompany]['total-complains']+1,
                                false,
                                selectedCompany,
                                snapshot.data[0][selectedCompany]['total-complains']+1,
                                complain,
                                globalCurrentUserLoggedInIndex,
                                snapshot.data[1]['$globalCurrentUserLoggedInIndex']['notification-amount']+1,
                            );

                            Navigator.pushNamed(context, '/home');
                          },
                          child: Text("Send Complain", style: TextStyle(
                            color: Colors.white,
                          ),),
                        ),
                      );
                    }
                  }
                  return const Text("");
                },

              ),


            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropDownMenu(List<String> companyList, String selected){
    return Container(
      height: 30,
      width: 350,
      //margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black),
      ),
      child: Center(
        child: DropdownButton<String>(
          value: selected,
          items: companyList.map(buildMenuItem).toList(),
          onChanged: (value){
            setState(() {
              selected = value!;
              selectedCompany = selected;
            });
          },
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Center(
      child: Text(
        item,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
          fontSize: 15,
        ),
      ),
    ),
  );

}
