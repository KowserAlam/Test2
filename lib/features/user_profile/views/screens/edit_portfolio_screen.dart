import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:p7app/features/user_profile/models/portfolio_info.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/main_app/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/image_compress_util.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/views/widgets/custom_zefyr_rich_text_from_field.dart';
import 'package:p7app/main_app/views/widgets/edit_screen_save_button.dart';
import 'package:p7app/main_app/views/widgets/loader.dart';
import 'package:provider/provider.dart';

class EditPortfolio extends StatefulWidget {
  final PortfolioInfo portfolioInfo;
  final int index;

  @override
  _EditPortfolioState createState() => _EditPortfolioState();

  const EditPortfolio({
    this.portfolioInfo,
    this.index,
  });
}

class _EditPortfolioState extends State<EditPortfolio> {
  bool isBusyImageCrop = false;
  final _formKey = GlobalKey<FormState>();
  File fileImage;

  //TextEditingController
  final _portfolioNameController = TextEditingController();
  ZefyrController _descriptionZefyrController =
  ZefyrController(NotusDocument());
  //FocusNodes
  final _portfolioNameFocusNode = FocusNode();
  final _portfolioDescriptionFocusNode = FocusNode();

  //widgets
  var spaceBetweenFields = SizedBox(
    height: 15,
  );


  initState() {
    if (widget.portfolioInfo != null) {
      _descriptionZefyrController = ZefyrController(
          ZeyfrHelper.htmlToNotusDocument(
              widget.portfolioInfo?.description  ?? " "));
      _portfolioNameController.text = widget.portfolioInfo?.name ?? "";
    }

    super.initState();
  }

  String getBase64Image() {
    List<int> imageBytes = fileImage.readAsBytesSync();
//    print(imageBytes);
    var img = "data:image/jpg;base64," + base64Encode(imageBytes);

//    print(img);
    return img;
  }

  Future getImage() async {
    var file = await ImagePicker().getImage(source: ImageSource.gallery);
    if (file != null) {

      Future<File> croppedFile =  ImageCropper.cropImage(
          sourcePath: file.path,
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
          )
      );

      croppedFile.then((value) {
        fileImage = value;
        setState(() {

        });
      });
    } else {}
  }

  _handleSave() async {
    if (_formKey.currentState.validate()) {
      var userProviderViewModel =
          Provider.of<UserProfileViewModel>(context, listen: false);
      var authUser = await AuthService.getInstance();
      var professionalId = authUser.getUser().professionalId;

      var data = {
        "name": _portfolioNameController.text,
        "description": ZeyfrHelper.notusDocumentToHTML(
            _descriptionZefyrController.document),
        "professional_id": professionalId
      };

      if (fileImage != null) {
        data.addAll({"image": getBase64Image()});
      }

      if (widget.portfolioInfo == null) {
        //add new item

        userProviderViewModel
            .addPortfolioInfo(
            data: data)
            .then((value) {
          if (value) {
            Navigator.pop(context);
          }
        });

      } else {
        // update existing item
        userProviderViewModel
            .updatePortfolio(
                data: data,
                index: widget.index,
                portfolioId: widget.portfolioInfo.portfolioId.toString())
            .then((value) {
          if (value) {
            Navigator.pop(context);
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var portfolioImage = Center(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 180,
              width: 180,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: fileImage != null
                        ? Image.file(
                            fileImage,
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            placeholder: (context, _) => Image.asset(
                              kImagePlaceHolderAsset,
                              fit: BoxFit.cover,
                            ),
                            imageUrl: widget.portfolioInfo?.image ?? "",
                          ),
                  )),
            ),
          ),
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor, width: 4),
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(10),
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
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(StringResources.portfolioText),
        actions: <Widget>[
          EditScreenSaveButton(
            text: StringResources.saveText,
            onPressed: _handleSave,
          ),
        ],
      ),
      body: ZefyrScaffold(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  portfolioImage,
                  //Name
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    validator: Validator().nullFieldValidate,
                    keyboardType: TextInputType.text,
                    focusNode: _portfolioNameFocusNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (a) {
                      FocusScope.of(context)
                          .requestFocus(_portfolioDescriptionFocusNode);
                    },
                    controller: _portfolioNameController,
                    labelText: StringResources.titleText,
                    hintText: StringResources.titleText,
                  ),
                  spaceBetweenFields,
                  //Description

                  CustomZefyrRichTextFormField(
                    labelText: StringResources.descriptionText,
                    focusNode: _portfolioDescriptionFocusNode,
                    controller: _descriptionZefyrController,
                  ),
//                CustomTextFormField(
//                  keyboardType: TextInputType.multiline,
//                  minLines: 5,
//                  maxLines: 12,
//                  maxLength: 800,
//                  focusNode: _portfolioDescriptionFocusNode,
//                  controller: _portfolioDescriptionController,
//                  labelText: StringResources.portfolioDescriptionText,
//                  hintText: StringResources.portfolioDescriptionText,
//                ),
                  spaceBetweenFields,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
