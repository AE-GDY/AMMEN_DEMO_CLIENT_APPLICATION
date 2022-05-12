import 'package:client_application/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:client_application/companies/first.dart';
import 'package:client_application/companies/second.dart';
import 'package:client_application/constants.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

  DataBaseService dataBaseService = DataBaseService();


  TextEditingController ratingController1 = TextEditingController();
  TextEditingController ratingController2 = TextEditingController();
  TextEditingController ratingController3 = TextEditingController();
  TextEditingController ratingController4 = TextEditingController();
  TextEditingController ratingController5 = TextEditingController();
  TextEditingController ratingController6 = TextEditingController();
  TextEditingController ratingController7 = TextEditingController();
  TextEditingController ratingController8 = TextEditingController();
  TextEditingController ratingController9 = TextEditingController();
  TextEditingController ratingController10 = TextEditingController();
  TextEditingController ratingController11 = TextEditingController();
  TextEditingController ratingController12 = TextEditingController();
  TextEditingController ratingController13 = TextEditingController();
  TextEditingController ratingController14 = TextEditingController();
  TextEditingController ratingController15 = TextEditingController();
  TextEditingController ratingController16 = TextEditingController();

  bool secureText = true;
  bool agreed = false;
  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";
  String confirmSignature = "";
  String cardHolder = "";
  bool confirmedSelected  = false;

  bool leftSelected = false;
  var formKey = GlobalKey<FormState>();

  Future<Map<String, dynamic>?> policyApprovalData() async {
    return (await FirebaseFirestore.instance.collection('users-policy-approvals').
    doc('approvals').get()).data();
  }

  Future<Map<String, dynamic>?> policyRequestsData(String companyName) async {
    return (await FirebaseFirestore.instance.collection('users-policy-requests').
    doc(currentCompanyToPay).get()).data();
  }

  Future<Map<String, dynamic>?> requestsDocPolicyRequestsData() async {
    return (await FirebaseFirestore.instance.collection('users-policy-requests').
    doc("requests").get()).data();
  }

  Future<Map<String, dynamic>?> brokerPolicyRequestsData(String brokerName) async {
    return (await FirebaseFirestore.instance.collection('users-policy-requests-broker').
    doc(brokerName).get()).data();
  }


  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Text(
            'الموقع الاول لمقارنه اسعار التامين في مصر',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildPasswordRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        validator: (value){
          if(value!.length < 4){
            return "Enter at least 4 characters";
          }
          else{
            return null;
          }
        },
        onSaved: (value) => setState(() => cardNumber = value!),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'Card Number',
        ),
      ),
    );
  }

  Widget _buildDateRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        validator: (value){
          if(value!.length < 4){
            return "Enter at least 4 characters";
          }
          else{
            return null;
          }
        },
        onSaved: (value) => setState(() => expiryDate = value!),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'Expiry Date',
        ),
      ),
    );
  }

  Widget _buildIdRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        validator: (value){
          if(value!.length < 4){
            return "Enter at least 4 characters";
          }
          else{
            return null;
          }
        },
        onSaved: (value) => setState(() => cvv = value!),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'CVV',
        ),
      ),
    );
  }

  Widget _buildNameRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        validator: (value){
          if(value!.length < 4){
            return "Enter at least 4 characters";
          }
          else{
            return null;
          }
        },
        onSaved: (value) => setState(() => cardHolder = value!),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'Card Holder',
        ),
      ),
    );
  }

  Widget _buildForgetPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextButton(
          onPressed: () {},
          child: Text("Forgot Password"),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.5 * (MediaQuery.of(context).size.height / 20),
          width: 8 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(bottom: 20),
          child: RaisedButton(
            elevation: 5.0,
            color: (confirmedSelected == true)?mainColor:Colors.blueGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () {
              FocusScope.of(context).unfocus();
              final isValid = formKey.currentState!.validate();
              if(isValid && confirmedSelected == true){
                formKey.currentState!.save();
                setState(() {
                  userCardHolder = cardHolder;
                  cardExpiryDate = expiryDate;
                  cardCvv = cvv;
                  userCardNumber = cardNumber;

                  setState(() {
                    int idx = 0;
                    while(idx < firstCompanies.length){
                      firstCompanies[idx].selected = false;
                      idx++;
                    }
                    idx = 0;
                    while(idx < secondCompanies.length){
                      secondCompanies[idx].selected = false;
                      idx++;
                    }

                    companyList.removeRange(0, companyList.length);
                    amountToCompare = 0;
                  });
                });
                print("$userCardHolder");
                print("$cardExpiryDate");
                print("$cardCvv");
                print("$userCardNumber");




                Navigator.pushNamed(context, '/booked');
              }
            },
            child: Text(
              "Proceed to Payment",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                fontSize: MediaQuery.of(context).size.height / 45,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildConfirmNameRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        //obscureText: true,
        validator: (value){
          if(value!.length < 4){
            return "Enter at least 4 characters";
          }
          else{
            return null;
          }
        },
        onSaved: (value) => setState(() => confirmSignature = value!),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'Enter full legal name',
        ),
      ),
    );
  }


  Widget _buildCertButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 30,),
      width: 230,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30),
      ),
      child: MaterialButton(
        onPressed: (){
          Navigator.pushNamed(context, '/home');
        },
        child: Text("تحميل شهادة التأمين", style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),),
      ),
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 1.5,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child:Image(
                    image: AssetImage('assets/visa.png'),
                  ),
                  width: 100,
                  height: 100,
                ),

                _buildNameRow(),
                _buildIdRow(),
                _buildDateRow(),
                _buildPasswordRow(),
                SizedBox(height: 20,),
               // _buildCertButton(),
                SizedBox(height: 50,),
                _buildConfirmNameRow(),
                SizedBox(height: 30,),
                _buildLoginButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }


  List<bool> chosenRating0 = [false,false,false,false,false,false];
  List<bool> chosenRating1 = [false,false,false,false,false,false];
  List<bool> chosenRating2 = [false,false,false,false,false,false];
  List<bool> chosenRating3 = [false,false,false,false,false,false];
  List<bool> chosenRating4 = [false,false,false,false,false,false];
  List<bool> chosenRating5 = [false,false,false,false,false,false];
  List<bool> chosenRating6 = [false,false,false,false,false,false];
  List<bool> chosenRating7 = [false,false,false,false,false,false];
  List<bool> chosenRating8 = [false,false,false,false,false,false];
  List<bool> chosenRating9 = [false,false,false,false,false,false];
  List<bool> chosenRating10 = [false,false,false,false,false,false];
  List<bool> chosenRating11 = [false,false,false,false,false,false];
  List<bool> chosenRating12 = [false,false,false,false,false,false];
  List<bool> chosenRating13 = [false,false,false,false,false,false];
  List<bool> chosenRating14 = [false,false,false,false,false,false];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          centerTitle: true,
          title: Container(
            width: globalWidth,
            height: globalHeight,
            child: Image(
              image: AssetImage('assets/logofinal.PNG'),
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfff2f3f7),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          child: Form(
          key: formKey,
          child: Container(
            height: 3000,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  child: SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      decoration: BoxDecoration(
                          color: mainColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: const Radius.circular(30),
                          bottomRight: const Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    height: 2100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              child: Container(
                                height: MediaQuery.of(context).size.height * 3,
                                width: MediaQuery.of(context).size.width * 1,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        SizedBox(width: 100,),
                                        Container(
                                          child:Image(
                                            image: AssetImage('assets/visa.png'),
                                          ),
                                          width: 100,
                                          height: 100,
                                        ),
                                        Container(
                                          child:Image(
                                            image: AssetImage('assets/fawry.png'),
                                          ),
                                          width: 150,
                                          height: 150,
                                        ),
                                      ],
                                    ),

                                    _buildNameRow(),
                                    _buildIdRow(),
                                    _buildDateRow(),
                                    _buildPasswordRow(),
                                    SizedBox(height: 20,),
                                   // _buildCertButton(),
                                    SizedBox(height: 50,),

                                    Text("Please provide your ratings below from 1-5 (5:Very satisfied, 1: Vert disatisfied):", style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                    SizedBox(height: 20,),

                                    Expanded(child: buildRatingCriteria(0,chosenRating0, isClaimRequest)),
                                    Expanded(child:buildRatingCriteria(1,chosenRating1, isClaimRequest)),
                                    Expanded(child:buildRatingCriteria(2,chosenRating2, isClaimRequest)),
                                    Expanded(child:buildRatingCriteria(3,chosenRating3, isClaimRequest)),
                                    Expanded(child:buildRatingCriteria(4,chosenRating4, isClaimRequest)),
                                    Expanded(child:buildRatingCriteria(5,chosenRating5, isClaimRequest)),
                                    Expanded(child:buildRatingCriteria(6,chosenRating6, isClaimRequest)),
                                    Expanded(child:buildRatingCriteria(7,chosenRating7, isClaimRequest)),
                                    Expanded(child:buildRatingCriteria(8,chosenRating8, isClaimRequest)),
                                    Expanded(child:buildRatingCriteria(9,chosenRating9, isClaimRequest)),
                                    Expanded(child:buildRatingCriteria(10,chosenRating10, isClaimRequest)),

                                    SizedBox(height: 30,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        FutureBuilder(
                                          future: Future.wait([requestsDocPolicyRequestsData(),policyApprovalData(),policyRequestsData(draftInsuranceCompany),brokerPolicyRequestsData(draftBrokerCompany)]),
                                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                            if(snapshot.connectionState == ConnectionState.done){
                                              if(snapshot.hasError){
                                                return const Text("There is an error");
                                              }
                                              else if(snapshot.hasData){



                                                return Container(
                                                  height: 1.5 * (MediaQuery.of(context).size.height / 20),
                                                  width: 8 * (MediaQuery.of(context).size.width / 10),
                                                  margin: EdgeInsets.only(bottom: 20),
                                                  child: RaisedButton(
                                                    elevation: 5.0,
                                                    color: (
                                                        chosenRating0[5] &&
                                                        chosenRating1[5] &&
                                                        chosenRating2[5] &&
                                                        chosenRating3[5] &&
                                                        chosenRating4[5] &&
                                                        chosenRating5[5] &&
                                                        chosenRating6[5] &&
                                                        chosenRating7[5] &&
                                                        chosenRating8[5] &&
                                                        chosenRating9[5] &&
                                                        chosenRating10[5]
                                                    )?mainColor:Colors.blueGrey,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(30.0),
                                                    ),
                                                    onPressed: () async {
                                                      FocusScope.of(context).unfocus();
                                                      final isValid = formKey.currentState!.validate();
                                                      if(isValid && agreeTermsAndConditions == true &&
                                                          chosenRating0[5] &&
                                                          chosenRating1[5] &&
                                                          chosenRating2[5] &&
                                                          chosenRating3[5] &&
                                                          chosenRating4[5] &&
                                                          chosenRating5[5] &&
                                                          chosenRating6[5] &&
                                                          chosenRating7[5] &&
                                                          chosenRating8[5] &&
                                                          chosenRating9[5] &&
                                                          chosenRating10[5] &&
                                                          isClaimRequest == false){
                                                        formKey.currentState!.save();
                                                        setState(() {
                                                          userCardHolder = cardHolder;
                                                          cardExpiryDate = expiryDate;
                                                          cardCvv = cvv;
                                                          userCardNumber = cardNumber;

                                                          setState(() {
                                                            int idx = 0;
                                                            while(idx < firstCompanies.length){
                                                              firstCompanies[idx].selected = false;
                                                              idx++;
                                                            }
                                                            idx = 0;
                                                            while(idx < secondCompanies.length){
                                                              secondCompanies[idx].selected = false;
                                                              idx++;
                                                            }

                                                            companyList.removeRange(0, companyList.length);
                                                            amountToCompare = 0;
                                                          });
                                                        });
                                                        print("$userCardHolder");
                                                        print("$cardExpiryDate");
                                                        print("$cardCvv");
                                                        print("$userCardNumber");


                                                        Navigator.pushNamed(context, '/booked');


                                                        if(amountOfVehiclesMoreThanOne){
                                                          print("REACHED WHERE THERE IS MORE THAN ONE VEHICLE");
                                                          int vehicleIndex = 0;
                                                          while(vehicleIndex < snapshot.data[0]['$globalIndexToPay']['vehicle-amount']){
                                                            print("UPDATED VEHICLE STATUS IN USERS SIGNED UP DOC");
                                                            await dataBaseService.updateUserVehicleStatus(
                                                              globalCurrentUserLoggedInIndex,
                                                              pendingVehicles[vehicleIndex].currentIndex,
                                                            );
                                                            vehicleIndex++;
                                                          }
                                                        }
                                                        else{
                                                          await dataBaseService.updateUserVehicleStatus(
                                                            globalCurrentUserLoggedInIndex,
                                                            globalVehicleIndex,
                                                          );
                                                        }

                                                        await dataBaseService.requestsDocUpdateUserPurchased(
                                                          snapshot.data[0]['$globalIndexToPay']['policy-number'],
                                                        );

                                                        await dataBaseService.updatePendingAndOverallAmount(
                                                          currentCompanyToPay,
                                                          snapshot.data[2]['total-pending-policies']-1,
                                                          snapshot.data[2]['total-amount-approved']+1,
                                                          false,
                                                        );

                                                        await dataBaseService.updatePendingAndOverallAmount(
                                                          currentBrokerToPay,
                                                          snapshot.data[3]['total-pending-policies']-1,
                                                          snapshot.data[3]['total-amount-approved']+1,
                                                          true,
                                                        );
                                                      }
                                                      else if(isValid && agreeTermsAndConditions == true &&
                                                          chosenRating0[5] &&
                                                          chosenRating1[5] &&
                                                          chosenRating2[5] &&
                                                          chosenRating3[5] &&
                                                          chosenRating4[5] &&
                                                          chosenRating5[5] &&
                                                          chosenRating6[5] &&
                                                          chosenRating7[5] &&
                                                          chosenRating8[5] &&
                                                          chosenRating9[5] &&
                                                          chosenRating10[5] &&
                                                          isClaimRequest == true){
                                                        await dataBaseService.claimUpdateUserApprovalData(globalClaimIndex);
                                                        await dataBaseService.claimUpdateStatusDeclinedInsuranceComp(globalToPayIntendedComp,globalClaimNumberInsComp);
                                                        isClaimRequest = false;
                                                        Navigator.pushNamed(context, '/booked');
                                                      }
                                                    },
                                                    child: Text(
                                                      "Proceed to Payment",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        letterSpacing: 1,
                                                        fontSize: MediaQuery.of(context).size.height / 45,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                            }
                                            return const Text("Please wait");
                                          },

                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ),
    );
  }


  Widget buildRatingCriteria(int index, List<bool> ratingList, bool isClaimRequest){
    if(!isClaimRequest){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(ratingCriteriaNew[index], style: TextStyle(
            fontSize: 16,
          ),),
          SizedBox(height:0,),
          Row(
            children: [
              SizedBox(width: 60,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: ratingList[0]?mainColor:Colors.grey[200],
                ),
                width: 40,
                height: 40,
                child: TextButton(
                  onPressed: (){
                    print("PRESSED");
                    setState(() {
                      ratingList[0] = true;
                      ratingList[1] = false;
                      ratingList[2] = false;
                      ratingList[3] = false;
                      ratingList[4] = false;
                      ratingList[5] = true;

                    });

                  },
                  child: Text("1", style: TextStyle(
                    color: ratingList[0]?Colors.white:Colors.black,
                  ),),
                ),
              ),
              SizedBox(width: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: ratingList[1]?mainColor:Colors.grey[200],
                ),
                width: 40,
                height: 40,
                child: TextButton(
                  onPressed: (){
                    setState(() {
                      ratingList[0] = false;
                      ratingList[1] = true;
                      ratingList[2] = false;
                      ratingList[3] = false;
                      ratingList[4] = false;
                      ratingList[5] = true;

                    });

                  },
                  child: Text("2", style: TextStyle(
                    color: ratingList[1]?Colors.white:Colors.black,
                  ),),
                ),
              ),
              SizedBox(width: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: ratingList[2]?mainColor:Colors.grey[200],
                ),
                width: 40,
                height: 40,
                child: TextButton(
                  onPressed: (){
                    setState(() {
                      ratingList[0] = false;
                      ratingList[1] = false;
                      ratingList[2] = true;
                      ratingList[3] = false;
                      ratingList[4] = false;
                      ratingList[5] = true;

                    });

                  },
                  child: Text("3", style: TextStyle(
                    color: ratingList[2]?Colors.white:Colors.black,
                  ),),
                ),
              ),
              SizedBox(width: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: ratingList[3]?mainColor:Colors.grey[200],
                ),
                width: 40,
                height: 40,
                child: TextButton(
                  onPressed: (){
                    setState(() {
                      ratingList[0] = false;
                      ratingList[1] = false;
                      ratingList[2] = false;
                      ratingList[3] = true;
                      ratingList[4] = false;
                      ratingList[5] = true;

                    });

                  },
                  child: Text("4", style: TextStyle(
                    color: ratingList[3]?Colors.white:Colors.black,
                  ),),
                ),
              ),
              SizedBox(width: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: ratingList[4]?mainColor:Colors.grey[200],
                ),
                width: 40,
                height: 40,
                child: TextButton(
                  onPressed: (){
                    setState(() {
                      ratingList[0] = false;
                      ratingList[1] = false;
                      ratingList[2] = false;
                      ratingList[3] = false;
                      ratingList[4] = true;
                      ratingList[5] = true;
                    });

                  },
                  child: Text("5", style: TextStyle(
                    color: ratingList[4]?Colors.white:Colors.black,
                  ),),
                ),
              ),
              SizedBox(height: 10,),
            ],
          ),
        ],
      );
    }
    else{
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(ratingCriteriaNewClaim[index], style: TextStyle(
            fontSize: 16,
          ),),
          SizedBox(height:0,),
          Row(
            children: [
              SizedBox(width: 60,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: ratingList[0]?mainColor:Colors.grey[200],
                ),
                width: 40,
                height: 40,
                child: TextButton(
                  onPressed: (){
                    print("PRESSED");
                    setState(() {
                      ratingList[0] = true;
                      ratingList[1] = false;
                      ratingList[2] = false;
                      ratingList[3] = false;
                      ratingList[4] = false;
                      ratingList[5] = true;

                    });

                  },
                  child: Text("1", style: TextStyle(
                    color: ratingList[0]?Colors.white:Colors.black,
                  ),),
                ),
              ),
              SizedBox(width: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: ratingList[1]?mainColor:Colors.grey[200],
                ),
                width: 40,
                height: 40,
                child: TextButton(
                  onPressed: (){
                    setState(() {
                      ratingList[0] = false;
                      ratingList[1] = true;
                      ratingList[2] = false;
                      ratingList[3] = false;
                      ratingList[4] = false;
                      ratingList[5] = true;

                    });

                  },
                  child: Text("2", style: TextStyle(
                    color: ratingList[1]?Colors.white:Colors.black,
                  ),),
                ),
              ),
              SizedBox(width: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: ratingList[2]?mainColor:Colors.grey[200],
                ),
                width: 40,
                height: 40,
                child: TextButton(
                  onPressed: (){
                    setState(() {
                      ratingList[0] = false;
                      ratingList[1] = false;
                      ratingList[2] = true;
                      ratingList[3] = false;
                      ratingList[4] = false;
                      ratingList[5] = true;

                    });

                  },
                  child: Text("3", style: TextStyle(
                    color: ratingList[2]?Colors.white:Colors.black,
                  ),),
                ),
              ),
              SizedBox(width: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: ratingList[3]?mainColor:Colors.grey[200],
                ),
                width: 40,
                height: 40,
                child: TextButton(
                  onPressed: (){
                    setState(() {
                      ratingList[0] = false;
                      ratingList[1] = false;
                      ratingList[2] = false;
                      ratingList[3] = true;
                      ratingList[4] = false;
                      ratingList[5] = true;

                    });

                  },
                  child: Text("4", style: TextStyle(
                    color: ratingList[3]?Colors.white:Colors.black,
                  ),),
                ),
              ),
              SizedBox(width: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: ratingList[4]?mainColor:Colors.grey[200],
                ),
                width: 40,
                height: 40,
                child: TextButton(
                  onPressed: (){
                    setState(() {
                      ratingList[0] = false;
                      ratingList[1] = false;
                      ratingList[2] = false;
                      ratingList[3] = false;
                      ratingList[4] = true;
                      ratingList[5] = true;
                    });

                  },
                  child: Text("5", style: TextStyle(
                    color: ratingList[4]?Colors.white:Colors.black,
                  ),),
                ),
              ),
              SizedBox(height: 10,),
            ],
          ),
        ],
      );
    }
  }


}


