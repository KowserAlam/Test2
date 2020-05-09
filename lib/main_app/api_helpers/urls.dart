

//dev server
import 'package:p7app/main_app/api_helpers/api_client.dart';

const String kBaseUrDev = "http://54.84.198.57";

////rashed vai
//const String kBaseUrDev = "http://192.168.1.51:8000";

const String kBaseUrlQA = "http://54.84.198.57";
const String kBaseUrlProd = "http://100.25.85.115";

class Urls {
  /// new
  /// Those url should not contain base url
  /// base url will added by [ApiClient] before sending request

  static String loginUrl = "/api/sign_in/";
  static String signUpUrl = "/api/professional/create_with_user/";
  static String passwordResetUrl = "/api/professional/password_reset/";
  static String dashboardUrl = "/api/app-dashboard";

  static String userProfileUrl = "/api/professional/profile";
  static String userProfileUpdateUrlPartial = "/api/professional/profile_update_partial";
  static String userProfileUpdateUrl = "/api/professional/profile_update";
  static String professionalReference = "/api/professional/professional_reference";
  static String professionalSkillUrl = "/api/professional/professional_skill";
  static String professionalEducationUrl = "/api/professional/professional_education";
  static String professionalMembershipUrl = "/api/professional/professional_membership";
  static String professionalCertificationUrl = "/api/professional/professional_certification";
  static String professionalPortfolioUrl = " /api/professional/professional_portfolio";
  static String professionalExperienceUrl = "/api/professional/professional_work_experience";


  static String industryListUrl = "/api/industry/";
  static String companyListUrl = "/api/company/";
  static String genderListUrl = "/api/gender/";
  static String nationalityListUrl = "/api/professional/nationality/";
  static String religionListUrl = "/api/professional/religion/";
  static String skillListUrl = "/api/skill_list/";
  static String instituteListUrl = "/api/professional/institute/";
  static String organizationListUrl = "/api/professional/organization/";
  static String majorListUrl = "/api/professional/major/";
  static String certificateNameListUrl = "/api/professional/certificate_name/";
  static String qualificationListUrl = "/api/qualification/";
  static String experienceListUrl = "/api/experience/";

  static String favouriteJobAddUrl = "/api/favourite_job_add/";
  static String applyJobOnlineUrl = "/api/apply_online_job_add/";

//  http://p7.ishraak.com/api/job_list/?page=1&page_size=2
  /// http://dev.ishraak.com/api/job_list/?page=1&q=job&location=&category=
  /// &location_from_homepage=&keyword_from_homepage=&skill=&salaryMin=
  /// &salaryMax=&experienceMin=&experienceMax=null&datePosted=&gender=
  /// &qualification=&sort=&page_size=10
  static String jobListUrl = "/api/job_list";
  static String appliedJobListUrl = "/api/applied_jobs";
  static String favouriteJobListUrl = "/api/favourite-jobs";
  static String companySearchUrl = "/company/search";





  /// skill check

  static String examListUrl = "/registration/index";
  static String questionListUrl = "/api/question-list";
  static String submitUrl = "/api/exam-paper/submit";

  static String examResultByIdUrl = "/api/exam/result";
  static String featuredExamListUrl = "/api/featured-examlist";
  static String examEnrollUrl = "/api/exam-enroll/";
  static String recentExamListUrl = "/api/recent-examlist";
  static String searchFeaturedExamUrl = "/api/featured-examlist";
  static String enrolledExamListUrl = "/api/enrolled-examlist";

  static String signUpEmailCheckUrl = "/api/signup/email";
  static String signUpEmailVerificationUrl = "/api/signup/email-verification";
  static String signUpEmailConfirmPassword = "/api/signup/examinee";



}