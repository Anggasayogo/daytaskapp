import 'dart:async';
import 'package:daytaskapp/app/my_app.dart';
import 'package:daytaskapp/data/repo/authenticate/login_repo.dart';
import 'package:daytaskapp/data/repo/rank/rank_repo.dart';
import 'package:daytaskapp/data/repo/tasklist/priority_repo.dart';
import 'package:daytaskapp/data/repo/tasklist/task_repo.dart';
import 'package:daytaskapp/feature/home/bloc/priority_bloc.dart';
import 'package:daytaskapp/feature/home/bloc/task_bloc.dart';
import 'package:daytaskapp/feature/login/bloc/login_bloc.dart';
import 'package:daytaskapp/feature/rank/bloc/rank_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';

import 'app/config/server_config.dart';
import 'data/repo/repo.dart' as repo;
import 'data/services/service.dart';

void main() {
  runZonedGuarded(() {
    initService();
    repo.initRepo();
    apiService.init(mainBaseUrl: ServerConfig.mainBaseUrl);
    Bloc.observer = TalkerBlocObserver();

    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (BuildContext context) => LoginBloc(loginRepo: getIt.get<LoginRepo>()),
          ),
          BlocProvider<PriorityBloc>(
            create: (BuildContext context) => PriorityBloc(priorityRepo: getIt.get<PriorityRepo>())
          ),
          BlocProvider<TaskBloc>(
            create: (BuildContext context) => TaskBloc(taskRepo: getIt.get<TaskRepo>())
          ),
          BlocProvider<RankBloc>(
            create: (BuildContext context) => RankBloc(rankRepo: getIt.get<RankRepo>())
          )
        ],
        child: const MyApp(),
      ),
    );
  }, (error, stack) {
    debugPrint("Error: $error\nStack Trace: $stack");
  });
}
