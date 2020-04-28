import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:p7app/features/user_profile/models/portfolio_info.dart';
import 'package:p7app/features/user_profile/models/user_model.dart';
import 'package:p7app/features/user_profile/repositories/user_profile_repository.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/main_app/failure/error.dart';

class MockUserProfileRepository extends Mock implements UserProfileRepository {}

main() {
  var viewModel = UserProfileViewModel();
  var mockUserProfileRepository = MockUserProfileRepository();

  test("Portfolio add test, Calling nothing userData should be null ", () {
    expect(viewModel.userData, null);
  });

  group("Portfolio test", () {
    setUp(() {
      viewModel.userData = UserModel(portfolioInfo: []);
    });

    test("Portfolio add successful, Should have one portfolio ", () async {
      when(mockUserProfileRepository.createPortfolioInfo({"": ""})).thenAnswer(
          (_) async => Right(PortfolioInfo(portfolioId: 1, name: "name")));
      var val = await viewModel.addPortfolioInfo(
          data: {"": ""}, userProfileRepository: mockUserProfileRepository);
      expect(val, true);
    });

    test("Portfolio add unsuccessful, Should have one portfolio ", () async {
      when(mockUserProfileRepository.createPortfolioInfo({"": ""}))
          .thenAnswer((_) async => Left(AppError.unknownError));
      var val = await viewModel.addPortfolioInfo(
          data: {"": ""}, userProfileRepository: mockUserProfileRepository);
      expect(val, false);
    });

    test("Portfolio delete unsuccessful, Should have one portfolio ", () async {
      var portfolio =
          PortfolioInfo(portfolioId: 1, name: "ad", description: "sad");

      viewModel.userData.portfolioInfo = [portfolio];

      when(mockUserProfileRepository.deletePortfolio(portfolio))
          .thenAnswer((_) async => Left(AppError.unknownError));

      var val = await viewModel.deletePortfolio(portfolio, 0,
          userProfileRepository: mockUserProfileRepository);
      expect(viewModel.userData.portfolioInfo.length, 1);
    });
    test("Portfolio delete successful, Should have no portfolio ", () async {
      var portfolio =
          PortfolioInfo(portfolioId: 1, name: "ad", description: "sad");

      viewModel.userData.portfolioInfo = [portfolio];

      when(mockUserProfileRepository.deletePortfolio(portfolio))
          .thenAnswer((_) async => Right(true));

      var val = await viewModel.deletePortfolio(portfolio, 0,
          userProfileRepository: mockUserProfileRepository);
      expect(viewModel.userData.portfolioInfo.length, 0);
    });
  });
}
