import 'package:daytaskapp/data/models/rangking_model.dart';

abstract class RankRepo {
  Future<RankListResponse> fetchRanks();
}