//dev server
import 'package:p7app/main_app/api_helpers/api_client.dart';

const String kBaseUrDev = "http://dev.ishraak.com";
const String kBaseUrlProd = "https://jobxprss.com";

class Urls {
  /// new
  /// Those url should not contain base url
  /// base url will added by [ApiClient] before sending request

  static String loginUrl = "/api/pro/signin/";
  static String googleSignIn = "/api/pro/google/signin/";
  static String signUpUrl = "/api/professional/create_with_user/";
  static String passwordResetUrl = "/api/professional/password_reset/";
  static String dashboardUrl = "/api/app-dashboard";
  static String passwordChangeUrl = "/api/pro/change-password/";
  static String openJobsCompany = "/api/job/search/?company="; //cname
  static String jobAlertStatusUrl =
      "/api/professional/job_alert_notification/"; //cname
  static String jobAlertOnOffUrl =
      "/api/professional/email-subscription-on-off/"; //c8eb21a2-0bb6-46ec-add6-0de5336e1723/
  static String countryListUrl = "/api/country/list/";
  static String userProfileUrl = "/api/professional/profile";
  static String userProfileUpdateUrlPartial =
      "/api/professional/profile_update_partial";
  static String userProfileUpdateUrl = "/api/professional/profile_update";
  static String professionalReference =
      "/api/professional/professional_reference";
  static String professionalSkillUrl = "/api/professional/professional_skill";
  static String professionalEducationUrl =
      "/api/professional/professional_education";
  static String professionalEducationObjUrl =
      "/api/professional/professional_education_object";
  static String professionalMembershipUrl =
      "/api/professional/professional_membership";
  static String professionalCertificationUrl =
      "/api/professional/professional_certification";
  static String professionalPortfolioUrl =
      "/api/professional/professional_portfolio";
  static String professionalExperienceUrl =
      "/api/professional/professional_work_experience";
  static String jobExperienceList = "/api/experience/list";
  static String industryListUrl = "/api/industry/";
  static String companyListUrl = "/api/company/";
  static String genderListUrl = "/api/gender/list";
  static String certifyingOrganizationListUrl = "/api/professional/certifying_organization/search/"; //?name=Scrum
  static String membershipOrganizationListUrl = "/api/professional/membership_organization/search/"; //?name=Scrum

  static String nationalityListUrl = "/api/professional/nationality/";
  static String religionListUrl = "/api/professional/religion/";
  static String skillListUrl = "/api/skill/list/";
  static String instituteListUrl = "/api/professional/institute/list/";
  static String organizationListUrl = "/api/professional/organization/";
  static String majorListUrl = "/api/professional/major/";
  static String certificateNameListUrl = "/api/professional/certificate_name/";
  static String qualificationListUrl = "/api/qualification/list";
  static String experienceListUrl = "/api/experience/";
  static String jobCategoriesListUrl = "/api/job-category/list/";
  static String topCategoriesListUrl = "/api/job/top-categories/";
  static String recentJobsListUrl = "/api/job/recent/";
  static String topCompaniesListUrl = "/api/job/top-companies/";
  static String featuredCompaniesListUrl = "/api/company/list/featured";
  static String jobTypeListUrl = "/api/job-type/list";
  static String jobLocationListUrl = "/api/location/";
  static String jobSourceList = "/api/job-source/list/";
  static String jobGenderList = "/api/job-gender/list/";
  static String jobSiteList = "/api/job-site/list";
  static String jobNatureList = "/api/job-nature/list";
  static String educationLevelListURl = "/api/professional/education_level/";

  static String jobDetailsUrl = "/api/job/get/";
  static String favouriteJobAddUrl = "/api/job/favourite/toggle";
  static String applyJobOnlineUrl = "/api/job/apply/";
  static String applyJobWithNoteUrl = "/api/job_apply/";

//  http://p7.ishraak.com/api/job_list/?page=1&page_size=2
  /// http://dev.ishraak.com/api/job_list/?page=1&q=job&location=&category=
  /// &location_from_homepage=&keyword_from_homepage=&skill=&salaryMin=
  /// &salaryMax=&experienceMin=&experienceMax=null&datePosted=&gender=
  /// &qualification=&sort=&page_size=10

  static String jobListUrl = "/api/job/search";
  static String appliedJobListUrl = "/api/job/applied/";
  static String favouriteJobListUrl = "/api/job/favourite/";
  static String companySearchUrl = "/api/company/search";
  static String similarJobs = "/api/job/similar"; // /job id/
  static String fcmTokenAddUrl = "/api/fcm-cloud-message/"; // /job id/

  /// dashboardUrl
  static String dashboardInfoBoxUrl = "/api/pro/dashboard/infobox/";
  static String dashboardSkillJobChartUrl = "/api/pro/dashboard/skill/";
  static String profileCompleteness = "/api/pro/profile-completeness/";
  static String vitalStatsUrl = "/api/vital_stats/get/";

  static String jwtRefreshUrl = "/api/token/refresh/";
  static String careerAdviceUrl = "/api/career_advice";

//contact us
  static String settingsUrl = "/api/settings/";
  static String contactUsSubmitUrl = "/api/send_email_to_admin_contact_us/";

  static String notificationMarkReadUrl = "/api/notification/mark-read"; //  id
  static String notificationListUrl = "/api/notification";
  static String notificationGetUrl = "/api/notification/get/"; //  id
  static String createMessageListUrl = "/api/employer-message-create/";
  static String messageSenderListUrl = "/api/sender-list/";
  static String senderMessageListUrl =
      "/api/sender-message-list/?sender="; //  id 75
  static String messageMarkedReadUrl =
      "/api/employer-message/mark-read/"; //  id

// webUrl
  static String aboutUsWeb = "/about-us-app/";
  static String contactUsWeb = "/contact-us-app/";
  static String careerAdviceWeb = "/career-advice-app/";
  static String faqWeb = "/FAQ-app/";
}
