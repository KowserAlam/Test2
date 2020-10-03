class WebSettingsModel {
  String id;
  String facebookUrl;
  String linkedinUrl;
  String twitterUrl;
  String appstoreUrl;
  String playstoreUrl;
  String logoUrl;
  String adminEmail;
  String supportEmail;
  String address;
  String phone;
  int zoom;
  String latitude;
  String longitude;
  int  minimumProfileCompleteness;

  WebSettingsModel(
      {this.id,
      this.minimumProfileCompleteness,
      this.facebookUrl,
      this.linkedinUrl,
      this.twitterUrl,
      this.appstoreUrl,
      this.playstoreUrl,
      this.logoUrl,
      this.adminEmail,
      this.supportEmail,
      this.address,
      this.phone,
      this.zoom,
      this.latitude,
      this.longitude});

  WebSettingsModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    facebookUrl = json['facebook_url'];
    linkedinUrl = json['linkedin_url'];
    twitterUrl = json['twitter_url'];
    appstoreUrl = json['appstore_url'];
    playstoreUrl = json['playstore_url'];
    logoUrl = json['logo_url'];
    adminEmail = json['admin_email'];
    supportEmail = json['support_email'];
    address = json['address'];
    phone = json['phone']?.toString();
    zoom = json['zoom'];
    minimumProfileCompleteness = json['minimum_profile_completeness'];
    if (json['longitude'] != null) {
      latitude = json['latitude'];
    }
    if (json['longitude'] != null) {
      longitude = json['longitude'];
    }
  }

}
