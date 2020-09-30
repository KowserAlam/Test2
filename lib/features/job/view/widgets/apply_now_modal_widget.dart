import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/job/models/job_model.dart';
import 'package:p7app/features/job/repositories/job_repository.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/custom_zefyr_rich_text_from_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';

class ApplyNowModalWidget extends StatefulWidget {
  final String jobTitle;
  final String jobId;
  final Function onSuccessfulApply;

  ApplyNowModalWidget(
    this.jobTitle,
    this.jobId,
    this.onSuccessfulApply,
  );

  @override
  _ApplyNowModalWidgetState createState() => _ApplyNowModalWidgetState();
}

class _ApplyNowModalWidgetState extends State<ApplyNowModalWidget> {
  ZefyrController _zefyrController = ZefyrController(NotusDocument());
  FocusNode _focusNode = FocusNode();
  File file;

  Future<bool> applyForJob() async {
    var data = {
      "application_notes": _zefyrController.document.toPlainText().trim().isNotEmptyOrNotNull?_zefyrController.document.toHTML:"",
      "job": widget.jobId,
    };

    BotToast.showLoading();
    var res =  JobRepository().applyForJobWithAttachment(data,file);
    res.then((value) {
      BotToast.closeAllLoading();
      if(value){
        if(widget.onSuccessfulApply != null)
        widget.onSuccessfulApply();
      }
    });

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return ZefyrScaffold(
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          constraints: BoxConstraints(maxWidth: 400,maxHeight: 600),
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.edit,
                            size: 14,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(StringResources.applyTextCaps),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: Material(
                        color: Colors.white,
                        shape: CircleBorder(),
                        elevation: 4,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(11.0),
                            child: Icon(
                              Icons.close,
                              size: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Text(
                        widget.jobTitle,
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                      SizedBox(
                        height: 10
                      ),
                      Material(
                        color: Colors.grey.withOpacity(.2),
                        child: InkWell(
                          onTap: ()async{
                            FilePickerResult result = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['pdf','zip','doc','docx'],
                            );
                            if(result != null) {
                               file = File(result.files.single.path);
                               setState(() {

                               });
                            }
                          },
                            child: SizedBox(
                              height: 70,
                              child: Center(
                                child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(FeatherIcons.uploadCloud,size: 16,color: Colors.grey,),
                              file != null? Text(basename(file.path)??"",maxLines: 1,) :
                              Text("Attach your file (pdf,zip,doc,docx)",style: TextStyle(color: Colors.grey),),
                            ],
                          ),
                        ),
                              ),
                            )),
                      ),
                      SizedBox(
                          height: 10
                      ),
                      CustomZefyrRichTextFormField(
                        labelText: StringResources.applicationNoteText,
                        height: 200,
                        zefyrKey: Key('myProfileHeaderDescriptionField'),
                        focusNode: _focusNode,
                        controller: _zefyrController,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.pop(context);
                      applyForJob();

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(StringResources.applyNowText),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
