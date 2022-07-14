import 'package:client_application/models/claim_requests.dart';
import 'package:client_application/views/usercars.dart';
import 'package:client_application/widgets/notification_widget.dart';
import 'package:client_application/widgets/user_vehicle.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

late DocumentSnapshot snapshot;
bool asGuest = false;
bool fromHome = false;


class UserPolicyIssuance{
  // user info when registering for policy issuance
  String intendedCompany = '';
  String beneficiary = '';
  int insuranceAmount = 0;
  String policyHolderID = '';
  String policyHolderName = '';
  String mobile = '';
  String address = '';
  String email = '';
  String policyNumber = '';

  String vehicleChassisNumber = '';
  String vehicleMotorNumber = '';
  String vehiclePlateNumber = '';

// vehicle info when registering for policy issuance
  int vehicleIndex = 0;
  String vehicleMake = '';
  String vehicleModel = '';
  String productionYear = '';
  String vehicleValue = '';
  String carLicenseId = '';
  String drivingLicenseId = '';
  String vehicleType = '';
  String vehicleWeight = '';
  String vehicleNumberOfSeats = '';
  List<UserVehicleWidget> vehicles = [];


  UserPolicyIssuance({
    required this.vehicleIndex,
    required this.insuranceAmount,
    required this.intendedCompany,
    required this.policyHolderID,
    required this.policyHolderName,
    required this.mobile,
    required this.address,
    required this.email,


    required this.vehicleMake,
    required this.vehicleModel,
    required this.productionYear,
    required this.vehicleValue,
    required this.carLicenseId,
    required this.drivingLicenseId,

    required this.vehicleChassisNumber,
    required this.vehicleMotorNumber,
    required this.vehiclePlateNumber,

    required this.vehicles,
    required this.beneficiary,
    required this.vehicleType,
    required this.vehicleWeight,
    required this.vehicleNumberOfSeats,
  });

}

Map<String, int> companyCurrentPolicyAmount = {
  'المجموعة العربية المصرية للتأمين': -1,
  'مصر للتأمين': -1,
  'قناة السويس للتأمين': -1,
  'الشركة الأهلية للتأمي': -1,
  'نايل تكافل': -1,
  'بيت التأمين المصري السعودي': -1,
  'شركة المهندس للتأمين': -1,
  'الدلتا للتأمين': -1,
};

// keeps track of how many users are signed in
int currentAmountOfSignedInUsers = 0;

// index to keep track of amount of vehicles registered by user
int globalUserVehiclesRegisteredIndex = 0;

// index to keep track of which vehicle is currently being used for current policy request
int globalUserVehicleToBeRegistered = 0;

// index to keep track of which user is currently logged in
int globalCurrentUserLoggedInIndex = -1;

int currentPolicyAmount = -1;
int globalCurrentPolicyRequestAmount = 0;

String globalIntendedInsuranceCompany = '';
String globalBeneficiary = '';
String globalPolicyHolderID = '';
String globalUserPassword = '';
String globalDateOfBirth = '';
String globalPolicyHolderName = '';
String globalUserMobile = '';
String globalUserAddress = '';
String globalUserEmail = '';
String globalVehicleChassisNumber = '';
String globalVehicleMotorNumber = '';
String globalVehiclePlateNumber = '';




String globalVehicleMake = '';
String globalVehicleModel = '';
String globalProductionYear = '';
String globalVehicleValue = '';
String globalCarLicenseId = '';
String globalDrivingLicenseId = '';


// current amount of policy requests to insurance company
int policyRequestAmount = 0;


const mainColor = Color(0xff2470c7);

// left or right side
var onFirst = false;
var onSecond = false;

// insurance details
var appointmentAmount = 0;
var insuranceCompanyName = " ";
String insuranceCompanyImage = "";
var insuranceCompanyOptions = [];
var insuranceCompanyPrice = 0;
var serviceProvider = " ";
var currentIndex = 0;
var amountSelected = 1;


// iscore
var suspensionWord = "نسبة التحمل";
var clearedWord = "نوع السيارة";
var compliedOnWord = "امتثل على";
var violationWord = "تاريخ الانتهاك";
var accidentDateWord = "تاريخ الحادث";


var history1 = [
  "12/3/2020",
  "70%",
  "Audi R7",
];
var history2 = [
  "18/6/2021",
  "50%",
  "Audi R7",
];

double globalWidth = 100;
double globalHeight = 100;


// insurance options
List<String> insuranceOptions = [
  "asdasdas",
];


//to know which is selected at table view
var atFirst = false;
var atSecond = false;

// credit card details
var userCardHolder = "";
var cardExpiryDate = "";
var cardCvv = "";
var userCardNumber = "";

List<String> selectedOptions = [];

var companyEmails = [
  "insuranceeg@ins.eg",
  "insuranceeg@ins2.eg",
  "insuranceeg@ins3.eg",
  "insuranceeg@ins4.eg",
  "insuranceeg@ins5.eg",
  "insuranceeg@ins6.eg",
  "insuranceeg@ins7.eg",
  "insuranceeg@ins8.eg",
];

var companyNumbers = [
  "01014563231",
  "01013433231",
  "01014562941",
  "01004532231",
  "01014548291",
  "01014536289",
  "01014563323",
  "01014362918",
];

var companyIds = [
  "21441",
  "21323",
  "24382",
  "36482",
  "73829",
  "15382",
  "74628",
  "91027",
];

// amount of insurance companies to compare
int amountToCompare = 0;

// list of insurance companies to compare
List<Map<dynamic, dynamic>> companyList = [

];

// user details
var fullName  = "";
var nationalID  = "";
var insuranceDate = "";
var userEmail = "";
var userPassword = "";
var userPoints = 0;
var useriScore = 250;

ClaimRequest globalCurrentClaimRequest = ClaimRequest(
    intendedInsuranceCompany: "",
    claimRequesterId: "",
    claimRequesterName: "",
    claimRequesterMobile: "",
    claimRequesterAddress: "",
    claimRequesterEmail: "",
    claimRequesterVehicleIndex: -1,
    claimRequesterVehicleMake: "",
    claimRequesterVehicleModel: "",
    claimRequesterProductionYear: "",
    claimRequesterVehicleValue: "",
    claimRequesterCarLicenseId: "",
);


bool onBrokerCompany = false;
bool onCompany = false;

List<String> insuranceCompanyList = [
  'Gig Egypt',
  'Misr Insurance',
  'Suez Canal Insurance',
  'Al Ahlia Insurance',
  'Nile Takaful',
  'Egyptian Saudi Insurance',
  'Mohandes Insurance Co.',
  'Delta Insurance',
];


List<String> brokerCompanyList = [
  'Deraya Insurance Brokerage',
  'BMW Egypt Insurance',
  'Future Insurance Brokerage',
  'GoodLife Insurance Brokers',
  'GIG Insurance Brokers',
];

List<UserVehicleWidget> pendingVehicles = [];
int globalPolicyVehiclesIndex = 0;



List<int> userVehiclesIndexes = [];

List<UserVehicleWidget> userVehicles = [];

List<UserVehicleWidget> userVehiclesToBeRequested = [];


String currentCompanyToPay = "";
String currentBrokerToPay = "";

int globalIndexToPay = 0;


int globalClaimIndex = 0;
int globalClaimNumberInsComp = 0;
String globalToPayIntendedComp = "";
int globalVehicleIndex = 0;
bool amountOfVehiclesMoreThanOne = false;

bool isClaimRequest = false;



//vehicle type
String vehicleType = 'personal';


//policy draft
String draftVehicleMake = '';
String draftVehicleModel = '';
String draftVehicleProductionYear = '';
String draftInsuranceCompany = '';
String draftBrokerCompany = '';
String draftPremium = '';


List<NotificationWidget> notificationList = [];
int globalNotificationAmount = 0;


bool agreeTermsAndConditions = false;

String globalVehicleType = '';
String globalVehicleWeight = '';
String globalNumberOfSeats = '';


List<String> termsAndConditionsList = [
  'The insured bears a compulsory rate of 25% of the value of the panorama seat and all its inclusions and the movable sunroof with all its inclusions, twists and Xenon and xenon lamps integrated with lasers and lasers, if any, in case of partial loss only',
  'The issuance expenses include a tax of five pounds in favor of the Fund for Honoring Martyrs, Victims, Missing Persons and Operation Injuredsecurity and their families',
  'Accordingly, the company shall not be responsible for any accident of an insured vehicle in case the insured violates the instructions and instructions Issued by the Traffic Department, such as (exceeding the speed limit inside and outside cities - driving in the opposite direction - stopping in (Unallocated places..etc.',
  'It is known and agreed upon that the insured bears the compulsory 75% of the value of the **** ** pillows and their contents in ** ** Case of partial and total loss as well',
  'It is known and agreed that in the case. A covered according to the terms of the supplementary car policy + and the chronic desire to have it repaired damages. Associated with this accident by proxy or authorized service centers.” When settling compensation, the following applies, deducting the 3601 percentage. From the total compensation as a sum, an additional burden shall be borne by the insured in the event that the age of the car does not exceed five years, including the bad model. It can be waived in return for an increase in the premium by 3%, and 9675 percent of the total compensation will be deducted as an additional deductible for the insured. A machine in the event that the car is more than five years old. As long as it does not exceed ten years, including the model year, the above discounts are applied in the previous two cases, in the case of purchasing spare parts from the agency, authorized service centers, or authorized distributors, in the event of a breach of duty. The car is ten years old, including the model year. The value of the repair is estimated by the hopeful company according to the prices of repairs outside Power of attorney and the insured is not entitled to obtain more than the value of the fixed repair with the knowledge of the insured company.',
];

List<String> ratingCriteria = [
  'Sufficiency, simplicity and accuracy of website data. ',
  'Products and services meet your needs.',
  'Ease of submitting requests.',
  'Quick responses to requests / inquiries/ complaints.',
  'Price versus quality.',
  'Premium settlement process.',
  'Issuance and delivery of insurance policy.',
  'Claims handling process.',
  'Services provided within reasonable time.',
  'Satisfaction with compensation.',
  'Satisfaction with repair process / paying in cash.',
  'Quality of our representatives.',
  'Availability of company branches / service centers.',
  'Quality of roadside assistance service.',
  'Possibility to renew your current policy with us.',
];

List<String> ratingCriteriaNew = [
  'Sufficiency, simplicity and accuracy of website data. ',
  'Products and services meet your needs.',
  'Ease of submitting requests.',
  'Quick responses to requests / inquiries/ complaints.',
  'Price versus quality.',
  'Premium settlement process.',
  'Issuance and delivery of insurance policy.',
  'Services provided within reasonable time.',
  'Quality of our representatives.',
  'Availability of company branches / service centers.',
  'Possibility to renew your current policy with us.',
];

List<String> ratingCriteriaNewClaim = [
  'Sufficiency, simplicity and accuracy of website data. ',
  'Products and services meet your needs.',
  'Ease of submitting requests.',
  'Quick responses to requests / inquiries/ complaints.',
  'Claims handling process.',
  'Services provided within reasonable time.',
  'Satisfaction with compensation.',
  'Satisfaction with repair process / paying in cash.',
  'Quality of our representatives.',
  'Availability of company branches / service centers.',
  'Quality of roadside assistance service.',
];
