import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart' as dartZ;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:p7app/features/user_profile/models/user_model.dart';
import 'package:p7app/features/user_profile/models/user_personal_info.dart';
import 'package:p7app/features/user_profile/repositories/user_profile_repository.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/repositories/job_experience_list_repository.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/views/widgets/custom_searchable_dropdown_from_field.dart';
import 'package:p7app/main_app/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/views/widgets/custom_zefyr_rich_text_from_field.dart';
import 'package:p7app/main_app/views/widgets/edit_screen_save_button.dart';
import 'package:p7app/main_app/views/widgets/loader.dart';
import 'package:provider/provider.dart';

class ProfileHeaderEditScreen extends StatefulWidget {
  final UserModel userModel;
  final bool focusAboutMe;

  @override
  _ProfileHeaderEditScreenState createState() =>
      _ProfileHeaderEditScreenState();

  const ProfileHeaderEditScreen({
    @required this.userModel,
    this.focusAboutMe = false,
  });
}

class _ProfileHeaderEditScreenState extends State<ProfileHeaderEditScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool isBusyImageCrop = false;
  File imageFile;
  var _fullNameTextEditingController = TextEditingController();
  var _locationEditingController = TextEditingController();
  var _phoneEditingController = TextEditingController();
  var _facebookEditingController = TextEditingController();
  var _twitterEditingController = TextEditingController();
  var _linkedInEditingController = TextEditingController();
  var _currentCompanyEditingController = TextEditingController();
  var _currentDesignationEditingController = TextEditingController();
  List<String> _experienceList = [];
  String _selectedExperience;
  ZefyrController _aboutMeZefyrController = ZefyrController(NotusDocument());
  FocusNode _aboutMeFocusNode = FocusNode();

  @override
  void initState() {
    var personalInfo = widget.userModel.personalInfo;

    _phoneEditingController.text = personalInfo.phone ?? "";
    _locationEditingController.text = personalInfo.currentLocation ?? "";
    _aboutMeZefyrController =
        ZefyrController(ZeyfrHelper.htmlToNotusDocument(personalInfo.aboutMe));
    _fullNameTextEditingController.text = personalInfo.fullName ?? "";
    _selectedExperience = personalInfo.experience;
    _facebookEditingController.text = personalInfo.facebookId ?? "";
    _twitterEditingController.text = personalInfo.twitterId ?? "";
    _linkedInEditingController.text = personalInfo.linkedinId ?? "";
    _currentCompanyEditingController.text = personalInfo.currentCompany ?? "";
    _currentDesignationEditingController.text =
        personalInfo.currentDesignation ?? "";
    JobExperienceListRepository().getList().then((value) {
      _experienceList = value.fold((l) => [], (r) => r);
      setState(() {});
    });
    if (widget.focusAboutMe) {
      _aboutMeFocusNode.requestFocus();
    }
    super.initState();
  }

  String getBase64Image() {
    List<int> imageBytes = imageFile.readAsBytesSync();
//    print(imageBytes);
    var img = "data:image/jpg;base64," + base64Encode(imageBytes);

//    print(img);
    return img;
  }

  Future getImage() async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
//      var compressedImage = await ImageCompressUtil.compressImage(file, 80);
      Future<File> croppedFile = ImageCropper.cropImage(
          sourcePath: pickedFile.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Theme.of(context).primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));

      croppedFile.then((value) {
        imageFile = value;
        setState(() {});
      });
    } else {}
  }

  _handleSave() async {
    var isValid = _formKey.currentState.validate();

    if (isValid) {
      var userViewModel =
          Provider.of<UserProfileViewModel>(context, listen: false);
      var userData = userViewModel.userData;
      UserPersonalInfo personalInfo = userViewModel.userData.personalInfo;

      var data = {
        "experience": _selectedExperience,
        "current_location": _locationEditingController.text.isEmpty
            ? null
            : _locationEditingController.text,
        "full_name": _fullNameTextEditingController.text,
        "about_me":
            ZeyfrHelper.notusDocumentToHTML(_aboutMeZefyrController.document),
        "phone": _phoneEditingController.text,
        "facebook_id": _facebookEditingController.text,
        "twitter_id": _twitterEditingController.text,
        "linkedin_id": _linkedInEditingController.text,
        "current_designation": _currentDesignationEditingController.text.isEmpty
            ? null
            : _currentDesignationEditingController.text,
        "current_company": _currentCompanyEditingController.text.isEmpty
            ? null
            : _currentCompanyEditingController.text,
      };

      if (imageFile != null) {
        data.addAll({'image': getBase64Image()});
      }

      dartZ.Either<AppError, UserPersonalInfo> res =
          await UserProfileRepository().updateUserBasicInfo(data);
      res.fold((l) {
        // left
        print(l);
      }, (UserPersonalInfo r) {
        //right
        userData.personalInfo = r;
        print(userData.personalInfo.fullName);
        userViewModel.userPersonalInfo = r;
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          StringResources.editProfileText,
          key: Key('myProfileHeaderAppbarTitle'),
        ),
        actions: <Widget>[
          EditScreenSaveButton(
            key: Key("myProfileHeaderSaveButton"),
            text: StringResources.saveText,
            onPressed: () {
              print('save clicked');
              _handleSave();
            },
          ),
        ],
      ),
      body: ZefyrScaffold(
        child: SingleChildScrollView(
          key: Key('myProfileHeaderScrollView'),

          child: Column(
            children: <Widget>[
              SizedBox(
                width: double.infinity,
              ),
              SizedBox(height: 20),
              _buildEditProfileImage(),
              SizedBox(height: 20),
              _buildInformationFields(),
            ],
          ),
        ),
      ),
    );
  }

  _buildEditProfileImage() {
    return Consumer<UserProfileViewModel>(
        builder: (context, userProfileViewModel, _) {
      return Stack(
        children: <Widget>[
          Container(
            height: 180,
            width: 180,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(180),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: imageFile != null
                      ? Image.file(
                          imageFile,
                          fit: BoxFit.cover,
                        )
                      : CachedNetworkImage(
                          placeholder: (context, _) => Image.asset(
                            kDefaultUserImageAsset,
                            fit: BoxFit.cover,
                          ),
                          fit: BoxFit.cover,
                          imageUrl: userProfileViewModel
                                  .userData.personalInfo.profileImage ??
                              "",
                        ),
                )),
          ),
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor, width: 4),
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: IconButton(
                onPressed: () {
                  getImage();
                },
                icon: Icon(
                  FontAwesomeIcons.pencilAlt,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
              ),
            ),
            right: 0,
            bottom: 0,
          ),
          isBusyImageCrop
              ? Positioned(
                  bottom: 80,
                  left: 80,
                  child: Loader(),
                )
              : SizedBox(),
        ],
      );
    });
  }

  /// Information From Fields
  _buildInformationFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            ///name
            CustomTextFormField(
              textFieldKey: Key('myProfileHeaderFullNameField'),
              controller: _fullNameTextEditingController,
              validator: Validator().nullFieldValidate,
              labelText: StringResources.nameText,
              hintText: "eg. Bill Gates",
            ),
            SizedBox(height: 10),

            ///about
            CustomZefyrRichTextFormField(
              zefyrKey: Key('myProfileHeaderDescriptionField'),
              labelText: StringResources.descriptionText,
              focusNode: _aboutMeFocusNode,
              controller: _aboutMeZefyrController,
            ),
//            CustomTextFormField(
//              controller: _aboutTextEditingController,
//              keyboardType: TextInputType.multiline,
//              minLines: 3,
//              maxLines: 8,
//              labelText: StringResources.aboutMeText,
//              hintText: StringResources.aboutHintText,
//            ),

            SizedBox(height: 10),

            /// experience
            CustomDropdownSearchFormField<String>(
              dropdownKey: Key('myProfileHeaderExperienceInYearField'),
              labelText: StringResources.experienceInYear,
              items: _experienceList,
              popupItemBuilder:
                  (BuildContext context, String exp, bool selected) => ListTile(
                key: Key(exp),
                title: Text(exp),
                enabled: _selectedExperience != exp,
              ),
              selectedItem: _selectedExperience,
              onChanged: (v) {
                _selectedExperience = v;
              },
            ),
            SizedBox(height: 10),

            /// phone

            CustomTextFormField(
              textFieldKey: Key('myProfileHeaderMobileField'),
              controller: _phoneEditingController,
              validator: Validator().validatePhoneNumber,
              keyboardType: TextInputType.phone,
              labelText: StringResources.mobileText,
              hintText: StringResources.phoneHintText,
            ),

            SizedBox(height: 10),

            /// company
            CustomTextFormField(
              textFieldKey: Key('myProfileHeaderCurrentCompanyField'),
              controller: _currentCompanyEditingController,
              keyboardType: TextInputType.multiline,
              labelText: StringResources.currentCompany,
              hintText: StringResources.currentCompanyHint,
            ),
            SizedBox(height: 10),

            /// designation
            CustomTextFormField(
              textFieldKey: Key('myProfileHeaderCurrentDesignationField'),
              controller: _currentDesignationEditingController,
              keyboardType: TextInputType.multiline,
              labelText: StringResources.currentDesignation,
              hintText: StringResources.currentDesignationHint,
            ),
            SizedBox(height: 10),

            ///current location
            CustomTextFormField(
              textFieldKey: Key('myProfileHeaderLocationField'),
              controller: _locationEditingController,
              keyboardType: TextInputType.multiline,
              labelText: StringResources.locationText,
              hintText: StringResources.locationHintText,
            ),
            SizedBox(height: 10),

            ///facebook
            CustomTextFormField(
              textFieldKey: Key('myProfileHeaderFacebookField'),
              controller: _facebookEditingController,
              keyboardType: TextInputType.multiline,
              labelText: StringResources.facebookTrlText,
              prefix: Text(StringResources.facebookBaseUrl),
            ),
            SizedBox(height: 10),

            ///twitter
            CustomTextFormField(
              textFieldKey: Key('myProfileHeaderTwitterField'),
              controller: _twitterEditingController,
              keyboardType: TextInputType.multiline,
              labelText: StringResources.twitterUrlText,
              prefix: Text(StringResources.twitterBaeUrl),
            ),
            SizedBox(height: 10),

            ///linkedIn
            CustomTextFormField(
              textFieldKey: Key('myProfileHeaderLinkedInField'),
              controller: _linkedInEditingController,
              keyboardType: TextInputType.multiline,
              labelText: StringResources.linkedUrlText,
              prefix: Text(StringResources.linkedBaseUrl),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
