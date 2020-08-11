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
  static final onboardingPageSkipButton = find.byValueKey('onboardingPageSkipButton');

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

  ///////////         My Profile          /////////////
  static final myProfileAppbarTitle = find.byValueKey('myProfileAppbarTitle');
  static final myProfileScrollView = find.byValueKey('myProfileScrollView');

  static final myProfileHeaderEditButton = find.byValueKey('myProfileHeaderEditButton');

  static final myProfileAddSkillPen = find.byValueKey('myProfileAddSkillPen');
  static final myProfileAddSkillAdd = find.byValueKey('myProfileAddSkillAdd');

  static final myProfileAddReferencesPen = find.byValueKey('myProfileAddReferencesPen');
  static final myProfileAddReferencesAdd = find.byValueKey('myProfileAddReferencesAdd');
  static final myProfileReferencesTileEditButton1 = find.byValueKey('myProfileReferencesTileEditButton1');
  static final myProfileReferencesTileDeleteButton1 = find.byValueKey('myProfileReferencesTileDeleteButton1');
  static final referenceTileDescription1 = find.byValueKey('referenceTileDescription1');


  //Header Section
  static final myProfileHeaderSaveButton = find.byValueKey('myProfileHeaderSaveButton');
  static final myProfileHeaderFullName = find.byValueKey('myProfileHeaderFullName');
  static final myProfileHeaderDescription = find.byValueKey('myProfileHeaderDescription');
  static final myProfileHeaderExperiencePerYear = find.byValueKey('myProfileHeaderExperiencePerYear');
  static final myProfileHeaderMobile = find.byValueKey('myProfileHeaderMobile');
  static final myProfileHeaderCurrentCompany = find.byValueKey('myProfileHeaderCurrentCompany');
  static final myProfileHeaderCurrentDesignation = find.byValueKey('myProfileHeaderCurrentDesignation');
  static final myProfileHeaderLocation = find.byValueKey('myProfileHeaderLocation');
  static final myProfileHeaderFacebook = find.byValueKey('myProfileHeaderFacebook');
  static final myProfileHeaderTwitter = find.byValueKey('myProfileHeaderTwitter');
  static final myProfileHeaderLinkedIn = find.byValueKey('myProfileHeaderLinkedIn');
  static final myProfileHeaderScrollView = find.byValueKey('myProfileHeaderScrollView');


  //Professional Skill
  static final skillAddField = find.byValueKey('skillAddField');
  static final skillExpertise = find.byValueKey('skillExpertise');
  static final skillSaveButton = find.byValueKey('skillSaveButton');


  //References
  static final myProfileReferencesSaveButton = find.byValueKey('myProfileReferencesSaveButton');
  static final referencesDescription = find.byValueKey('referencesDescription');

}