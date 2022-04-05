import 'package:client_application/widgets/user_vehicle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class UserVehicle{
  String vehicleType = '';
  String numberOfSeats = '';
  String weight = '';
  String vehicleMake = '';
  String vehicleModel = '';
  String productionYear = '';
  String vehicleValue = '';
  String vehicleLicenseId = '';
  String vehiclePlateNumber = '';
  String vehicleMotorNumber = '';
  String vehicleChassisNumber = '';
  //String intendedInsuranceCompany = '';
  bool isActive = false;

  UserVehicle({
   // required this.intendedInsuranceCompany,
    required this.vehicleMake,
    required this.vehicleModel,
    required this.vehicleValue,
    required this.productionYear,
    required this.vehicleLicenseId,
    required this.vehiclePlateNumber,
    required this.vehicleChassisNumber,
    required this.vehicleMotorNumber,
    required this.isActive,
    required this.numberOfSeats,
    required this.vehicleType,
    required this.weight,

});
}

class UserVehiclesPage extends StatefulWidget {

  UserVehiclesPage({Key? key}) : super(key: key);

  @override
  _UserVehiclesPageState createState() => _UserVehiclesPageState();
}

class _UserVehiclesPageState extends State<UserVehiclesPage> {

  Future<Map<String, dynamic>?> usersSignedUp() async {
    return (await FirebaseFirestore.instance.collection('users-signed-up').
    doc('users').get()).data();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicles"),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body:FutureBuilder(
        future: usersSignedUp(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('there is an error'),
              );
            }
            else if(snapshot.hasData){
              if(snapshot.data['$globalCurrentUserLoggedInIndex']['user-vehicle-amount'] == -1){
                return Center(
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(height: 200,),
                        const Text("You don't have any vehicles registered", style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 50,),
                        Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: (){
                              Navigator.pushNamed(context, '/registerVehicle');
                            },
                            child: const Text("Register a vehicle now",style: TextStyle(
                            //  fontSize: 20,
                              color: Colors.white,
                             // fontWeight: FontWeight.bold,
                            ),),
                          ),
                        ),

                        SizedBox(height: 20,),
                        buildUploadSpreadSheetButton(),

                      ],
                    ),
                  ),
                );
              }
              else{
                return SingleChildScrollView(
                  child: Container(
                    height: 600,
                    child: Column(
                      children: [
                       Expanded(
                           child: ListView.builder(
                               scrollDirection: Axis.vertical,
                               physics: ScrollPhysics(),
                               itemCount: snapshot.data['$globalCurrentUserLoggedInIndex']['user-vehicle-amount']+1,
                               itemBuilder: (context,index){

                                 UserVehicleWidget newVehicle = UserVehicleWidget(
                                   vehicleInsuranceCompany: snapshot.data['$globalCurrentUserLoggedInIndex']['user-vehicles']['$index']['intended-insurance-company'],
                                   vehicleMake: snapshot.data['$globalCurrentUserLoggedInIndex']['user-vehicles']['$index']['vehicle-make'],
                                   vehicleModel: snapshot.data['$globalCurrentUserLoggedInIndex']['user-vehicles']['$index']['vehicle-model'],
                                   vehicleValue: snapshot.data['$globalCurrentUserLoggedInIndex']['user-vehicles']['$index']['vehicle-value'],
                                   isActive: snapshot.data['$globalCurrentUserLoggedInIndex']['user-vehicles']['$index']['vehicle-status'],
                                   vehicleLicenseId: snapshot.data['$globalCurrentUserLoggedInIndex']['user-vehicles']['$index']['vehicle-license'],
                                   productionYear: snapshot.data['$globalCurrentUserLoggedInIndex']['user-vehicles']['$index']['vehicle-production-year'],
                                   currentIndex: index,
                                   vehicleChassisNumber: snapshot.data['$globalCurrentUserLoggedInIndex']['user-vehicles']['$index']['vehicle-chassis-number'],
                                   vehicleMotorNumber: snapshot.data['$globalCurrentUserLoggedInIndex']['user-vehicles']['$index']['vehicle-motor-number'],
                                   vehiclePlateNumber: snapshot.data['$globalCurrentUserLoggedInIndex']['user-vehicles']['$index']['vehicle-plate-number'],
                                   vehicleType: snapshot.data['$globalCurrentUserLoggedInIndex']['user-vehicles']['$index']['vehicle-type'],
                                   vehicleWeight: snapshot.data['$globalCurrentUserLoggedInIndex']['user-vehicles']['$index']['vehicle-weight'],
                                   vehicleNumberOfSeats: snapshot.data['$globalCurrentUserLoggedInIndex']['user-vehicles']['$index']['no-seats'],
                                 );

                                 userVehicles.add(newVehicle);

                                 return newVehicle;
                               }),
                       ),
                        SizedBox(height: 20,),
                        Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: (){
                              Navigator.pushNamed(context, '/registerVehicle');
                            },
                            child: Text("Register a new vehicle", style: TextStyle(
                              color: Colors.white,
                            ),),
                          ),
                        ),
                        SizedBox(height: 20,),
                        buildUploadSpreadSheetButton(),
                        SizedBox(height: 20,),
                        buildRequestPolicyWidget(),
                      ],
                    ),
                  ),
                );
              }
            }
          }
          return const Text("Hold");
        },
      ),
    );

  }


  Widget buildUploadSpreadSheetButton(){
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

  Widget buildRequestPolicyWidget(){
    if(onCompany){
      return Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          onPressed: (){
            if(!userVehiclesToBeRequested.isEmpty){
              Navigator.pushNamed(context, '/vehicleAttachments');
            }
          },
          child: Text("Request Policy", style: TextStyle(
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



