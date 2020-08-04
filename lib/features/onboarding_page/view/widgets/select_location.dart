import 'package:flutter/material.dart';
import 'package:p7app/features/onboarding_page/view_models/additional_info_view_model.dart';
import 'package:p7app/main_app/repositories/country_repository.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/custom_searchable_dropdown_from_field.dart';
import 'package:provider/provider.dart';

class SelectLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<AdditionalInfoViewModel>(builder: (context, vm, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomDropdownSearchFormField<Country>(
              hintText: StringResources.tapToSelectText,
              labelText: StringResources.jobLocationPrefText,
              items: vm.countryList,
              selectedItem: vm.country,
              showSearchBox: true,
              onChanged: (v) {
                vm.country = v;
              },
            ),
          ],
        );
      }),
    );
  }
}
