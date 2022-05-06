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
                  height: 120,
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Vehicle Make: ${pendingVehicles[index].vehicleMake}", style: TextStyle(
                          fontSize: 20,
                        ),),
                        SizedBox(height: 10,),
                        Text("Vehicle Model: ${pendingVehicles[index].vehicleModel}",style: TextStyle(
                          fontSize: 20,
                        ),),
                        SizedBox(height: 10,),
                        Text("Vehicle Plate Number: ${pendingVehicles[index].vehiclePlateNumber}",style: TextStyle(
                          fontSize: 20,
                        ),),
                      ],
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
