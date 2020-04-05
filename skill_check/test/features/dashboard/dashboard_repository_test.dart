import 'package:skill_check/features/home_screen/models/dashboard_models.dart';
import 'package:skill_check/features/home_screen/repositories/base_dashboard_repository.dart';
import 'package:skill_check/features/home_screen/repositories/dashboard_repository.dart';
import 'package:skill_check/main_app/failure/exceptions.dart';
import 'package:skill_check/main_app/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDashBoardRepository extends Mock implements DashBoardRepository {}

void main() {
  MockDashBoardRepository mockDashBoardRepository;
//  DashBoardRepository dashBoardRepository;
  //setup test data
  setUp(() {
    mockDashBoardRepository = MockDashBoardRepository();
//    dashBoardRepository = DashBoardRepository();
  });

  group("DeshboardRepository", () {
    test("should return Right, response succcessful", () async {
      //arrange
      when(mockDashBoardRepository.getDashboardData()).thenAnswer((_) async =>
          Right(DashBoardModel(user: UserDashBoard(name: "shofi"))));

      //act
      var response = await mockDashBoardRepository.getDashboardData();

      //assert

      expect(response.isRight(), true);
      verify(mockDashBoardRepository.getDashboardData());
    });

//    test("should throw server exception, on ServerExceptions", () async {
//      //arrange
//      when(mockDashBoardRepository.getDashboardData()).thenThrow( Exception());
//
//      //act
//      var response = await mockDashBoardRepository.getDashboardData();
//
//      //assert
//
//      expect(response.isLeft(),true);
//      verify(mockDashBoardRepository.getDashboardData());
//    });
  });
}
