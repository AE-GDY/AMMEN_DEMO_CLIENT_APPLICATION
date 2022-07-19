import 'package:flutter/material.dart';

import '../constants.dart';

class PendingVehicle extends StatefulWidget {
  const PendingVehicle({Key? key}) : super(key: key);

  @override
  _PendingVehicleState createState() => _PendingVehicleState();
}

class _PendingVehicleState extends State<PendingVehicle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pending Vehicles"),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Container(
          width: 500,
          height: 1000,
          child: ListView.builder(
              itemCount: pendingVehicles.length,
              itemBuilder: (context, index){
                return Container(
                  height: 270,
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    //color: Colors.grey[300],
                  ),
                  child: Card(
                    elevation: 10.0,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Vehicle Make", style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),),
                          SizedBox(height: 5,),
                          Text(pendingVehicles[index].vehicleMake, style: TextStyle(
                            fontSize: 18,
                          ),),
                          SizedBox(height: 10),
                          Text("Vehicle Model", style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),
                          SizedBox(height: 5,),
                          Text(pendingVehicles[index].vehicleModel, style: TextStyle(
                            fontSize: 18,
                          ),),
                          SizedBox(height: 10),
                          Text("Vehicle Plate Number", style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),
                          SizedBox(height: 5,),
                          Text(pendingVehicles[index].vehiclePlateNumber, style: TextStyle(
                            fontSize: 18,
                          ),),
                          SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ),
                );
              }
          ),
        ),
      ),
    );
  }
}
