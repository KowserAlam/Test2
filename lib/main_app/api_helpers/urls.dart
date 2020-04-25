

//dev server
const String kBaseUrDev = "http://54.84.198.57:8081";

////rashed vai
//const String kBaseUrDev = "http://192.168.1.51:8000";

const String kBaseUrlQA = "http://54.84.198.57:8081";
const String kBaseUrlProd = "http://100.25.85.115";

class Urls {
  /// new
  static String loginUrl = "/api/sign_in/";
  static String signUpUrl = "/api/professional/create_with_user/";
  static String passwordResetUrl = "api/professional/password_reset/";
  static String dashboardUrl = "/api/app-dashboard";

  static String userProfileUrl = "/api/professional/profile";
  static String userProfileUpdateUrlPartial = "/api/professional/profile_update_partial";
  static String userProfileUpdateUrl = "/api/professional/profile_update";
  static String professionalReference = "/api/professional/professional_reference";
  static String professionalSkillUrl = "/api/professional/professional_skill";
  static String professionalEducationUrl = "/api/professional/professional_education";
  static String professionalMembershipUrl = "/api/professional/professional_membership";
  static String professionalCertificationUrl = "/api/professional/certificate_name";


  static String industryListUrl = "/api/industry/";
  static String genderListUrl = "/api/gender/";
  static String nationalityListUrl = "/api/professional/nationality/";
  static String religionListUrl = "/api/professional/religion/";
  static String skillListUrl = "/api/skill_list/";
  static String instituteListUrl = "/api/institute/";
  static String organizationListUrl = "/api/professional/organization/";
  static String majorListUrl = "/api/professional/major/";
  static String certificateNameListUrl = "/api/professional/certificate_name/";
  static String qualificationListUrl = "/api/qualification/";
  static String experienceListUrl = "/api/experience/";





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



//  http://p7.ishraak.com/api/job_list/?page=1&page_size=2
  static String jobListUrl = "/api/job_list";

  /// http://{BASE_URL}/api/featured-examlist/{USER_ID}?page={PAGE_NUMBER}&q={QUERY_TEXT}
//  static String featuredExamListUrl = baseUrl + "/api/featured-examlist";

  /// http://{BASE_URL}/api/enrolled-examlist/{USER_ID}?page={PAGE_NUMBER}
  /// http://{BASE_URL}/api/enrolled-examlist/{USER_ID}?page={PAGE_NUMBER}&q={QUERY_TEXT}
  /// http://192.168.1.143/api/enrolled-examlist/1?q=man&page=1
//  static String examEnrollUrl = baseUrl + "/api/exam-enroll/";

  /// http://{BASE_URL}/api/recent-examlist/{USER_ID}?page={PAGE_NUMBER}&q={QUERY_TEXT}
  ///http://192.168.1.143/api/recent-examlist/1?page=1&q=python
//  static String recentExamListUrl = baseUrl + "/api/recent-examlist";

  /// Search Urls
  /// http://{BASE_URL}/api/featured-examlist/{USER_ID}?page={PAGE_NUMBER}&q={QUERY_TEXT}
//  static String searchFeaturedExamUrl = baseUrl + "/api/featured-examlist";

//  static String searchFeaturedExamUrl = baseUrl + "/api/featured-examlist-search";

  /// enroll exam list
  /// http://{BASE_URL}/api/enrolled-examlist/{USER_ID}?page={PAGE_NUMBER}&q={QUERY_TEXT}
//  static String enrolledExamListUrl = baseUrl + "/api/enrolled-examlist";

  ///User Profile Api
  ///http://dev.ishraak.com:8080/api/app-user/2
  ///http://{BASE_URL}/api/app-user/{USER_ID}
//  static String userProfileUrl = baseUrl + "/api/app-user";
//
//  static String examListUrl = baseUrl + "/registration/index";
//  static String questionListUrl = baseUrl + "/question/list";
//  static String submitUrl = baseUrl + "/exam/submit";

//  Future<bool> checkInternetConnectivity()async{
//
//    bool result = await DataConnectionChecker().hasConnection;
//    if(result == true) {
//      print('Active Internet Connection !');
//    } else {
//      print('No internet!');
//      print(DataConnectionChecker().lastTryResults);
//    }
//
//    return result;
//  }

}
