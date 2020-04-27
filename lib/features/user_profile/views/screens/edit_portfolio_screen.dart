import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:p7app/features/user_profile/models/portfolio_info.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/image_compress_util.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/widgets/edit_screen_save_button.dart';
import 'package:p7app/main_app/widgets/loader.dart';
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
  final cropKey = GlobalKey<CropState>();

  //TextEditingController
  final _portfolioNameController = TextEditingController();
  final _portfolioDescriptionController = TextEditingController();

  //FocusNodes
  final _portfolioNameFocusNode = FocusNode();
  final _portfolioDescriptionFocusNode = FocusNode();

  //widgets
  var spaceBetweenFields = SizedBox(
    height: 15,
  );

  initState(){

    if(widget.portfolioInfo != null){}
    _portfolioDescriptionController.text = widget.portfolioInfo.description;
    _portfolioNameController.text = widget.portfolioInfo.name;
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
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var compressedImage = await ImageCompressUtil.compressImage(image, 40);
      _showCropDialog(compressedImage);
    } else {}
  }

   _handleSave () async{
    if (_formKey.currentState.validate()) {
      var userProviderViewModel = Provider.of<UserProfileViewModel>(context,listen: false);
      var authUser = await AuthService.getInstance();
      var professionalId = authUser.getUser().professionalId;
      var data = {
        "name":_portfolioNameController.text,
        "description":_portfolioDescriptionController.text,
        "professional_id": professionalId
      };
      
      if(fileImage != null){
        data.addAll({
          "image":getBase64Image()
        });
      }

      if(widget.portfolioInfo == null){
        //add new item

      }else{
        // update existing item
userProviderViewModel.updatePortfolio(data: data, index: widget.index, portfolioId: widget.portfolioInfo.portfolioId.toString()).then((value){
 if(value){
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
        title: Text(StringUtils.portfolioText),
        actions: <Widget>[
          EditScreenSaveButton(
            text: StringUtils.saveText,
            onPressed: _handleSave,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10,),
                  portfolioImage,
                  //Name
                  SizedBox(height: 10,),
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
                    labelText: StringUtils.portfolioNameText,
                    hintText: StringUtils.portfolioNameText,
                  ),
                  spaceBetweenFields,
                  //Description
                  //Name
                  CustomTextFormField(
                    keyboardType: TextInputType.text,
                    maxLines: 8,
                    focusNode: _portfolioDescriptionFocusNode,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (a) {
//                      FocusScope.of(context)
//                          .requestFocus(_currentPositionFocusNode);
                    },
                    controller: _portfolioDescriptionController,
                    labelText: StringUtils.portfolioDescriptionText,
                    hintText: StringUtils.portfolioDescriptionText,
                  ),
                  spaceBetweenFields,
                ],
              ),
            ),
          ),
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
        context: context,
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

    fileImage = file;
    isBusyImageCrop = false;
    setState(() {});

//    _lastCropped?.delete();
//    _lastCropped = file;

    debugPrint('$file');
  }
}
