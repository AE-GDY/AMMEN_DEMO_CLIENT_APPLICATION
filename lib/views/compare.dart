import 'package:flutter/material.dart';
import 'package:client_application/constants.dart';
//import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Compare extends StatefulWidget {
  const Compare({Key? key}) : super(key: key);

  @override
  _CompareState createState() => _CompareState();
}

class _CompareState extends State<Compare> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("قارن الأسعار"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 800,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              //   physics: ScrollPhysics(),
              itemCount: amountToCompare+1,
              itemBuilder: (context,index){
                if(index == amountToCompare){
                  return Stack(
                    children: [
                      Positioned(
                        right: 50,
                        top: 50,
                        child: Container(
                          child: Text("قيمه التحمل:"),
                        ),
                      ),
                    ],
                  );
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 150,),
                      Container(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text("قيمه التحمل:"),
                        ),
                      ),
                      SizedBox(height: 150,),
                      Container(
                        child: Text("نقاط:"),
                      ),
                      SizedBox(height: 150,),
                      Container(
                        child: Text("تغطيات اضافيه:"),
                      ),
                    ],
                  );
                }
                else{
                  List<String> currentOptions = companyList[index]['options'];
                  print(currentOptions);
                  return Column(
                    children: [
                      SizedBox(height: 100,),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                        ),
                        width: 100,
                        height: 50,
                        child: Text("${companyList[index]['name']}"),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                        ),
                        width: 100,
                        height: 50,
                        child: Text("${companyList[index]['price']}"),
                      ),
                      SizedBox(height: 100,),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                        ),
                        width: 100,
                        height: 50,
                        child: Text("${companyList[index]['points']}"),
                      ),
                      SizedBox(height: 100,),
                      SizedBox(
                        height: 300,
                        width: 100,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: currentOptions.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context,i){
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                ),
                                width: 100,
                                height: 50,
                                child: Text("${currentOptions[i]}"),
                              );
                            }),
                      ),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}
/*
newCompare['name'] = secondCompanies[index-1].title;
newCompare['type'] = secondCompanies[index-1].subtitle;
newCompare['price'] = secondCompanies[index-1].price;
newCompare['points'] = secondCompanies[index-1].loyaltyPoints;
//Text("${companyList[index]['name']}"),
*/