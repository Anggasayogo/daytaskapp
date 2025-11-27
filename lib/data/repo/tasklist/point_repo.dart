import 'package:daytaskapp/data/models/point_model.dart';

abstract class PointRepo {
  Future<PointListResponse> fetchPointList();
}