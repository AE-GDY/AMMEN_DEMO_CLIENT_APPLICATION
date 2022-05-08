import 'package:flutter/material.dart';

class ClaimRequest{

  final String intendedInsuranceCompany;
  final String claimRequesterId;
  final String claimRequesterName;
  final String claimRequesterMobile;
  final String claimRequesterAddress;
  final String claimRequesterEmail;
  final int claimRequesterVehicleIndex;
  final String claimRequesterVehicleMake;
  final String claimRequesterVehicleModel;
  final String claimRequesterProductionYear;
  final String claimRequesterVehicleValue;
  final String claimRequesterCarLicenseId;
  late final bool brokerRegistered;
//  final String claimRequesterDrivingLicenseId;

  ClaimRequest({
    required this.intendedInsuranceCompany,
    required this.claimRequesterId,
    required this.claimRequesterName,
    required this.claimRequesterMobile,
    required this.claimRequesterAddress,
    required this.claimRequesterEmail,
    required this.claimRequesterVehicleIndex,
    required this.claimRequesterVehicleMake,
    required this.claimRequesterVehicleModel,
    required this.claimRequesterProductionYear,
    required this.claimRequesterVehicleValue,
    required this.claimRequesterCarLicenseId,
   // required this.brokerRegistered,
  //  required this.claimRequesterDrivingLicenseId
  });

}

List<ClaimRequest> claimRequestsList = [];