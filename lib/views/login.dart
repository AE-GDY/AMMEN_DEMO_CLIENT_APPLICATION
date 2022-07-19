import 'package:client_application/services/database.dart';
import 'package:client_application/services/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:client_application/constants.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Storage _storage = Storage();

  bool secureText = true;
  String userName = "";
  String dateOfBirth = "";
  String iD = "";
  String email = "";
  String password = "";
  String nationality = "";
  String mobileNumber = "";
  String city = "";
  String carModel = "";
  String carType = "";
  String modelYear = "";

  bool leftSelected = false;
  var formKey = GlobalKey<FormState>();

  DataBaseService dataBaseService = DataBaseService();

  Future<Map<String, dynamic>?> usersSignedUpIndex() async {
    return (await FirebaseFirestore.instance.collection('users-signed-up').
    doc('users').get()).data();
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Text(
            'Integrated car insurance platform',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 35,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildEmailRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator: (value){
          if(value!.length < 4){
            return "Enter at least 4 characters";
          }
          else{
            return null;
          }
        },
        onSaved: (value) => setState(() => globalUserEmail = value!),
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: mainColor,
            ),
            labelText: 'E-mail'),
      ),
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
        onSaved: (value) => setState(() => globalUserPassword = value!),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'Password',
        ),
      ),
    );
  }

  Widget _buildDateRow() {
    if(!onCompany){
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
          onSaved: (value) => setState(() => globalDateOfBirth = value!),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: mainColor,
            ),
            labelText: 'Date of Birth',
          ),
        ),
      );
    }
    return Container();
  }

  Widget _buildIdRow() {
    if(!onCompany){
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
          onSaved: (value) => setState(() => globalPolicyHolderID = value!),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: mainColor,
            ),
            labelText: 'National ID',
          ),
        ),
      );
    }
    return Container();

  }

  Widget _buildDrivingLicenseRow(){
    if(!onCompany){
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
          onSaved: (value) => setState(() => globalDrivingLicenseId = value!),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: mainColor,
            ),
            labelText: 'Driving License',
          ),
        ),
      );
    }
    return Container();
  }

  Widget _buildBeneficiaryRow(){
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
        onSaved: (value) => setState(() => globalBeneficiary = value!),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'Beneficiary',
        ),
      ),
    );
  }



  Widget _buildCarTypeRow(){
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        // obscureText: true,
        validator: (value){
          if(value!.length < 4){
            return "Enter at least 4 characters";
          }
          else{
            return null;
          }
        },
        onSaved: (value) => setState(() => globalVehicleMake = value!),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'Vehicle Make',
        ),
      ),
    );
  }

  Widget _buildModelYearRow(){
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        //  obscureText: true,
        validator: (value){
          if(value!.length < 4){
            return "Enter at least 4 characters";
          }
          else{
            return null;
          }
        },
        onSaved: (value) => setState(() => globalProductionYear = value!),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'Production Year',
        ),
      ),
    );
  }



  Widget _buildCityRow(){
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        //  obscureText: true,
        validator: (value){
          if(value!.length < 4){
            return "Enter at least 4 characters";
          }
          else{
            return null;
          }
        },
        onSaved: (value) => setState(() => city = value!),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'City',
        ),
      ),
    );
  }

  Widget _buildMobileRow(){
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        //    obscureText: true,
        validator: (value){
          if(value!.length < 4){
            return "Enter at least 4 characters";
          }
          else{
            return null;
          }
        },
        onSaved: (value) => setState(() => globalUserMobile = value!),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'Mobile',
        ),
      ),
    );
  }

  Widget _buildNameRow() {
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
        onSaved: (value) => setState(() => globalPolicyHolderName = value!),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: onCompany?'Company Name':'Full Name',
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
          width: 5 * (MediaQuery.of(context).size.width / 7),
          margin: EdgeInsets.only(bottom: 20),
          child: FutureBuilder(
            future: usersSignedUpIndex(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done){
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('there is an error'),
                  );
                }
                else if(snapshot.hasData){
                  return RaisedButton(
                    elevation: 5.0,
                    color: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    onPressed: () async {


                      FocusScope.of(context).unfocus();
                      final isValid = formKey.currentState!.validate();
                      if(isValid){
                        formKey.currentState!.save();
                        setState(() {
                          fullName  = userName;
                          nationalID  = iD;
                          insuranceDate = dateOfBirth;
                          userEmail = email;
                          userPassword = password;
                          snapshot.data['total-user-amount'] += 1;
                          currentAmountOfSignedInUsers = snapshot.data['total-user-amount'];
                          globalCurrentUserLoggedInIndex = snapshot.data['total-user-amount'];
                          //globalNotificationAmount = snapshot.data['notification-amount'];
                          print("global user index : $globalCurrentUserLoggedInIndex");
                        });
                        await dataBaseService.updateSignedUpUsers(
                            onCompany,
                            snapshot.data['total-user-amount'],
                            globalPolicyHolderName,
                            globalPolicyHolderID,
                            globalDateOfBirth,
                            globalUserEmail,
                            globalUserPassword,
                            globalUserMobile,
                            globalDrivingLicenseId,
                            globalBeneficiary,
                        );

                        _storage.uploadFile('users-signed-up', '${snapshot.data['total-user-amount']}/national-id', _image!.path);

                        Navigator.pushNamed(context, '/home');
                      }
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        fontSize: MediaQuery.of(context).size.height / 30,
                      ),
                    ),
                  );
                }
              }
              return const Text("Please wait");
            },

          ),
        )
      ],
    );
  }

  Widget _buildGuestButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.5 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(bottom: 20),
          child: RaisedButton(
            elevation: 5.0,
            color: mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () {
              FocusScope.of(context).unfocus();
              setState(() {
                asGuest = true;
                fullName  = "";
              });
              Navigator.pushNamed(context, '/home');
            },
            child: Text(
              "Enter as Guest",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                fontSize: 17,
              ),
            ),
          ),
        )
      ],
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
            height: MediaQuery.of(context).size.height * 2,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20,),
                _buildGuestButton(),
                SizedBox(height: 30,),
                Row(
                  children: [
                    SizedBox(width: 20,),
                    Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        color: onCompany?Colors.blueGrey[50]:Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: (){
                          setState(() {
                            onCompany = false;
                          });
                        },
                        child: Text("User",
                          style: TextStyle(
                            color: onCompany?Colors.black:Colors.white,
                            fontSize: 18,
                          ),),
                      ),
                    ),
                    SizedBox(width: 30,),
                    Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        color: onCompany?Colors.blue:Colors.blueGrey[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: (){
                          setState(() {
                            onCompany = true;
                          });
                        },
                        child: Text("Company",
                          style: TextStyle(
                            color: onCompany?Colors.white:Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        onCompany?"Company Registration":"User registration",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 30,
                        ),
                      ),
                    ),

                  ],
                ),

                _buildNameRow(),
                _buildIdRow(),
                _buildDateRow(),
                _buildEmailRow(),
                _buildPasswordRow(),
                _buildMobileRow(),
                _buildDrivingLicenseRow(),
                _buildBeneficiaryRow(),
               // _buildCarTypeRow(),
              //  _buildModelYearRow(),
                SizedBox(height: 10,),
                buildAttachId(),
                _buildForgetPasswordButton(),
                SizedBox(height: 30,),
                _buildLoginButton(),

                //_buildOrRow(),
                // _buildSocialBtnRow(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAttachId(){
    if(onCompany){
      return Container();
    }
    else{
      return Container(
        height: 100,
        width: 250,
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          border: Border.all(width: 1.0,),
        ),
        child: Center(
          child: TextButton(
            onPressed: (){
              getImage(true);
            },
            child: _image == null?Text("Attach National ID", style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ):Image.file(_image!, height: 400.0, width: 600.0,)),),
      );
    }
  }
  

  Widget _buildSignUpBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 40),
          child: FlatButton(
            onPressed: () {},
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'Dont have an account? ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.height / 40,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: 'Sign Up',
                  style: TextStyle(
                    color: mainColor,
                    fontSize: MediaQuery.of(context).size.height / 40,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]),
            ),
          ),
        ),
      ],
    );
  }


  File? _image;
  final ImagePicker _picker = ImagePicker();
  Future getImage(bool isCamera) async {
    XFile? image;
      if(isCamera){
        image = await _picker.pickImage(source: ImageSource.camera);
        setState(() {
          _image = File(image!.path);
        });
      }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          centerTitle: true,
          title: Container(
            width: globalWidth,
            height: globalHeight ,
            child: Image(
              image: AssetImage('assets/logofinal.PNG'),
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfff2f3f7),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formKey,
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    _buildLogo(),
                    _buildContainer(),
                    _buildSignUpBtn(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}