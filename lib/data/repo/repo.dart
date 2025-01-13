import 'package:daytaskapp/data/repo/authenticate/login_repo_impl.dart';
import 'package:daytaskapp/data/repo/tasklist/priority_repo.dart';
import 'package:daytaskapp/data/repo/tasklist/priority_repo_impl.dart';
import 'package:daytaskapp/data/repo/tasklist/task_repo.dart';
import 'package:daytaskapp/data/repo/tasklist/task_repo_impl.dart';
import 'package:daytaskapp/data/services/api/api_service.dart';
import 'package:get_it/get_it.dart';

import 'product/product_repo.dart';
import 'product/product_repo_mock_impl.dart';
import 'authenticate/login_repo.dart';

final getIt = GetIt.instance;

void initRepo() {
  // Register ProductRepo dengan implementasi mock (atau sesuaikan dengan implementasi yang diperlukan)
  getIt.registerLazySingleton<ProductRepo>(() => ProductRepoMockImpl());
  
  // Register LoginRepo dengan implementasi LoginRepoImpl
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepoImpl(apiService: getIt.get<ApiService>()));
  getIt.registerLazySingleton<PriorityRepo>(() => PriorityRepoImpl(apiService: getIt.get<ApiService>()));
  getIt.registerLazySingleton<TaskRepo>(() => TaskRepoImpl(apiService: getIt.get<ApiService>()));

  // Jika ingin menggunakan mock untuk login, Anda bisa mengganti implementasi seperti ini:
  // getIt.registerLazySingleton<LoginRepo>(() => LoginRepoMockImpl());
}

ProductRepo get productRepo => getIt.get<ProductRepo>();

LoginRepo get loginRepo => getIt.get<LoginRepo>();
PriorityRepo get priorityRepo => getIt.get<PriorityRepo>();
