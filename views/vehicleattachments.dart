import 'package:client_application/services/database.dart';
import 'package:client_application/widgets/user_vehicle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';


class VehicleAttachments extends StatefulWidget {
  const VehicleAttachments({Key? key}) : super(key: key);

  @override
  _VehicleAttachmentsState createState() => _VehicleAttachmentsState();
}

class _VehicleAttachmentsState extends State<VehicleAttachments> {

  DataBaseService dataBaseService = DataBaseService();

  Future<Map<String, dynamic>?> insuranceCompaniesPolicies() async {
    return (await FirebaseFirestore.instance.collection('users-policy-requests').
    doc(globalIntendedInsuranceCompany).get()).data();
  }

  Future<Map<String, dynamic>?> requestsDocInsuranceCompaniesPolicies() async {
    return (await FirebaseFirestore.instance.collection('users-policy-requests').
    doc("requests").get()).data();
  }

  Future<Map<String, dynamic>?> brokerCompaniesPolicies() async {
    return (await FirebaseFirestore.instance.collection('users-policy-requests-broker').
    doc(globalIntendedInsuranceCompany).get()).data();
  }

  List<UserVehicleWidget> tempUserVehiclesToBeRequested = userVehiclesToBeRequested;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Vehicle Attachments"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 25,
            child: Container(
              width: 160,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text("Front Side", style: TextStyle(
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    ),),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 220,
            child: Container(
              width: 160,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text("Back Side", style: TextStyle(
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    ),),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 25,
            child: Container(
              width: 160,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text("Left Side", style: TextStyle(
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    ),),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 330,
            left: 120,
            child: Container(
              width: 160,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text("Top Side", style: TextStyle(
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    ),),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 220,
            child: Container(
              width: 160,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text("Right Side", style: TextStyle(
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    ),),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 470,
            left: 100,
            child:  buildUploadImages(),
          ),

          Positioned(
            top: 540,
            left: 100,
            child: FutureBuilder(
              future:Future.wait([(onBrokerCompany == false)?insuranceCompaniesPolicies(): brokerCompaniesPolicies(),requestsDocInsuranceCompaniesPolicies()]),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('there is an error'),
                    );
                  }
                  else if(snapshot.hasData){
                   return Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          setState(() {
                            snapshot.data[0]['total-policy-amount']++;
                            snapshot.data[1]['total-policy-amount']++;
                            snapshot.data[0]['total-new-requests']++;
                          });

                          //HERE
                          UserPolicyIssuance newPolicyIssuanceRequest;

                          if(onCompany){
                            newPolicyIssuanceRequest = UserPolicyIssuance(
                              vehicleIndex: globalUserVehicleToBeRegistered,
                              insuranceAmount: onBrokerCompany?0:globalCurrentPolicyRequestAmount,
                              intendedCompany: globalIntendedInsuranceCompany,
                              policyHolderID: globalPolicyHolderID,
                              policyHolderName: globalPolicyHolderName,
                              mobile: globalUserMobile,
                              address: globalUserAddress,
                              email: globalUserEmail,
                              vehicleMake: globalVehicleMake,
                              vehicleModel: globalVehicleModel,
                              productionYear: globalProductionYear,
                              vehicleValue: globalVehicleValue,
                              carLicenseId: globalCarLicenseId,
                              drivingLicenseId: globalDrivingLicenseId,
                              vehiclePlateNumber: globalVehiclePlateNumber,
                              vehicleChassisNumber: globalVehicleChassisNumber,
                              vehicleMotorNumber: globalVehicleMotorNumber,
                              vehicles: userVehiclesToBeRequested,
                              beneficiary: globalBeneficiary,
                              vehicleType: '',
                              vehicleWeight: '',
                              vehicleNumberOfSeats: '',
                            );

                            if(!onBrokerCompany){
                              int idx = 0;
                              while(idx < userVehiclesToBeRequested.length){
                                await dataBaseService.updatePolicyRequestsDataCompany(
                                  userVehiclesToBeRequested.length,
                                  idx,
                                  newPolicyIssuanceRequest,
                                  snapshot.data[0]['total-policy-amount'],
                                  snapshot.data[0]['total-new-requests'],
                                  snapshot.data[0]['total-amount-approved'],
                                  snapshot.data[0]['total-amount-renewal'],
                                  snapshot.data[0]['total-amount-cancelled'],
                                  snapshot.data[0]['total-pending-policies'],
                                );
                                idx++;
                              }
                            }
                            else{
                              int idx = 0;
                              while(idx < userVehiclesToBeRequested.length){
                                await dataBaseService.updateBrokerPolicyRequestsDataCompany(
                                  userVehiclesToBeRequested.length,
                                  idx,
                                  newPolicyIssuanceRequest,
                                  snapshot.data[0]['total-policy-amount'],
                                  snapshot.data[0]['total-new-requests'],
                                  snapshot.data[0]['total-amount-approved'],
                                  snapshot.data[0]['total-amount-renewal'],
                                  snapshot.data[0]['total-amount-cancelled'],
                                  snapshot.data[0]['total-pending-policies'],
                                );
                                idx++;
                              }
                            }

                            int idx2 = 0;
                            while(idx2 < userVehiclesToBeRequested.length){
                              await dataBaseService.requestsDocUpdatePolicyRequestsDataCompany(
                                idx2,
                                newPolicyIssuanceRequest,
                                snapshot.data[1]['total-policy-amount'],
                                onBrokerCompany,
                                userVehiclesToBeRequested.length,
                              );
                              idx2++;
                            }

                            int vehicleIdx = 0;
                            while(vehicleIdx < userVehiclesToBeRequested.length){
                              await dataBaseService.updateUserVehicleIntendedCompany(
                                globalCurrentUserLoggedInIndex,
                                userVehiclesToBeRequested[vehicleIdx].currentIndex,
                                globalIntendedInsuranceCompany,
                              );
                              vehicleIdx++;
                            }


                          }
                          else{
                            newPolicyIssuanceRequest = UserPolicyIssuance(
                              vehicleIndex: globalUserVehicleToBeRegistered,
                              insuranceAmount: onBrokerCompany?0:globalCurrentPolicyRequestAmount,
                              intendedCompany: globalIntendedInsuranceCompany,
                              policyHolderID: globalPolicyHolderID,
                              policyHolderName: globalPolicyHolderName,
                              mobile: globalUserMobile,
                              address: globalUserAddress,
                              email: globalUserEmail,
                              vehicleMake: globalVehicleMake,
                              vehicleModel: globalVehicleModel,
                              productionYear: globalProductionYear,
                              vehicleValue: globalVehicleValue,
                              carLicenseId: globalCarLicenseId,
                              drivingLicenseId: globalDrivingLicenseId,
                              vehiclePlateNumber: globalVehiclePlateNumber,
                              vehicleChassisNumber: globalVehicleChassisNumber,
                              vehicleMotorNumber: globalVehicleMotorNumber,
                              vehicles: [],
                              beneficiary: globalBeneficiary,
                              vehicleType: globalVehicleType,
                              vehicleWeight: globalVehicleWeight,
                              vehicleNumberOfSeats: globalNumberOfSeats,
                            );


                            if(onBrokerCompany){
                              await dataBaseService.updateBrokerPolicyRequestsData(newPolicyIssuanceRequest,
                                snapshot.data[0]['total-policy-amount'],
                                snapshot.data[0]['total-new-requests'],
                                snapshot.data[0]['total-amount-approved'],
                                snapshot.data[0]['total-amount-renewal'],
                                snapshot.data[0]['total-amount-cancelled'],
                                snapshot.data[0]['total-pending-policies'],
                              );
                            }
                            else{
                              await dataBaseService.updatePolicyRequestsData(newPolicyIssuanceRequest,
                                snapshot.data[0]['total-policy-amount'],
                                snapshot.data[0]['total-new-requests'],
                                snapshot.data[0]['total-amount-approved'],
                                snapshot.data[0]['total-amount-renewal'],
                                snapshot.data[0]['total-amount-cancelled'],
                                snapshot.data[0]['total-pending-policies'],
                              );
                            }

                            await dataBaseService.requestsDocUpdatePolicyRequestsData(
                              newPolicyIssuanceRequest,
                              snapshot.data[1]['total-policy-amount'],
                              onBrokerCompany,
                            );

                            await dataBaseService.updateUserVehicleIntendedCompany(
                              globalCurrentUserLoggedInIndex,
                              globalUserVehicleToBeRegistered,
                              globalIntendedInsuranceCompany,
                            );

                          }

                          userVehiclesToBeRequested.clear();
                          Navigator.pushNamed(context, '/home');
                        },
                        child: const Text("Complete Policy Request", style: TextStyle(
                          color: Colors.white,
                        ),),
                      ),
                    );

                  }
                }
                return const Text("Please wait");
              },

            ),
          ),

        ],
      ),
    );
  }


  Widget buildUploadImages(){
    if(onCompany){
      return Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          onPressed: (){},
          child: Text("Upload Spreadsheet", style: TextStyle(
            color: Colors.white,
          ),),
        ),
      );
    }
    else{
      return Container();
    }
  }

}
