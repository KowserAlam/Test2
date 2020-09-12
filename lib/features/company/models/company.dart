import 'package:equatable/equatable.dart';
import 'package:p7app/main_app/flavour/flavour_config.dart';

// ignore: must_be_immutable
class Company extends Equatable {
  String name;
  String email;
  String companyNameBdjobs;
  String companyNameFacebook;
  String companyNameGoogle;
  String basisMemberShipNo;
  DateTime yearOfEstablishment;
  String address;
  String country;
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
  double latitude;
  double longitude;
  String createdDate;
  String division;
  String city;
  int numberOfPost;

  Company(
      {this.name,
      this.email,
      this.companyNameBdjobs,
      this.companyNameFacebook,
      this.companyNameGoogle,
      this.basisMemberShipNo,
      this.yearOfEstablishment,
      this.address,
      this.country,
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
      this.city});

  Company.fromJson(Map<String, dynamic> json) {
    String baseUrl = FlavorConfig?.instance?.values?.baseUrl;

    name = json['name']?.toString();
    email = json['email']?.toString();
    companyNameBdjobs = json['company_name_bdjobs']?.toString();
    companyNameFacebook = json['company_name_facebook']?.toString();
    companyNameGoogle = json['company_name_google']?.toString();
    basisMemberShipNo = json['basis_membership_no']?.toString();
    if (json['year_of_eastablishment'] != null) {
      yearOfEstablishment = DateTime.parse(json['year_of_eastablishment']);
    }
    address = json['address']?.toString();
    numberOfPost = json['num_posts'];
    country = json['country']?.toString();
    companyContactNoOne = json['company_contact_no_one']?.toString();
    companyContactNoTwo = json['company_contact_no_two']?.toString();
    companyContactNoThree = json['company_contact_no_three']?.toString();
    webAddress = json['web_address']?.toString();
    organizationHead = json['organization_head']?.toString();
    organizationHeadDesignation =
        json['organization_head_designation']?.toString();
    organizationHeadNumber = json['organization_head_number']?.toString();
    legalStructure = json['legal_structure_of_this_company']?.toString();
    noOfHumanResources = json['total_number_of_human_resources']?.toString();
    noOfResources = json['no_of_it_resources']?.toString();
    contactPerson = json['contact_person']?.toString();
    contactPersonDesignation = json['contact_person_designation']?.toString();
    contactPersonMobileNo = json['contact_person_mobile_no']?.toString();
    contactPersonEmail = json['contact_person_email']?.toString();
    companyProfile = json['company_profile']?.toString();
    if (json['profile_picture'] != null) {
      profilePicture = "$baseUrl${json['profile_picture']}";
    }

    try {
      if(json['latitude'] != null)
      latitude = double.parse(json['latitude'].toString());
      if(json['longitude'] != null)
      longitude = double.parse(json['longitude'].toString());
    } catch (e) {
      print(e);
    }

    createdDate = json['created_date']?.toString();
    division = json['division']?.toString();
    city = json['city']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['company_name_bdjobs'] = this.companyNameBdjobs;
    data['company_name_facebook'] = this.companyNameFacebook;
    data['company_name_google'] = this.companyNameGoogle;
    data['basis_membership_no'] = this.basisMemberShipNo;
    data['year_of_eastablishment'] = this.yearOfEstablishment;
    data['address'] = this.address;
    data['country'] = this.country;
    data['company_contact_no_one'] = this.companyContactNoOne;
    data['company_contact_no_two'] = this.companyContactNoTwo;
    data['company_contact_no_three'] = this.companyContactNoThree;
    data['web_address'] = this.webAddress;
    data['organization_head'] = this.organizationHead;
    data['organization_head_designation'] = this.organizationHeadDesignation;
    data['organization_head_number'] = this.organizationHeadNumber;
    data['legal_structure_of_this_company'] = this.legalStructure;
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
    data['city'] = this.city;
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
