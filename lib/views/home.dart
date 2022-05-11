import 'package:client_application/companies/brokers.dart';
import 'package:client_application/services/database.dart';
import 'package:client_application/views/datatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:client_application/companies/first.dart';
import 'package:client_application/companies/second.dart';
import 'package:client_application/widgets/search.dart';
import '../constants.dart';

class Home2 extends StatefulWidget {
  Home2({Key? key});

  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home2> {

  Future<Map<String, dynamic>?> usersSignedUp() async {
    return (await FirebaseFirestore.instance.collection('users-signed-up').
    doc('users').get()).data();
  }


  DataBaseService dataBaseService = DataBaseService();


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue[700]),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 70,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text("${(globalPolicyHolderName == "")? "Guest":globalPolicyHolderName}", style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        SizedBox(width: 50,),
                        Container(
                          padding: EdgeInsets.all(10),
                          width: 180,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black26,
                          ),
                          child: Text("i-Score: ${useriScore}", textAlign: TextAlign.center,style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_circle_rounded),
                title: Text("My Account", style: TextStyle(
                  fontSize: 20,
                ),),
                onTap: (){
                  Navigator.pushNamed(context, '/home');
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings", style: TextStyle(
                  fontSize: 20,
                ),),
                onTap: (){
                  Navigator.pushNamed(context, '/home');
                },
              ),
              ListTile(
                leading: Icon(Icons.insights_rounded),
                title: Text("i-Score details", style: TextStyle(
                  fontSize: 20,
                ),),
                onTap: (){
                  Navigator.pushNamed(context, '/iscore');
                },
              ),
              ListTile(
                leading: Icon(Icons.policy),
                title: Text("Pending Policies", style: TextStyle(
                  fontSize: 20,
                ),),
                onTap: (){
                  Navigator.pushNamed(context, '/pendingPolicies');
                },
              ),
              ListTile(
                leading: Icon(Icons.book),
                title: Text("Pending Claims", style: TextStyle(
                  fontSize: 20,
                ),),
                onTap: (){
                  Navigator.pushNamed(context, '/pendingClaims');
                },
              ),
              ListTile(
                leading: Icon(Icons.local_taxi_rounded),
                title: Text("My Vehicles", style: TextStyle(
                  fontSize: 20,
                ),),
                onTap: (){
                  setState(() {
                    fromHome = true;
                  });
                  if(asGuest == true){
                    Navigator.pushNamed(context, '/signUpLater');
                  }
                  else{
                    Navigator.pushNamed(context, '/userVehicles');
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.live_help),
                title: Text("Complains", style: TextStyle(
                  fontSize: 20,
                ),),
                onTap: (){
                  setState(() {
                    fromHome = true;
                  });
                  if(asGuest == true){
                    Navigator.pushNamed(context, '/signUpLater');
                  }
                  else{
                    Navigator.pushNamed(context, '/complains');
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.info_sharp),
                title: Text("Terms and Conditions", style: TextStyle(
                  fontSize: 20,
                ),),
                onTap: (){
                  Navigator.pushNamed(context, '/termsAndConditions');
                },
              ),
              /*
              ListTile(
                leading: Icon(Icons.book),
                title: Text("Temp", style: TextStyle(
                  fontSize: 20,
                ),),
                onTap: () async {
                  // updateRequestsDocTemp
                  await dataBaseService.userClaimApprovalTemp();
                },
              ),
              */
            ],
          ),
        ),
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          backgroundColor: mainColor,
          title: Container(
            width: globalWidth,
            height: globalHeight,
            child: Image(
              image: AssetImage('assets/logofinal.PNG'),
            ),
          ),
          centerTitle: true,
          actions: [
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  icon: Icon(Icons.refresh),
                ),
              ],
            ),
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/notifications-page');
                  },
                  icon: Icon(Icons.notifications),
                ),
                FutureBuilder(
                  future: usersSignedUp(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if(snapshot.connectionState == ConnectionState.done){
                      if(snapshot.hasError){
                        return const Text("There is an error");
                      }
                      else if(snapshot.hasData){

                        //globalPolicyHolderName = snapshot.data['$globalCurrentUserLoggedInIndex']['user-name'].toString();

                        int notificationAmount = 0;
                        int index = 0;

                        if(!asGuest){
                          while(index < snapshot.data['$globalCurrentUserLoggedInIndex']['notification-amount'] + 1){
                            if(snapshot.data['$globalCurrentUserLoggedInIndex']['notifications']['$index']['available'] == true){
                              notificationAmount++;
                            }
                            index++;
                          }
                        }

                        return Container(
                          margin: EdgeInsets.only(left: 25, top:5,),
                          child: CircleAvatar(
                            radius: (notificationAmount> 0)?10:0,
                            backgroundColor: Colors.red,
                            child: Text("$notificationAmount"),
                          ),
                        );
                      }
                    }
                    return const Text("Please wait");
                  },

                ),

              ],
            ),
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    if(amountToCompare > 0){
                      Navigator.pushNamed(context,'/compare');
                    }

                  },
                  icon: Icon(Icons.directions_car),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25, top:5,),
                  child: CircleAvatar(
                    radius: (amountToCompare > 0)?10:0,
                    backgroundColor: Colors.red,
                    child: Text("${amountToCompare}"),
                  ),
                ),

              ],
            ),
          ],
          bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  child: Text(
                    "شامل",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "ضد الغير",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Brokers",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ]
          ),
        ),
        body: TabBarView(
          children: [
            // SizedBox(height: 10,),
            Container(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index){
                    if(index != 0){
                      return Padding(
                        padding: EdgeInsets.all(15),
                        child: Stack(
                          //alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              height: 250,
                              width: 450,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 20,
                                      // offset: Offset(0,3),
                                    ),
                                  ]
                              ),
                              child: Container(
                                margin: EdgeInsets.only(right: 3),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              top: 5,
                              child: Container(
                                width: (index-1 == 0 || index-1 == 2)?70:(index-1 == 1)?80:100,
                                height: (index-1 == 0 || index-1 == 2)?70:(index-1 == 1)?80:100,
                                child: Image(
                                  image: AssetImage('${firstCompanies[index-1].image}'),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: 20,
                              child: Container(
                                child: Text("${firstCompanies[index-1].title}",
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),),
                              ),
                            ),

                            Positioned(
                              left: 20,
                              top: 110,
                              child: Container(
                                child: Text("Covering type: fire, burglary, accident",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),),
                              ),
                            ),

                            Positioned(
                              left: 20,
                              top: 80,
                              child: Container(
                                child: Text("Premium: ${firstCompanies[index-1].price} EGP",style: TextStyle(
                                  fontSize: 20,
                                ),),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: 140,
                              child: Container(
                                child: Text("Rating: ${firstCompanies[index-1].loyaltyPoints}",style: TextStyle(
                                  fontSize: 20,
                                ),),
                              ),
                            ),
                            Positioned(
                              left: 260,
                              top: 190,
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green[400],
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      onBrokerCompany = false;
                                      insuranceCompanyName = firstCompanies[index-1].title;
                                      insuranceCompanyImage = firstCompanies[index-1].image;
                                      insuranceOptions = firstCompanies[index-1].insuranceOptions;
                                      globalCurrentPolicyRequestAmount = firstCompanies[index-1].price;
                                    });
                                    Navigator.pushNamed(context, '/companydetails');
                                  },
                                  child: Text(
                                    "Select",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 190,
                              top: 140,
                              child: Container(
                                height: 40,
                                width: 170,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[300],
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      onBrokerCompany = false;
                                      insuranceCompanyName = firstCompanies[index-1].title;
                                      insuranceCompanyImage = firstCompanies[index-1].image;
                                      insuranceCompanyPrice = firstCompanies[index-1].price;
                                      globalCurrentPolicyRequestAmount = firstCompanies[index-1].price;
                                      insuranceOptions = firstCompanies[index-1].insuranceOptions;
                                    });
                                    Navigator.pushNamed(context, '/insuranceoptions');
                                  },
                                  child: Text(
                                    "Additional coverages",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 30,
                              top: 190,
                              child: Container(
                                height: 45,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (firstCompanies[index-1].selected == false)?Colors.blue[600]:Colors.red,
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if(firstCompanies[index-1].selected == false){
                                        amountSelected++;
                                        firstCompanies[index-1].selected = true;
                                        var newCompare = new Map();
                                        newCompare['name'] = firstCompanies[index-1].title;
                                        newCompare['type'] = firstCompanies[index-1].subtitle;
                                        newCompare['price'] = firstCompanies[index-1].price;
                                        newCompare['image'] = firstCompanies[index-1].image;
                                        newCompare['limits'] = firstCompanies[index-1].limits;
                                        newCompare['points'] = firstCompanies[index-1].loyaltyPoints;
                                        newCompare['options'] = firstCompanies[index-1].insuranceOptions;
                                        newCompare['cond'] = true;
                                        companyList.insert(amountToCompare, newCompare);
                                        amountToCompare++;
                                      }
                                      else{
                                        amountSelected--;
                                        firstCompanies[index-1].selected = false;
                                        int idx = 0;
                                        while(idx < amountToCompare){
                                          if(firstCompanies[index-1].title == companyList[idx]['name']){
                                            companyList.remove(companyList[idx]);
                                            break;
                                          }
                                          idx++;
                                        }
                                        amountToCompare--;
                                      }
                                    });
                                    //Navigator.pushNamed(context, '/insuranceoptions');
                                  },
                                  child: Text(
                                    (firstCompanies[index-1].selected == false)?"Compare":"Cancel",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      );
                    }
                    else{
                      return Container(
                        margin: EdgeInsets.all(15),
                        width: (MediaQuery.of(context).size.width / 100) * 60,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          readOnly: true,
                          textAlignVertical: TextAlignVertical.center,
                          onTap: (){
                            showSearch(context: context, delegate: DataSearch(condition: false));
                          },
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "Search for an insurance or broker company",
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      );
                    }
                  }),
            ),
            Container(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index){
                    if(index != 0){
                      return Padding(
                        padding: EdgeInsets.all(15),
                        child: Stack(
                          //alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              height: 250,
                              width: 400,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 20,
                                      // offset: Offset(0,3),
                                    ),
                                  ]
                              ),
                              child: Container(
                                margin: EdgeInsets.only(right: 3),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: 20,
                              child: Container(
                                child: Text("${secondCompanies[index-1].title}",
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: 110,
                              child: Container(
                                child: Text("Covering type: fire, burglary, accident",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: 80,
                              child: Container(
                                child: Text("Premium: ${secondCompanies[index-1].price} EGP",style: TextStyle(
                                  fontSize: 20,
                                ),),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              top: 10,
                              child: Container(
                                width: (index-1 == 1)?75:70,
                                height: (index-1 == 1)?75:70,
                                child: Image(
                                  image: AssetImage('${secondCompanies[index-1].image}'),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: 140,
                              child: Container(
                                child: Text(" Rating: ${secondCompanies[index-1].loyaltyPoints}",style: TextStyle(
                                  fontSize: 20,
                                ),),
                              ),
                            ),
                            Positioned(
                              left: 260,
                              top: 190,
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green[400],
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      onBrokerCompany = false;
                                      insuranceCompanyName = secondCompanies[index-1].title;
                                      insuranceCompanyImage = secondCompanies[index-1].image;
                                      insuranceOptions = secondCompanies[index-1].insuranceOptions;
                                      globalCurrentPolicyRequestAmount = secondCompanies[index-1].price;
                                    });
                                    Navigator.pushNamed(context, '/companydetails');
                                  },
                                  child: Text(
                                    "Select",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 190,
                              top: 140,
                              child: Container(
                                height: 40,
                                width: 170,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[300],
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      onBrokerCompany = false;
                                      insuranceCompanyName = secondCompanies[index-1].title;
                                      insuranceCompanyImage = secondCompanies[index-1].image;
                                      insuranceCompanyPrice = secondCompanies[index-1].price;
                                      globalCurrentPolicyRequestAmount = secondCompanies[index-1].price;
                                      insuranceOptions = secondCompanies[index-1].insuranceOptions;
                                    });
                                    Navigator.pushNamed(context, '/insuranceoptions');
                                  },
                                  child: Text(
                                    "Additional coverages",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 30,
                              top: 180,
                              child: Container(
                                height: 45,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (secondCompanies[index-1].selected == false)?Colors.blue[600]:Colors.red,
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if(secondCompanies[index-1].selected == false){
                                        secondCompanies[index-1].selected = true;
                                        var newCompare = new Map();
                                        newCompare['name'] = secondCompanies[index-1].title;
                                        newCompare['type'] = secondCompanies[index-1].subtitle;
                                        newCompare['price'] = secondCompanies[index-1].price;
                                        newCompare['limits'] = secondCompanies[index-1].limits;
                                        newCompare['points'] = secondCompanies[index-1].loyaltyPoints;
                                        newCompare['options'] = secondCompanies[index-1].insuranceOptions;
                                        newCompare['image'] = secondCompanies[index-1].image;
                                        newCompare['cond'] = false;
                                        companyList.insert(amountToCompare, newCompare);
                                        amountToCompare++;
                                        amountSelected++;
                                      }
                                      else{
                                        secondCompanies[index-1].selected = false;
                                        int idx = 0;
                                        while(idx < amountToCompare){
                                          if(secondCompanies[index-1].title == companyList[idx]['name']){
                                            companyList.remove(companyList[idx]);
                                            break;
                                          }
                                          idx++;
                                        }
                                        amountToCompare--;
                                        amountSelected--;
                                      }
                                    }
                                    );
                                    //Navigator.pushNamed(context, '/insuranceoptions');
                                  },
                                  child: Text(
                                    (secondCompanies[index-1].selected == false)?"Compare":"Cancel",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      );
                    }
                    else{
                      return Container(
                        margin: EdgeInsets.all(15),
                        width: (MediaQuery.of(context).size.width / 100) * 60,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          readOnly: true,
                          textAlignVertical: TextAlignVertical.center,
                          onTap: (){
                            showSearch(context: context, delegate: DataSearch(condition: true));
                          },
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "Search for an insurance or broker company",
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      );
                    }
                  }),
            ),



            //BROKERS

            Container(
              child: ListView.builder(
                  itemCount: insuranceBrokers.length+1,
                  itemBuilder: (context, index){
                    if(index != 0){
                      return Padding(
                        padding: EdgeInsets.all(15),
                        child: Stack(
                          //alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              height: 230,
                              width: 400,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 20,
                                      // offset: Offset(0,3),
                                    ),
                                  ]
                              ),
                              child: Container(
                                margin: EdgeInsets.only(right: 3),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: 20,
                              child: Container(
                                child: Text("${insuranceBrokers[index-1].title}",
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  ),),
                              ),
                            ),
                            Positioned(
                              right: 20,
                              top: 90,
                              child: Container(
                                child: Text("${insuranceBrokers[index-1].subtitle}",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: 150,
                              child: Container(
                                child: Text("Rating: 8/10",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              top: 10,
                              child: Container(
                                width: (index-1 == 1)?75:70,
                                height: (index-1 == 1)?75:70,
                                child: Image(
                                  image: AssetImage('${insuranceBrokers[index-1].image}'),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 250,
                              top: 170,
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green[400],
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      onBrokerCompany = true;
                                      insuranceCompanyName = insuranceBrokers[index-1].title;
                                      insuranceCompanyImage = insuranceBrokers[index-1].image;
                                      insuranceOptions = insuranceBrokers[index-1].insuranceOptions;
                                      globalCurrentPolicyRequestAmount = 2000;
                                      //secondCompanies[index-1].price
                                    });
                                    Navigator.pushNamed(context, '/companydetails');
                                  },
                                  child: Text(
                                    "Select",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 200,
                              top: 80,
                              child: Container(
                                height: 40,
                                width: 170,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[300],
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      onBrokerCompany = true;
                                      insuranceCompanyName = insuranceBrokers[index-1].title;
                                      insuranceCompanyImage = insuranceBrokers[index-1].image;
                                      globalCurrentPolicyRequestAmount = 2000;
                                      //firstCompanies[index-1].price
                                      insuranceOptions = insuranceBrokers[index-1].insuranceOptions;
                                    });
                                    Navigator.pushNamed(context, '/insuranceoptions');
                                  },
                                  child: Text(
                                    "Additional coverages",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            /*
                            Positioned(
                              left: 140,
                              top: 180,
                              child: Container(
                                height: 45,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (secondCompanies[index-1].selected == false)?Colors.blue[600]:Colors.red,
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if(secondCompanies[index-1].selected == false){
                                        secondCompanies[index-1].selected = true;
                                        var newCompare = new Map();
                                        newCompare['name'] = secondCompanies[index-1].title;
                                        newCompare['type'] = secondCompanies[index-1].subtitle;
                                        newCompare['price'] = secondCompanies[index-1].price;
                                        newCompare['limits'] = secondCompanies[index-1].limits;
                                        newCompare['points'] = secondCompanies[index-1].loyaltyPoints;
                                        newCompare['options'] = secondCompanies[index-1].insuranceOptions;
                                        newCompare['image'] = secondCompanies[index-1].image;
                                        newCompare['cond'] = false;
                                        companyList.insert(amountToCompare, newCompare);
                                        amountToCompare++;
                                        amountSelected++;
                                      }
                                      else{
                                        secondCompanies[index-1].selected = false;
                                        int idx = 0;
                                        while(idx < amountToCompare){
                                          if(secondCompanies[index-1].title == companyList[idx]['name']){
                                            companyList.remove(companyList[idx]);
                                            break;
                                          }
                                          idx++;
                                        }
                                        amountToCompare--;
                                        amountSelected--;
                                      }
                                    }
                                    );
                                    //Navigator.pushNamed(context, '/insuranceoptions');
                                  },
                                  child: Text(
                                    (secondCompanies[index-1].selected == false)?"قارن":"الغاء",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            */
                          ],
                        ),

                      );
                    }
                    else{
                      return Container(
                        margin: EdgeInsets.all(15),
                        width: (MediaQuery.of(context).size.width / 100) * 60,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          readOnly: true,
                          textAlignVertical: TextAlignVertical.center,
                          onTap: (){
                            showSearch(context: context, delegate: DataSearch(condition: true));
                          },
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "Search for an insurance or broker company",
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}