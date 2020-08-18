import 'package:flutter/material.dart';
import 'package:p7app/features/user_profile/models/skill.dart';
import 'package:p7app/features/user_profile/models/skill_info.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/views/widgets/custom_searchable_dropdown_from_field.dart';

class AddSkillWidget extends StatefulWidget {
  final List<Skill> items;
  final Function(SkillInfo skillInfo) onAdd;

  AddSkillWidget({Key key, this.items, this.onAdd}) : super(key: key);

  @override
  _AddSkillWidgetState createState() => _AddSkillWidgetState();
}

class _AddSkillWidgetState extends State<AddSkillWidget> {
  bool addMode = false;
  Skill selectedSkill;
  double rating = 0;
  var _formKey = GlobalKey<FormState>();

  _handleAdd() {
    bool isValid = _formKey.currentState.validate();

    if (isValid) {
      if (widget.onAdd != null)
        widget.onAdd(SkillInfo(
//          profSkillId: DateTime.now().millisecondsSinceEpoch.toString(),
          verifiedBySkillCheck: false,
          rating: rating,
          skill: selectedSkill,
        ));
      rating = 0;
      selectedSkill = null;
      addMode = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var form = Column(
      children: [
        Form(
          key: _formKey,
          child: CustomDropdownSearchFormField<Skill>(
            validator: (v) {
              return Validator().nullFieldValidate(v?.name);
            },
            onChanged: (v) {
              selectedSkill = v;
            },
            labelText: StringResources.skillText,
            hintText: StringResources.tapToSelectText,
            selectedItem: selectedSkill,
            showSelectedItem: true,
            showSearchBox: true,
            items: widget.items ?? [],
          ),
        ),
        Row(
          children: [

            Text(
              StringResources.expertiseLevel,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Slider(
                value: rating ?? 0,
                min: 0,
                max: 10,
                onChanged: (double value) {
                  rating = value;
                  setState(() {});
                },
              ),
            ),
            Text("${rating.toStringAsFixed(2)}"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RaisedButton(
              onPressed: _handleAdd,
//                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Text(StringResources.addSkillText),
            ),
            SizedBox(
              width: 5,
            ),
          ],
        ),
      ],
    );
    var button = Center(
      child: RawMaterialButton(
        fillColor: Theme.of(context).accentColor,
        constraints:
            BoxConstraints(minHeight: 40, minWidth: 200, maxHeight: 40),
        onPressed: () {
          addMode = true;
          setState(() {});
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(Icons.add), Text(StringResources.addSkillText)],
        ),
      ),
    );
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: addMode
              ? Border.all(color: Theme.of(context).primaryColor, width: 2)
              : null,
        ),
        constraints: BoxConstraints(minHeight: 180, maxHeight: 200),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          color: addMode
              ? Theme.of(context).primaryColor.withOpacity(0.02)
              : Colors.transparent,
          child: Padding(
            key: ValueKey<bool>(addMode),
            padding: const EdgeInsets.all(8.0),
            child: addMode ? form : button,
          ),
        ));
  }
}
