import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Company extends Equatable {
  String name;
  String email;
  String companyNameBdjobs;
  String companyNameFacebook;
  String companyNameGoogle;
  String basisMemberShipNo;
  String yearsOfEstablishment;
  String address;
  String postCode;
  String companyContactNoOne;
  String companyContactNoTwo;
  String companyContactNoThree;
  String webAddress;
  String organizationHead;
  String organizationHeadDesignation;
  String organizationHeadNumber;
  String legalStructure;
  String noOfHumanResources;
  String noOfResources;
  String contactPerson;
  String contactPersonDesignation;
  String contactPersonMobileNo;
  String contactPersonEmail;
  String companyProfile;
  String profilePicture;
  String latitude;
  String longitude;
  String createdDate;
  String division;
  String district;

  Company(
      {this.name,
      this.email,
        this.companyNameBdjobs,
        this.companyNameFacebook,
        this.companyNameGoogle,
        this.basisMemberShipNo,
        this.yearsOfEstablishment,
      this.address,
        this.postCode,
      this.companyContactNoOne,
        this.companyContactNoTwo,
        this.companyContactNoThree,
        this.webAddress,
        this.organizationHead,
        this.organizationHeadDesignation,
        this.organizationHeadNumber,
        this.legalStructure,
        this.noOfHumanResources,
        this.noOfResources,
      this.contactPerson,
      this.contactPersonDesignation,
      this.contactPersonMobileNo,
      this.contactPersonEmail,
        this.companyProfile,
      this.profilePicture,
        this.latitude,
        this.longitude,
      this.createdDate,
      this.division,
      this.district});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    email = json['email']?.toString();
    companyNameBdjobs = json['company_name_bdjobs']?.toString();
    companyNameFacebook = json['company_name_facebook']?.toString();
    companyNameGoogle = json['company_name_google']?.toString();
    basisMemberShipNo = json['basis_membership_no']?.toString();
    yearsOfEstablishment = json['years_of_establishment']?.toString();
    address = json['address']?.toString();
    postCode = json['post_code']?.toString();
    companyContactNoOne = json['company_contact_no_one']?.toString();
    companyContactNoTwo = json['company_company_no_two']?.toString();
    companyContactNoThree = json['company_contact_no_three']?.toString();
    webAddress = json['web_address']?.toString();
    organizationHead = json['organization_head']?.toString();
    organizationHeadDesignation = json['organization_head_designation']?.toString();
    organizationHeadNumber = json['organization_head_number']?.toString();
    legalStructure = json['legal_structure']?.toString();
    noOfHumanResources = json['total_number_of_human_resources']?.toString();
    noOfResources = json['no_of_it_resources']?.toString();
    contactPerson = json['contact_person']?.toString();
    contactPersonDesignation = json['contact_person_designation']?.toString();
    contactPersonMobileNo = json['contact_person_mobile_no']?.toString();
    contactPersonEmail = json['contact_person_email']?.toString();
    companyProfile = json['company_profile']?.toString();
    profilePicture = json['profile_picture']?.toString();
    latitude = json['latitude']?.toString();
    longitude = json['longitude']?.toString();
    createdDate = json['created_date']?.toString();
    division = json['division']?.toString();
    district = json['district']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['company_name_bdjobs'] = this.companyNameBdjobs;
    data['company_name_facebook'] = this.companyNameFacebook;
    data['company_name_google'] = this.companyNameGoogle;
    data['basis_membership_no'] = this.basisMemberShipNo;
    data['years_of_establishment'] = this.yearsOfEstablishment;
    data['address'] = this.address;
    data['post_code'] = this.postCode;
    data['company_contact_no_one'] = this.companyContactNoOne;
    data['company_contact_no_two'] = this.companyContactNoTwo;
    data['company_contact_no_three'] = this.companyContactNoThree;
    data['web_address'] = this.webAddress;
    data['organization_head'] = this.organizationHead;
    data['organization_head_designation'] = this.organizationHeadDesignation;
    data['organization_head_number'] = this.organizationHeadNumber;
    data['legal_structure'] = this.legalStructure;
    data['total_number_of_human_resources'] = this.noOfHumanResources;
    data['no_of_it_resources'] = this.noOfResources;
    data['contact_person'] = this.contactPerson;
    data['contact_person_designation'] = this.contactPersonDesignation;
    data['contact_person_mobile_no'] = this.contactPersonMobileNo;
    data['contact_person_email'] = this.contactPersonEmail;
    data['company_profile'] = this.companyProfile;
    data['profile_picture'] = this.profilePicture;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_date'] = this.createdDate;
    data['division'] = this.division;
    data['district'] = this.district;
    return data;
  }

  @override
  String toString() {
    return name;
  }

  @override
  // TODO: implement props
  List<Object> get props => [
        name,
        email,
        address,
        companyContactNoOne,
        contactPerson,
        contactPersonDesignation,
        contactPersonMobileNo,
        contactPersonEmail,
        profilePicture,
        createdDate,
      ];
}
