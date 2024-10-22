import 'package:go_router/go_router.dart';

import '../../domain/entities/article.dart';
import '../../presentation/screens/news_detail_screen.dart';
import '../../presentation/screens/news_list_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => const NewsListScreen(),
        routes: [
          GoRoute(
            path: 'news_detail',
            builder: (context, state) {
              final article = state.extra as Article;
              return NewsDetailScreen(article: article);
            },
          ),
        ]),

    // GoRoute(path: '/business', builder: (context, state) => ,)
  ],
);
