import 'package:flutter_driver/flutter_driver.dart';

class Keys{

  //Common keys
  static final backButton = find.byTooltip('Back');
  static final doneButtonKey = find.byTooltip('doneButtonKey');

  //Sign in screen
  static final signInEmail = find.byValueKey('signInEmail');
  static final signInPassword = find.byValueKey('signInPassword');
  static final signInButton = find.byValueKey('signInButton');
  static final signUpText = find.byValueKey('signUpText');
  static final forgotPasswordLink = find.text('Forgot Password ?');

  //Onboarding screen
  static final onboardingPageBackArrow = find.byValueKey('onboardingPageBackArrow');
  static final onboardingPageFrontArrow = find.byValueKey('onboardingPageFrontArrow');
  static final onboardingPageContinueButton = find.byValueKey('onboardingPageContinueButton');
  static final onboardingPageSkipButton = find.text('Skip');

  //Signup screen
  static final signUpNameField = find.byValueKey('signUpName');
  static final signUpEmailField = find.byValueKey('signUpEmail');
  static final signUpMobileField = find.byValueKey('signUpMobile');
  static final signUpPasswordField = find.byValueKey('signUpPassword');
  static final signUpConfirmPasswordField = find.byValueKey('signUpConfirmPassword');
  static final signUpRegisterButton = find.byValueKey('signUpRegisterButton');

  //Dashboard
  static final bottomNavigationBarMyProfile = find.byValueKey('bottomNavigationBarMyProfile');
  static final bottomNavigationBarDashboard = find.byValueKey('bottomNavigationBarDashboard');
  static final bottomNavigationBarCompany = find.byValueKey('bottomNavigationBarCompany');
  static final bottomNavigationBarMessages = find.byValueKey('bottomNavigationBarMessages');
  static final bottomNavigationBarJobs = find.byValueKey('bottomNavigationBarJobs');
  static final notificationsTextOnAppBar = find.byValueKey('notificationsText');

  ///////////         My Profile          /////////////
  static final myProfileAppbarTitle = find.byValueKey('myProfileAppbarTitle');
  static final myProfileScrollView = find.byValueKey('myProfileScrollView');
  static final myProfileDialogBoxDeleteTile = find.byValueKey('myProfileDialogBoxDeleteTile');
  static final myProfileDialogBoxCancelDeleteTile = find.byValueKey('myProfileDialogBoxCancelDeleteTile');

  static final myProfileHeaderEditButton = find.byValueKey('myProfileHeaderEditButton');
  static final myProfileHeaderName = find.byValueKey('myProfileHeaderName');
  static final myProfileHeaderDescription = find.byValueKey('myProfileHeaderDescription');
  static final myProfileHeaderLocation = find.byValueKey('myProfileHeaderLocation');
  static final myProfileHeaderPhone = find.byValueKey('myProfileHeaderPhone');
  static final myProfileHeaderEmail = find.byValueKey('myProfileHeaderEmail');
  static final myProfileHeaderDesignation = find.byValueKey('myProfileHeaderDesignation');
  static final myProfileHeaderCompany = find.byValueKey('myProfileHeaderCompany');

  static final myProfileExperiencePenKey = find.byValueKey('myProfileExperiencePenKey');
  static final myProfileExperienceAddKey = find.byValueKey('myProfileExperienceAddKey');

  static final myProfileAddSkillPen = find.byValueKey('myProfileAddSkillPen');
  static final myProfileAddSkillAdd = find.byValueKey('myProfileAddSkillAdd');
  static final skillEditButton = find.byValueKey('skillEditButtonPython');
  static final skillDeleteButton = find.byValueKey('skillDeleteButton0');
  static final tileSkillName = find.byValueKey('tileSkillName0');
  static final addedTileSkillName = find.byValueKey('tileSkillName1');

  static final myProfileAddReferencesPen = find.byValueKey('myProfileAddReferencesPen');
  static final myProfileAddReferencesAdd = find.byValueKey('myProfileAddReferencesAdd');
  static final myProfileReferencesTileEditButton1 = find.byValueKey('myProfileReferencesTileEditButton1');
  static final myProfileReferencesTileDeleteButton1 = find.byValueKey('myProfileReferencesTileDeleteButton1');
  static final referenceTileDescription1 = find.byValueKey('referenceTileDescription1');

  static final myProfilePortfolioAddKey = find.byValueKey('myProfilePortfolioAddKey');
  static final myProfilePortfolioPenKey = find.byValueKey('myProfilePortfolioPenKey');


  //Header Edit Screen
  static final myProfileHeaderAppbarTitle = find.byValueKey('myProfileHeaderAppbarTitle');
  static final myProfileHeaderSaveButton = find.byValueKey('myProfileHeaderSaveButton');
  static final myProfileHeaderFullNameField = find.byValueKey('myProfileHeaderFullNameField');
  static final myProfileHeaderDescriptionField = find.byValueKey('myProfileHeaderDescriptionField');
  static final myProfileHeaderExperiencePerYearField = find.byValueKey('myProfileHeaderExperiencePerYearField');
  static final myProfileHeaderMobileField = find.byValueKey('myProfileHeaderMobileField');
  static final myProfileHeaderCurrentCompanyField = find.byValueKey('myProfileHeaderCurrentCompanyField');
  static final myProfileHeaderCurrentDesignationField = find.byValueKey('myProfileHeaderCurrentDesignationField');
  static final myProfileHeaderLocationField = find.byValueKey('myProfileHeaderLocationField');
  static final myProfileHeaderFacebookField = find.byValueKey('myProfileHeaderFacebookField');
  static final myProfileHeaderTwitterField = find.byValueKey('myProfileHeaderTwitterField');
  static final myProfileHeaderLinkedInField = find.byValueKey('myProfileHeaderLinkedInField');
  static final myProfileHeaderScrollView = find.byValueKey('myProfileHeaderScrollView');

  //Work Experience
  static final workExperienceAppbarTitleKey = find.byValueKey('workExperienceAppbarTitleKey');
  static final workExperienceSaveButton = find.byValueKey('workExperienceSaveButton');
  static final experienceDesignationKey = find.byValueKey('experienceDesignationKey');
  static final experienceDescriptionKey = find.byValueKey('experienceDescriptionKey');
  static final experienceCurrentlyWorkingKey = find.byValueKey('experienceCurrentlyWorkingKey');
  static final experienceCompanyName = find.byValueKey('experienceCompanyName');
  static final experienceLeavingDate = find.byValueKey('experienceLeavingDate');
  static final experienceJoiningDate = find.byValueKey('experienceJoiningDate');



  //Professional Skill
  static final professionalSkillAppbarTitle = find.byValueKey('professionalSkillAppbarTitle');
  static final skillAddField = find.byValueKey('skillAddField');
  static final skillExpertise = find.byValueKey('skillExpertise');
  static final skillSaveButton = find.byValueKey('skillSaveButton');


  //References
  static final referencesAppbarTitle = find.byValueKey('referencesAppbarTitle');
  static final myProfileReferencesSaveButton = find.byValueKey('myProfileReferencesSaveButton');
  static final referencesDescription = find.byValueKey('referencesDescription');

  //Portfolio
  static final portfolioAppbarTitle = find.byValueKey('portfolioAppbarTitle');
  static final portfolioName = find.byValueKey('portfolioName');
  static final portfolioDescription = find.byValueKey('portfolioDescription');

  //Jobs Segment
  static final clickOnAppliedJobsFromSegmentScreen = find.byValueKey('jobsSegmentAppliedText');
  static final clickOnFavoriteJobsFromSegmentScreen = find.byValueKey('jobsSegmentFavoriteText');
  static final clickOnAllJobsFromSegmentScreen = find.byValueKey('jobsSegmentAllText');

  //Jobs Segment - All jobs
  static final clickOnFirstApplyKeyOnAllJobs = find.byValueKey('allJobsApplyKey0');
  static final clickOnFirstTileOnAllJobs = find.byValueKey('allJobsTileKey0');
  static final checkFavoriteUnfavoriteFromAllJobsList = find.byValueKey('allJobsListFavoriteButtonKey0'); //click on 1st tile
  static final dialogBoxNoButton = find.text('No');


  //Job Segment - Applied Jobs
  static final clickOnFirstApplyKeyOnAppliedJobs = find.byValueKey('appliedApplyKey0');
  static final clickOnFirstTileOnAppliedJobs = find.byValueKey('appliedTileKey0');
  static final searchForJobDetails = find.text('Job Details');
  static final checkFavoriteUnfavoriteFromAppliedList = find.byValueKey('appliedJobsListFavoriteButtonKey0'); //click on 1st tile

  //Job segment - Favorite jobs
  static final clickOnFirstApplyKeyOnFavoriteJobs = find.byValueKey('favoriteApplyKey0');
  static final clickOnFirstTileOnFavoriteJobs = find.byValueKey('favoriteTileKey0');
  static final checkFavoriteUnfavoriteFromFavoriteList = find.byValueKey('favoriteFavoriteButtonKey0'); //click on 1st tile

  //Contact Us
  static final tapOnNameField = find.byValueKey('contactUsNameField');
  static final tapOnEmailField = find.text('contactUsEmailTextField');
  static final tapOnPhoneField = find.text('contactUsPhoneTextField');
  static final tapOnSubjectField = find.text('contactUsSubjectTextField');
  static final tapOnMessageField = find.text('contactUsMessageTextField');
  static final tapOnSubmitButton = find.text('contactUsSubmitButtonKey');

















}