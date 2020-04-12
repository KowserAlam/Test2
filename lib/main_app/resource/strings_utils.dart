import 'package:p7app/features/user_profile/edit_profile_screen.dart';

class StringUtils {
  /// login screen

  static var signSuccessfulText =
      "Sign up Successful \n Check your email to verify account !";

  static String appName = "Job Search";
  static String signInButtonText = "Sign in";
  static String loginSuccessMessage = "Login Successful";
  static String loginUnsuccessfulMessage = "Login unsuccessful";
  static String checkInternetConnectionMessage = "Check Internet Connection";
  static String forgotPassword = "Forgot Password ?";

  /// Validator

  static String invalidEmail = "Invalid Email";
  static String invalidCode = "Invalid Code";
  static String thisFieldIsRequired = "This field is Required";
  static String invalidPassword = "Invalid Password";
  static String passwordMustBeEight =
      "Password must be at least 8 characters long with at least one digit and one letter";
  static String passwordDoesNotMatch = "Password doesn't match";
  static String enterValidEmail = 'Enter Valid Email';
  static String enterValidPhoneNumber = 'Enter Valid Phone Number';

  ///
  static String passwordText = "Password";
  static String confirmPasswordText = "Confirm Password";
  static String labelTextFullName = "Full Name";
  static String emailText = "Email";
  static String smsText = "SMS";
  static String textExamInfo = "Exam Info";
  static String submitButtonText = "Submit";
  static String cancelButtonText = "Cancel";
  static String proceedButtonText = "Proceed";
  static String doYouWantToSubmitText = "Do you want to submit?";

  static String yesText = "Yes";
  static String noText = "No";
  static String candidateListText = "Candidate List";
  static String candidateNameText = "Candidate Name";

  static String examNameText = "Exam";
  static String noExamText = "No Exam";

  static String instructionText = "Instruction";
  static String instructionDetailsText = " Exam ";

  static String startExamText = "Start Exam";
  static String startText = "Start";

  /// ***************** Dashboard  Screen ***********************

  static String examHistoryText = "Exam History";
  static String exams = "Exams";
  static String enrolledExamsText = "Enrolled Exams";
  static String pieChartText = "Pie chart";
  static String searchText = "Search";
  static String enrollText = "Enroll";
  static String enrolledText = "Enrolled";

  /// ***************** Featured Exam Screen ***********************
  static String featuredExamsText = "Featured Exams";

  /// ***************** Recent Exam Screen ***********************

  static String recentExamsText = "Recent Exams";

  static String viewMoreText = "View More";

  /// ***************** Feature Assessment ***********************
  static String questionTextUpperCase = "QUESTIONS";
  static String questionNoTextUpperCase = "Question No";
  static String examText = "Exam";
  static String nameText = "Name";
  static String examCodeText = "Exam Code";
  static String idTextUpperCase = "ID";
  static String minutesText = "Minutes";
  static String regNoText = "Reg. No.";
  static String allText = "All";
  static String reviewText = "Review";

  static String indexText = "Index";

  static var prevQuestionText = "Previous";
  static var nextQuestionText = "Next";

  static var finishExamButtonText = " Finish Exam ";

  static String confusedText = "Confused";
  static String submissionSuccessful = "Submission Successful";

  static String remainingTimeText = "Remaining Time: ";
  static String elapsedTimeText = "Elapsed Time: ";
  static String somethingWentWrong = "Something went wrong";
  static String unableToFetchList = "Unable to fetch List";
  static String failedToLoadList = 'Failed to load list';
  static String failedToLoadData = 'Failed to load data';
  static String ishraakSolutionsText = 'Ishraak Solutions';
  static String doYouWantToExitApp = 'Do you want to exit this application?';
  static String doYouWantToQuitExamApp = 'Do you want to Quit Exam?';

  static String yourProgressWillBeLost = 'Your progress will be lost !';
  static String yourProgressIsSubmitting = 'Your Progress is Submitting !. . .';
  static String failedToSubmit = 'Failed to submit! Retrying . . . .';
  static String backText = 'Back';

  static String tryAgainText = "Try Again";

  static var markedForReviewText = "Marked for review";
  static var attemptedNMarkedForReviewText = "Attempted but marked";
  static var attemptedText = "Attempted";
  static var notAttemptedText = "Not Attempted";

  static String checkRequiredField = "Check Required Fields";

  static String durationText = "Duration";
  static String settingsText = "Settings";
  static String signOutText = "Sign out";

  static String darkModeText = "DarkMode";

  /// **************** Dashboard *****************

  static String dashBoardText = "Dashboard";
  static String areYouSure = "Are you sure?";

  /// **************** Profile *****************

  static String profileText = "My Profile";

  static String publicView = "PUBLIC VIEW";

  static String editProfileText = "EDIT PROFILE";
  static String aboutText = "About";
  static String aboutMeText = "About Me";

  static String contactInfoText = "Contact info";

  static var experienceText = "Professional Experiences";
  static var educationsText = "Educations";
  static var skillsText = "Skills";
  static var technicalSkillText = "Technical Skills";
  static var projectsText = "Portfolio";
  static var otherText = "Other";
  static var referenceText = "Reference";
  static var personalInfoText = "Personal Information";
  static var editPersonalInfoText = "Edit Personal Information";
  static var contactText = "Contact";


  static String saveText = "Save";

  ///SharedPreferences key Strings

  static const String isDarkModeOn = "isDarkModeOn";

  /// Add or Edit New Experience
  static String nameOfOrganizationText = "Name of Organization";
  static String nameOfOrganizationEg = "eg. Ishraak Solutions";
  static String positionText = "Position";
  static String positionTextEg = "Software Engineer";
  static String roleText = "Role(Optional)";
  static String roleTextEg = " ... ";
  static String joiningDateText = "Joining Date";
  static String leavingDateText = "Leaving Date";
  static String currentlyWorkingHereText = "I'm currently working here";

  /// Add or Edit New Education

  static String nameOfOInstitutionText = "Name of Institution";
  static String nameOfOInstitutionHintText = "eg. Ishraak Solutions";
  static String nameOfODegreeText = "Degree";
  static String nameOfODegreeHintText = "eg. Bachelor of Science";
  static String gpaText = "Percentage/CGPA";
  static String gpaHintText = "eg. 4.0";
  static String passingYearText = "Passing Year";
  static String currentlyStudyingHereText = "I'm currently studying here";
  static String startingDateText = "Starting Date";

  /// login screen

  static var doNotHaveAccountText = "Don't have an account?";
  static var alreadyHaveAndAccountText =
      "Already have an account?";

  /// SignUp Screen

  static var signInText = "Sign In";
  static var registerText = "Register";
  static var registerAccountText = "Register Account";
  static var signUpText = "Signup";
  static var proceedText = "Proceed";
  static var signUpWithEmailText = "Signup with email";
  static var emailAlreadyExistText =
      "Email Already exist! Try login or rest password";
  static var somethingIsWrong = "Something is wrong ! Try again later";

  /// AddEditSkill Screen

  static var skillNameText = "Name of Skill";
  static var skillNameExample = "eg. Python";
  static var expertiseLevel = "Expertise level";

  /// Verify Screen

  static var verifyYourEmailText = "Verify Your Email";
  static var an6DigitCodeSentToText = "A 6-digit code is sent to";
  static var codeText = "Code";
  static var didNotReceiveTheCodeText = "Didn't receive the code?";
  static var resendText = "Resend";
  static var verify = "Verify";

  /// Edit Profile Screen Texts
  /// [EditProfileScreen]

  static var fullNameText = "Full Name";
  static var fullNameHintText = "eg. Bill Gates";
  static var designationText = "Designation";
  static var designationHintText = "eg. Software Engineer";
  static var aboutHintText = " ...";
  static var phoneText = "Phone";
  static var mobileText = "Mobile";
  static var phoneHintText = "+8801XXXXXXXX";
  static var addressText = "Full Address";
  static var addressHintText =
      "eg. House 76 (Level 4), Road 4, Block B, Niketan Gulshan 1, Dhaka 1212, Bangladesh";

  static var locationText = "Location";
  static var locationHintText = "Dhaka, Bangladesh";
  static var editText = "Edit";

  /// Profile Screen *******************
  /// Personal Info

  static var fatherNameText = "Father name";
  static var motherNameText = "Mother name";
  static var dateOfBirthText = "Date of Birth";
  static var permanentAddersText = "Permanent adders";
  static var currentAddersText = "Current adders";
  static var religionText = "Religion";
  static var genderText = "Gender";
  static var nationalityText = "Nationality";
  static var languagesKnown  = "Languages Known ";


  /// password reset
  static var passwordResetText = "Reset Password";
  static var setNewPasswordText = "Set new password";
  static var resetYourPassword = "Reset your Password";

  /// Result Screen

  static var pleaseWaitText = "Please Wait .. ";
  static var resultText = "Result";

  /// General
  static var versionText = "Version";

  static String noExamFoundText = "No exam found !";

  static var homText = "home";

  static String enumName(String enumToString) {
    List<String> paths = enumToString.split(".");
    return paths[paths.length - 1];
  }


  ///
/// Jobs
static const String unspecifiedText = "Unspecified";
static const String deadlineText = "Deadline";
static const String applyText = "Apply";
static const String jobListText = "Job List";


///Job Details
static const String jobDetailsAppBarTitle = 'Job Details';
static const String applyButtonText = 'Apply Online';
static const String saveJobButtonText = 'Save Job';
static const String jobDescriptionTitle = 'Job Description: ';
static const String responsibilitiesTitle = 'Responsibilities: ';
static const String educationTitle = 'Education: ';
static const String salaryTitle = 'Salary: ';
static const String otherBenefitsTitle = 'Other Benefits: ';
static const String secondApplyButtonText = 'Apply Online: ';
static const String emailJobButtonText = 'Email Job: ';
static const String jobSummeryTitle = 'Job Summery: ';
static const String publishedOn = 'Published on: ';
static const String vacancy = 'Vacancy: ';
static const String employmentStatus = 'Emplyment Status: ';
static const String yearsOfExperience = 'Yeas of Experience: ';
static const String jobLocation = 'Job Location: ';
static const String salary = 'Salary: ';
static const String gender = 'Gender: ';
static const String applicationDeadline = 'Application Deadline: ';
static const String requiredSkills = 'Required Skills: ';
}
