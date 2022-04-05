import 'package:client_application/models/claim_requests.dart';
import 'package:client_application/views/usercars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../constants.dart';


class DataBaseService{

  final CollectionReference usersSignedUp = FirebaseFirestore.instance.collection('users-signed-up');
  final CollectionReference usersToApprove = FirebaseFirestore.instance.collection('users-policy-approvals');
  final CollectionReference userPolicyRequest = FirebaseFirestore.instance.collection('users-policy-requests');
  final CollectionReference userPolicyRequestBroker = FirebaseFirestore.instance.collection('users-policy-requests-broker');
  final CollectionReference userClaimRequest = FirebaseFirestore.instance.collection('users-claim-requests');
  final CollectionReference userBrokerClaimRequest = FirebaseFirestore.instance.collection('users-claim-requests-broker');
  final CollectionReference userClaimApproval = FirebaseFirestore.instance.collection('users-claim-approvals');
  final CollectionReference userComplains = FirebaseFirestore.instance.collection('user-complains');
  final CollectionReference centerRequests = FirebaseFirestore.instance.collection('centers-requests');


  Future updateUserComplains(int totalClaims,bool complainStatus, String Comp, int complainIndex, String complain, int userIdx, int notAmount) async {
    return await (userComplains).doc("complains").set({
      Comp: {
        '$complainIndex': {
          'complain-idx': complainIndex,
          'user-index': userIdx,
          'user-name': globalPolicyHolderName,
          'user-id': globalPolicyHolderID,
          'user-email': globalUserEmail,
          'user-license': globalDrivingLicenseId,
          'complain': complain,
          'notification-amount': notAmount,
          'complain-closed': complainStatus,
        },
        'total-complains':totalClaims,
      },
    },SetOptions(merge: true),
    );
  }

  Future closeComplaint(String Comp, int complainIndex) async {
    return await (userComplains).doc("complains").set({
      Comp: {
        '$complainIndex': {
          'complain-closed': true,
        },
      },
    },SetOptions(merge: true),
    );
  }


  Future updateNotificationToFalse(int userIdx, int notIdx) async {
    return await (usersSignedUp).doc("users").set({
      '$userIdx': {
        'notifications': {
          '$notIdx': {
            'available': false,
          },
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future addNotificationTypePayment(int userIdx, int notIdx, String company, int paymentAmount) async {
    return await (usersSignedUp).doc("users").set({
      '$userIdx': {
        'notifications': {
          '$notIdx': {
            'notification-type': 'Payment',
            'notification-sender': company,
            'client-coverage': paymentAmount,
            'available': true,
          },
        },
        'notification-amount': notIdx,
      },
    },SetOptions(merge: true),
    );
  }


  Future updateUserApprovalToInspection(String Comp, int policyIndex, bool signInAsBroker) async {
    return await (signInAsBroker?userPolicyRequestBroker:userPolicyRequest).doc(Comp).set({
      '$policyIndex': {
        'status-waiting-user-schedule-approval': false,
        'status-inspection': true,
      },
    },SetOptions(merge: true),
    );
  }

  Future updateUserApprovalToScheduling(String Comp, int policyIndex, bool signInAsBroker) async {
    return await (signInAsBroker?userPolicyRequestBroker:userPolicyRequest).doc(Comp).set({
      '$policyIndex': {
        'status-waiting-user-schedule-approval': false,
        'status-scheduling': true,
      },
    },SetOptions(merge: true),
    );
  }

  Future updateUserPurchased(String Comp, int policyIndex, bool signInAsBroker) async {
    return await (signInAsBroker?userPolicyRequestBroker:userPolicyRequest).doc(Comp).set({
      '$policyIndex': {
        'status-waiting-user-schedule-approval': false,
        'status-scheduling': true,
      },
    },SetOptions(merge: true),
    );
  }

  // update the current insurance company user has selected
  Future updateData(String name) async {
    return await userPolicyRequest.doc('current-policy-request').set({
      'insurance-company': name,
    });
  }

  Future updateUserPurchaseStatus(int currentIndex) async {
    return await usersToApprove.doc('approvals').set({
      '$currentIndex': {
        'user-purchased': true,
      },
    },SetOptions(merge: true)
    );
  }

  Future claimUpdateUserApproved(String Comp, int claimIndex, bool isBroker) async {
    return await (isBroker?userBrokerClaimRequest:userClaimRequest).doc("claims").set({
      Comp:{
        '$claimIndex': {
          'status-requester-approved': true,
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future claimUpdateUserApproval(int claimIndex) async {
    return await userClaimApproval.doc("approvals").set({
      '$claimIndex': {
        'user-approved': true,
      },
    },SetOptions(merge: true),
    );
  }

  Future claimUpdateUserApprovalData(int claimIndex) async {
    return await userClaimRequest.doc("claims-user").set({
      '$claimIndex': {
        'status-ic-approved': false,
        'user-approved': true,
      },
    },SetOptions(merge: true),
    );
  }

  Future claimUpdateStatusDeclinedPendingApproval(int claimIndex) async {
    return await userClaimRequest.doc("claims-user").set({
      '$claimIndex': {
        'status-ic-approved': false,
        'status-waiting-ic-approval': true,
      },
    },SetOptions(merge: true),
    );
  }

  Future claimUpdateStatusDeclinedClaimsDoc(String company,int claimIndex, String userComment) async {
    return await userClaimRequest.doc("claims").set({
      company:{
        '$claimIndex': {
          'status-ic-approved': false,
          'user-comment': userComment,
          'status-waiting-ic-approval': true,
          'declined-amount': true,
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future claimUpdateStatusDeclinedInsuranceComp(String company,int claimIndex) async {
    return await userClaimRequest.doc("claims").set({
      company:{
        '$claimIndex': {
          'status-requester-approved': true,
          'declined-amount': false,
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future updateClaimsRequestsData(int claimNumberUser,String nationalId, String drivingLicense,bool anotherDriver, String claimRequesterName,ClaimRequest claimRequest, int currentCompanyClaim, String dateOfBirth,String accidentLoc, String accidentInfo, String center) async {
    List<dynamic> invoiceItems = [];
    List<dynamic> invoiceFees = [];
    return await (claimRequest.brokerRegistered?userBrokerClaimRequest:userClaimRequest).doc("claims").set({
      claimRequest.intendedInsuranceCompany:{
        '$currentCompanyClaim': {
          'user-comment': '',
          'claim-number-user': claimNumberUser,
          'claim-requester-date-of-birth': dateOfBirth,
          'claim-requester-accident-location':accidentLoc,
          'claim-requester-accident-info':accidentInfo,
          'intended-insurance-company': claimRequest.intendedInsuranceCompany,
          'claim-requester-id': claimRequest.claimRequesterId,
          'claim-number': currentCompanyClaim,
          'claim-requester-name': anotherDriver?claimRequesterName:claimRequest.claimRequesterName,
          'claim-requester-mobile': anotherDriver?"":claimRequest.claimRequesterMobile,
          'claim-requester-address': anotherDriver?"":claimRequest.claimRequesterAddress,
          'claim-requester-email': anotherDriver?"":claimRequest.claimRequesterEmail,
          'claim-requester-vehicle-index': claimRequest.claimRequesterVehicleIndex,
          'claim-requester-vehicle-make': claimRequest.claimRequesterVehicleMake,
          'claim-requester-vehicle-model': claimRequest.claimRequesterVehicleModel,
          'claim-requester-vehicle-production-year': claimRequest.claimRequesterProductionYear,
          'claim-requester-vehicle-value': claimRequest.claimRequesterVehicleValue,
          'claim-requested-national-id': anotherDriver?nationalId:globalPolicyHolderID,
          'claim-requester-vehicle-driving-license-id': anotherDriver?drivingLicense:globalDrivingLicenseId,
          'claim-requester-vehicle-car-license-id': claimRequest.claimRequesterCarLicenseId,

          'invoice-items': invoiceItems,
          'invoice-fees': invoiceFees,

          'status-waiting-fees-approval': true,
          'status-scheduling': false,
          'status-waiting-ic-approval': false,
          'status-ic-approved': false,
          'status-ic-refused': false,
          'status-requester-approved': false,
          'declined-amount': false,
          'center': center,
        },
        'total-claim-amount' : currentCompanyClaim,
      }
    },SetOptions(merge: true)
    );
  }

  Future updateClaimsRequestsDataUser(
      int currentIdx,
      String nationalId,
      String drivingLicense,
      bool anotherDriver,
      String claimRequesterName,
      ClaimRequest claimRequest,
      int currentCompanyClaim,
      String dateOfBirth,
      String accidentLoc,
      String accidentInfo,
      String center
      ) async {
    List<dynamic> invoiceItems = [];
    List<dynamic> invoiceFees = [];
    return await (userClaimRequest).doc("claims-user").set({
        '$currentIdx': {
          'user-comment': '',
          'current-index': currentIdx,
          'claim-requester-date-of-birth': dateOfBirth,
          'claim-requester-accident-location':accidentLoc,
          'claim-requester-accident-info':accidentInfo,
          'intended-insurance-company': claimRequest.intendedInsuranceCompany,
          'claim-requester-id': claimRequest.claimRequesterId,
          'claim-number': currentCompanyClaim,
          'claim-requester-name': anotherDriver?claimRequesterName:claimRequest.claimRequesterName,
          'claim-requester-mobile': anotherDriver?"":claimRequest.claimRequesterMobile,
          'claim-requester-address': anotherDriver?"":claimRequest.claimRequesterAddress,
          'claim-requester-email': anotherDriver?"":claimRequest.claimRequesterEmail,
          'claim-requester-vehicle-index': claimRequest.claimRequesterVehicleIndex,
          'claim-requester-vehicle-make': claimRequest.claimRequesterVehicleMake,
          'claim-requester-vehicle-model': claimRequest.claimRequesterVehicleModel,
          'claim-requester-vehicle-production-year': claimRequest.claimRequesterProductionYear,
          'claim-requester-vehicle-value': claimRequest.claimRequesterVehicleValue,
          'claim-requested-national-id': anotherDriver?nationalId:globalPolicyHolderID,
          'claim-requester-vehicle-driving-license-id': anotherDriver?drivingLicense:globalDrivingLicenseId,
          'claim-requester-vehicle-car-license-id': claimRequest.claimRequesterCarLicenseId,

          'invoice-items': invoiceItems,
          'invoice-fees': invoiceFees,

          'status-waiting-fees-approval': true,
          'status-scheduling': false,
          'status-waiting-ic-approval': false,
          'status-ic-approved': false,
          'status-ic-refused': false,
          'status-requester-approved': false,
          'user-approved': false,
          'declined-amount': false,
          'center': center,
        },
        'total-claim-amount' : currentIdx,
    },SetOptions(merge: true)
    );
  }

  Future updateServiceClaimsRequestsData(int claimNumberUser,int currentRequest,String nationalId, String drivingLicense,bool anotherDriver, String claimRequesterName,ClaimRequest claimRequest, int currentCompanyClaim, String dateOfBirth,String accidentLoc, String accidentInfo, String center) async {
    return await (centerRequests).doc("requests").set({
      center:{
        '$currentRequest': {
          'claim-number-user': claimNumberUser,
          'current-request': currentRequest,
          'claim-requester-date-of-birth': dateOfBirth,
          'claim-requester-accident-location':accidentLoc,
          'claim-requester-accident-info':accidentInfo,
          'intended-insurance-company': claimRequest.intendedInsuranceCompany,
          'claim-requester-id': claimRequest.claimRequesterId,
          'claim-number': currentCompanyClaim,
          'claim-requester-name': anotherDriver?claimRequesterName:claimRequest.claimRequesterName,
          'claim-requester-mobile': anotherDriver?"":claimRequest.claimRequesterMobile,
          'claim-requester-address': anotherDriver?"":claimRequest.claimRequesterAddress,
          'claim-requester-email': anotherDriver?"":claimRequest.claimRequesterEmail,
          'claim-requester-vehicle-index': claimRequest.claimRequesterVehicleIndex,
          'claim-requester-vehicle-make': claimRequest.claimRequesterVehicleMake,
          'claim-requester-vehicle-model': claimRequest.claimRequesterVehicleModel,
          'claim-requester-vehicle-production-year': claimRequest.claimRequesterProductionYear,
          'claim-requester-vehicle-value': claimRequest.claimRequesterVehicleValue,
          'claim-requested-national-id': anotherDriver?nationalId:globalPolicyHolderID,
          'claim-requester-vehicle-driving-license-id': anotherDriver?drivingLicense:globalDrivingLicenseId,
          'claim-requester-vehicle-car-license-id': claimRequest.claimRequesterCarLicenseId,

          'status-waiting-fees-approval': true,
          'status-scheduling': true,
          'status-waiting-ic-approval': false,
          'status-ic-approved': false,
          'status-ic-refused': false,
          'status-requester-approved': false,
          'center': center,
        },
        'total-requests' : currentRequest,
      }
    },SetOptions(merge: true)
    );
  }

  // update the collection that stores users that signed up
  Future updateSignedUpUsers(
      bool onCompany,
      int currentUserIndex,
      String userName,
      String userID,
      String dateOfBirth,
      String userEmail,
      String userPassword,
      String userMobile,
      String userDrivingLicense,
      String beneficiary,
      ) async {
    return await usersSignedUp.doc('users').set({
      '$currentUserIndex': {
        'as-company': onCompany,
        'user-name': userName,
        'user-id' : userID,
        'date-of-birth': dateOfBirth,
        'user-email': userEmail,
        'user-password': userPassword,
        'user-mobile': userMobile,
        'user-driving-license': userDrivingLicense,
        'beneficiary': globalBeneficiary,
        'user-vehicle-amount': -1,
        'notifications': {},
        'notification-amount': -1,
        'user-vehicles':{

        },
      },
      'total-user-amount': currentUserIndex,
    },SetOptions(merge: true)
    );
  }


  // updates users vehicles when they register a new vehicle in the account
  Future updateUserVehicles(int currentUserIndex,UserVehicle vehicle, int vehicleAmount) async {
    return await usersSignedUp.doc('users').set({
      '$currentUserIndex': {
        'user-vehicles':{
          '$vehicleAmount': {
            'vehicle-type': vehicle.vehicleType,
            'vehicle-weight': vehicle.weight,
            'no-seats': vehicle.numberOfSeats,
            'intended-insurance-company': '',
            'vehicle-make': vehicle.vehicleMake,
            'vehicle-model': vehicle.vehicleModel,
            'vehicle-production-year': vehicle.productionYear,
            'vehicle-chassis-number': vehicle.vehicleChassisNumber,
            'vehicle-motor-number': vehicle.vehicleMotorNumber,
            'vehicle-plate-number': vehicle.vehiclePlateNumber,
            'vehicle-value': vehicle.vehicleValue,
            'vehicle-license':vehicle.vehicleLicenseId,
            'vehicle-status': false,
          },
        },
        'user-vehicle-amount': vehicleAmount,
      },
    },SetOptions(merge: true)
    );
  }

  Future updateUserVehicleStatus(int currentUserIndex, int vehicleIndex) async {
    return await usersSignedUp.doc('users').set({
      '$currentUserIndex': {
        'user-vehicles':{
          '$vehicleIndex': {
            'vehicle-status': true,
          },
        },
      },
    },SetOptions(merge: true)
    );
  }

  Future updateUserVehicleIntendedCompany(int currentUserIndex, int vehicleIndex, String insuranceCompany) async {
    return await usersSignedUp.doc('users').set({
      '$currentUserIndex': {
        'user-vehicles':{
          '$vehicleIndex': {
            'intended-insurance-company': insuranceCompany,
          },
        },
      },
    },SetOptions(merge: true)
    );
  }



/*
  Future removePendingPolicy(int currentUserIndex, int vehicleIndex) async {
    return await usersSignedUp.doc('users').set(data);
  }


*/


  Future updatePolicyRequestsDataCompany(
        int vehicleAmount,
        int currentVehicle,
        UserPolicyIssuance policyIssuance,
        int currentCompanyPolicy,
        int totalNewRequests,
        int amountApproved,
        int renewal,
        int cancelled,
        int pending,
      ) async {
      return await userPolicyRequest.doc(policyIssuance.intendedCompany).set({
        '$currentCompanyPolicy': {
          'broker-name': "none",
          'policy-amount': policyIssuance.insuranceAmount,
          'policy-number' : currentCompanyPolicy,
          'policy-holder-id' : policyIssuance.policyHolderID,
          'policy-holder-name': policyIssuance.policyHolderName,
          'policy-holder-mobile': policyIssuance.mobile,
          'policy-holder-address': policyIssuance.address,
          'policy-holder-email':policyIssuance.email,
          'vehicle-amount': vehicleAmount,
          'vehicles':{
            '$currentVehicle':{
              'vehicle-type': policyIssuance.vehicles[currentVehicle].vehicleType,
              'vehicle-weight': policyIssuance.vehicles[currentVehicle].vehicleWeight,
              'no-seats': policyIssuance.vehicles[currentVehicle].vehicleNumberOfSeats,
              'vehicle-index': policyIssuance.vehicles[currentVehicle].currentIndex,
              'vehicle-make': policyIssuance.vehicles[currentVehicle].vehicleMake,
              'vehicle-model': policyIssuance.vehicles[currentVehicle].vehicleModel,
              'vehicle-production-year': policyIssuance.vehicles[currentVehicle].productionYear,
              'vehicle-chassis-number': policyIssuance.vehicles[currentVehicle].vehicleChassisNumber,
              'vehicle-motor-number': policyIssuance.vehicles[currentVehicle].vehicleMotorNumber,
              'vehicle-plate-number': policyIssuance.vehicles[currentVehicle].vehiclePlateNumber,
              'vehicle-value': policyIssuance.vehicles[currentVehicle].vehicleValue,
              'vehicle-license-id': policyIssuance.vehicles[currentVehicle].vehicleLicenseId,
              'vehicle-driving-license': policyIssuance.drivingLicenseId,
            },
          },

          'status-scheduling': true,
          'status-waiting-user-schedule-approval': false,
          'status-inspection': false,
          'status-underwriting': false,
          'status-waiting-ic-approval': false,
          'status-ic-approved': false,

        },
        'total-policy-amount' : currentCompanyPolicy,
        'total-amount-approved' : amountApproved,
        'total-new-requests' : totalNewRequests,
        'total-pending-policies' : renewal,
        'total-amount-cancelled': cancelled,
        'total-amount-renewal': pending,
      },SetOptions(merge: true)
      );
  }

  Future updatePolicyRequestsData(
      UserPolicyIssuance policyIssuance,
      int currentCompanyPolicy,
      int totalNewRequests,
      int amountApproved,
      int renewal,
      int cancelled,
      int pending,
      ) async{
    return await userPolicyRequest.doc(policyIssuance.intendedCompany).set({
        '$currentCompanyPolicy': {
          'broker-name': "none",
          'policy-amount': policyIssuance.insuranceAmount,
          'policy-number' : currentCompanyPolicy,
          'policy-holder-id' : policyIssuance.policyHolderID,
          'policy-holder-name': policyIssuance.policyHolderName,
          'policy-holder-mobile': policyIssuance.mobile,
          'policy-holder-address': policyIssuance.address,
          'policy-holder-email':policyIssuance.email,

          'vehicle-index': policyIssuance.vehicleIndex,
          'vehicle-type': policyIssuance.vehicleType,
          'vehicle-weight': policyIssuance.vehicleWeight,
          'no-seats': policyIssuance.vehicleNumberOfSeats,
          'vehicle-make': policyIssuance.vehicleMake,
          'vehicle-model': policyIssuance.vehicleModel,
          'vehicle-production-year': policyIssuance.productionYear,
          'vehicle-chassis-number': policyIssuance.vehicleChassisNumber,
          'vehicle-motor-number': policyIssuance.vehicleMotorNumber,
          'vehicle-plate-number': policyIssuance.vehiclePlateNumber,
          'vehicle-value': policyIssuance.vehicleValue,
          'vehicle-license-id': policyIssuance.carLicenseId,
          'vehicle-driving-license': policyIssuance.drivingLicenseId,
          'vehicle-amount': 0,

          'status-scheduling': true,
          'status-waiting-user-schedule-approval': false,
          'status-inspection': false,
          'status-underwriting': false,
          'status-waiting-ic-approval': false,
          'status-ic-approved': false,

        },
        'total-policy-amount' : currentCompanyPolicy,
        'total-amount-approved' : amountApproved,
        'total-new-requests' : totalNewRequests,
        'total-pending-policies' : renewal,
        'total-amount-cancelled': cancelled,
        'total-amount-renewal': pending,
    },SetOptions(merge: true)
    );
  }

  Future updateNewRequestsData(
      String insuranceCompany,
      int totalNewRequests,
      ) async{
    return await userPolicyRequest.doc(insuranceCompany).set({
      'total-new-requests' : totalNewRequests,
    },SetOptions(merge: true)
    );
  }

  Future requestsDocUpdateUserApprovalToScheduling(int policyIndex) async {
    return await userPolicyRequest.doc("requests").set({
      '$policyIndex': {
        'status-waiting-user-schedule-approval': false,
        'status-scheduling': true,
      },
    },SetOptions(merge: true),
    );
  }

  Future requestsDocUpdateUserApprovalToInspection(int policyIndex) async {
    return await userPolicyRequest.doc("requests").set({
      '$policyIndex': {
        'status-waiting-user-schedule-approval': false,
        'status-inspection': true,
      },
    },SetOptions(merge: true),
    );
  }

  Future requestsDocUpdateUserPurchased(int policyIndex) async {
    return await userPolicyRequest.doc("requests").set({
      '$policyIndex': {
        'status-ic-approved': false,
        'status-user-purchased':true,
      },
    },SetOptions(merge: true),
    );
  }

  Future requestsDocUpdatePolicyRequestsData(UserPolicyIssuance policyIssuance, int currentAmount, bool isBroker) async{
    return await userPolicyRequest.doc("requests").set({
      '$currentAmount': {
        'broker-name': isBroker?policyIssuance.intendedCompany:"none",
        'intended-company': isBroker?"none":policyIssuance.intendedCompany,
        'policy-amount': policyIssuance.insuranceAmount,
        'policy-number' : currentAmount,
        'policy-holder-id' : policyIssuance.policyHolderID,
        'policy-holder-name': policyIssuance.policyHolderName,
        'policy-holder-mobile': policyIssuance.mobile,
        'policy-holder-address': policyIssuance.address,
        'policy-holder-email':policyIssuance.email,

        'vehicle-index': policyIssuance.vehicleIndex,
        'vehicle-type': policyIssuance.vehicleType,
        'vehicle-weight': policyIssuance.vehicleWeight,
        'no-seats': policyIssuance.vehicleNumberOfSeats,
        'vehicle-make': policyIssuance.vehicleMake,
        'vehicle-model': policyIssuance.vehicleModel,
        'vehicle-production-year': policyIssuance.productionYear,
        'vehicle-chassis-number': policyIssuance.vehicleChassisNumber,
        'vehicle-motor-number': policyIssuance.vehicleMotorNumber,
        'vehicle-plate-number': policyIssuance.vehiclePlateNumber,
        'vehicle-value': policyIssuance.vehicleValue,
        'vehicle-license-id': policyIssuance.carLicenseId,
        'vehicle-driving-license': policyIssuance.drivingLicenseId,
        'vehicle-amount': 0,

        'status-scheduling': true,
        'status-waiting-user-schedule-approval': false,
        'status-inspection': false,
        'status-underwriting': false,
        'status-waiting-ic-approval': false,
        'status-ic-approved': false,
        'status-user-approved':false,
        'status-user-purchased': false,
        'is-broker': isBroker,

      },
      'total-policy-amount' : currentAmount,
    },SetOptions(merge: true)
    );
  }

  Future requestsDocUpdatePolicyRequestsDataCompany(int vehicleIndex,UserPolicyIssuance policyIssuance, int currentAmount, bool isBroker, int vehicleAmount) async{
    return await userPolicyRequest.doc("requests").set({
      '$currentAmount': {
        'broker-name': isBroker?policyIssuance.intendedCompany:"none",
        'intended-company': isBroker?"none":policyIssuance.intendedCompany,
        'policy-amount': policyIssuance.insuranceAmount,
        'policy-number' : currentAmount,
        'policy-holder-id' : policyIssuance.policyHolderID,
        'policy-holder-name': policyIssuance.policyHolderName,
        'policy-holder-mobile': policyIssuance.mobile,
        'policy-holder-address': policyIssuance.address,
        'policy-holder-email':policyIssuance.email,
        'vehicle-amount': vehicleAmount,
        'vehicles': {
          '$vehicleIndex':{
            'vehicle-index': policyIssuance.vehicles[vehicleIndex].currentIndex,
            'vehicle-type': policyIssuance.vehicles[vehicleIndex].vehicleType,
            'vehicle-weight': policyIssuance.vehicles[vehicleIndex].vehicleWeight,
            'no-seats': policyIssuance.vehicles[vehicleIndex].vehicleNumberOfSeats,
            'vehicle-make': policyIssuance.vehicles[vehicleIndex].vehicleMake,
            'vehicle-model': policyIssuance.vehicles[vehicleIndex].vehicleModel,
            'vehicle-production-year': policyIssuance.vehicles[vehicleIndex].productionYear,
            'vehicle-chassis-number': policyIssuance.vehicles[vehicleIndex].vehicleChassisNumber,
            'vehicle-motor-number': policyIssuance.vehicles[vehicleIndex].vehicleMotorNumber,
            'vehicle-plate-number': policyIssuance.vehicles[vehicleIndex].vehiclePlateNumber,
            'vehicle-value': policyIssuance.vehicles[vehicleIndex].vehicleValue,
            'vehicle-license-id': policyIssuance.vehicles[vehicleIndex].vehicleLicenseId,
            'vehicle-driving-license': policyIssuance.drivingLicenseId,
          },
        },

        'status-scheduling': true,
        'status-waiting-user-schedule-approval': false,
        'status-inspection': false,
        'status-underwriting': false,
        'status-waiting-ic-approval': false,
        'status-ic-approved': false,
        'status-user-approved':false,
        'status-user-purchased': false,
        'is-broker': isBroker,

      },
      'total-policy-amount' : currentAmount,
    },SetOptions(merge: true)
    );
  }

  Future updateBrokerPolicyRequestsDataCompany(
      int vehicleAmount,
      int currentVehicle,
      UserPolicyIssuance policyIssuance,
      int currentCompanyPolicy,
      int totalNewRequests,
      int amountApproved,
      int renewal,
      int cancelled,
      int pending,
      ) async{
    return await userPolicyRequestBroker.doc(policyIssuance.intendedCompany).set({
      '$currentCompanyPolicy': {
        'insurance-company-assigned': "none",
        'policy-amount': policyIssuance.insuranceAmount,
        'policy-number' : currentCompanyPolicy,
        'policy-holder-id' : policyIssuance.policyHolderID,
        'policy-holder-name': policyIssuance.policyHolderName,
        'policy-holder-mobile': policyIssuance.mobile,
        'policy-holder-address': policyIssuance.address,
        'policy-holder-email':policyIssuance.email,
        'vehicle-amount': vehicleAmount,
        'vehicles':{
          '$currentVehicle':{
            'vehicle-index': policyIssuance.vehicles[currentVehicle].currentIndex,
            'vehicle-make': policyIssuance.vehicles[currentVehicle].vehicleMake,
            'vehicle-model': policyIssuance.vehicles[currentVehicle].vehicleModel,
            'vehicle-production-year': policyIssuance.vehicles[currentVehicle].productionYear,
            'vehicle-chassis-number': policyIssuance.vehicles[currentVehicle].vehicleChassisNumber,
            'vehicle-motor-number': policyIssuance.vehicles[currentVehicle].vehicleMotorNumber,
            'vehicle-plate-number': policyIssuance.vehicles[currentVehicle].vehiclePlateNumber,
            'vehicle-value': policyIssuance.vehicles[currentVehicle].vehicleValue,
            'vehicle-license-id': policyIssuance.vehicles[currentVehicle].vehicleLicenseId,
            'vehicle-driving-license': policyIssuance.drivingLicenseId,
          },
        },


        'status-scheduling': true,
        'status-inspection': false,
        'status-underwriting': false,
        'status-waiting-ic-approval': false,
        'status-ic-approved': false,
        'status-waiting-user-schedule-approval': false,
      },
      'total-policy-amount' : currentCompanyPolicy,
      'total-amount-approved' : amountApproved,
      'total-new-requests' : totalNewRequests,
      'total-pending-policies' : renewal,
      'total-amount-cancelled': cancelled,
      'total-amount-renewal': pending,
    },SetOptions(merge: true)
    );
  }

  Future updateBrokerPolicyRequestsData(
      UserPolicyIssuance policyIssuance,
      int currentCompanyPolicy,
      int totalNewRequests,
      int amountApproved,
      int renewal,
      int cancelled,
      int pending,
      ) async{
    return await userPolicyRequestBroker.doc(policyIssuance.intendedCompany).set({
      '$currentCompanyPolicy': {
        'insurance-company-assigned': "none",
        'policy-amount': policyIssuance.insuranceAmount,
        'policy-number' : currentCompanyPolicy,
        'policy-holder-id' : policyIssuance.policyHolderID,
        'policy-holder-name': policyIssuance.policyHolderName,
        'policy-holder-mobile': policyIssuance.mobile,
        'policy-holder-address': policyIssuance.address,
        'policy-holder-email':policyIssuance.email,

        'vehicle-index': policyIssuance.vehicleIndex,
        'vehicle-type': policyIssuance.vehicleType,
        'vehicle-weight': policyIssuance.vehicleWeight,
        'no-seats': policyIssuance.vehicleNumberOfSeats,
        'vehicle-make': policyIssuance.vehicleMake,
        'vehicle-model': policyIssuance.vehicleModel,
        'vehicle-production-year': policyIssuance.productionYear,
        'vehicle-chassis-number': policyIssuance.vehicleChassisNumber,
        'vehicle-motor-number': policyIssuance.vehicleMotorNumber,
        'vehicle-plate-number': policyIssuance.vehiclePlateNumber,
        'vehicle-value': policyIssuance.vehicleValue,
        'vehicle-license-id': policyIssuance.carLicenseId,
        'vehicle-driving-license': policyIssuance.drivingLicenseId,

        'status-scheduling': true,
        'status-inspection': false,
        'status-underwriting': false,
        'status-waiting-ic-approval': false,
        'status-ic-approved': false,
        'status-waiting-user-schedule-approval': false,
      },
      'total-policy-amount' : currentCompanyPolicy,
      'total-amount-approved' : amountApproved,
      'total-new-requests' : totalNewRequests,
      'total-pending-policies' : renewal,
      'total-amount-cancelled': cancelled,
      'total-amount-renewal': pending,
    },SetOptions(merge: true)
    );
  }


  Future updatePendingAndOverallAmount(String Comp, int totalPending, int totalOverall,bool asBroker) async{
    return await (asBroker?userPolicyRequestBroker:userPolicyRequest).doc(Comp).set({
      'total-amount-approved' : totalOverall,
      'total-pending-policies' : totalPending,
    },SetOptions(merge: true)
    );
  }

  Future updatePolicyRequestsDataStatuses(int currentUsersPolicies,
      int currentUserIdx, int currentVehicleIdx) async{
    return await userPolicyRequest.doc("requests").set({
      '$currentUserIdx': {
        '$currentVehicleIdx': {
          'vehicle-index': currentUsersPolicies,
          'status-waiting-date-approval': false,
          'date-approved':false,
        },
        'total-policy-amount' : currentUsersPolicies,
      },
    },SetOptions(merge: true)
    );
  }




  void fetchData() async {
    DocumentSnapshot data = await FirebaseFirestore.instance.collection('ahmedNew').doc('123').get();
    snapshot = data;
  }

}