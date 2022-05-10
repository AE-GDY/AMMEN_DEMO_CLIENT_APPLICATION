import 'package:client_application/constants.dart';
import 'package:client_application/services/database.dart';
import 'package:client_application/widgets/user_vehicle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PendingPolicies extends StatefulWidget {
  const PendingPolicies({Key? key}) : super(key: key);

  @override
  _PendingPoliciesState createState() => _PendingPoliciesState();
}

class _PendingPoliciesState extends State<PendingPolicies> {

  Future<Map<String, dynamic>?> policyApprovalData() async {
    return (await FirebaseFirestore.instance.collection('users-policy-approvals').
    doc('approvals').get()).data();
  }

  Future<Map<String, dynamic>?> policyRequestsData(String companyName) async {
    return (await FirebaseFirestore.instance.collection('users-policy-requests').
    doc(companyName).get()).data();
  }

  Future<Map<String, dynamic>?> requestsDocPolicyRequestsData() async {
    return (await FirebaseFirestore.instance.collection('users-policy-requests').
    doc("requests").get()).data();
  }

  Future<Map<String, dynamic>?> brokerPolicyRequestsData(String brokerName) async {
    return (await FirebaseFirestore.instance.collection('users-policy-requests-broker').
    doc(brokerName).get()).data();
  }


  String currentCompany = "none";
  String currentBrokerComp = "none";
  DataBaseService dataBaseService = DataBaseService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Pending Policies"),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: Container(
          height: 1300,
              child:FutureBuilder(
                    future: Future.wait([requestsDocPolicyRequestsData(),policyApprovalData(),policyRequestsData(currentCompany),brokerPolicyRequestsData(currentBrokerComp)]),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                      if (snapshot.connectionState == ConnectionState.done){
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('there is an error 1'),
                          );
                        }
                        else if(snapshot.hasData){
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data[0]['total-policy-amount']+1,
                            itemBuilder: (context,index){
                              print(globalPolicyHolderName);
                              if(snapshot.data[0]['$index']['policy-holder-name'] == globalPolicyHolderName
                             && snapshot.data[0]['$index']['status-user-purchased'] == false){



                                if(snapshot.data[0]['$index']['status-scheduling'] == true){
                                  String currentInsuranceCompany = "";
                                  String currentBroker = "";

                                  if(snapshot.data[0]['$index']['broker-name'] != "none"){
                                    currentBroker = snapshot.data[0]['$index']['broker-name'];
                                  }


                                  if(snapshot.data[0]['$index']['intended-company'] != "none"){
                                    currentInsuranceCompany = snapshot.data[0]['$index']['intended-company'];
                                  }

                                  return Container(
                                    height: 200,
                                    margin: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      //color: Colors.grey[200],
                                    ),
                                    child: Card(
                                      elevation: 10.0,
                                      child: Stack(
                                        children: [
                                          buildVehicleMake(
                                              snapshot.data[0]['$index']['vehicle-amount'],
                                              snapshot.data[0]['$index']['vehicle-make'],
                                              snapshot.data[0]['$index']['vehicle-model'],
                                          ),

                                          buildViewVehicles(snapshot.data[0]['$index']['vehicle-amount'], snapshot,index),

                                          Positioned(
                                            top: 30,
                                            left: 250,
                                            child: Column(
                                              children: [
                                                Positioned(
                                                  top: 20,
                                                  left: 250,
                                                  child: Text("Status:",
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight: FontWeight.bold,
                                                    ),),
                                                ),
                                                Positioned(
                                                  top: 50,
                                                  left: 250,
                                                  child: Text("Scheduling",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                    ),),
                                                ),

                                        ],
                                      ),
                                  ),
                                          Positioned(
                                            top: 120,
                                            left: 20,
                                            child: Text(currentBroker,style: TextStyle(
                                              fontSize: 20,
                                              //fontWeight: FontWeight.bold,
                                            ),),
                                          ),

                                          Positioned(
                                            top: 90,
                                            left: 20,
                                            child: Text(currentInsuranceCompany,style: TextStyle(
                                              fontSize: 18,
                                              //fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                      ],
                                  ),
                                    ),
                              );
                                }
                                else if(snapshot.data[0]['$index']['status-waiting-broker-schedule-approval'] == true){

                                  String currentInsuranceCompany = "";
                                  String currentBroker = "";

                                  if(snapshot.data[0]['$index']['broker-name'] != "none"){
                                    currentBroker = snapshot.data[0]['$index']['broker-name'];
                                  }


                                  if(snapshot.data[0]['$index']['intended-company'] != "none"){
                                    currentInsuranceCompany = snapshot.data[0]['$index']['intended-company'];
                                  }


                                  return Container(
                                    height: 200,
                                    margin: EdgeInsets.all(30),
                                    decoration: BoxDecoration(
                                     // color: Colors.grey[200],
                                    ),
                                    child: Card(
                                      elevation: 10.0,
                                      child: Stack(
                                        children: [
                                          buildVehicleMake(snapshot.data[0]['$index']['vehicle-amount'],
                                            snapshot.data[0]['$index']['vehicle-make'],
                                            snapshot.data[0]['$index']['vehicle-model'],
                                          ),
                                          buildViewVehicles(snapshot.data[0]['$index']['vehicle-amount'], snapshot,index),

                                          Positioned(
                                            top: 10,
                                            left: 200,
                                            child: Text("Pending broker",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),
                                          Positioned(
                                            top: 30,
                                            left: 190,
                                            child: Text("Schedule approval",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),
                                          Positioned(
                                            top: 60,
                                            left: 200,
                                            child: Text("Time: ${snapshot.data[0]['$index']['time-scheduled']}",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),

                                          Positioned(
                                            top: 80,
                                            left: 200,
                                            child: Text("Date: ${snapshot.data[0]['$index']['day-scheduled']}/"
                                                "${snapshot.data[0]['$index']['month-scheduled']}/${snapshot.data[0]['$index']['year-scheduled']}",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),
                                          Positioned(
                                            top: 110,
                                            left: 20,
                                            child: Text(currentBroker,style: TextStyle(
                                              fontSize: 20,
                                              //fontWeight: FontWeight.bold,
                                            ),),
                                          ),

                                          Positioned(
                                            top: 80,
                                            left: 20,
                                            child: Text(currentInsuranceCompany,style: TextStyle(
                                              fontSize: 18,
                                              //fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                          Positioned(
                                            top: 138,
                                            left: 110,
                                            child: Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: snapshot.data[0]['$index']['is-broker'] != true?Colors.blue:Colors.transparent,
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  width: 100,
                                                  height: 40,
                                                  child: TextButton(
                                                    onPressed: () async {
                                                      if(snapshot.data[0]['$index']['is-broker'] != true){

                                                        setState(() {
                                                          currentCompany = snapshot.data[0]['$index']['intended-company'];
                                                        });

                                                        await dataBaseService.requestsDocUpdateUserApprovalToInspection(index);
                                                        await dataBaseService.updateUserApprovalToInspection(
                                                            snapshot.data[0]['$index']['global-comp'],
                                                            snapshot.data[0]['$index']['policy-idx'],
                                                            snapshot.data[0]['$index']['sign-in-as-broker']
                                                        );

                                                        await dataBaseService.updateNewRequestsData(
                                                          snapshot.data[0]['$index']['global-comp'],
                                                          snapshot.data[2]['total-new-requests']-1,
                                                        );

                                                        Navigator.pushNamed(context, '/home');
                                                      }
                                                    },
                                                    child: Text("Confirm", style: TextStyle(
                                                      color: snapshot.data[0]['$index']['is-broker'] != true?Colors.white:Colors.transparent,
                                                    ),),
                                                  ),
                                                ),
                                                const SizedBox(width: 20,),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: snapshot.data[0]['$index']['is-broker'] != true?Colors.blue:Colors.transparent,
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  width: 100,
                                                  height: 40,
                                                  child: TextButton(
                                                    onPressed: () async {

                                                      if(snapshot.data[0]['$index']['is-broker'] != true){
                                                        await dataBaseService.requestsDocUpdateUserApprovalToScheduling(index);
                                                        await dataBaseService.updateUserApprovalToScheduling(
                                                            snapshot.data[0]['$index']['global-comp'],
                                                            snapshot.data[0]['$index']['policy-idx'],
                                                            snapshot.data[0]['$index']['sign-in-as-broker']
                                                        );
                                                        Navigator.pushNamed(context, '/home');
                                                      }
                                                    },
                                                    child: Text("Deny", style: TextStyle(
                                                      color: snapshot.data[0]['$index']['is-broker'] != true?Colors.white:Colors.transparent,
                                                    ),),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                else if(snapshot.data[0]['$index']['status-waiting-user-schedule-approval'] == true){

                                  String currentInsuranceCompany = "";
                                  String currentBroker = "";

                                  if(snapshot.data[0]['$index']['broker-name'] != "none"){
                                    currentBroker = snapshot.data[0]['$index']['broker-name'];
                                  }


                                  if(snapshot.data[0]['$index']['intended-company'] != "none"){
                                    currentInsuranceCompany = snapshot.data[0]['$index']['intended-company'];
                                  }


                                  return Container(
                                    height: 200,
                                    margin: EdgeInsets.all(30),
                                    decoration: BoxDecoration(
                                     // color: Colors.grey[200],
                                    ),
                                    child: Card(
                                      elevation: 10.0,
                                      child: Stack(
                                        children: [
                                          buildVehicleMake(snapshot.data[0]['$index']['vehicle-amount'],
                                              snapshot.data[0]['$index']['vehicle-make'],
                                              snapshot.data[0]['$index']['vehicle-model'],
                                       ),
                                          buildViewVehicles(snapshot.data[0]['$index']['vehicle-amount'], snapshot,index),

                                          Positioned(
                                            top: 10,
                                            left: 200,
                                            child: Text("Date Scheduled:",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),
                                          Positioned(
                                            top: 30,
                                            left: 200,
                                            child: Text("Time: ${snapshot.data[0]['$index']['time-scheduled']}",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),
                                          buildViewVehicles(snapshot.data[0]['$index']['vehicle-amount'],snapshot, index),
                                          Positioned(
                                            top: 50,
                                            left: 200,
                                            child: Text("Date: ${snapshot.data[0]['$index']['day-scheduled']}/"
                                                "${snapshot.data[0]['$index']['month-scheduled']}/${snapshot.data[0]['$index']['year-scheduled']}",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),
                                          Positioned(
                                            top: 110,
                                            left: 20,
                                            child: Text(currentBroker,style: TextStyle(
                                              fontSize: 20,
                                              //fontWeight: FontWeight.bold,
                                            ),),
                                          ),

                                          Positioned(
                                            top: 80,
                                            left: 20,
                                            child: Text(currentInsuranceCompany,style: TextStyle(
                                              fontSize: 18,
                                              //fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                          Positioned(
                                            top: 138,
                                            left: 110,
                                            child: Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  width: 100,
                                                  height: 40,
                                                  child: TextButton(
                                                    onPressed: () async {

                                                      setState(() {
                                                        currentCompany = snapshot.data[0]['$index']['intended-company'];
                                                      });

                                                      await dataBaseService.requestsDocUpdateUserApprovalToInspection(index);
                                                      await dataBaseService.updateUserApprovalToInspection(
                                                          snapshot.data[0]['$index']['global-comp'],
                                                          snapshot.data[0]['$index']['policy-idx'],
                                                          snapshot.data[0]['$index']['sign-in-as-broker']
                                                      );

                                                      await dataBaseService.updateNewRequestsData(
                                                        snapshot.data[0]['$index']['global-comp'],
                                                        snapshot.data[2]['total-new-requests']-1,
                                                      );

                                                      Navigator.pushNamed(context, '/home');

                                                    },
                                                    child: Text("Confirm", style: TextStyle(
                                                      color: Colors.white,
                                                    ),),
                                                  ),
                                                ),
                                                const SizedBox(width: 20,),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  width: 100,
                                                  height: 40,
                                                  child: TextButton(
                                                    onPressed: () async {

                                                      await dataBaseService.requestsDocUpdateUserApprovalToScheduling(index);
                                                      await dataBaseService.updateUserApprovalToScheduling(
                                                          snapshot.data[0]['$index']['global-comp'],
                                                          snapshot.data[0]['$index']['policy-idx'],
                                                          snapshot.data[0]['$index']['sign-in-as-broker']
                                                      );
                                                      Navigator.pushNamed(context, '/home');
                                                    },
                                                    child: Text("Deny", style: TextStyle(
                                                      color: Colors.white,
                                                    ),),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                else if(snapshot.data[0]['$index']['status-waiting-broker-inspection-approval'] == true){

                                  String currentInsuranceCompany = "";
                                  String currentBroker = "";

                                  if(snapshot.data[0]['$index']['broker-name'] != "none"){
                                    currentBroker = snapshot.data[0]['$index']['broker-name'];
                                  }


                                  if(snapshot.data[0]['$index']['intended-company'] != "none"){
                                    currentInsuranceCompany = snapshot.data[0]['$index']['intended-company'];
                                  }


                                  return Container(
                                    height: 200,
                                    margin: EdgeInsets.all(30),
                                    decoration: BoxDecoration(
                                    //  color: Colors.grey[200],
                                    ),
                                    child: Card(
                                      elevation: 10.0,
                                      child: Stack(
                                        children: [
                                          buildVehicleMake(snapshot.data[0]['$index']['vehicle-amount'],
                                            snapshot.data[0]['$index']['vehicle-make'],
                                            snapshot.data[0]['$index']['vehicle-model'],
                                          ),
                                          buildViewVehicles(snapshot.data[0]['$index']['vehicle-amount'], snapshot,index),

                                          Positioned(
                                            top: 10,
                                            left: 160,
                                            child: Text("Pending Inspection",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),
                                          Positioned(
                                            top: 30,
                                            left: 160,
                                            child: Text("Approval from Broker",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),
                                          buildViewVehicles(snapshot.data[0]['$index']['vehicle-amount'],snapshot, index),
                                          Positioned(
                                            top: 110,
                                            left: 20,
                                            child: Text(currentBroker,style: TextStyle(
                                              fontSize: 20,
                                              //fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                          Positioned(
                                            top: 80,
                                            left: 20,
                                            child: Text(currentInsuranceCompany,style: TextStyle(
                                              fontSize: 18,
                                              //fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                else if(snapshot.data[0]['$index']['status-waiting-broker-underwriting-approval'] == true){

                                  String currentInsuranceCompany = "";
                                  String currentBroker = "";

                                  if(snapshot.data[0]['$index']['broker-name'] != "none"){
                                    currentBroker = snapshot.data[0]['$index']['broker-name'];
                                  }


                                  if(snapshot.data[0]['$index']['intended-company'] != "none"){
                                    currentInsuranceCompany = snapshot.data[0]['$index']['intended-company'];
                                  }


                                  return Container(
                                    height: 200,
                                    margin: EdgeInsets.all(30),
                                    decoration: BoxDecoration(
                                    //  color: Colors.grey[200],
                                    ),
                                    child: Card(
                                      elevation: 10.0,
                                      child: Stack(
                                        children: [
                                          buildVehicleMake(snapshot.data[0]['$index']['vehicle-amount'],
                                            snapshot.data[0]['$index']['vehicle-make'],
                                            snapshot.data[0]['$index']['vehicle-model'],
                                          ),
                                          buildViewVehicles(snapshot.data[0]['$index']['vehicle-amount'], snapshot,index),

                                          Positioned(
                                            top: 20,
                                            left: 150,
                                            child: Text("Pending Underwriting",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),
                                          Positioned(
                                            top: 40,
                                            left: 150,
                                            child: Text("Approval from Broker",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),
                                          buildViewVehicles(snapshot.data[0]['$index']['vehicle-amount'],snapshot, index),
                                          Positioned(
                                            top: 120,
                                            left: 20,
                                            child: Text(currentBroker,style: TextStyle(
                                              fontSize: 20,
                                              //fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                          Positioned(
                                            top: 90,
                                            left: 20,
                                            child: Text(currentInsuranceCompany,style: TextStyle(
                                              fontSize: 18,
                                              //fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                else if(snapshot.data[0]['$index']['status-inspection'] == true){
                                  String currentInsuranceCompany = "";
                                  String currentBroker = "";

                                  if(snapshot.data[0]['$index']['broker-name'] != "none"){
                                    currentBroker = snapshot.data[0]['$index']['broker-name'];
                                  }


                                  if(snapshot.data[0]['$index']['intended-company'] != "none"){
                                    currentInsuranceCompany = snapshot.data[0]['$index']['intended-company'];
                                  }
                                  return Container(
                                    height: 200,
                                    margin: EdgeInsets.all(30),
                                    decoration: BoxDecoration(
                                     // color: Colors.grey[200],
                                    ),
                                    child: Card(
                                      elevation: 10.0,
                                      child: Stack(
                                        children: [
                                          buildVehicleMake(snapshot.data[0]['$index']['vehicle-amount'],
                                              snapshot.data[0]['$index']['vehicle-make'],
                                              snapshot.data[0]['$index']['vehicle-model'],
                                              ),
                                          Positioned(
                                            top: 110,
                                            left: 20,
                                            child: Text(currentBroker,style: TextStyle(
                                              fontSize: 20,
                                              //fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                          buildViewVehicles(snapshot.data[0]['$index']['vehicle-amount'],snapshot, index),

                                          Positioned(
                                            top: 80,
                                            left: 20,
                                            child: Text(currentInsuranceCompany,style: TextStyle(
                                              fontSize: 18,
                                              //fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                          Positioned(
                                            top: 20,
                                            left: 260,
                                            child: Text("Status:",
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),
                                          Positioned(
                                            top: 50,
                                            left: 250,
                                            child: Text("Inspection",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                else if(snapshot.data[0]['$index']['status-underwriting'] == true){
                                  String currentInsuranceCompany = "";
                                  String currentBroker = "";

                                  if(snapshot.data[0]['$index']['broker-name'] != "none"){
                                    currentBroker = snapshot.data[0]['$index']['broker-name'];
                                  }


                                  if(snapshot.data[0]['$index']['intended-company'] != "none"){
                                    currentInsuranceCompany = snapshot.data[0]['$index']['intended-company'];
                                  }
                                  return Container(
                                    height: 200,
                                    margin: EdgeInsets.all(30),
                                    decoration: BoxDecoration(
                                  //    color: Colors.grey[200],
                                    ),
                                    child: Card(
                                      elevation: 10.0,
                                      child: Stack(
                                        children: [
                                          buildVehicleMake(snapshot.data[0]['$index']['vehicle-amount'],
                                              snapshot.data[0]['$index']['vehicle-make'],
                                              snapshot.data[0]['$index']['vehicle-model'],
                                           ),
                                          Positioned(
                                            top: 110,
                                            left: 20,
                                            child: Text(currentBroker,style: TextStyle(
                                              fontSize: 20,
                                              //fontWeight: FontWeight.bold,
                                            ),),
                                          ),

                                          buildViewVehicles(snapshot.data[0]['$index']['vehicle-amount'],snapshot, index),
                                          Positioned(
                                            top: 80,
                                            left: 20,
                                            child: Text(currentInsuranceCompany,style: TextStyle(
                                              fontSize: 18,
                                              //fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                          Positioned(
                                            top: 20,
                                            left: 240,
                                            child: Text("Status:",
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),
                                          Positioned(
                                            top: 50,
                                            left: 220,
                                            child: Text("Underwriting",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),

                                        ],
                                      ),
                                    ),
                                  );
                                }
                                else if(snapshot.data[0]['$index']['status-waiting-ic-approval'] == true){
                                  String currentInsuranceCompany = "";
                                  String currentBroker = "";

                                  if(snapshot.data[0]['$index']['broker-name'] != "none"){
                                    currentBroker = snapshot.data[0]['$index']['broker-name'];
                                  }


                                  if(snapshot.data[0]['$index']['intended-company'] != "none"){
                                    currentInsuranceCompany = snapshot.data[0]['$index']['intended-company'];
                                  }
                                  return Container(
                                    height: 200,
                                    margin: EdgeInsets.all(30),
                                    decoration: BoxDecoration(
                                      //color: Colors.grey[200],
                                    ),
                                    child: Card(
                                      elevation: 10.0,
                                      child: Stack(
                                        children: [
                                          buildVehicleMake(snapshot.data[0]['$index']['vehicle-amount'],
                                              snapshot.data[0]['$index']['vehicle-make'],
                                              snapshot.data[0]['$index']['vehicle-model'],
                                         ),
                                          Positioned(
                                            top: 110,
                                            left: 20,
                                            child: Text(currentBroker,style: TextStyle(
                                              fontSize: 20,
                                              //fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                          buildViewVehicles(snapshot.data[0]['$index']['vehicle-amount'],snapshot, index),

                                          Positioned(
                                            top: 80,
                                            left: 20,
                                            child: Text(currentInsuranceCompany,style: TextStyle(
                                              fontSize: 18,
                                              //fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                          Positioned(
                                            top: 10,
                                            left: 220,
                                            child: Text("Status:",
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),
                                          Positioned(
                                            top: 40,
                                            left: 220,
                                            child: Text("Pending",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),
                                          Positioned(
                                            top: 60,
                                            left: 220,
                                            child: Text("IC Approval",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                else if(snapshot.data[0]['$index']['status-ic-approved'] == true){
                                  String currentInsuranceCompany = "";
                                  String currentBroker = "";

                                  if(snapshot.data[0]['$index']['broker-name'] != "none"){
                                    currentBroker = snapshot.data[0]['$index']['broker-name'];
                                  }


                                  if(snapshot.data[0]['$index']['intended-company'] != "none"){
                                    currentInsuranceCompany = snapshot.data[0]['$index']['intended-company'];
                                  }
                                  return Container(
                                    height: 240,
                                    margin: EdgeInsets.all(30),
                                    decoration: BoxDecoration(

                                    ),
                                    child: Card(
                                      elevation: 10.0,
                                      child: Stack(
                                        children: [
                                          buildVehicleMake(snapshot.data[0]['$index']['vehicle-amount'],
                                          snapshot.data[0]['$index']['vehicle-make'],
                                          snapshot.data[0]['$index']['vehicle-model'],
                                       ),
                                          Positioned(
                                            top: 110,
                                            left: 20,
                                            child: Text(currentBroker,style: TextStyle(
                                              fontSize: 20,
                                              //fontWeight: FontWeight.bold,
                                            ),),
                                          ),

                                          Positioned(
                                            top: 80,
                                            left: 20,
                                            child: Text(currentInsuranceCompany,style: TextStyle(
                                              fontSize: 18,
                                              //fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                          buildViewVehicles(snapshot.data[0]['$index']['vehicle-amount'],snapshot, index),
                                          Positioned(
                                            top: 30,
                                            left: 220,
                                            child: Text("${snapshot.data[0]['$index']['policy-amount']} EGP",
                                              style: TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),
                                          Positioned(
                                            top: 60,
                                            left: 180,
                                            child: Container(
                                              width: 150,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: TextButton(
                                                onPressed: (){
                                                  if(snapshot.data[0]['$index']['vehicle-amount'] > 0){
                                                    pendingVehicles.clear();
                                                    int vehicleIdx = 0;
                                                    while(vehicleIdx < snapshot.data[0]['$index']['vehicle-amount']){
                                                      UserVehicleWidget pendingVehicle = UserVehicleWidget(
                                                          vehicleInsuranceCompany: "",
                                                          vehicleMake: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-make']!.toString(),
                                                          vehicleModel: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-model']!.toString(),
                                                          productionYear: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-production-year']!.toString(),
                                                          vehicleValue: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-value']!.toString(),
                                                          vehicleLicenseId: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-driving-license']!.toString(),
                                                          isActive: false,
                                                          currentIndex: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-index']!,
                                                          vehicleChassisNumber: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-chassis-number']!.toString(),
                                                          vehicleMotorNumber: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-motor-number']!.toString(),
                                                          vehiclePlateNumber: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-plate-number']!.toString(),
                                                        vehicleType: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-type']!.toString(),
                                                        vehicleWeight: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-weight']!.toString(),
                                                        vehicleNumberOfSeats: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['no-seats']!.toString(),
                                                      );

                                                      pendingVehicles.add(pendingVehicle);

                                                      vehicleIdx++;
                                                    }
                                                  }
                                                  else{
                                                    draftVehicleMake = snapshot.data[0]['$index']['vehicle-make']!.toString();
                                                    draftVehicleModel = snapshot.data[0]['$index']['vehicle-model']!.toString();
                                                    draftVehicleProductionYear = snapshot.data[0]['$index']['vehicle-production-year']!.toString();
                                                  }


                                                  draftPremium = snapshot.data[0]['$index']['policy-amount']!.toString();
                                                  draftBrokerCompany = (currentBroker == "")?"none":currentBroker;
                                                  draftInsuranceCompany = currentInsuranceCompany;

                                                  print("DRAFT INSURANCE COMPANY: $draftInsuranceCompany");
                                                  print("DRAFT BROKER COMPANY: $draftBrokerCompany");

                                                  Navigator.pushNamed(context, '/policyDraft');
                                                },
                                                child: Text("View Policy Draft", style: TextStyle(
                                                  color: Colors.white,
                                                ),),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 180,
                                            left: 210,
                                            child: Container(
                                              width: 100,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: TextButton(
                                                onPressed: () async {

                                                  setState(() {
                                                    currentCompany = snapshot.data[0]['$index']['intended-company'];
                                                    globalIndexToPay = index;
                                                    currentCompanyToPay = currentCompany;
                                                    currentBrokerToPay = currentBroker;

                                                    if(snapshot.data[0]['$index']['vehicle-amount'] > 0){
                                                      pendingVehicles.clear();
                                                      amountOfVehiclesMoreThanOne = true;
                                                      int vehicleIdx = 0;
                                                      while(vehicleIdx < snapshot.data[0]['$index']['vehicle-amount']){
                                                        UserVehicleWidget pendingVehicle = UserVehicleWidget(
                                                            vehicleInsuranceCompany: "",
                                                            vehicleMake: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-make']!.toString(),
                                                            vehicleModel: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-model']!.toString(),
                                                            productionYear: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-production-year']!.toString(),
                                                            vehicleValue: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-value']!.toString(),
                                                            vehicleLicenseId: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-driving-license']!.toString(),
                                                            isActive: false,
                                                            currentIndex: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-index']!,
                                                            vehicleChassisNumber: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-chassis-number']!.toString(),
                                                            vehicleMotorNumber: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-motor-number']!.toString(),
                                                            vehiclePlateNumber: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-plate-number']!.toString(),
                                                            vehicleType: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-type']!.toString(),
                                                            vehicleWeight: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-weight']!.toString(),
                                                            vehicleNumberOfSeats: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['no-seats']!.toString(),

                                                        );

                                                        pendingVehicles.add(pendingVehicle);

                                                        vehicleIdx++;
                                                      }
                                                    }
                                                    else{
                                                      amountOfVehiclesMoreThanOne = false;
                                                      globalVehicleIndex = snapshot.data[0]['$index']['vehicle-index'];
                                                      draftVehicleMake = snapshot.data[0]['$index']['vehicle-make']!.toString();
                                                      draftVehicleModel = snapshot.data[0]['$index']['vehicle-model']!.toString();
                                                      draftVehicleProductionYear = snapshot.data[0]['$index']['vehicle-production-year']!.toString();
                                                    }

                                                    draftPremium = snapshot.data[0]['$index']['policy-amount']!.toString();
                                                    draftBrokerCompany = (currentBroker == "")?"none":currentBroker;
                                                    draftInsuranceCompany = currentInsuranceCompany;

                                                    print("DRAFT INSURANCE COMPANY: $draftInsuranceCompany");
                                                    print("DRAFT BROKER COMPANY: $draftBrokerCompany");

                                                  });
                                                  // UPDATE TOTAL AMOUNT APPROVED AND PENDING
                                                  Navigator.pushNamed(context, '/policyDraft');
                                                },
                                                child: Text("Purchase",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 180,
                                            left: 40,
                                            child: Container(
                                              width: 100,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: TextButton(
                                                onPressed: () async {

                                                  Navigator.pushNamed(context, '/home');

                                                  setState(() {
                                                    currentCompany = snapshot.data[0]['$index']['intended-company'];
                                                  });

                                                  await dataBaseService.updateICApprovedToUnderwriting(
                                                      snapshot.data[0]['$index']['policy-idx'],
                                                      currentCompany
                                                  );

                                                  await dataBaseService.requestsDocUpdateICApprovedToUnderwriting(index);


                                                  // UPDATE TOTAL AMOUNT APPROVED AND PENDING

                                                },
                                                child: Text("Deny",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),),
                                              ),
                                            ),
                                          ),
                                          //status-user-denied-policy-details
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              }
                              return Container();
                            }
                              );
                        }
                      }
                      return const Text("Please wait");
                    }
                ),
              ),
    );
  }

  Widget buildVehicleMake(int vehicleAmount, dynamic vehicleMake, dynamic vehicleModel){
    if(vehicleAmount == 0){
      print("VEHICLE AMOUNT 0");
      return Positioned(
        top: 30,
        left: 20,
        child: Column(
          children: [
            Text(vehicleMake, style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),),
            //SizedBox(height: 5,),
            Text(vehicleModel,style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),),
            // Text("${snapshot.data['$index']['policy-holder-name']}"),
          ],
        ),
      );
    }
    else{
      return Container();
    }
  }

  Widget buildViewVehicles(int vehicleAmount, AsyncSnapshot  snapshot,int index){
    if(vehicleAmount != 0){
      return Positioned(
        top: 20,
        left: 30,
        child: Container(
          width: 150,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextButton(
            onPressed: (){
              if(snapshot.data[0]['$index']['vehicle-amount'] > 0){
                pendingVehicles.clear();
                int vehicleIdx = 0;
                while(vehicleIdx < snapshot.data[0]['$index']['vehicle-amount']){
                  UserVehicleWidget pendingVehicle = UserVehicleWidget(
                      vehicleInsuranceCompany: "",
                      vehicleMake: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-make']!.toString(),
                      vehicleModel: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-model']!.toString(),
                      productionYear: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-production-year']!.toString(),
                      vehicleValue: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-value']!.toString(),
                      vehicleLicenseId: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-driving-license']!.toString(),
                      isActive: false,
                      currentIndex: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-index']!,
                      vehicleChassisNumber: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-chassis-number']!.toString(),
                      vehicleMotorNumber: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-motor-number']!.toString(),
                      vehiclePlateNumber: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-plate-number']!.toString(),
                      vehicleType: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-type']!.toString(),
                      vehicleWeight: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['vehicle-weight']!.toString(),
                      vehicleNumberOfSeats: snapshot.data[0]['$index']['vehicles']['$vehicleIdx']['no-seats']!.toString(),
                  );

                  pendingVehicles.add(pendingVehicle);

                  vehicleIdx++;
                }
              }

              Navigator.pushNamed(context, '/pendingVehicles');
            },
            child: Text("View Vehicles", style: TextStyle(
              color: Colors.white,
            ),),
          ),
        ),
      );
    }
    else{
      return Container();
    }
  }

}
