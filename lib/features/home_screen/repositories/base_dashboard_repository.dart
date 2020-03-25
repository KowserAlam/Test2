import 'package:assessment_ishraak/features/home_screen/models/dashboard_models.dart';
import 'package:assessment_ishraak/main_app/failure/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BaseDashBoardRepository {
  Future<Either<Failure,DashBoardModel>> getDashboardData();
}


