
import 'package:daytaskapp/data/models/rangking_model.dart';
import 'package:daytaskapp/data/repo/rank/rank_repo.dart';

class RankRepoMockImpl implements RankRepo {
  @override
  Future<RankListResponse> fetchRanks() async {
    await Future.delayed(Duration(seconds: 1)); // Simulating network delay

    final mockResponse = {
      "status": true,
      "message": "success",
      "data": [
        {
          "user_id": 1,
          "username": "John Doe",
          "total_point": "150",
          "ranking": 1
        },
        {
          "user_id": 2,
          "username": "Jane Smith",
          "total_point": "120",
          "ranking": 2
        },
        {
          "user_id": 3,
          "username": "Alice Brown",
          "total_point": "100",
          "ranking": 3
        }
      ]
    };

    return RankListResponse.fromJson(mockResponse);
  }
}