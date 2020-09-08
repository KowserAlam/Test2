import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/job/view/widgets/all_job_list_widget.dart';
import 'package:p7app/features/job/view/widgets/filter_preview_widget.dart';
import 'package:p7app/features/job/view/widgets/job_list_filters_widget.dart';
import 'package:p7app/features/job/view/widgets/jobs_screen_segment_control_bar.dart';
import 'package:p7app/features/job/view_model/job_list_filter_widget_view_model.dart';
import 'package:p7app/features/job/view_model/job_list_view_model.dart';
import 'package:p7app/features/settings/settings_view_model.dart';
import 'package:p7app/main_app/auth_service/auth_view_model.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/locator.dart';
import 'package:p7app/main_app/views/widgets/custom_text_field.dart';
import 'package:p7app/main_app/views/widgets/failure_widget.dart';
import 'package:p7app/main_app/views/widgets/loader.dart';
import 'package:provider/provider.dart';

class AllJobListScreen extends StatefulWidget {
  AllJobListScreen({Key key}) : super(key: key);

  @override
  _AllJobListScreenState createState() => _AllJobListScreenState();
}

class _AllJobListScreenState extends State<AllJobListScreen>
    with AfterLayoutMixin, TickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  TextEditingController _searchTextEditingController = TextEditingController();
  var _searchFieldFocusNode = FocusNode();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void afterFirstLayout(BuildContext context) {
    var jobListViewModel =
        Provider.of<JobListViewModel>(context, listen: false);
    jobListViewModel.getJobList(isFormOnPageLoad: true).then((v) {
      if (jobListViewModel.appError != null) {
        if (jobListViewModel.appError == AppError.unauthorized) {
          locator<SettingsViewModel>().signOut();
        }
      }
    });

    if (jobListViewModel.hasSearchQuery) {
      _searchTextEditingController.text =
          jobListViewModel.jobListFilters.searchQuery;
    }

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        jobListViewModel.getMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget errorWidget() {
    var jobListViewModel =
        Provider.of<JobListViewModel>(context, listen: false);
    switch (jobListViewModel.appError) {
      case AppError.serverError:
        return FailureFullScreenWidget(
          errorMessage: StringResources.unableToLoadData,
          onTap: () {
            return Provider.of<JobListViewModel>(context, listen: false)
                .refresh();
          },
        );

      case AppError.networkError:
        return FailureFullScreenWidget(
          errorMessage: StringResources.unableToReachServerMessage,
          onTap: () {
            return Provider.of<JobListViewModel>(context, listen: false)
                .refresh();
          },
        );

      case AppError.unauthorized:
        return FailureFullScreenWidget(
          errorMessage: StringResources.somethingIsWrong,
          onTap: () {
            return locator<SettingsViewModel>().signOut();
          },
        );

      default:
        return FailureFullScreenWidget(
          errorMessage: StringResources.somethingIsWrong,
          onTap: () {
            return Provider.of<JobListViewModel>(context, listen: false)
                .refresh();
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).backgroundColor;
    var scaffoldBackgroundColor = Theme.of(context).backgroundColor;

    var jobListViewModel = Provider.of<JobListViewModel>(context);
    var isInSearchMode = jobListViewModel.isInSearchMode;
    var searchInputWidget = Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: CustomTextField(
            textFieldKey: Key("jobListSearchInputFieldKey"),
            textInputAction: TextInputAction.search,
            focusNode: _searchFieldFocusNode,
            onChanged: (v) => jobListViewModel.jobListFilters.searchQuery,
            onSubmitted: (v) {
//                if (_searchTextEditingController.text.isNotEmpty)
              jobListViewModel.search(_searchTextEditingController.text);
            },
            suffixIcon: IconButton(
              key: Key("jobListSearchButtonKey"),
              icon: Icon(Icons.search),
              onPressed: () {
//                  if (_searchTextEditingController.text.isNotEmpty)
                jobListViewModel.search(_searchTextEditingController.text);
              },
            ),
            controller: _searchTextEditingController,
            hintText: StringResources.searchText,
          ),
        ),
        Container(
          width: double.infinity,
          child: Column(
            children: [
              if (jobListViewModel.totalJobCount != 0)
                if (_searchTextEditingController.text.isNotEmpty &&
                    !jobListViewModel.isFetchingData)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                        '${jobListViewModel.totalJobCount} ${StringResources.jobsFoundText}'),
                  )
            ],
          ),
        ),
      ],
    );
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(StringResources.jobsText, key: Key('jobsAppbarTitle')),
        actions: [
          IconButton(
            key: Key("jobListSearchToggleButtonKey"),
            icon: Icon(isInSearchMode ? Icons.close : Icons.search),
            onPressed: () {
              _searchTextEditingController?.clear();
              jobListViewModel.toggleIsInSearchMode();

              if (jobListViewModel.isInSearchMode) {
                _searchFieldFocusNode.requestFocus();
              } else {
                _searchFieldFocusNode.unfocus();
              }
            },
          ),
          IconButton(
            key: Key("filterButtonKey"),
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _scaffoldKey.currentState.openEndDrawer();
            },
          )
        ],
      ),
      endDrawer: Drawer(
        child: JobListFilterWidget(),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _searchTextEditingController?.clear();
          Provider.of<JobListFilterWidgetViewModel>(context, listen: false)
              .resetState();
          return Provider.of<JobListViewModel>(context, listen: false)
              .refresh();
        },
        child: jobListViewModel.shouldShowPageLoader
            ? Center(child: Loader())
            : Container(
                child: jobListViewModel.shouldShowAppError
                    ? ListView(
                        children: [errorWidget()],
                      )
                    : Stack(
                        children: [
                          Column(
                            children: [
                              if(Provider.of<AuthViewModel>(context).isLoggerIn)
                              SizedBox(height: 35),
                              if (jobListViewModel.isInSearchMode)
                                searchInputWidget,
                              if (jobListViewModel.isFilterApplied)
                                FilterPreviewWidget(),
                              Expanded(
                                child: ListView(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  controller: _scrollController,
                                  children: [
                                    // loader for search and filter
                                    if (jobListViewModel
                                        .shouldSearchNFilterLoader)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Loader(),
                                      ),

                                    jobListViewModel.shouldShowNoJobsFound
                                        ? Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  StringResources.noJobsFound),
                                            ),
                                          )
                                        : AllJobListWidget(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if(Provider.of<AuthViewModel>(context).isLoggerIn)
                          JobsScreenSegmentControlBar(),
                        ],
                      ),
              ),
      ),
    );
  }
}
