import 'package:client_application/views/complains.dart';
import 'package:client_application/views/dashboard.dart';
import 'package:client_application/views/login.dart';
import 'package:client_application/views/notifications.dart';
import 'package:client_application/views/pending_claims.dart';
import 'package:client_application/views/pending_policies.dart';
import 'package:client_application/views/pending_vehicle.dart';
import 'package:client_application/views/policy_draft.dart';
import 'package:client_application/views/policy_issuance.dart';
import 'package:client_application/views/registervehicle.dart';
import 'package:client_application/views/signuplater.dart';
import 'package:client_application/views/t_and_c.dart';
import 'package:client_application/views/user_claim_request.dart';
import 'package:client_application/views/usercars.dart';
import 'package:client_application/views/vehicle_info.dart';
import 'package:client_application/views/booked.dart';
import 'package:client_application/views/datatable.dart';
import 'package:client_application/views/finalize.dart';
import 'package:client_application/views/home.dart';
import 'package:client_application/views/insuranceoptions.dart';
import 'package:client_application/views/iscore.dart';
import 'package:client_application/views/payment.dart';
import 'package:client_application/views/vehicleattachments.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/':(context) => LoginPage(),
        '/home':(context) => Home2(),
        '/complains':(context) => Complains(),
        '/policyIssuance':(context) => const PolicyIssuance(),
        '/vehicleInfo':(context) => const VehicleInfo(),
        '/registerVehicle':(context) =>const RegisterVehicle(),
        '/vehicleAttachments':(context) => const VehicleAttachments(),
        '/pendingVehicles':(context)=> const PendingVehicle(),
        '/pendingPolicies':(context) => const PendingPolicies(),
        '/booked': (context) => const SuccessfulBooking(),
        '/companydetails': (context) => const CompanyDetails(),
        '/insuranceoptions' : (context) => const InsuranceOptions(),
        '/compare': (context) => const Data(),
        '/payment': (context) =>Payment(),
        '/iscore':(context) => const Iscore(),
        '/userVehicles':(context) => UserVehiclesPage(),
        '/userClaimRequest':(context) => UserClaimRequest(),
        '/signUpLater':(context) => const SignUpLater(),
        '/pendingClaims':(context) => const PendingClaims(),
        '/policyDraft':(context) => const PolicyDraft(),
        '/notifications-page':(context) => const NotificationsPage(),
        '/termsAndConditions':(context) => const TermsAndConditions(),
      },
    //  home: Home(),
    );
  }
}
