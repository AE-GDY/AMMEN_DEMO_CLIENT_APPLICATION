import 'package:flutter/material.dart';
import 'package:client_application/companies/first.dart';
import 'package:client_application/companies/second.dart';
import '../constants.dart';


class Data extends StatefulWidget {
  const Data({Key? key}) : super(key: key);

  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {

  List<Map> selectedComps = [];
  bool companySelected = false;
  Map currentlySelected = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Container(
            width: globalWidth,
            height: globalWidth,
            child: Image(
              image: AssetImage('assets/logofinal.PNG'),
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child:  buildDataTable(),
                ),
              ),
            ),
            //  _buildSubmit(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmit() => Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    color: Colors.white,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        minimumSize: Size.fromHeight(40),
      ),
      child: Text("Continue"),
      onPressed: (){
        if(selectedComps.length > 0){
          print("GREATER");
          insuranceCompanyName = currentlySelected['name'];
          insuranceCompanyImage = currentlySelected['image'];
          insuranceOptions = currentlySelected['options'];
          Navigator.pushNamed(context, '/companydetails');
        }

      },
    ),
  );

  Widget buildDataTable(){
    final columns = ['','اسم الشركة','قيمه التحمل','تقييم', 'التغطيات', 'حد المسؤولية'];

    return DataTable(
      headingRowColor: MaterialStateColor.resolveWith((states) {return Colors.blueGrey.shade50;},),
      showBottomBorder: true,
      horizontalMargin: 15,
      dividerThickness: 1,
      headingRowHeight: 50,
      dataRowHeight: 100,
      columns: getColumns(columns),
      rows: getRows(companyList),
    );
  }

  List<DataRow> getRows(List<Map> companyList)=>companyList
      .map((Map current) => DataRow(
      selected: selectedComps.contains(current),
      onSelectChanged: (isSelected) =>setState(() {
        Map previous = currentlySelected;
        currentlySelected = current;
        selectedComps.add(currentlySelected);
        selectedComps.remove(previous);
        amountSelected--;

        insuranceCompanyName = current['name'];
        insuranceCompanyImage = current['image'];
        insuranceOptions = current['options'];
        insuranceCompanyPrice = current['price'];
        Navigator.pushNamed(context, '/companydetails');

      }),
      cells: [
        DataCell(
          Container(
            height: 60,
            width: 60,
            child: Image(
                image:AssetImage("${current['image']}",)),
          ),
        ),
        DataCell(
          Container(
            width: 120,
            child: Text("${current['name']}", style: TextStyle(
              fontSize: 18,
            ),),
          ),
        ),
        DataCell(
          Container(
            width: 60,
            child: Text("${current['price']}",style: TextStyle(
              fontSize: 18,
            ),),
          ),
        ),

        DataCell(
          Container(
            width: 60,
            child: Text("${current['points']}",style: TextStyle(
              fontSize: 18,
            ),),
          ),
        ),
        DataCell(
          Container(
            width: 160,
            child: SizedBox(
              child: ListView.builder(
                  itemCount: current['options'].length,
                  itemBuilder: (context,index){
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child:Text("-${current['options'][index]}", style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      ),);
                  }),
            ),
          ),
        ),
        DataCell(
          Container(
            width: 110,
            child: Text("${current['limits']}",style: TextStyle(
              fontSize: 18,
            ),),
          ),
        ),

      ]
  )).toList();

  List<DataColumn> getColumns(List<String> columns)=>columns
      .map((String column) => DataColumn(
    label: Text(column, style: TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.bold,
    ),),
  )).toList();



}





// OPTIONS FOR INSURANCE COMPANY
/*
              Container(
          width: 160,
          child: SizedBox(
            child: ListView.builder(
                itemCount: current['options'].length+1,
                itemBuilder: (context,index){
                  return Text("-${current['options'][index]}", style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),);
                }),
          ),
        ),
      */