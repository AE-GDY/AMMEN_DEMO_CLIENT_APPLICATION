import 'package:client_application/services/database.dart';
import 'package:flutter/material.dart';

import '../constants.dart';


class VehicleInfo extends StatefulWidget {
  const VehicleInfo({Key? key}) : super(key: key);

  @override
  _VehicleInfoState createState() => _VehicleInfoState();
}

class _VehicleInfoState extends State<VehicleInfo> {

  String vehicleMake = '';
  String vehicleModel = '';
  String productionYear = '';
  String vehicleValue = '';
  String carLicenseId = '';
  String drivingLicenseId = '';

  DataBaseService dataBaseService = DataBaseService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Policy Request - Vehicle Info"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Vehicle Make',
                ),
                validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
                //obscureText: true,
                onChanged: (val){
                  setState(() {
                    vehicleMake = val;
                  });
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Vehicle Model',
                ),
                validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
                //obscureText: true,
                onChanged: (val){
                  setState(() {
                    vehicleModel = val;
                  });
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Production Year',
                ),
                validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
                // obscureText: true,
                onChanged: (val){
                  setState(() {
                    productionYear = val;
                  });
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Vehicle Value',
                ),
                validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
                //obscureText: true,
                onChanged: (val){
                  setState(() {
                    vehicleValue = val;
                  });
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Car License ID',
                ),
                validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
                //obscureText: true,
                onChanged: (val){
                  carLicenseId = val;
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Driving License ID',
                ),
                validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
                //obscureText: true,
                onChanged: (val){
                  drivingLicenseId = val;
                },
              ),

              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () async {
                  /*
                          if(_formKey.currentState!.validate()) {
                          }*/
                  globalVehicleMake = vehicleMake;
                  globalVehicleModel = vehicleModel;
                  globalProductionYear = productionYear ;
                  globalVehicleValue = vehicleValue;
                  globalCarLicenseId = carLicenseId;
                  globalDrivingLicenseId = drivingLicenseId;
                  setState(() {
                    int? currentAmount =  companyCurrentPolicyAmount[globalIntendedInsuranceCompany]! + 1;
                    companyCurrentPolicyAmount[globalIntendedInsuranceCompany] = currentAmount!;
                    currentPolicyAmount++;
                  });
                /*
                  UserPolicyIssuance newPolicyIssuanceRequest = UserPolicyIssuance(
                      vehicleIndex: globalUserVehicleToBeRegistered,
                      insuranceAmount: globalCurrentPolicyRequestAmount,
                      intendedInsuranceCompany: globalIntendedInsuranceCompany,
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
                  );
                */

               //   await dataBaseService.updatePolicyRequestsData(newPolicyIssuanceRequest,companyCurrentPolicyAmount[globalIntendedInsuranceCompany]!);

                },
                child: Text("continue"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
