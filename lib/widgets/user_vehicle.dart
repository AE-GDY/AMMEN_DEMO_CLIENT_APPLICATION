import 'package:client_application/companies/brokers.dart';
import 'package:client_application/constants.dart';
import 'package:client_application/models/claim_requests.dart';
import 'package:client_application/services/database.dart';
import 'package:client_application/views/usercars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class UserVehicleWidget extends StatefulWidget {

  final String vehicleInsuranceCompany;
  final String vehicleMake;
  final String vehicleModel;
  final String productionYear;
  final String vehicleValue;
  final String vehicleLicenseId;
  final String vehicleChassisNumber;
  final String vehicleMotorNumber;
  final String vehiclePlateNumber;
  final bool isActive;
  final int currentIndex;
  final String vehicleType;
  final String vehicleWeight;
  final String vehicleNumberOfSeats;

  const UserVehicleWidget({
    Key? key,
    required this.vehicleInsuranceCompany,
    required this.vehicleMake,
    required this.vehicleModel,
    required this.productionYear,
    required this.vehicleValue,
    required this.vehicleLicenseId,
    required this.isActive,
    required this.currentIndex,
    required this.vehicleChassisNumber,
    required this.vehicleMotorNumber,
    required this.vehiclePlateNumber,
    required this.vehicleType,
    required this.vehicleWeight,
    required this.vehicleNumberOfSeats,
  }) : super(key: key);

  @override
  _UserVehicleWidgetState createState() => _UserVehicleWidgetState();
}

class _UserVehicleWidgetState extends State<UserVehicleWidget> {

  DataBaseService dataBaseService = DataBaseService();
  bool isChecked = false;
  int vehicleIdx = 0;

  Future<Map<String, dynamic>?> usersClaimData() async {
    return (await FirebaseFirestore.instance.collection('users-claim-requests').
    doc('claims').get()).data();
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.blue;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: ScrollPhysics(),
      child: Container(
        width: 200,
        height: 180,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          //color: Colors.grey[200],
        ),
        child: Card(
          elevation: 10.0,
          child: Stack(
              children: [
                Positioned(
                  top: 20,
                  left: 30,
                  child: Text(widget.vehicleMake, style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
                Positioned(
                  top: 40,
                  left: 30,
                  child: Text(widget.vehicleModel,style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
                Positioned(
                  top: 80,
                  left: 30,
                  child: Text("Vehicle License: ${widget.vehicleLicenseId}",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),),
                ),
                Positioned(
                  top: 110,
                  left: 30,
                  child: Text("Policy Insurer: ",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),),
                ),
                Positioned(
                  top: 10,
                  left: 240,
                  child: Container(
                    width: 110,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: (){
                        if(widget.isActive == false && fromHome == false){
                          setState(() {
                            globalUserVehicleToBeRegistered = widget.currentIndex;
                            globalVehicleMake = widget.vehicleMake;
                            globalVehicleModel =  widget.vehicleModel;
                            globalProductionYear = widget.productionYear;
                            globalVehicleValue = widget.vehicleValue;
                            globalCarLicenseId = widget.vehicleLicenseId;
                            globalVehicleChassisNumber = widget.vehicleChassisNumber;
                            globalVehicleMotorNumber = widget.vehicleMotorNumber;
                            globalVehiclePlateNumber = widget.vehiclePlateNumber;
                          });
                          Navigator.pushNamed(context, '/vehicleAttachments');
                        }
                      },
                      child: Text(widget.isActive?"Active": "Not Insured",style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                ),
                  ),
                ),
                FutureBuilder(
                  future: usersClaimData(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if(snapshot.connectionState == ConnectionState.done){
                      if(snapshot.hasError){
                        return const Text("There is an error");
                      }
                      else if(snapshot.hasData){
                        return Positioned(
                          top: 50,
                          left: 210,
                          child: TextButton(
                            onPressed: () async {
                              if(widget.isActive == true){
                                ClaimRequest newClaimRequest = ClaimRequest(
                                  intendedInsuranceCompany: widget.vehicleInsuranceCompany,
                                  claimRequesterId: globalPolicyHolderID,
                                  claimRequesterName: globalPolicyHolderName,
                                  claimRequesterMobile: globalUserMobile,
                                  claimRequesterAddress: globalUserAddress,
                                  claimRequesterEmail: globalUserEmail,
                                  claimRequesterVehicleIndex: widget.currentIndex,
                                  claimRequesterVehicleMake: widget.vehicleMake,
                                  claimRequesterVehicleModel: widget.vehicleModel,
                                  claimRequesterProductionYear: widget.productionYear,
                                  claimRequesterVehicleValue: widget.vehicleValue,
                                  claimRequesterCarLicenseId: widget.vehicleLicenseId,
                                );

                                setState(() {
                                  int idx = 0;
                                  bool brokerRegistered = false;
                                  while(idx < insuranceBrokers.length){
                                    if(widget.vehicleInsuranceCompany == insuranceBrokers[idx].title){
                                      brokerRegistered = true;
                                    }
                                    idx++;
                                  }
                                  globalCurrentClaimRequest = newClaimRequest;
                                  globalCurrentClaimRequest.brokerRegistered = brokerRegistered;
                                  //snapshot.data[widget.vehicleInsuranceCompany]['total-claim-amount']++;
                                });

                               // await dataBaseService.updateClaimsRequestsData(
                                 // newClaimRequest,
                                  //snapshot.data[widget.vehicleInsuranceCompany]['total-claim-amount'],
                                //);
                                Navigator.pushNamed(context, '/userClaimRequest');
                              }
                            },
                            child: Text(widget.isActive?"Claim Request": "",style: TextStyle(
                              fontSize: 18,
                            ),
                            ),
                          ),
                        );
                      }
                    }
                    return const Text("");
                  },

                ),

                buildCheckBoxes(getColor),



              ],
            ),
        ),
      ),
    );

  }


  Widget buildCheckBoxes(Color getColor(Set<MaterialState> states)){
    if(onCompany && !widget.isActive){
      return Positioned(
        left: 280,
        top: 60,
        child: Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {



              isChecked = value!;
              int idx = 0;
              while(idx < userVehicles.length){
                if(widget.currentIndex == userVehicles[idx].currentIndex){
                  if(!isChecked){
                    userVehiclesToBeRequested.remove(userVehicles[idx]);
                  }
                  else{
                    userVehiclesToBeRequested.add(userVehicles[idx]);
                  }
                  break;
                }
                idx++;
              }

              int vIdx = 0;
              while(vIdx < userVehiclesToBeRequested.length){
                print("Vehicle Index: ${userVehiclesToBeRequested[vIdx].currentIndex}");
                vIdx++;
              }

            });
          },
        ),
      );
    }
    else{
      return Container();
    }
  }
}


