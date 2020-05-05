class Company{
  String name;
  String email;
  String address;
  String companyContactNoOne;
  String contactPerson;
  String contactPersonDesignation;
  String contactPersonMobileNo;
  String contactPersonEmail;
  String profilePicture;
  String createdDate;

  Company(
      {this.name,
        this.email,
        this.address,
        this.companyContactNoOne,
        this.contactPerson,
        this.contactPersonDesignation,
        this.contactPersonMobileNo,
        this.contactPersonEmail,
        this.profilePicture,
        this.createdDate});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    address = json['address'];
    companyContactNoOne = json['company_contact_no_one'];
    contactPerson = json['contact_person'];
    contactPersonDesignation = json['contact_person_designation'];
    contactPersonMobileNo = json['contact_person_mobile_no'];
    contactPersonEmail = json['contact_person_email'];
    profilePicture = json['profile_picture'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['company_contact_no_one'] = this.companyContactNoOne;
    data['contact_person'] = this.contactPerson;
    data['contact_person_designation'] = this.contactPersonDesignation;
    data['contact_person_mobile_no'] = this.contactPersonMobileNo;
    data['contact_person_email'] = this.contactPersonEmail;
    data['profile_picture'] = this.profilePicture;
    data['created_date'] = this.createdDate;
    return data;
  }
}