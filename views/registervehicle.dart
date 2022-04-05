import 'package:client_application/services/database.dart';
import 'package:client_application/views/usercars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants.dart';


class RegisterVehicle extends StatefulWidget {
  const RegisterVehicle({Key? key}) : super(key: key);

  @override
  _RegisterVehicleState createState() => _RegisterVehicleState();
}

class _RegisterVehicleState extends State<RegisterVehicle> {

  String vehicleMake = '';
  String vehicleModel = '';
  String productionYear = '';
  String vehicleValue = '';
  String vehicleLicenseId = '';
  String vehiclePlateNumber = '';
  String vehicleChassisNumber = '';
  String vehicleMotorNumber = '';
  String numberOfSeats = '';
  String weight = '';

  DataBaseService dataBaseService = DataBaseService();

  Future<Map<String, dynamic>?> usersSignedUpIndex() async {
    return (await FirebaseFirestore.instance.collection('users-signed-up').
    doc('users').get()).data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Vehicle"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              Row(
                children: [
                  SizedBox(width: 20,),
                  Container(
                    decoration: BoxDecoration(
                      color: (vehicleType == 'personal')?Colors.blue:Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 100,
                    height: 40,
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          vehicleType = 'personal';
                          globalVehicleType = vehicleType;
                        });
                      },
                      child: Text("Personal", style: TextStyle(
                        color: Colors.white,
                      ),),
                    ),
                  ),
                  SizedBox(width: 30,),
                  Container(
                    decoration: BoxDecoration(
                      color: (vehicleType == 'bus')?Colors.blue:Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 100,
                    height: 40,
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          vehicleType = 'bus';
                          globalVehicleType = vehicleType;
                        });
                      },
                      child: Text("Bus",style: TextStyle(
                        color: Colors.white,
                      ),),
                    ),
                  ),
                  SizedBox(width: 30,),
                  Container(
                    decoration: BoxDecoration(
                      color: (vehicleType == 'truck')?Colors.blue:Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 100,
                    height: 40,
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          vehicleType = 'truck';
                          globalVehicleType = vehicleType;
                        });
                      },
                      child: Text("Truck",style: TextStyle(
                        color: Colors.white,
                      ),),
                    ),
                  ),
                  SizedBox(width: 30,),
                ],
              ),
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
              buildNoSeats(),
              buildWeight(),
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
                  hintText: 'Vehicle License ID',
                ),
                validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
                //obscureText: true,
                onChanged: (val){
                  vehicleLicenseId = val;
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Vehicle Plate Number',
                ),
                validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
                //obscureText: true,
                onChanged: (val){
                  vehiclePlateNumber = val;
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Vehicle Chassis Number',
                ),
                validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
                //obscureText: true,
                onChanged: (val){
                  vehicleChassisNumber = val;
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Vehicle Motor Number',
                ),
                validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
                //obscureText: true,
                onChanged: (val){
                  vehicleMotorNumber = val;
                },
              ),

              SizedBox(height: 20,),

              Container(
                width: 250,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[50],
                  border: Border.all(color: Colors.black, width: 1.0),
                ),
                child: Center(child: Text("Attach Driving License", style: TextStyle(
                  fontSize: 18,
                ),)),
              ),

              SizedBox(height: 30,),

              FutureBuilder(
                future: usersSignedUpIndex(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('there is an error'),
                      );
                    }
                    else if(snapshot.hasData){
                     return ElevatedButton(
                        onPressed: () async {

                          UserVehicle newUserVehicle = UserVehicle(
                          //  intendedInsuranceCompany: globalIntendedInsuranceCompany,
                            vehicleMake: vehicleMake,
                            vehicleModel: vehicleModel,
                            productionYear: productionYear,
                            vehicleValue: vehicleValue,
                            vehiclePlateNumber: vehiclePlateNumber,
                            vehicleLicenseId: vehicleLicenseId,
                            isActive: false,
                            vehicleMotorNumber: vehicleMotorNumber,
                            vehicleChassisNumber: vehicleChassisNumber,
                            weight: weight,
                            numberOfSeats: numberOfSeats,
                            vehicleType: vehicleType,
                          );


                          setState(() {
                            snapshot.data['$globalCurrentUserLoggedInIndex']['user-vehicle-amount']+=1;
                          });

                          await dataBaseService.updateUserVehicles(
                            globalCurrentUserLoggedInIndex,
                            newUserVehicle,
                            snapshot.data['$globalCurrentUserLoggedInIndex']['user-vehicle-amount'],
                          );


                          Navigator.pushNamed(context, '/userVehicles');
                        },
                        child: Text("Register"),
                      );
                    }
                  }
                  return const Text("Hold");
                },

              ),


            ],
          ),
        ),
      ),
    );
  }

  Widget buildNoSeats(){
    if(vehicleType == 'bus'){
      return Column(
        children: [
          SizedBox(height: 20,),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Number of seats',
            ),
            validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
            //obscureText: true,
            onChanged: (val){
              setState(() {
                numberOfSeats = val;
                globalNumberOfSeats = numberOfSeats;
              });
            },
          ),
        ],
      );
    }
    else{
      return Container();
    }
  }

  Widget buildWeight(){
    if(vehicleType == 'truck'){
      return Column(
        children: [
          SizedBox(height: 20,),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Weight',
            ),
            validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
            //obscureText: true,
            onChanged: (val){
              setState(() {
                weight = val;
                globalVehicleWeight = weight;
              });
            },
          ),
        ],
      );
    }
    else{
      return Container();
    }
  }


}
