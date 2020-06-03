

//dev server
import 'package:p7app/main_app/api_helpers/api_client.dart';

const String kBaseUrDev = "http://dev.ishraak.com";

////rashed vai
//const String kBaseUrDev = "http://192.168.1.51:8000";

const String kBaseUrlQA = "http://dev.ishraak.com";
const String kBaseUrlProd = "http://100.25.85.115";

class Urls {
  /// new
  /// Those url should not contain base url
  /// base url will added by [ApiClient] before sending request

  static String loginUrl = "/api/sign_in/";
  static String signUpUrl = "/api/professional/create_with_user/";
  static String passwordResetUrl = "/api/professional/password_reset/";
  static String dashboardUrl = "/api/app-dashboard";
  static String passwordChangeUrl = "/api/pro/change-password/";

  static String userProfileUrl = "/api/professional/profile";
  static String userProfileUpdateUrlPartial = "/api/professional/profile_update_partial";
  static String userProfileUpdateUrl = "/api/professional/profile_update";
  static String professionalReference = "/api/professional/professional_reference";
  static String professionalSkillUrl = "/api/professional/professional_skill";
  static String professionalEducationUrl = "/api/professional/professional_education";
  static String professionalMembershipUrl = "/api/professional/professional_membership";
  static String professionalCertificationUrl = "/api/professional/professional_certification";
  static String professionalPortfolioUrl = "/api/professional/professional_portfolio";
  static String professionalExperienceUrl = "/api/professional/professional_work_experience";


  static String industryListUrl = "/api/industry/";
  static String companyListUrl = "/api/company/";
  static String genderListUrl = "/api/gender/list";

  static String nationalityListUrl = "/api/professional/nationality/";
  static String religionListUrl = "/api/professional/religion/";
  static String skillListUrl = "/api/skill/list/";
  static String instituteListUrl = "/api/professional/institute/";
  static String organizationListUrl = "/api/professional/organization/";
  static String majorListUrl = "/api/professional/major/";
  static String certificateNameListUrl = "/api/professional/certificate_name/";
  static String qualificationListUrl = "/api/qualification/list";
  static String experienceListUrl = "/api/experience/";
  static String jobCategoriesListUrl = "/api/job-category/list/";
  static String jobTypeListUrl = "/api/job-type/list";
  static String jobLocationListUrl = "/api/location/";
  static String jobSourceList = "/api/job-source/list/";
  static String jobGenderList = "/api/job-gender/list/";
  static String jobSiteList = "/api/job-site/list";
  static String jobNatureList = "/api/job-nature/list";

  static String jobDetailsUrl = "/api/job/get/";
  static String favouriteJobAddUrl = "/api/job/favourite/toggle";
  static String applyJobOnlineUrl = "/api/job/apply/";

//  http://p7.ishraak.com/api/job_list/?page=1&page_size=2
  /// http://dev.ishraak.com/api/job_list/?page=1&q=job&location=&category=
  /// &location_from_homepage=&keyword_from_homepage=&skill=&salaryMin=
  /// &salaryMax=&experienceMin=&experienceMax=null&datePosted=&gender=
  /// &qualification=&sort=&page_size=10

  static String jobListUrl = "/api/job/search";
  static String appliedJobListUrl = "/api/job/applied/";
  static String favouriteJobListUrl = "/api/job/favourite/";
  static String companySearchUrl = "/api/company/search";

  /// dashboardUrl

static String dashboardInfoBoxUrl = "/api/professional/info_box/";
static String dashboardSkillJobChartUrl = "/api/professional/skill_job_chart/";
static String profileCompleteness = "/api/pro/profile-completeness/";
static String settingsUrl = "/api/settings/";



// webUrl
  static String aboutUsWeb = "/about-us-app/";
  static String contactUsWeb = "/contact-us-app/";
  static String careerAdviceWeb = "/career-advice-app/";
  static String faqWeb = "/FAQ-app/";



}