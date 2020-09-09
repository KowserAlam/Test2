import 'package:flutter_driver/flutter_driver.dart';

class Keys{

  //Common keys
  static final backButton = find.byTooltip('Back');
  static final doneButtonKey = find.byValueKey('doneButtonKey');
  static final datePikerKey = find.byValueKey('datePickerKey');
  static final applyButtonText = find.byValueKey('applyButtonText');
  static final commonPromptText = find.byValueKey('commonPromptText');
  static final commonPromptYes = find.byValueKey('commonPromptYes');
  static final commonPromptNo = find.byValueKey('commonPromtNo');

  //Sign in screen
  static final signInWelcomeText = find.byValueKey('signInWelcomeText');
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
  static final dashboardAppbardTitle = find.byValueKey('dashboardAppbardTitle');
  static final dashboardAddSkillButton = find.byValueKey('dashboardAddSkillButton');

  //Settings Screen
  static final settingsAppbarTitle = find.byValueKey('settingsAppbarTitle');
  static final settingsChangePassword = find.byValueKey('settingsChangePassword');
  static final pushNotificationTextKey = find.byValueKey('pushNotificationTextKey');
  static final emailSubscriptionTextKey = find.byValueKey('emailSubscriptionTextKey');
  static final clearCachedDataKey = find.byValueKey('clearCachedDataKey');
  static final settingsSignOut = find.byValueKey('settingsSignOut');

  //Change Password
  static final changePasswordAppbarTitle = find.byValueKey('changePasswordAppbarTitle');
  static final changePasswordOldPassword = find.byValueKey('changePasswordOldPassword');
  static final changePasswordNewPassword = find.byValueKey('changePasswordNewPassword');
  static final changePasswordConfirmPassword = find.byValueKey('changePasswordConfirmPassword');
  static final changePasswordSubmitButton = find.byValueKey('changePasswordSubmitButton');

  ///////////         My Profile          /////////////
  static final myProfileAppbarTitle = find.byValueKey('myProfileAppbarTitle');
  static final myProfileScrollView = find.byValueKey('myProfileScrollView');
  static final myProfileSettingsButton = find.byValueKey('myProfileSettingsButton');

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
  static final skillEditButton = find.byValueKey('skillEditButton0');
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
  static final personalInfoPenKey = find.byValueKey('personalInfoPenKey');

  static final myProfileEducationPenKey = find.byValueKey('myProfileEducationPenKey');
  static final myProfileEducationAddKey = find.byValueKey('myProfileEducationAddKey');
  static final educationTileInstitutionName = find.byValueKey('educationTileInstitutionName0');
  static final addedEducationTileInstitutionName = find.byValueKey('educationTileInstitutionName1');
  static final educationTileDegree = find.byValueKey('educationTileDegree0');
  static final educationTileEditButton = find.byValueKey('educationTileEditButton0');
  static final educationTileDeleteButton = find.byValueKey('educationTileDeleteButton0');


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

  //Membership
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
  static final personalInfoScrollView = find.byValueKey('personalInfoScrollView');
  static final personalInfoDOB = find.byValueKey('personalInfoDOB');
  static final personalInfoFatherName = find.byValueKey('personalInfoFatherName');
  static final personalInfoMotherName = find.byValueKey('personalInfoMotherName');
  static final personalInfoCurrentAddress = find.byValueKey('personalInfoCurrentAddress');
  static final personalInfoPermanentAddress = find.byValueKey('personalInfoPermanentAddress');
  static final personalInfoGender = find.byValueKey('personalInfoGender');
  static final genderMale = find.text('Male');
  static final personalInfoGenderMale = find.byValueKey('Male');
  static final personalInfoNationality = find.byValueKey('personalInfoNationality');
  static final bangladeshi = find.text('Bangladeshi');
  static final personalInfoReligion = find.byValueKey('personalInfoReligion');
  static final islam = find.text('Islam');
  static final personalInfoBloodGroup = find.byValueKey('personalInfoBloodGroup');
  static final bloodGroupAplus = find.text('A+');

  //Education
  static final educationScrollView = find.byValueKey('educationScrollView');
  static final educationAppbarTitle = find.byValueKey('educationAppbarTitle');
  static final educationSaveButton = find.byValueKey('educationSaveButton');
  static final educationInstitutionName = find.byValueKey('educationInstitutionName');
  static final educationLevelOfEducation = find.byValueKey('educationLevelOfEducation');
  static final educationCGPA = find.byValueKey('educationCGPA');
  static final educationEnrollDate = find.byValueKey('educationEnrollDate');
  static final educationGraduationDate = find.byValueKey('educationGraduationDate');
  static final educationMajor = find.byValueKey('educationMajor');
  static final educationDegree = find.byValueKey('educationDegree');
  static final educationDescription = find.byValueKey('educationDescription');
  static final educationOngoing = find.byValueKey('educationOngoing');




  //Jobs Segment
  static final jobsSegmentAppliedText = find.byValueKey('jobsSegmentAppliedText');
  static final jobsSegmentFavoriteText = find.byValueKey('jobsSegmentFavoriteText');
  static final jobsSegmentAllText = find.byValueKey('jobsSegmentAllText');
  static final jobsAppbarTitle = find.byValueKey('jobsAppbarTitle');
  static final jobListSearchInputFieldKey = find.byValueKey('jobListSearchInputFieldKey');
  static final jobListSearchButtonKey = find.byValueKey('jobListSearchButtonKey');
  static final jobListSearchToggleButtonKey = find.byValueKey('jobListSearchToggleButtonKey');

  //Jobs Segment - All jobs
  static final allJobsTileApplyButton = find.byValueKey('allJobsApplyKey0');
  static final allJobsTile0 = find.byValueKey('allJobsTileKey0');
  static final allJobsTile1 = find.byValueKey('allJobsTileKey1');
  static final allJobsTileFavoriteButton = find.byValueKey('allJobsListFavoriteButtonKey0'); //click on 1st tile
  static final allJobsTileFavoriteButton1 = find.byValueKey('allJobsListFavoriteButtonKey1');
  static final dialogBoxNoButton = find.text('No');
  static final dialogBoxYesButton = find.text('Yes');
  static final jobTileCompanyName = find.byValueKey('jobTileCompanyName0');
  static final jobTileJobTitle0 = find.byValueKey('jobTileJobTitle0');
  static final jobTileJobTitle1 = find.byValueKey('jobTileJobTitle1');



  //Job Segment - Applied Jobs
  static final clickOnFirstApplyKeyOnAppliedJobs = find.byValueKey('appliedApplyKey0');
  static final appliedTileKey0 = find.byValueKey('appliedTileKey0');
  static final appliedTileKey1 = find.byValueKey('appliedTileKey1');
  static final searchForJobDetails = find.text('Job Details');
  static final checkFavoriteUnfavoriteFromAppliedList = find.byValueKey('appliedJobsListFavoriteButtonKey0'); //click on 1st tile

  //Job segment - Favorite jobs
  static final favoriteJobsApplyButton = find.byValueKey('favoriteApplyKey0');
  static final noFavoriteJobs = find.byValueKey('noFavoriteJobs');
  static final favoriteDeadline0 = find.byValueKey('favoriteDeadline0');
  static final favoriteDeadline1= find.byValueKey('favoriteDeadline1');
  static final favoritePublishedDate = find.byValueKey('favoritePublishedDate');
  static final favoriteCompanyLocation = find.byValueKey('favoriteCompanyLocation0');
  static final clickOnFirstTileOnFavoriteJobs = find.byValueKey('favoriteTileKey0');
  static final favoriteJobsFavoriteButton = find.byValueKey('favoriteFavoriteButtonKey0'); //click on 1st tile

  //Job Details
  static final jobDetailsScrollKey = find.byValueKey('jobDetailsScrollKey');
  static final jobDetailsAppbarTitle = find.byValueKey('jobDetailsAppbarTitle');
  static final jobDetailsJobTitle = find.byValueKey('jobDetailsJobTitle');
  static final jobDetailsCompanyName = find.byValueKey('jobDetailsCompanyName');
  static final jobDetailsFavoriteButton = find.byValueKey('jobDetailsFavoriteButton');
  static final checkJobFavorite = find.byValueKey('checkJobFavorite');
  static final jobDetailsApplyButton = find.byValueKey('jobDetailsApplyButton');
  static final jobDetailsApplyNoButton = find.byValueKey('jobDetailsApplyNoButton');
  static final jobDetailsApplyYesButton = find.byValueKey('jobDetailsApplyYesButton');
  static final jobDetailsPublishDate = find.byValueKey('jobDetailsPublishDate');
  static final jobDetailsDeadlineDate = find.byValueKey('jobDetailsDeadlineDate');
  static final similarJobsTitle = find.byValueKey('similarJobsTitle');
  static final similarJobsTile = find.byValueKey('similarJobsTile0');
  static final similarJobsTileFavorite = find.byValueKey('similarJobsTileFavorite0');
  static final similarJobsTileApply = find.byValueKey('similarJobsTileApply0');
  static final similarJobsTilePublishedDate = find.byValueKey('similarJobsTilePublishedDate0');
  static final similarJobsTileDeadline0 = find.byValueKey('similarJobsTileDeadline0');
  static final similarJobsTileDeadline1 = find.byValueKey('similarJobsTileDeadline1');
  static final similarJobsTileCompanyLocation = find.byValueKey('similarJobsTileCompanyLocation0');
  static final jobDetailsApplyButtonText = find.byValueKey('jobDetailsApplyButtonText');

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

  //Company List Screen
  static final companyListAppbarTitle = find.byValueKey('companyListAppbarTitle');
  static final companyListTileKey0 = find.byValueKey('companyListTileKey0');
  static final companyListTileKey1 = find.byValueKey('companyListTileKey1');

  //Company Details
  static final companyDetailsAppbarTitle = find.byValueKey('companyDetailsAppbarTitle');
  static final companyDetailsListViewKey = find.byValueKey('companyDetailsListViewKey');
  static final companyDetailsCompanyName = find.byValueKey('companyDetailsCompanyName');
  static final openJobsCompanyLocation0 = find.byValueKey('openJobsCompanyLocation0');
  static final openJobsDeadline0 = find.byValueKey('openJobsDeadline0');
  static final openJobsDeadline1 = find.byValueKey('openJobsDeadline1');
  static final openJobsPublishedDate0 = find.byValueKey('openJobsPublishedDate0');
  static final openJobsFavorite0 = find.byValueKey('openJobsFavorite0');
  static final openJobsApplyButton0 = find.byValueKey('openJobsApplyButton0');
  static final companyDetailsOpenJobsKey0 = find.byValueKey('companyDetailsOpenJobsKey0');
  static final noOpenJobs = find.byValueKey('noOpenJobs');



















}