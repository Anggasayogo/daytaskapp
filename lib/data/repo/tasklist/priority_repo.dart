import 'package:daytaskapp/data/models/priority_model.dart';

abstract class PriorityRepo {
  Future<PriorityResponse> fetchPriorities();
  Future<void> addPriority(PriorityData priorityData);
  Future<void> deletePriority(int idPriority);
}