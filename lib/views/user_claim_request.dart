import 'package:client_application/companies/service_centers.dart';
import 'package:client_application/companies/workshops.dart';
import 'package:client_application/main.dart';
import 'package:client_application/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class UserClaimRequest extends StatefulWidget {
  const UserClaimRequest({Key? key}) : super(key: key);


  @override
  _UserClaimRequestState createState() => _UserClaimRequestState();
}

class _UserClaimRequestState extends State<UserClaimRequest> {

  bool anotherDriver = false;
  bool serviceCenterSelected = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();
  TextEditingController drivingLicenseController = TextEditingController();
  TextEditingController accidentInfoController = TextEditingController();
  TextEditingController accidentLocationController = TextEditingController();

  DataBaseService dataBaseService = DataBaseService();

  String serviceCenter = 'Tobgui Auto Service Center';
  String workShop = 'VAG Egypt Garage';

  Future<Map<String, dynamic>?> usersClaimData() async {
    return (await FirebaseFirestore.instance.collection('users-claim-requests').
    doc('claims').get()).data();
  }

  Future<Map<String, dynamic>?> usersClaimDataUser() async {
    return (await FirebaseFirestore.instance.collection('users-claim-requests').
    doc('claims-user').get()).data();
  }

  Future<Map<String, dynamic>?> centersRequests() async {
    return (await FirebaseFirestore.instance.collection('centers-requests').
    doc('requests').get()).data();
  }

  Future<Map<String, dynamic>?> usersBrokerClaimData() async {
    return (await FirebaseFirestore.instance.collection('users-claim-requests-broker').
    doc('claims').get()).data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Claim Request"),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Container(
          height: 1500,
          child: Column(
            children: [
              /*
              Positioned(
                top: 30,
                left: 100,
                child: Container(
                  height: 180,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text("Vehicle Info", style: TextStyle(
                        fontSize: 20,
                      ),),
                      SizedBox(height: 15,),
                      Text("Vehicle Make: ${globalCurrentClaimRequest
                          .claimRequesterVehicleMake}", style: TextStyle(
                        fontSize: 15,
                      ),),
                      SizedBox(height: 15,),
                      Text("Vehicle Model: ${globalCurrentClaimRequest
                          .claimRequesterVehicleModel}", style: TextStyle(
                        fontSize: 15,
                      ),),
                      SizedBox(height: 15,),
                      Text("Production Year: ${globalCurrentClaimRequest
                          .claimRequesterProductionYear}", style: TextStyle(
                        fontSize: 15,
                      ),),
                      SizedBox(height: 15,),
                      Text("Vehicle License: ${globalCurrentClaimRequest
                          .claimRequesterCarLicenseId}", style: TextStyle(
                        fontSize: 15,
                      ),),
                    ],
                  ),
                ),
              ),
              */
              Container(
                height: 100,
                width: 400,
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    Text("Driver: ",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(width: 10,),
                    Container(
                      width: 140,
                      height: 40,
                      decoration: BoxDecoration(
                        color: anotherDriver?Colors.grey:mainColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            anotherDriver = false;
                          });
                        },
                        child: Text(
                          "Me",style: TextStyle(
                          color: Colors.white,
                        ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 140,
                      height: 40,
                      decoration: BoxDecoration(
                        color: anotherDriver?mainColor:Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            anotherDriver = true;
                          });
                        },
                        child: Text(
                          "Another Driver", style: TextStyle(
                          color: Colors.white,
                        ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.all(10),
                width: 400,
                height: 1200,
                child: Card(
                  elevation: 5.0,
                  child: Container(
                    margin: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Text("Personal Information", style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 10,),
                        TextField(
                          readOnly: !anotherDriver,
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: "Driver Name",
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextField(
                          readOnly: !anotherDriver,
                          controller: dateController,
                          decoration: InputDecoration(
                            labelText: "Date of Birth",
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextField(
                          readOnly: !anotherDriver,
                          controller: nationalIdController,
                          decoration: InputDecoration(
                            labelText: "National ID",
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextField(
                          readOnly: !anotherDriver,
                          controller: drivingLicenseController,
                          decoration: InputDecoration(
                            labelText: "Driving License",
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text("Accident Information", style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 10,),
                        TextField(
                          controller: accidentLocationController,
                          decoration: InputDecoration(
                            labelText: "Accident Location",
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextField(
                          controller: accidentInfoController,
                          decoration: const InputDecoration(
                            labelText: "Accident Description",
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text("Attachments", style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            SizedBox(width: 30,),
                            Container(
                              width: 130,
                              height: 120,
                              decoration: BoxDecoration(
                                //color: Colors.grey[100],
                               // border: Border.all(color: Colors.black,width: 1.0),
                              ),
                              child:  Card(
                                elevation: 10.0,
                                child: Column(
                                  children: [
                                    SizedBox(height: 30,),
                                    Center(child: Text("Vehicle", style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),)),
                                    SizedBox(height: 10,),
                                    Center(child: Text("Attachments", style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),)),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 50,),
                            Container(
                              width: 130,
                              height: 120,
                              decoration: BoxDecoration(
                                //color: Colors.grey[100],
                                //border: Border.all(color: Colors.black,width: 1.0),
                              ),
                              child:  Card(
                                elevation: 10.0,
                                child: Column(
                                  children: [
                                    SizedBox(height: 30,),
                                    Center(child: Text("National", style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),)),
                                    SizedBox(height: 10,),
                                    Center(child: Text("ID", style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            SizedBox(width: 30,),
                            Container(
                              width: 130,
                              height: 120,
                              decoration: BoxDecoration(
                              //  color: Colors.grey[100],
                              //  border: Border.all(color: Colors.black,width: 1.0),
                              ),
                              child:  Card(
                                elevation: 10.0,
                                child: Column(
                                  children: [
                                    SizedBox(height: 30,),
                                    Center(child: Text("Driving", style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),),),
                                    SizedBox(height: 10,),
                                    Center(child: Text("License", style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),)),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 50,),
                            Container(
                              width: 130,
                              height: 120,
                              decoration: BoxDecoration(
                               // color: Colors.grey[100],
                                //border: Border.all(color: Colors.black,width: 1.0),
                              ),
                              child:  Card(
                                elevation: 10.0,
                                child: Column(
                                  children: [
                                    SizedBox(height: 30,),
                                    Center(child: Text("Police", style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),)),
                                    SizedBox(height: 10,),
                                    Center(child: Text("Report", style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 40,),
                        Text("Fixing Place:", style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            SizedBox(width: 10,),
                            Container(
                              width: 170,
                              height: 40,
                              decoration: BoxDecoration(
                                color: serviceCenterSelected?mainColor:Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    serviceCenterSelected = true;

                                  });
                                },
                                child: Text("Service Center", style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                            ),
                            SizedBox(width: 15,),
                            Container(
                              width: 170,
                              height: 40,
                              decoration: BoxDecoration(
                                color: serviceCenterSelected?Colors.grey:mainColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:  TextButton(
                                onPressed: () {
                                  setState(() {
                                    serviceCenterSelected = false;
                                  });
                                },
                                child: Text("Authorized Workshop", style: TextStyle(
                                  color: Colors.white,
                                )),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 30,),

                        _buildDropDownButton(),
                        SizedBox(height: 30,),
                        FutureBuilder(
                          future: Future.wait([globalCurrentClaimRequest.brokerRegistered?usersBrokerClaimData():usersClaimData(),centersRequests(),usersClaimDataUser()]),

                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if(snapshot.connectionState == ConnectionState.done){
                              if(snapshot.hasError){
                                return const Text("There is an error");
                              }
                              else if(snapshot.hasData){
                                return TextButton(
                                  onPressed: () async {

                                    Navigator.pushNamed(context, '/home');
                                    setState((){
                                      snapshot.data[0][globalCurrentClaimRequest.intendedInsuranceCompany]['total-claim-amount']++;
                                    });
                                    await dataBaseService.updateClaimsRequestsData(
                                      snapshot.data[2]['total-claim-amount']+1,
                                      nationalIdController.text,
                                      drivingLicenseController.text,
                                      anotherDriver,
                                      nameController.text,
                                      globalCurrentClaimRequest,
                                      snapshot.data[0][globalCurrentClaimRequest.intendedInsuranceCompany]['total-claim-amount'],
                                      globalDateOfBirth,
                                      accidentLocationController.text,
                                      accidentInfoController.text,
                                      serviceCenterSelected? serviceCenter:workShop,
                                    );

                                    await dataBaseService.updateServiceClaimsRequestsData(
                                      snapshot.data[2]['total-claim-amount']+1,
                                      snapshot.data[1][serviceCenterSelected?serviceCenter:workShop]['total-requests']+1,
                                      nationalIdController.text,
                                      drivingLicenseController.text,
                                      anotherDriver,
                                      nameController.text,
                                      globalCurrentClaimRequest,
                                      snapshot.data[0][globalCurrentClaimRequest.intendedInsuranceCompany]['total-claim-amount'],
                                      globalDateOfBirth,
                                      accidentLocationController.text,
                                      accidentInfoController.text,
                                      serviceCenterSelected?serviceCenter:workShop,
                                    );

                                    await dataBaseService.updateClaimsRequestsDataUser(
                                      snapshot.data[2]['total-claim-amount']+1,
                                      nationalIdController.text,
                                      drivingLicenseController.text,
                                      anotherDriver,
                                      nameController.text,
                                      globalCurrentClaimRequest,
                                      snapshot.data[0][globalCurrentClaimRequest.intendedInsuranceCompany]['total-claim-amount'],
                                      globalDateOfBirth,
                                      accidentLocationController.text,
                                      accidentInfoController.text,
                                      serviceCenterSelected?serviceCenter:workShop,
                                    );
                                  },
                                  child: Container(
                                    width: 250,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text("Request Claim", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),),
                                    ),
                                  ),
                                );
                              }
                            }
                            return const Text("Please wait");
                          },

                        ),

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
  Widget _buildDropDownButton() {
    if(serviceCenterSelected == true){
        return Container(
          height: 30,
          width: 350,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
          ),
          child: Center(
            child: DropdownButton<String>(
              value: serviceCenter,
              items: serviceCenters.map(buildMenuItem).toList(),
              onChanged: (value){
                setState(() {
                  serviceCenter = value!;
                });
              },
            ),
          ),
        );
    }
    else{
      return Container(
        height: 30,
        width: 350,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: DropdownButton<String>(
            value: workShop,
            items: workshops.map(buildMenuItem).toList(),
            onChanged: (value){
              setState(() {
                workShop = value!;
              });
            },
          ),
        ),
      );
    }

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