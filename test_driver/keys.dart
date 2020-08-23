import 'package:flutter_driver/flutter_driver.dart';

class Keys{

  //Common keys
  static final backButton = find.byTooltip('Back');
  static final doneButtonKey = find.byValueKey('doneButtonKey');
  static final datePikerKey = find.byValueKey('datePickerKey');

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
  static final myProfileHeaderExperienceInYearField = find.byValueKey('myProfileHeaderExperienceInYearField');
  static final myProfileHeaderExperienceInYearOptionChoice = find.byValueKey('1');

  static final myProfileExperiencePenKey = find.byValueKey('myProfileExperiencePenKey');
  static final myProfileExperienceAddKey = find.byValueKey('myProfileExperienceAddKey');
  static final experienceEditButton = find.byValueKey('experienceEditButton0');
  static final experienceDeleteButton = find.byValueKey('experienceDeleteButton0');
  static final experienceTileDesignation = find.byValueKey('experienceTileDesignation0');
  static final experienceTileCompanyName = find.byValueKey('experienceTileCompanyName0');
  static final addedExperienceTileCompanyName = find.byValueKey('experienceTileCompanyName1');

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
  static final portfolioTileEditButton = find.byValueKey('portfolioTileEditButton0');
  static final portfolioTileDeleteButton = find.byValueKey('portfolioTileDeleteButton0');
  static final portfolioTileName = find.byValueKey('portfolioTileName0');

  static final myProfileMembershipPenKey = find.byValueKey('myProfileMembershipPenKey');
  static final myProfileMembershipAddKey = find.byValueKey('myProfileMembershipAddKey');
  static final membershipEditKey = find.byValueKey('membershipEditKey0');
  static final membershipDeleteKey = find.byValueKey('membershipDeleteKey0');
  static final membershipTileOrganizationName = find.byValueKey('membershipTileOrganizationName0');
  static final addedMembershipTileOrganizationName = find.byValueKey('membershipTileOrganizationName1');
  static final membershipTilePositionHeld = find.byValueKey('membershipTilePositionHeld0');

  static final myProfileCertificationPenKey = find.byValueKey('myProfileCertificationPenKey');
  static final myProfileCertificationAddKey = find.byValueKey('myProfileCertificationAddKey');
  static final certificationTileOrganizationNameKey = find.byValueKey('certificationTileOrganizationNameKey0');
  static final certificationTileNameKey = find.byValueKey('certificationTileNameKey0');
  static final certificationEditKey = find.byValueKey('certificationEditKey0');
  static final certificationDeleteKey = find.byValueKey('certificationDeleteKey0');
  static final addedCertificationTileNameKey = find.byValueKey('certificationTileNameKey1');

  static final personalInfoTileDateOfBirth = find.byValueKey('personalInfoTileDateOfBirth');
  static final personalInfoTileGender = find.byValueKey('personalInfoTileGender');
  static final personalInfoTileFatherName = find.byValueKey('personalInfoTileFatherName');
  static final personalInfoTileMotherName = find.byValueKey('personalInfoTileMotherName');
  static final personalInfoTileCurrentAddress = find.byValueKey('personalInfoTileCurrentAddress');
  static final personalInfoTilePermanentAddress = find.byValueKey('personalInfoTilePermanentAddress');
  static final personalInfoTileNationality = find.byValueKey('personalInfoTileNationality');
  static final personalInfoTileReligion = find.byValueKey('personalInfoTileReligion');
  static final personalInfoTileBloodGroup = find.byValueKey('personalInfoTileBloodGroup');


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

  //Certification
  static final certificationAppbarTitle = find.byValueKey('certificationAppbarTitle');
  static final certificationSaveButton = find.byValueKey('certificationSaveButton');
  static final certificationName = find.byValueKey('certificationName');
  static final certificationOrganizationName = find.byValueKey('certificationOrganizationName');
  static final certificationCredentialIdName = find.byValueKey('certificationCredentialIdName');
  static final certificationCredentialUrl = find.byValueKey('certificationCredentialUrl');
  static final certificationIssueDate = find.byValueKey('certificationIssueDate');
  static final certificationHasExpiryDate = find.byValueKey('certificationHasExpiryDate');
  static final certificationExpiryDate = find.byValueKey('certificationExpiryDate');

  //Portfolio
  static final portfolioAppbarTitle = find.byValueKey('portfolioAppbarTitle');
  static final portfolioName = find.byValueKey('portfolioName');
  static final portfolioSaveButton = find.byValueKey('portfolioSaveButton');
  static final portfolioDescription = find.byValueKey('portfolioDescription');

  //Education
  static final membershipAppbarTitle = find.byValueKey('membershipAppbarTitle');
  static final membershipSaveButton = find.byValueKey('membershipSaveButton');
  static final membershipOrganizationName = find.byValueKey('membershipOrganizationName');
  static final membershipPositionHeld = find.byValueKey('membershipPositionHeld');
  static final membershipDescription = find.byValueKey('membershipDescription');
  static final membershipStartDate = find.byValueKey('membershipStartDate');
  static final membershipOngoing = find.byValueKey('membershipOngoing');
  static final membershipEndDate = find.byValueKey('membershipEndDate');

  //Personal Info
  static final personalInfoAppbarTitle = find.byValueKey('personalInfoAppbarTitle');
  static final personalInfoSaveButton = find.byValueKey('personalInfoSaveButton');
  static final personalInfoDOB = find.byValueKey('personalInfoDOB');
  static final personalInfoFatherName = find.byValueKey('personalInfoFatherName');
  static final personalInfoMotherName = find.byValueKey('personalInfoMotherName');
  static final personalInfoCurrentAddress = find.byValueKey('personalInfoCurrentAddress');
  static final personalInfoPermanentAddress = find.byValueKey('personalInfoPermanentAddress');
//  static final membershipEndDate = find.byValueKey('membershipEndDate');
//  static final membershipEndDate = find.byValueKey('membershipEndDate');
//  static final membershipEndDate = find.byValueKey('membershipEndDate');


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
  static final tapOnNameField = find.byValueKey('contactUsNameTextField');


  static final tapOnEmailField = find.byValueKey('contactUsEmailTextField');
  static final tapOnPhoneField = find.byValueKey('contactUsPhoneTextField');
  static final tapOnSubjectField = find.byValueKey('contactUsSubjectTextField');
  static final tapOnMessageField = find.byValueKey('contactUsMessageTextField');
  static final tapOnSubmitButton = find.byValueKey('contactUsSubmitButtonKey');
  static final confirmCompanyInfoAddress = find.text('House 76, Level 4,');
  static final confirmCompanyInfoEmail = find.text('support@jobxprss.com');
  static final confirmCompanyInfoPhone = find.text('01609500001');




















}