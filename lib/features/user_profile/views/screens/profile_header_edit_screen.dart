import 'dart:convert';
import 'dart:io';
import 'package:after_layout/after_layout.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart' as dartZ;
import 'package:p7app/features/user_profile/models/user_model.dart';
import 'package:p7app/features/user_profile/models/user_personal_info.dart';
import 'package:p7app/features/user_profile/repositories/industry_list_repository.dart';
import 'package:p7app/features/user_profile/repositories/user_profile_repository.dart';
import 'package:p7app/features/user_profile/styles/profile_common_style.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_dropdown_button_form_field.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/failure/error.dart';
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
import 'package:modal_progress_hud/modal_progress_hud.dart';
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

  List<DropdownMenuItem<String>> _industryExpertiseList = [];
  String _selectedIndustryExpertiseDropDownItem = "";

  @override
  void initState() {
    var personalInfo = widget.userModel.personalInfo;

    _phoneEditingController.text = personalInfo.phone ?? "";
    _locationEditingController.text = personalInfo.address ?? "";
    _aboutTextEditingController.text = personalInfo.aboutMe ?? "";
    _fullNameTextEditingController.text = personalInfo.fullName ?? "";
    _selectedIndustryExpertiseDropDownItem = personalInfo.industryExpertise ?? "";

    IndustryListRepository()
        .getIndustryList()
        .then((dartZ.Either<AppError, List<String>> value) {
      value.fold((l) {
        // left
        BotToast.showText(text: "Unable to load expertise list ");
      }, (r) {
        // right
        _industryExpertiseList = r
            .map((e) => DropdownMenuItem(
                  key: Key(e),
                  value: e,
                  child: Text(e ?? ""),
                ))
            .toList();
        setState(() {});
      });
    });
    super.initState();
  }

  String getBase64Image() {
    List<int> imageBytes = fileProfileImage.readAsBytesSync();
//    print(imageBytes);
    return base64Encode(imageBytes);
  }

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var compressedImage  = await ImageCompressUtil.compressImage(image, 40);
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

//      personalInfo.address = _addressEditingController.text;
//      personalInfo.fullName = _fullNameTextEditingController.text;
//      personalInfo.industryExpertise = industryExpertiseTextEditingController.text;
//      personalInfo.aboutMe = _aboutTextEditingController.text;
//      personalInfo.phone = _phoneEditingController.text;

      var data = {
        "current_location": _locationEditingController.text,
        "full_name": _fullNameTextEditingController.text,
        "industry_expertise": _selectedIndustryExpertiseDropDownItem,
        "about_me": _aboutTextEditingController.text,
        "phone": _phoneEditingController.text,
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
        print(r.fullName);
        print(userData.personalInfo.fullName);
        userViewModel.userData = userData;
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
                  FontAwesomeIcons.camera,
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
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            ///name
            CustomTextFormField(
              controller: _fullNameTextEditingController,
              validator: Validator().nullFieldValidate,
              labelText: "Full Name",
              hintText: "eg. Bill Gates",
            ),
            SizedBox(height: 10),

//            /// Designation
//            CustomTextFormField(
//              focusNode: _designationFocusNode,
//              controller: industryExpertiseTextEditingController,
//              validator: Validator().nullFieldValidate,
//              labelText: "Designation",
//              hintText: "eg. Software Engineer",
//            ),

            CustomDropdownButtonFormField<String>(
              labelText: StringUtils.industryExpertiseText,
              hint: Text('Tap to select'),
              value: _selectedIndustryExpertiseDropDownItem,
              onChanged: (value) {
                _selectedIndustryExpertiseDropDownItem = value;
                setState(() {});
              },
              items: _industryExpertiseList,
            ),

            SizedBox(height: 10),

            ///about
            CustomTextFormField(
              controller: _aboutTextEditingController,
              validator: Validator().nullFieldValidate,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              labelText: StringUtils.aboutMeText,
              hintText: StringUtils.aboutHintText,
            ),

            SizedBox(height: 10),

            /// phone

            CustomTextFormField(
              controller: _phoneEditingController,
              validator: Validator().validatePhoneNumber,
              keyboardType: TextInputType.phone,
              maxLines: null,
              labelText: StringUtils.phoneText,
              hintText: StringUtils.phoneHintText,
            ),

            SizedBox(height: 10),
            SizedBox(height: 10),

//            ///full address
//            TextFormField(
//              style: Theme.of(context).textTheme.title,
//              controller: _fullAddressEditingController,
//              validator: Validator().nullFieldValidate,
//              keyboardType: TextInputType.multiline,
//              maxLines: null,
//              decoration: InputDecoration(
//                labelText: StringsEn.addressText,
//                hintText: StringsEn.addressHintText,
//              ),
//            ),
//
//            SizedBox(height: 10),

            ///current location
            CustomTextFormField(
              controller: _locationEditingController,
//              validator: Validator().nullFieldValidate,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              labelText: StringUtils.locationText,
              hintText: StringUtils.locationHintText,
            ),
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
