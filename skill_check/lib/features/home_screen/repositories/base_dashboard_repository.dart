import 'package:skill_check/features/home_screen/models/dashboard_models.dart';
import 'package:skill_check/main_app/failure/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BaseDashBoardRepository {
  Future<Either<Failure,DashBoardModel>> getDashboardData();
}


