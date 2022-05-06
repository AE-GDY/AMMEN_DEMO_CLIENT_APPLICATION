import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../services/database.dart';


class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  TextEditingController messageController = TextEditingController();

  Future<Map<String, dynamic>?> usersSignedUp() async {
    return (await FirebaseFirestore.instance.collection('users-signed-up').
    doc('users').get()).data();
  }

  Future<Map<String, dynamic>?> usersComplains() async {
    return (await FirebaseFirestore.instance.collection('user-complains').
    doc('complains').get()).data();
  }


  DataBaseService dataBaseService = DataBaseService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text("Notifications"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
          child: FutureBuilder(
            future: Future.wait([usersSignedUp(),usersComplains()]),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasError){
                  return const Text("There is an error");
                }
                else if(snapshot.hasData){
                  return Container(
                    height: 1000,
                    child: ListView.builder(
                        itemCount: snapshot.data[0]['$globalCurrentUserLoggedInIndex']['notification-amount']+1,
                        itemBuilder: (context,index){
                          if(snapshot.data[0]['$globalCurrentUserLoggedInIndex']['notifications']['$index']['notification-type'] == "Payment"
                          && snapshot.data[0]['$globalCurrentUserLoggedInIndex']['notifications']['$index']['available'] == true
                          ){
                            return Container(
                              height: 200,
                              margin: EdgeInsets.all(10),
                              child: Card(
                                elevation: 2.0,
                                child: Column(
                                  children: [
                                    Text(snapshot.data[0]['$globalCurrentUserLoggedInIndex']['notifications']['$index']['notification-sender'], style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                    SizedBox(height:20),
                                    Text("Comment: Fixes Complete", style: TextStyle(
                                      fontSize: 18
                                    ),),
                                    SizedBox(height:10),
                                    Text("Client share: ${snapshot.data[0]['$globalCurrentUserLoggedInIndex']['notifications']['$index']['client-coverage']}"
                                    , style: TextStyle(
                                        fontSize: 18
                                      ),
                                    ),
                                    SizedBox(height:20),
                                    Container(
                                      width: 100,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextButton(
                                        onPressed: () async {
                                          await dataBaseService.updateNotificationToFalse(globalCurrentUserLoggedInIndex, index);
                                          Navigator.pushNamed(context, '/payment');
                                        },
                                        child: Text("Purchase", style: TextStyle(
                                          color: Colors.white,
                                        ),),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          else if (snapshot.data[0]['$globalCurrentUserLoggedInIndex']['notifications']['$index']['notification-type'] == 'Complaint'
                          && snapshot.data[0]['$globalCurrentUserLoggedInIndex']['notifications']['$index']['available'] == true){
                            return Container(
                              height: 200,
                              margin: EdgeInsets.all(10),
                              child: Card(
                                elevation: 2.0,
                                child: Column(
                                  children: [
                                    Text(snapshot.data[0]['$globalCurrentUserLoggedInIndex']['notifications']['$index']['notification-sender'], style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                    Text("Comment: ${snapshot.data[0]['$globalCurrentUserLoggedInIndex']['notifications']['$index']['notification-text']}"),
                                    TextField(
                                      controller: messageController,
                                      decoration: InputDecoration(
                                        labelText: "Message",
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    Row(
                                      children: [
                                        SizedBox(width: 30,),
                                        Container(
                                          width: 150,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: TextButton(
                                            onPressed: () async {
                                              await dataBaseService.updateNotificationToFalse(globalCurrentUserLoggedInIndex, index);
                                              await dataBaseService.closeComplaint(
                                                  snapshot.data[0]['$globalCurrentUserLoggedInIndex']['notifications']['$index']['notification-sender'],
                                                  snapshot.data[0]['$globalCurrentUserLoggedInIndex']['notifications']['$index']['complain-index']);
                                              Navigator.pushNamed(context, '/home');
                                            },
                                            child: Text("Close Case", style: TextStyle(
                                              color: Colors.white,
                                            ),),
                                          ),
                                        ),
                                        SizedBox(width: 20,),
                                        Container(
                                          width: 150,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: TextButton(
                                            onPressed: () async {

                                              await dataBaseService.updateNotificationToFalse(globalCurrentUserLoggedInIndex, index);

                                              await dataBaseService.updateUserComplains(
                                                snapshot.data[1][snapshot.data[0]['$globalCurrentUserLoggedInIndex']['notifications']['$index']['notification-sender']]['total-complains'],
                                                false,
                                                snapshot.data[0]['$globalCurrentUserLoggedInIndex']['notifications']['$index']['notification-sender'],
                                                snapshot.data[0]['$globalCurrentUserLoggedInIndex']['notifications']['$index']['complain-index'],
                                                messageController.text,
                                                globalCurrentUserLoggedInIndex,
                                                snapshot.data[0]['$globalCurrentUserLoggedInIndex']['notification-amount']+1,
                                              );
                                              Navigator.pushNamed(context, '/home');
                                            },
                                            child: Text("Send Message", style: TextStyle(
                                              color: Colors.white,
                                            ),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          else{
                            return Container();
                          }

                        }),
                  );
                }
              }
              return const Text("Please wait");
            },

          ),
      ),
    );
  }
}
