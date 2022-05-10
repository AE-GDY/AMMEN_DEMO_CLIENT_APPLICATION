import 'package:client_application/companies/brokers.dart';
import 'package:client_application/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';


class PendingClaims extends StatefulWidget {
  const PendingClaims({Key? key}) : super(key: key);

  @override
  _PendingClaimsState createState() => _PendingClaimsState();
}

class _PendingClaimsState extends State<PendingClaims> {

  DataBaseService dataBaseService = DataBaseService();

  Future<Map<String, dynamic>?> claimsApprovedData() async {
    return (await FirebaseFirestore.instance.collection('users-claim-approvals').
    doc('approvals').get()).data();
  }

  Future<Map<String, dynamic>?> claimsRequestsData() async {
    return (await FirebaseFirestore.instance.collection('users-claim-requests').
    doc('claims-user').get()).data();
  }

  Future<Map<String, dynamic>?> claimsRequestsDataInsuranceComp() async {
    return (await FirebaseFirestore.instance.collection('users-claim-requests').
    doc('claims').get()).data();
  }

  Future<Map<String, dynamic>?> usersSignedUp() async {
    return (await FirebaseFirestore.instance.collection('users-signed-up').
    doc('users').get()).data();
  }

  TextEditingController commentController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pending Claims"),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 400,
          height: 600,
          child: FutureBuilder(
            future: Future.wait([claimsApprovedData(),claimsRequestsData(), usersSignedUp()]),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasError){
                  return const Text("There is an error");
                }
                else if(snapshot.hasData){
                  return ListView.builder(
                      itemCount: snapshot.data[1]['total-claim-amount']+1,
                      itemBuilder: (context,index){
                        if(snapshot.data[1]['$index']['claim-requester-name'] == globalPolicyHolderName
                            && snapshot.data[1]['$index']['status-ic-approved'] == false &&
                            snapshot.data[1]['$index']['user-approved'] == false){
                          return Container(
                            height: 270,
                            margin: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                            //  color: Colors.grey[300],
                            ),
                            child: Card(
                              elevation: 10.0,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 15,
                                    left: 15,
                                    child: Text(snapshot.data[1]['$index']['claim-requester-vehicle-make'],style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  ),
                                  Positioned(
                                    top: 35,
                                    left: 15,
                                    child: Text(snapshot.data[1]['$index']['claim-requester-vehicle-model'],style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  ),
                                  Positioned(
                                    top: 75,
                                    left: 15,
                                    child: Text(snapshot.data[1]['$index']['intended-insurance-company'],style: TextStyle(
                                      fontSize: 18,
                                     // fontWeight: FontWeight.bold,
                                    ),),
                                  ),
                                  Positioned(
                                    top: 100,
                                    left: 15,
                                    child: Text(snapshot.data[1]['$index']['center'],style: TextStyle(
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                    ),),
                                  ),
                                  buildCoverageButton(snapshot,index),

                                  buildAcceptButton(snapshot,index),
                                  Positioned(
                                    top: 20,
                                    left: 160,
                                    child: Column(
                                      children: [
                                        Text("Status: ", style: TextStyle(
                                          fontSize: 18
                                        ),),
                                        Text(snapshot.data[1]['$index']['status-waiting-fees-approval']?"Waiting for invoice":
                                        snapshot.data[1]['$index']['status-scheduling']?"Scheduling Inspection":
                                        snapshot.data[1]['$index']['status-waiting-ic-approval']?"Waiting IC Approval":
                                        snapshot.data[1]['$index']['status-ic-approved']?"Pending Approval":"", style: const TextStyle(
                                            fontSize: 18
                                        ),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        else if (snapshot.data[1]['$index']['claim-requester-name'] == globalPolicyHolderName
                            && snapshot.data[1]['$index']['status-ic-approved'] == true
                        && snapshot.data[1]['$index']['user-approved'] == false){
                          return Container(
                            height: 270,
                            margin: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              //color: Colors.grey[300],
                            ),
                            child: Card(
                              elevation: 10.0,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 15,
                                    left: 15,
                                    child: Text(snapshot.data[1]['$index']['claim-requester-vehicle-make'],style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  ),
                                  Positioned(
                                    top: 35,
                                    left: 15,
                                    child: Text(snapshot.data[1]['$index']['claim-requester-vehicle-model'],style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  ),
                                  Positioned(
                                    top: 75,
                                    left: 15,
                                    child: Text(snapshot.data[1]['$index']['intended-insurance-company'],style: TextStyle(
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                    ),),
                                  ),
                                  Positioned(
                                    top: 100,
                                    left: 15,
                                    child: Text(snapshot.data[1]['$index']['center'],style: TextStyle(
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                    ),),
                                  ),
                                  Positioned(
                                    top: 190,
                                    left: 20,
                                    child: Container(
                                      width: 200,
                                      height: 50,
                                      child: TextField(
                                        controller: commentController,
                                        decoration: InputDecoration(
                                          labelText: "Add Comment",
                                        ),
                                      ),
                                    ),
                                  ),
                                  buildCoverageButton(snapshot,index),
                                  buildAcceptButton(snapshot,index),
                                  buildIsTotalLoss(snapshot,index),
                                  Positioned(
                                    top: 20,
                                    left: 160,
                                    child: Column(
                                      children: [
                                        Text("Status: ", style: TextStyle(
                                            fontSize: 18
                                        ),),
                                        Text("Pending Approval", style: const TextStyle(
                                            fontSize: 18
                                        ),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        else{
                          return Container();
                        }
                      }
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





  Widget buildAcceptButton(AsyncSnapshot<dynamic> snapshot, index){
    if(snapshot.data[1]['$index']['status-ic-approved'] == true){
    //  print("IC APPROVED ACCEPT BUTTON");
      return Positioned(
        top: 120,
        left: 240,
        child: Column(
          children: [
            Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child:TextButton(
                onPressed: () async {
                  Navigator.pushNamed(context, '/home');

                  bool isBroker = false;
                  setState(() {
                    isClaimRequest = true;
                    globalClaimIndex = index;
                    globalToPayIntendedComp = snapshot.data[1]['$index']['intended-insurance-company'];
                    globalClaimNumberInsComp = snapshot.data[1]['$index']['claim-number'];
                    int idx = 0;
                    while(idx < insuranceBrokers.length){
                      if(snapshot.data[1]['$index']['intended-insurance-company'] == insuranceBrokers[idx].title){
                        isBroker = true;
                      }
                      idx++;
                    }
                  });

                  await dataBaseService.claimUpdateUserApprovalData(globalClaimIndex);
                  await dataBaseService.claimUpdateStatusDeclinedInsuranceComp(globalToPayIntendedComp,globalClaimNumberInsComp);

                  await dataBaseService.addNotificationTypePayment(
                      globalCurrentUserLoggedInIndex,
                      snapshot.data[2]['$globalCurrentUserLoggedInIndex']['notification-amount']+1,
                      snapshot.data[1]['$index']['center'],
                      snapshot.data[1]['$index']['client-share']
                  );
                  Navigator.pushNamed(context, '/home');
                },
                child: Text("Accept",style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ),
            SizedBox(height: 15,),
            Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child:TextButton(
                onPressed: () async {
                  Navigator.pushNamed(context, '/home');

                  bool isBroker = false;
                  setState(() {
                    //isClaimRequest = true;
                    globalClaimIndex = index;
                  });

                  await dataBaseService.claimUpdateStatusDeclinedClaimsDoc(
                      snapshot.data[1]['$index']['intended-insurance-company'],
                      snapshot.data[1]['$index']['claim-number'],
                      commentController.text,
                  );
                  await dataBaseService.claimUpdateStatusDeclinedPendingApproval(globalClaimIndex);

                  Navigator.pushNamed(context, '/home');

                },
                child: Text("Decline",style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ),
          ],
        ),
      );
    }
    else{
      return Container();
    }
  }

  Widget buildCoverageButton(AsyncSnapshot<dynamic> snapshot, index){
    if(snapshot.data[1]['$index']['status-ic-approved'] == true){
      return Positioned(
        top: 140,
        left: 10,
        child: Column(
          children: [
            Text(snapshot.data[1]['$index']['total-loss']?"Please go to the":"Total client payment:",
              style: TextStyle(
                fontSize: snapshot.data[1]['$index']['total-loss']?16:18,
                fontWeight: FontWeight.bold,
              ),),
            Text(snapshot.data[1]['$index']['total-loss']?"nearest branch for further steps":"${snapshot.data[1]['$index']['client-share']} EGP",
              style: TextStyle(
                fontSize: snapshot.data[1]['$index']['total-loss']?16:18,
                fontWeight: FontWeight.bold,
              ),),
          ],
        ),
      );
    }
    else{
      return Container();
    }
  }

  Widget buildIsTotalLoss(AsyncSnapshot<dynamic> snapshot, index){
    if(snapshot.data[1]['$index']['status-ic-approved'] == true){
      if(snapshot.data[1]['$index']['total-loss'] == true){
        return Positioned(
          top: 90,
          left: 240,
          child: Text("Total Loss",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),
        );
      }
      else{
        return Container();
      }
    }
    else{
      return Container();
    }
  }


}