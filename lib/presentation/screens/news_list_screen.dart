import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noticias_app/presentation/widgets/side_menu.dart';

import '../providers/news_bloc/news_bloc.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0;
  bool _isLoadingMore = false;

  final List<String> _categories = [
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology',
  ];

  @override
  void initState() {
    super.initState();
    _loadNewsByCategory(_categories[_selectedIndex]); // Carga inicial
    _scrollController.addListener(_onScroll);
  }

  void _loadNewsByCategory(String category) {
    context.read<NewsBloc>().add(LoadNews(category: category));
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
      });
      context
          .read<NewsBloc>()
          .add(LoadMoreNews(category: _categories[_selectedIndex]));
    }
  }

  void _onCategorySelected(int index) {
    setState(() {
      _selectedIndex = index;
      _isLoadingMore = false;
    });
    _loadNewsByCategory(_categories[_selectedIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(
        scaffoldKey: scaffoldKey,
        selectedIndex: _selectedIndex,
        onCategorySelected: _onCategorySelected,
      ),
      appBar: AppBar(
        title: Text('News'),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading && !state.isLoadingMore) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsLoaded) {
            _isLoadingMore = false;
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.hasReachedMax
                  ? state.articles.length
                  : state.articles.length + (_isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= state.articles.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                final article = state.articles[index];
                return ListTile(
                  title: Text(
                    article.title ?? '',
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    article.description ?? 'No description',
                    maxLines: 2,
                  ),
                  leading: article.urlToImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            article.urlToImage!,
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return const SizedBox(
                                width: 80,
                                height: 80,
                                child: CircularProgressIndicator.adaptive(),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error);
                            },
                          ),
                        )
                      : const SizedBox(
                          width: 80,
                          height: 80,
                        ),
                  onTap: () {
                    context.go('/news_detail', extra: article);
                  },
                );
              },
            );
          } else if (state is NewsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<NewsBloc>()
                          .add(LoadNews(category: _categories[_selectedIndex]));
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
