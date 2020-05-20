import 'dart:convert';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart' as dartZ;
import 'package:p7app/features/user_profile/models/user_model.dart';
import 'package:p7app/features/user_profile/models/user_personal_info.dart';
import 'package:p7app/features/user_profile/repositories/industry_list_repository.dart';
import 'package:p7app/features/user_profile/repositories/user_profile_repository.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/main_app/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/image_compress_util.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/widgets/edit_screen_save_button.dart';
import 'package:p7app/main_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileHeaderEditScreen extends StatefulWidget {
  final UserModel userModel;

  @override
  _ProfileHeaderEditScreenState createState() =>
      _ProfileHeaderEditScreenState();

  const ProfileHeaderEditScreen({
    @required this.userModel,
  });
}

class _ProfileHeaderEditScreenState extends State<ProfileHeaderEditScreen> {
  final cropKey = GlobalKey<CropState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool isBusyImageCrop = false;
  File fileProfileImage;

  var _fullNameTextEditingController = TextEditingController();
  var _aboutTextEditingController = TextEditingController();
  var _locationEditingController = TextEditingController();
  var _phoneEditingController = TextEditingController();
  var _facebookEditingController = TextEditingController();
  var _twitterEditingController = TextEditingController();
  var _linkedInEditingController = TextEditingController();
  var _currentCompanyEditingController = TextEditingController();
  var _currentDesignationEditingController = TextEditingController();

  List<DropdownMenuItem<String>> _industryExpertiseList = [];
  String _selectedIndustryExpertiseDropDownItem;

  @override
  void initState() {
    var personalInfo = widget.userModel.personalInfo;

    _phoneEditingController.text = personalInfo.phone ?? "";
    _locationEditingController.text = personalInfo.currentLocation ?? "";
    _aboutTextEditingController.text = personalInfo.aboutMe ?? "";
    _fullNameTextEditingController.text = personalInfo.fullName ?? "";
    _selectedIndustryExpertiseDropDownItem = personalInfo.industryExpertise;
    _facebookEditingController.text = personalInfo.facebookId ?? "";
    _twitterEditingController.text = personalInfo.twitterId ?? "";
    _linkedInEditingController.text = personalInfo.linkedinId ?? "";
    _currentCompanyEditingController.text = personalInfo.currentCompany ?? "";
    _currentDesignationEditingController.text =
        personalInfo.currentDesignation ?? "";

    super.initState();
  }

  String getBase64Image() {
    List<int> imageBytes = fileProfileImage.readAsBytesSync();
//    print(imageBytes);
    var img = "data:image/jpg;base64," + base64Encode(imageBytes);

//    print(img);
    return img;
  }

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var compressedImage = await ImageCompressUtil.compressImage(image, 40);
      _showCropDialog(compressedImage);
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
        "current_location": _locationEditingController.text.isEmpty
            ? null
            : _locationEditingController.text,
        "full_name": _fullNameTextEditingController.text,
        "industry_expertise": _selectedIndustryExpertiseDropDownItem,
        "about_me": _aboutTextEditingController.text,
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

      if (fileProfileImage != null) {
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
        title: Text(StringUtils.editProfileText),
        actions: <Widget>[
          EditScreenSaveButton(
            text: StringUtils.saveText,
            onPressed: () {
              _handleSave();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
                  child: fileProfileImage != null
                      ? Image.file(
                          fileProfileImage,
                          fit: BoxFit.cover,
                        )
                      : CachedNetworkImage(
                          placeholder: (context, _) => Image.asset(
                            kDefaultUserImageAsset,
                            fit: BoxFit.cover,
                          ),
                          fit: BoxFit.cover,
                          imageUrl: userProfileViewModel
                                  .userData.personalInfo.image ??
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
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            ///name
            CustomTextFormField(
              controller: _fullNameTextEditingController,
              validator: Validator().nullFieldValidate,
              labelText: StringUtils.nameText,
              hintText: "eg. Bill Gates",
            ),
            SizedBox(height: 10),

//            CustomDropdownButtonFormField<String>(
//              labelText: StringUtils.industryExpertiseText,
//              hint: Text('Tap to select'),
//              value: _selectedIndustryExpertiseDropDownItem,
//              onChanged: (value) {
//                _selectedIndustryExpertiseDropDownItem = value;
//                setState(() {});
//              },
//              items: _industryExpertiseList,
//            ),

            SizedBox(height: 10),

            ///about
            CustomTextFormField(
              controller: _aboutTextEditingController,
              keyboardType: TextInputType.multiline,
              minLines: 3,
              maxLines: 8,
              labelText: StringUtils.aboutMeText,
              hintText: StringUtils.aboutHintText,
            ),

            SizedBox(height: 10),

            /// phone

            CustomTextFormField(
              controller: _phoneEditingController,
              validator: Validator().validatePhoneNumber,
              keyboardType: TextInputType.phone,
              labelText: StringUtils.mobileText,
              hintText: StringUtils.phoneHintText,
            ),

            SizedBox(height: 10),

            /// company
            CustomTextFormField(
              controller: _currentCompanyEditingController,
              keyboardType: TextInputType.multiline,
              labelText: StringUtils.currentCompany,
              hintText: StringUtils.currentCompanyHint,
            ),
            SizedBox(height: 10),

            /// designation
            CustomTextFormField(
              controller: _currentDesignationEditingController,
              keyboardType: TextInputType.multiline,
              labelText: StringUtils.currentDesignation,
              hintText: StringUtils.currentDesignationHint,
            ),
            SizedBox(height: 10),

            ///current location
            CustomTextFormField(
              controller: _locationEditingController,
              keyboardType: TextInputType.multiline,
              labelText: StringUtils.locationText,
              hintText: StringUtils.locationHintText,
            ),
            SizedBox(height: 10),

            ///facebook
            CustomTextFormField(
              controller: _facebookEditingController,
              keyboardType: TextInputType.multiline,
              labelText: StringUtils.facebookTrlText,
              prefix: Text(StringUtils.facebookBaseUrl),
            ),
            SizedBox(height: 10),

            ///twitter
            CustomTextFormField(
              controller: _twitterEditingController,
              keyboardType: TextInputType.multiline,
              labelText: StringUtils.twitterUrlText,
              prefix: Text(StringUtils.twitterBaeUrl),
            ),
            SizedBox(height: 10),

            ///linkedIn
            CustomTextFormField(
              controller: _linkedInEditingController,
              keyboardType: TextInputType.multiline,
              labelText: StringUtils.linkedUrlText,
              prefix: Text(StringUtils.linkedBaseUrl),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  /// Image Crop Screen with dialog
  _showCropDialog(File image) async {
    var primaryColor = Theme.of(context).primaryColor;
    final sample = await ImageCrop.sampleImage(
      file: image,
      preferredSize: context.size.longestSide.ceil(),
    );
    showDialog(
        context: _scaffoldKey.currentContext,
        builder: (context) {
          return Material(
            color: Colors.black,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Crop.file(
                    sample,
                    key: cropKey,
                    aspectRatio: 1 / 1,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20.0),
                  alignment: AlignmentDirectional.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RawMaterialButton(
                        child: Text(
                          StringUtils.cancelText,
                          style: Theme.of(context)
                              .textTheme
                              .button
                              .copyWith(color: Colors.white),
                        ),
                        fillColor: primaryColor,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      RawMaterialButton(
                        child: Text(
                          StringUtils.cropImageText,
                          style: Theme.of(context)
                              .textTheme
                              .button
                              .copyWith(color: Colors.white),
                        ),
                        fillColor: primaryColor,
                        onPressed: () {
                          _cropImage(image);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  /// Method to crop Image file
  Future<void> _cropImage(File image) async {
    final scale = cropKey.currentState.scale;
    final area = cropKey.currentState.area;
    if (area == null) {
      isBusyImageCrop = false;
      setState(() {});
      // cannot crop, widget is not setup
      return;
    }

    final sample = await ImageCrop.sampleImage(
      file: image,
      preferredSize: (2000 / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    sample.delete();

    fileProfileImage = file;
    isBusyImageCrop = false;
    setState(() {});

//    _lastCropped?.delete();
//    _lastCropped = file;

    debugPrint('$file');
  }
}
