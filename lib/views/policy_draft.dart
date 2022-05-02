import 'package:client_application/constants.dart';
import 'package:flutter/material.dart';


class PolicyDraft extends StatefulWidget {
  const PolicyDraft({Key? key}) : super(key: key);

  @override
  _PolicyDraftState createState() => _PolicyDraftState();
}

class _PolicyDraftState extends State<PolicyDraft> {

  bool delivery = false;
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Policy Draft"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Container(
          height: 2000,
          child: Container(
            margin: EdgeInsets.all(10),
            width: 800,
            //height: 300,
            child: Card(
              elevation: 5.0,
              child: buildPolicyInfo(),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPolicyInfo(){
    if(pendingVehicles.length > 0){
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Personal Information:", style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 10,),
          Text("Policy Holder Name: $globalPolicyHolderName", style: TextStyle(
            fontSize: 18,
          ),),
          SizedBox(height: 10,),
          Text("Policy Holder National ID: $globalPolicyHolderID", style: TextStyle(
            fontSize: 18,
          ),),
          SizedBox(height: 10,),
          Text("Policy Holder Date Of Birth: $globalDateOfBirth", style: TextStyle(
            fontSize: 18,
          ),),
          SizedBox(height: 10,),
          Text("Policy Holder Mobile: $globalUserMobile", style: TextStyle(
            fontSize: 18,
          ),),
          SizedBox(height: 10,),
          Text("Policy Holder Email: $globalUserEmail", style: TextStyle(
            fontSize: 18,
          ),),
          SizedBox(height: 30,),
          Text("Insurance Company:", style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),),
          Text("$draftInsuranceCompany", style: TextStyle(
            fontSize: 18,
          ),),
          SizedBox(height: 10,),
          Text((draftBrokerCompany.isEmpty)?"":"Broker Company:", style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),),
          Text("$draftBrokerCompany", style: TextStyle(
            fontSize: 18,
          ),),
          SizedBox(height: 10,),
          Text("Policy Premium:", style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),),
          Text("$draftPremium EGP", style: TextStyle(
            fontSize: 18,
          ),),
          SizedBox(height: 10,),
          Text("Vehicle Information:", style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 20,),
          Container(
            height: 200,
            child: ListView.builder(
              itemCount: pendingVehicles.length,
              itemBuilder: (context,index){
                return Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Vehicle Make: ${pendingVehicles[index].vehicleMake}", style: TextStyle(
                        fontSize: 18,
                      ),),
                      Text("Vehicle Model: ${pendingVehicles[index].vehicleModel}", style: TextStyle(
                        fontSize: 18,
                      ),),
                      Text("Production Year: ${pendingVehicles[index].productionYear}", style: TextStyle(
                        fontSize: 18,
                      ),),
                    ],
                  ),
                );
              }),
          ),

          SizedBox(height: 50,),
          Text("How would you like to receive the hardcopy of your policy?",style: TextStyle(
            fontSize: 16,
          ),),
          SizedBox(height: 15,),
          Row(
            children: [
              SizedBox(width: 20,),
              Container(
                  width: 160,
                  height: 50,
                  decoration: BoxDecoration(
                    color: (delivery == false)?Colors.blue:Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: (){
                      setState(() {
                        if(delivery){
                          delivery = !delivery;
                        }
                      });
                    },
                    child: Text("Pick up from Insurance Company", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),),
                  )
              ),
              SizedBox(width: 20,),
              Container(
                  width: 160,
                  height: 50,
                  decoration: BoxDecoration(
                    color: (delivery == true)?Colors.blue:Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: (){
                      setState(() {
                        if(!delivery){
                          delivery = !delivery;
                        }
                      });
                    },
                    child: Text("Delivery", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),),
                  )
              ),
            ],
          ),
          SizedBox(height: 20,),
          buildPickUpInfo(),
          SizedBox(height: 50,),
          Row(
            children: [
              Checkbox(
                value: agreeTermsAndConditions,
                onChanged: (bool? value) {
                  setState(() {
                    if(agreeTermsAndConditions == false){
                      agreeTermsAndConditions = true;
                    }
                    else{
                      agreeTermsAndConditions = false;
                    }
                  });

                },

              ),
              Container(
                child: Text("I agree with the terms and conditions"),
              ),
            ],
          ),
          SizedBox(height: 20,),
          TextButton(
              onPressed: (){
                print("Pressed");
                Navigator.pushNamed(context, '/termsAndConditions');
              },
              child: Text("View Terms and Conditions", style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),),
          ),
          SizedBox(height: 10,),
          Center(
            child: Container(
                width: 150,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: (){
                    if(delivery == true){
                      if(locationController.text.isNotEmpty && agreeTermsAndConditions){
                        Navigator.pushNamed(context, '/payment');
                      }
                    }
                    else if(agreeTermsAndConditions){
                      Navigator.pushNamed(context, '/payment');
                    }
                  },
                  child: Text("Accept Policy", style: TextStyle(
                    color: Colors.white,
                  ),),
                )
            ),
          ),
        ],
      );
    }
    else{
      return Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Personal Information:", style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 10,),
            Text("Policy Holder Name: $globalPolicyHolderName", style: TextStyle(
              fontSize: 18,
            ),),
            SizedBox(height: 10,),
            Text("Policy Holder National ID: $globalPolicyHolderID", style: TextStyle(
              fontSize: 18,
            ),),
            SizedBox(height: 10,),
            Text("Policy Holder Date Of Birth: $globalDateOfBirth", style: TextStyle(
              fontSize: 18,
            ),),
            SizedBox(height: 10,),
            Text("Policy Holder Mobile: $globalUserMobile", style: TextStyle(
              fontSize: 18,
            ),),
            SizedBox(height: 10,),
            Text("Policy Holder Email: $globalUserEmail", style: TextStyle(
              fontSize: 18,
            ),),
            SizedBox(height: 30,),
            Text("Insurance Company:", style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),),
            Text("$draftInsuranceCompany", style: TextStyle(
              fontSize: 18,
            ),),
            SizedBox(height: 10,),
            Text((draftBrokerCompany.isEmpty)?"":"Broker Company:", style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),),
            Text("$draftBrokerCompany", style: TextStyle(
              fontSize: 18,
            ),),
            SizedBox(height: 10,),
            Text("Policy Premium:", style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),),
            Text("$draftPremium EGP", style: TextStyle(
              fontSize: 18,
            ),),
            SizedBox(height: 20,),
            Text("Vehicle Information:", style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),),
            Text("Vehicle Make: $draftVehicleMake", style: TextStyle(
              fontSize: 18,
            ),),
            SizedBox(height: 10,),
            Text("Vehicle Model: $draftVehicleModel", style: TextStyle(
              fontSize: 18,
            ),),
            SizedBox(height: 10,),
            Text("Production Year: $draftVehicleProductionYear", style: TextStyle(
              fontSize: 18,
            ),),
            SizedBox(height: 30,),
            Text("How would you like to receive the hardcopy of your policy?",style: TextStyle(
              fontSize: 16,
            ),),
            SizedBox(height: 15,),
            Row(
              children: [
                SizedBox(width: 10,),
                Container(
                    width: 160,
                    height: 50,
                    decoration: BoxDecoration(
                      color: (delivery == false)?Colors.blue:Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          if(delivery){
                            delivery = !delivery;
                          }
                        });
                      },
                      child: Text("Pick up from Insurance Company", style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),),
                    )
                ),
                SizedBox(width: 20,),
                Container(
                    width: 160,
                    height: 50,
                    decoration: BoxDecoration(
                      color: (delivery == true)?Colors.blue:Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          if(!delivery){
                            delivery = !delivery;
                          }
                        });
                      },
                      child: Text("Delivery", style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),),
                    )
                ),
              ],
            ),
            SizedBox(height: 20,),
            buildPickUpInfo(),
            SizedBox(height: 50,),
            Row(
              children: [
                Checkbox(
                  value: agreeTermsAndConditions,
                  onChanged: (bool? value) {
                    setState(() {
                      if(agreeTermsAndConditions == false){
                        agreeTermsAndConditions = true;
                      }
                      else{
                        agreeTermsAndConditions = false;
                      }
                    });

                  },

                ),
                Container(
                  child: Text("I agree with the terms and conditions"),
                ),
              ],
            ),
            SizedBox(height: 5,),
            TextButton(
              onPressed: (){
                print("Pressed");
                Navigator.pushNamed(context, '/termsAndConditions');
              },
              child: Text("View Terms and Conditions", style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),),
            ),
            SizedBox(height: 20,),
            Center(
              child: Container(
                width: 150,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: (){
                    if(delivery == true){
                      if(locationController.text.isNotEmpty && agreeTermsAndConditions){
                        Navigator.pushNamed(context, '/payment');
                      }
                    }
                    else if(agreeTermsAndConditions){
                      Navigator.pushNamed(context, '/payment');
                    }
                  },
                  child: Text("Accept Policy", style: TextStyle(
                    color: Colors.white,
                  ),),
                )
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget buildPickUpInfo(){
    if(delivery){
      return Column(
        children: [
          Container(
            width: 150,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text("Share live location", style: TextStyle(
                color: Colors.white,
              ),),
            ),
          ),
          TextField(
            controller: locationController,
            decoration: InputDecoration(
              labelText: "Location for delivery",
            ),
          ),
        ],
      );
    }
    else{
      return Text("You can pick up your policy draft at any time between 10:00 AM to 8:00PM at $draftInsuranceCompany",
      style: TextStyle(
        fontSize: 18,
      ),);
    }
  }



}
