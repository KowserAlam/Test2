import 'package:flutter_driver/flutter_driver.dart';

class keys{
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

  static final myProfileAddReferencesPen = find.byValueKey('myProfileAddReferencesPen');
  static final myProfileAddReferencesAdd = find.byValueKey('myProfileAddReferencesAdd');
  static final myProfileReferencesTileEditButton1 = find.byValueKey('myProfileReferencesTileEditButton1');
  static final myProfileReferencesTileDeleteButton1 = find.byValueKey('myProfileReferencesTileDeleteButton1');
  static final referenceTileDescription1 = find.byValueKey('referenceTileDescription1');


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
//  static final workExperienceAppbarTitleKey = find.byValueKey('workExperienceAppbarTitleKey');
//  static final workExperienceAppbarTitleKey = find.byValueKey('workExperienceAppbarTitleKey');
//  static final workExperienceAppbarTitleKey = find.byValueKey('workExperienceAppbarTitleKey');
//  static final workExperienceAppbarTitleKey = find.byValueKey('workExperienceAppbarTitleKey');
//  static final workExperienceAppbarTitleKey = find.byValueKey('workExperienceAppbarTitleKey');
//  static final workExperienceAppbarTitleKey = find.byValueKey('workExperienceAppbarTitleKey');



  //Professional Skill
  static final professionalSkillAppbarTitle = find.byValueKey('professionalSkillAppbarTitle');
  static final skillAddField = find.byValueKey('skillAddField');
  static final skillExpertise = find.byValueKey('skillExpertise');
  static final skillSaveButton = find.byValueKey('skillSaveButton');


  //References
  static final referencesAppbarTitle = find.byValueKey('referencesAppbarTitle');
  static final myProfileReferencesSaveButton = find.byValueKey('myProfileReferencesSaveButton');
  static final referencesDescription = find.byValueKey('referencesDescription');

  //Jobs Segment
  static final clickOnAppliedJobsFromSegmentScreen = find.byValueKey('jobsSegmentAppliedText');
  static final clickOnFavoriteJobsFromSegmentScreen = find.byValueKey('jobsSegmentFavoriteText');
  static final clickOnAllFromSegmentScreen = find.byValueKey('jobsSegmentAllText');





}