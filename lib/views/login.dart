import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var formKey = GlobalKey<FormState>();

  Future<Map<String, dynamic>?> usersSignedUpIndex() async {
    return (await FirebaseFirestore.instance.collection('users-signed-up').
    doc('users').get()).data();
  }

  String email = "";
  String password = "";

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
            height: MediaQuery.of(context).size.height - 200,
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
                        onCompany?"Company Login":"User Login",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 30,
                        ),
                      ),
                    ),

                  ],
                ),

                _buildEmailRow(),
                _buildPasswordRow(),
              ],
            ),
          ),
        ),
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

  Widget _buildSignUpBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, '/sign-up');
            },
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
                    SizedBox(height: 30,),
                    _buildContainer(),
                    _buildLoginButton(),
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
                        int userIndex = 0;
                        while(userIndex <= snapshot.data['total-user-amount']){
                          if(snapshot.data['$userIndex']['user-email'] == globalUserEmail){
                            if(snapshot.data['$userIndex']['user-password'] == globalUserPassword){
                              globalCurrentUserLoggedInIndex = userIndex;
                              globalPolicyHolderName = snapshot.data['$userIndex']['user-name'];
                              print("USER INDEX ${globalCurrentUserLoggedInIndex}");
                              break;
                            }
                          }
                          userIndex++;
                        }

                        Navigator.pushNamed(context, '/home');
                      }
                    },
                    child: Text(
                      "Login",
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
}
