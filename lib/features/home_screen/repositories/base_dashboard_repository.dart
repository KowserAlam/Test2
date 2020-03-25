import 'package:p7app/features/home_screen/models/dashboard_models.dart';
import 'package:p7app/main_app/failure/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BaseDashBoardRepository {
  Future<Either<Failure,DashBoardModel>> getDashboardData();
}


