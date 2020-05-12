
import 'package:p7app/features/user_profile/models/reference_data.dart';
import 'package:p7app/features/user_profile/views/screens/profile_header_edit_screen.dart';

class StringUtils {
  /// login screen

  static var signSuccessfulText =
      "Sign up Successful \n Check your email to verify account !";

  static String appName = "Job Search";
  static String logInButtonText = "LOG IN";
  static String loginSuccessMessage = "Login Successful";
  static String loginUnsuccessfulMessage = "Login unsuccessful";
  static String checkInternetConnectionMessage = "Check Internet Connection";
  static String forgotPassword = "Forgot Password ?";
  static String welcomeBack = "Welcome back!";
  static String loginToYourExistingAccount = "Login to your existing account";

  /// Validator

  static String invalidEmail = "Invalid Email";
  static String pleaseEnterEmailText = "Please enter email";
  static String pleaseEnterAValidEmailText = "Please enter a valid email";
  static String invalidCode = "Invalid Code";
  static String thisFieldIsRequired = "This Field Is Required";
  static String pleaseEnterPasswordText = "Please enter password";
  static String valueWithinRange = "Please enter a value within 0-10";
  static String invalidPassword = "Invalid Password";
  static String passwordMustBeEight =
      "Password must be at least 8 characters long with at least one digit and one letter";
  static String passwordDoesNotMatch = "Password doesn't match";
  static String enterValidEmail = 'Enter Valid Email';
  static String enterValidPhoneNumber = 'Enter Valid Phone Number';
  static String twoDecimal = "Please enter a value within 0-9 and with two decimal values max";

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
  static String skillCheckText = "Skill Check";
  static String appliedJobsText = "Applied Jobs";
  static String favoriteJobsText = "Favorite Jobs";
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
  static String industryExpertiseText  = "Industry Expertise";

  static String contactInfoText = "Contact info";

  static var professionalExperienceText = "Professional Experience";
  static var experienceText = "Experience";
  static var educationsText = "Education";
  static var skillsText = "Skills";
  static var skillText = "Skill";
  static var professionalSkillText = "Professional Skills";
  static var projectsText = "Portfolio";
  static var certificationsText = "Certification";
  static var membershipsText = "Membership";
  static var otherText = "Other";
  static var referencesText = "Reference";
  static var personalInfoText = "Personal Information";
  static var editPersonalInfoText = "Edit Personal Information";
  static var contactText = "Contact";
  static var contactInfo = "Contact Info";
  static var qualificationText = "Qualification";


  static String saveText = "Save";

  //Reference Edit Screen
  static var referenceDescriptionText = "Description";
  static var referenceAppbarText = "Reference";


  //Membership Edit Screen
  static var membershipOrgNameText = "Organization Name";
  static var membershipPositionHeldText = "Position Held";
  static var membershipOngoingText = "Ongoing";
  static var membershipStartDateText = "Start Date";
  static var membershipEndDateText = "End Date";
  static var membershipDescriptionText = "Description";

  //Certifications Edit Screen
  static var certificationNameText = "Certification Name";
  static var certificationOrganizationNameText = "Organization Name";
  static var certificationIssueDateText = "Issue Date";
  static var certificationExpiryDateText = "Expiry Date";
  static var certificationCredentialIdText = "Credential Id";
  static var certificationCredentialUrlText = "Credential URL";
  static var previouslyAddedCertificateText  = "You have already added this certificate before";

  //Portfolio Edit Screen
  static var portfolioNameText = "Name";
  static var portfolioImageText = "Upload Image";
  static var portfolioDescriptionText = "Description";

  ///SharedPreferences key Strings

  static const String isDarkModeOn = "isDarkModeOn";

  /// Add or Edit New Experience
  static String nameOfOrganizationText = "Name of Organization";
  static String nameOfOrganizationEg = "eg. Ishraak Solutions";
  static String positionText = "Position";
  static String positionTextEg = "eg. Software Engineer";
  static String roleText = "Role";
  static String roleTextEg = " ... ";
  static String joiningDateText = "Joining Date";
  static String leavingDateText = "Leaving Date";
  static String currentlyWorkingHereText = "Currently working here";
  static String joining = "Currently working here";
  static String joiningLeavingDateLogic = "Please make sure your joining date occurs before your leaving date";
  static String sameExperience = "You\'ve already added this skill before.";




  /// Add or Edit New Education

  static String nameOfOInstitutionText = "Name of Institution";
  static String nameOfOInstitutionHintText = "eg. ABC Institution";
  static String nameOfODegreeText = "Degree";
  static String nameOfODegreeHintText = "eg. Bachelor of Science";
  static String gpaText = "Percentage/CGPA";
  static String gpaHintText = "eg. 4.0";
  static String enrollDate = "Enrolled Date";
  static String graduationDate = "Graduation Date";
  static String currentlyStudyingHereText = "I'm currently studying here";
  static String startingDateText = "Starting Date";
  static String chooseDateText = "Choose Date";
  static String majorDateText = "Major";
  static String noDegreeChosen = "You need to choose a degree";

  /// login screen

  static var doNotHaveAccountText = "Don't have an account?";
  static var alreadyHaveAndAccountText =
      "Already have an account?";

  /// SignUp Screen

  static var signInText = "Sign In";
  static var signupText = "Signup";
  static var registerAccountText = "Register Account";
  static var signUpText = "Signup";
  static var proceedText = "Proceed";
  static var signUpWithEmailText = "Signup with email";
  static var emailAlreadyExistText =
      "Email Already exist! Try login or rest password";
  static var somethingIsWrong = "Something is wrong ! \nTry again later";

  /// AddEditSkill Screen

  static var skillNameText = "Name of Skill";
  static var skillNameExample = "eg. Python";
  static var expertiseLevel = "Expertise level:";
  static var searchSkillText = "Search your skill";

  /// Verify Screen

  static var verifyYourEmailText = "Verify Your Email";
  static var an6DigitCodeSentToText = "A 6-digit code is sent to";
  static var codeText = "Code";
  static var didNotReceiveTheCodeText = "Didn't receive the code?";
  static var resendText = "Resend";
  static var verify = "Verify";

  /// Edit Profile Screen Texts
  /// [ProfileHeaderEditScreen]

  static var fullNameText = "Name";
  static var fullNameHintText = "eg. John Doe";
  static var designationText = "Designation";
  static var designationHintText = "eg. Software Engineer";
  static var aboutHintText = " ...";
  static var phoneText = "Phone";
  static var mobileText = "Mobile";
  static var phoneHintText = "+8801XXXXXXXX";
  static var addressText = "Address";
  static var addressHintText =
      "";

  static var locationText = "Location";
  static var currentCompany = "Current Company";
  static var nameOfCompany = "Name Of Company";
  static var currentCompanyHint = "eg. ABC Corporation";
  static var currentDesignation = "Current Designation";
  static var currentDesignationHint =  "eg. Software Engineer";
  static var locationHintText = "eg. Dhaka, Bangladesh";
  static var editText = "Edit";
  static var portfolioText = "Portfolio";

  /// Profile Screen *******************
  /// Personal Info

  static var fatherNameText = "Father's Name";
  static var motherNameText = "Mother's Name";
  static var dateOfBirthText = "Date of Birth";
  static var permanentAddressText = "Permanent Address";
  static var currentAddressText = "Current Address";
  static var religionText = "Religion";
  static var genderText = "Gender";
  static var nationalityText = "Nationality";
  static var languagesKnown  = "Languages Known ";
  static var cropImageText  = "Crop Image";
  static var cancelText  = "Cancel";
  static var facebookTrlText  = "Facebook";
  static var facebookBaseUrl  = "facebook.com/";
  static var twitterUrlText  = "Twitter";
  static var twitterBaeUrl  = "twitter.com/";
  static var linkedUrlText  = "LinkedIn";
  static var linkedBaseUrl  = "linkedin.com/in/";
  static var unableToLoadExpertiseListText  = "Unable to load expertise list";
  static var unableToLoadSkillListText  = "Unable to load skill list";
  static var enterValidSkillText  = "Please enter a valid skill";
  static var previouslyAddedSkillText  = "You have already added this skill before";


  /// password reset
  static var passwordResetText = "Reset Password";
  static var setNewPasswordText = "Set new password";
  static var resetYourPassword = "Reset your Password";
  static var unableToSaveData = "Unable to save data";
  static var aPasswordRestLinkHasBeenSentToText = "A password reset email has been sent to";

  /// Result Screen

  static var pleaseWaitText = "Please Wait .. ";
  static var resultText = "Result";

  /// General
  static var versionText = "Version";
  static var versionTextLowerCase = "v ";
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
static const String applyFilterText = "Apply Filter";
static const String appliedText = "Applied";
static const String jobListText = "Job List";
static const String successfullyAppliedText = "Successfully Applied";
static const String savedText = "Saved";
static const String typeToSearch = "Type to search";
static const String noJobsFound = "No jobs found";
static const String noFavouriteJobsFound = "No favourite jobs found";
static const String noAppliedJobsFound = "No applied jobs found";


///Job Details
static const String jobDetailsAppBarTitle = 'Job Details';
static const String applyButtonText = 'Apply';
static const String saveJobButtonText = 'Save Job';
static const String jobDescriptionTitle = 'Description';
static const String responsibilitiesTitle = 'Responsibilities';
static const String educationTitle = 'Educational Requirement';
static const String salaryTitle = 'Salary';
static const String otherBenefitsTitle = 'Other Benefits';
static const String secondApplyButtonText = 'Apply Online: ';
static const String emailJobButtonText = 'Email Job: ';
static const String jobSummeryTitle = 'Summary';
static const String publishedOn = 'Published on: ';
static const String vacancy = 'Vacancy: ';
static const String employmentStatus = 'Type: ';
static const String yearsOfExperience = 'Experience: ';
static const String jobLocation = 'Location: ';
static const String salary = 'Salary: ';
static const String salaryRangeText = 'Salary Range ';
static const String gender = 'Gender: ';
static const String tapToSelectText = 'Tap to select';
static const String applicationDeadline = 'Deadline: ';
static const String requiredSkills = 'Skill Requirement';
static const String benefitSectionTitle = 'Benefits';
static const String jobSource = 'Job Source';
static const String doYouWantToApplyText = 'Do you want to apply?';
static const String jobsFoundText = 'jobs found';
static const String sortBy = 'Sort By';
static const String advanceFilterText = "Advance Filter";
static const String jobCategoryText = "Job Category";
static const String jobTypeText  = "Job Type";
static const String datePosted  = "Date Posted";
}
