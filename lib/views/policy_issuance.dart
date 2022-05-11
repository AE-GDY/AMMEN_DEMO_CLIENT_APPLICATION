import 'package:client_application/constants.dart';
import 'package:flutter/material.dart';

class PolicyIssuance extends StatefulWidget {
  const PolicyIssuance({Key? key}) : super(key: key);

  @override
  _PolicyIssuanceState createState() => _PolicyIssuanceState();
}

class _PolicyIssuanceState extends State<PolicyIssuance> {


  final _formKey = GlobalKey<FormState>();
  String policyHolderID = '';
  String policyHolderName = '';
  String mobile = '';
  String address = '';
  String email = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Policy Request"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children:  [
              SizedBox(height: 10,),
              SizedBox(height: 20,),
              Text("User Info"),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20.0,),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Policyholder ID',
                      ),
                      validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
                      //obscureText: true,
                      onChanged: (val){
                        setState(() {
                          policyHolderID = val;
                        });
                      },
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Policyholder name',
                      ),
                      validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
                      //obscureText: true,
                      onChanged: (val){
                        setState(() {
                          policyHolderName = val;
                        });
                      },
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Policyholder mobile',
                      ),
                      validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
                     // obscureText: true,
                      onChanged: (val){
                        setState(() {
                          mobile = val;
                        });
                      },
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Policyholder address',
                      ),
                      validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
                      //obscureText: true,
                      onChanged: (val){
                        address = val;
                      },
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Policyholder email',
                      ),
                      validator: (val) => val!.isEmpty ? 'Please fill in this field': null,
                      //obscureText: true,
                      onChanged: (val){
                        email = val;
                      },
                    ),

                    SizedBox(height: 10,),
                    ElevatedButton(
                        onPressed: () async {

                          FocusScope.of(context).unfocus();
                          final isValid = _formKey.currentState!.validate();
                          if(isValid) {
                            globalPolicyHolderID = policyHolderID;
                            globalPolicyHolderName = policyHolderName;
                            globalUserMobile = mobile;
                            globalUserAddress = address;
                            globalUserEmail = email;
                            Navigator.pushNamed(context, '/vehicleInfo');
                          }
                        },
                        child: Text("continue"),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
