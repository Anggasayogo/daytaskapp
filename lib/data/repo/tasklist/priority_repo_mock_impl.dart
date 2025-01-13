// priority_mock_impl.dart
import 'package:daytaskapp/data/models/priority_model.dart';

import 'priority_repo.dart';

class PriorityRepoMockImpl implements PriorityRepo {
  @override
  Future<PriorityResponse> fetchPriorities() async {
    return PriorityResponse(
      status: true,
      message: 'Mocked fetch priorities',
      data: [
        PriorityData(
          idPriority: 1,
          priorityName: 'High',
          createdAt: DateTime.now(),
          updatedAt: null,
        ),
        PriorityData(
          idPriority: 2,
          priorityName: 'Medium',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ],
    );
  }

  @override
  Future<void> addPriority(PriorityData priorityData) async {
    print('Mocked add priority: ${priorityData.priorityName}');
  }

  @override
  Future<void> deletePriority(int idPriority) async {
    print('Mocked delete priority with ID: $idPriority');
  }
}