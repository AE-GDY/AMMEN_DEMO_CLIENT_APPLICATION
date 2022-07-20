import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client_application/constants.dart';
import 'package:client_application/models/checkbox.dart';

class InsuranceOptions extends StatefulWidget {
  const InsuranceOptions({Key? key}) : super(key: key);

  @override
  _InsuranceOptionsState createState() => _InsuranceOptionsState();
}

class _InsuranceOptionsState extends State<InsuranceOptions> {


  Future<Map<String, dynamic>?> insuranceCompanies() async {
    return (await FirebaseFirestore.instance.collection('insurance-companies').
    doc('insurance-company-list').get()).data();
  }

  bool value = false;

  final selectAll = CheckBoxState(title: 'Select all');
  List<CheckBoxState> optionsList = insuranceOptions.map((current) => CheckBoxState(title: current)).toList();

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.green;
      }
      return Colors.blue;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Additional Coverages "),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 60),
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(30),
                  topRight: const Radius.circular(30),
                ),
              ),
            ),
          ),
          FutureBuilder(
            future: insuranceCompanies(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasError){
                  return const Text("There is an error");
                }
                else if(snapshot.hasData){
                  return Container(
                    child: ListView.builder(
                        itemCount: snapshot.data['$globalCurrentInsuranceCompany']['additional-coverages-amount']+1,
                        itemBuilder: (context,index){
                          if(index == 0){
                            return Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text("$insuranceCompanyName", style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                    textAlign: TextAlign.center,),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                ),
                                Card(
                                  elevation: 0,
                                  margin: EdgeInsets.all(10),
                                  child: buildGroupCheckBox(selectAll),
                                ),
                                Divider(color: Colors.black,thickness: 1,),
                                // Divider(color: Colors.black,),
                              ],
                            );
                          }
                          else if(index == optionsList.length+1){
                            return Container(
                              margin: EdgeInsets.all(20),
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green[400],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/companydetails');
                                },
                                child: Text(
                                  "Continue",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            );
                          }
                          else{
                            return Container(
                              height: 90,
                              child: Card(
                                elevation:2,
                                margin: EdgeInsets.all(10),
                                child: buildSingleCheckBox(optionsList[index-1], snapshot.data['$globalCurrentInsuranceCompany']['additional-coverages'][index-1]),
                              ),
                            );
                          }
                        }
                    ),
                  );
                }
              }
              return const Text("Please wait");
            },

          ),
        ],
      ),
    );
  }

  Widget buildSingleCheckBox(CheckBoxState checkBox, String currentOption) => CheckboxListTile(
      controlAffinity: ListTileControlAffinity.trailing,
      value: checkBox.value,
      activeColor: Colors.blue,
      title: Text(currentOption, textAlign: TextAlign.start, style: const TextStyle(
        fontSize: 20,
      ),),
      onChanged: (value){
        setState(() {
          checkBox.value = value!;
          selectAll.value = optionsList.every((element) => element.value);
        });
      }
  );

  Widget buildGroupCheckBox(CheckBoxState checkBox) => CheckboxListTile(
    controlAffinity: ListTileControlAffinity.trailing,
    value: checkBox.value,
    activeColor: Colors.blue,
    title: Text("${checkBox.title}",textAlign: TextAlign.start,style: TextStyle(
      fontSize: 20,
    ),),
    onChanged: (value) {
      if(value == null){
        return;
      }
      setState(() {
        selectAll.value = value;
        optionsList.forEach((element)=>element.value = value);
      });
    },
  );
}
