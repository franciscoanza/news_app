import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'config/router/app_router.dart';
import 'infrastructure/datasources/remote/news_remote_datasource_impl.dart';
import 'infrastructure/repositories/news_repository_impl.dart';
import 'presentation/providers/news_bloc/news_bloc.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  final newsRepository = NewsRepositoryImpl(
    datasource: NewsRemoteDatasourceImpl(),
  );
  runApp(MainApp(
    newsRepository: newsRepository,
  ));
}

class MainApp extends StatelessWidget {
  final NewsRepositoryImpl newsRepository;
  const MainApp({super.key, required this.newsRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) =>
            NewsBloc(repository: newsRepository)..add(LoadNews()),
        child: MaterialApp.router(
          routerConfig: appRouter,
        ),
      ),
    );
  }
}
