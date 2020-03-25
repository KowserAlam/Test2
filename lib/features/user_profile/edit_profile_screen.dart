import 'dart:io';
import 'package:after_layout/after_layout.dart';
import 'package:assessment_ishraak/features/user_profile/providers/edit_profile_provider.dart';
import 'package:assessment_ishraak/features/user_profile/models/user_profile_models.dart';
import 'package:assessment_ishraak/features/user_profile/providers/user_provider.dart';
import 'package:assessment_ishraak/main_app/util/const.dart';
import 'package:assessment_ishraak/main_app/util/json_keys.dart';
import 'package:assessment_ishraak/main_app/util/strings_utils.dart';
import 'package:assessment_ishraak/main_app/util/validator.dart';
import 'package:assessment_ishraak/main_app/widgets/edit_screen_save_button.dart';
import 'package:assessment_ishraak/main_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with AfterLayoutMixin {
  final cropKey = GlobalKey<CropState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  var _fullNameTextEditingController = TextEditingController();
  var _designationTextEditingController = TextEditingController();
  var _aboutTextEditingController = TextEditingController();
//  var _fullAddressEditingController = TextEditingController();
  var _locationEditingController = TextEditingController();
  var _phoneEditingController = TextEditingController();

  @override
  void afterFirstLayout(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(_scaffoldKey.currentContext);

    if (userProvider.userData != null) {
      var user = userProvider.userData;
      _fullNameTextEditingController.text = user.displayName;
      _designationTextEditingController.text = user.designation;
      _aboutTextEditingController.text = user.about;
      _locationEditingController.text = user.city;
      _phoneEditingController.text = user.mobileNumber;
    }
  }

  Future getImage() async {
    var editProfileProvider = Provider.of<EditProfileProvider>(context);
    editProfileProvider.isBusyImageCrop = true;

    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      _showCropDialog(image);
    } else {
      editProfileProvider.isBusyImageCrop = false;
    }

  }

  _handleSave() async {

    var isValid = _formKey.currentState.validate();

    if (isValid) {
      _formKey.currentState.save();
      var userProvider = Provider.of<UserProvider>(_scaffoldKey.currentContext);
      userProvider.isBusySaving = true;

      var user = userProvider.userData;
      user.displayName = _fullNameTextEditingController.text;
//      user.address = _fullAddressEditingController.text;
      user.city = _locationEditingController.text;
      user.about = _aboutTextEditingController.text;
      user.mobileNumber = _phoneEditingController.text;
      user.designation = _designationTextEditingController.text;

      var res = await userProvider.updateUserData(user);

      if (res[JsonKeys.code] == "200") {
        userProvider.isBusySaving = false;
        Navigator.pop(context);
      } else {
        userProvider.isBusySaving = false;
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(
          res[JsonKeys.message],
        )));
      }
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
      body: ModalProgressHUD(
        opacity: .6,
        inAsyncCall: Provider.of<UserProvider>(context).isBusySaving,
        progressIndicator: Loader(size: 20,),
        child: SingleChildScrollView(
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
      ),
    );
  }

  _buildEditProfileImage() {
    return Consumer<EditProfileProvider>(
        builder: (context, editProfileProvider, _) {
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
                  child: editProfileProvider.fileProfileImage != null
                      ? Image.file(
                          editProfileProvider.fileProfileImage,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          kDefaultUserImageAsset,
                          fit: BoxFit.cover,
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
          editProfileProvider.isBusyImageCrop
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
            TextFormField(
              style: Theme.of(context).textTheme.title,
              controller: _fullNameTextEditingController,
              validator: Validator().nullFieldValidate,
              decoration: InputDecoration(
                  labelText: "Full Name", hintText: "eg. Bill Gates"),
            ),
            SizedBox(height: 10),

            /// Designation
            TextFormField(
              style: Theme.of(context).textTheme.title,
              controller: _designationTextEditingController,
              validator: Validator().nullFieldValidate,
              decoration: InputDecoration(
                  labelText: "Designation", hintText: "eg. Software Engineer"),
            ),

            SizedBox(height: 10),

            ///about
            TextFormField(
              style: Theme.of(context).textTheme.title,
              controller: _aboutTextEditingController,
              validator: Validator().nullFieldValidate,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                labelText: StringUtils.aboutText,
                hintText: StringUtils.aboutHintText,
              ),
            ),

            SizedBox(height: 10),

            /// phone

            TextFormField(
              style: Theme.of(context).textTheme.title,
              controller: _phoneEditingController,
              validator: Validator().validatePhoneNumber,
              keyboardType: TextInputType.phone,
              maxLines: null,
              decoration: InputDecoration(
                labelText: StringUtils.smsText,
                hintText: StringUtils.phoneHintText,
              ),
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

            ///location
            TextFormField(
              style: Theme.of(context).textTheme.title,
              controller: _locationEditingController,
              validator: Validator().nullFieldValidate,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                labelText: StringUtils.locationText,
                hintText: StringUtils.locationHintText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Image Crop Screen with dialog
  _showCropDialog(File image) async {
    final sample = await ImageCrop.sampleImage(
      file: image,
      preferredSize: context.size.longestSide.ceil(),
    );
    showDialog(
        context: _scaffoldKey.currentContext,
        builder: (context) {
          return Column(
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
                    FlatButton(
                      child: Text(
                        'Crop Image',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(color: Colors.white),
                      ),
                      onPressed: () {
                        _cropImage(image);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  /// Method to crop Image file
  Future<void> _cropImage(File image) async {
    var editProfileProvider = Provider.of<EditProfileProvider>(context);
    final scale = cropKey.currentState.scale;
    final area = cropKey.currentState.area;
    if (area == null) {
      editProfileProvider.isBusyImageCrop = false;
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

    editProfileProvider.fileProfileImage = file;
    editProfileProvider.isBusyImageCrop = false;

//    _lastCropped?.delete();
//    _lastCropped = file;

    debugPrint('$file');
  }
}
