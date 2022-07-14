import 'package:flutter/material.dart';
import 'package:client_application/companies/first.dart';
import 'package:client_application/constants.dart';
import 'package:client_application/companies/first.dart';
import 'package:client_application/companies/second.dart';

class DataSearch extends SearchDelegate<String>{

  final bool condition;
  DataSearch({required this.condition});

  List<String> placesNames = [

  ];

  dynamic places = [

  ];

  final recentPlaces = [

  ];

  final recentServices = [

  ];


  List<String> firstCompNames = firstCompanies.map((current) => current.title).toList();
  List<String> secondCompNames = secondCompanies.map((current) => current.title).toList();

  List<String> firstCompSub = firstCompanies.map((current) => current.subtitle).toList();
  List<String> secondCompSub = secondCompanies.map((current) => current.subtitle).toList();

  List<int> firstCompPrice = firstCompanies.map((current) => current.price).toList();
  List<int> secondCompPrice = secondCompanies.map((current) => current.price).toList();

  List<String> firstCompPoints = firstCompanies.map((current) => current.loyaltyPoints).toList();
  List<String> secondCompPoints = secondCompanies.map((current) => current.loyaltyPoints).toList();

  List<int> firstCompIndexes = firstCompanies.map((current) => current.index).toList();
  List<int> secondCompIndexes = firstCompanies.map((current) => current.index).toList();

  dynamic services = onFirst?firstCompanies:secondCompanies;


  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    // actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed:(){
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    // leading icon on the left of the appbar
    return IconButton(
        icon: AnimatedIcon(
            icon:AnimatedIcons.menu_arrow,
            progress:transitionAnimation
        ),onPressed:(){
      close(context, "null");
    });

  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    // show some result based on the selection
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    // show when someone searches for something
    final suggestionList = query.isEmpty
        ?recentPlaces:
    placesNames.where((p)=> p.startsWith(query)).toList();
    int currentIdx = 0;
    final companyNames = query.isEmpty?
    recentServices:!condition?firstCompNames.where((element) => element.startsWith(query)).toList()
        :secondCompNames.where((element) => element.startsWith(query)).toList();

    final companySubs = !condition?firstCompSub.where((element) => element.startsWith(query)).toList()
        :secondCompSub.where((element) => element.startsWith(query)).toList();

    //final currentServices = (services.map((current) =>current)).where((element) => element.title!.startsWith(query)).toList();

    return ListView.builder(
        itemCount: companyNames.length,
        itemBuilder: (context,index) {
          int x = 0;
          int length;
          if(!condition){
            length = firstCompNames.length;
          }
          else{
            length = secondCompNames.length;
          }
          while (x < length) {
            if(!condition){
              if (firstCompNames[x] == companyNames[index]) {
                currentIdx = x;
              }
            }
            else{
              if (secondCompNames[x] == companyNames[index]) {
                currentIdx = x;
              }
            }
            x++;
          }
          return Padding(
            padding: EdgeInsets.all(15),
            child: Stack(
              //alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 200,
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 12,
                          // offset: Offset(0,3),
                        ),
                      ]
                  ),
                  child: Container(
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 10,
                  child: Container(
                    child: Text("${companyNames[index]}",
                      style: TextStyle(
                        fontSize: 23,
                      ),),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 60,
                  child: Container(
                    child: Text("${!condition?firstCompSub[currentIdx]:secondCompSub[currentIdx]}",
                      style: TextStyle(
                        fontSize: 20,
                      ),),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 100,
                  child: Container(
                    child: Text("Price: ${!condition?firstCompPrice[currentIdx]:secondCompPrice[currentIdx]}",style: TextStyle(
                      fontSize: 20,
                    ),),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 130,
                  child: Container(
                    child: Text("Loyalty Points: ${!condition?firstCompPoints[currentIdx]:secondCompPoints[currentIdx]}",style: TextStyle(
                      fontSize: 20,
                    ),),
                  ),
                ),
                Positioned(
                  right: 240,
                  top: 140,
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green[400],
                    ),
                    child: TextButton(
                      onPressed: () {  },
                      child: Text(
                        "اختيار",
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
                  right: 220,
                  top: 90,
                  child: Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    child: TextButton(
                      onPressed: () {  },
                      child: Text(
                        "تغطيات اضافيه",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}
