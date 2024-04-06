import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsc_test/bloc/news/headlines_bloc.dart';
import 'package:jsc_test/bloc/news/news_bloc.dart';
import 'package:jsc_test/model/news/article_model.dart';
import 'package:jsc_test/ui/home_screen/widget/news_headlines.dart';
import 'package:jsc_test/ui/home_screen/widget/news_list.dart';
import 'package:jsc_test/widget/app_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HeadlinesBloc _headlinesBloc = HeadlinesBloc();
  final NewsBloc _newsBloc = NewsBloc();

  Timer? _debounce;

  List<ArticleModel> _headlinesList = [];
  List<ArticleModel> _newsList = [];

  TextEditingController searchCtrl = TextEditingController(text: '');

  @override
  void initState() {
    _headlinesBloc.add(FetchHeadlinesEvent());
    _newsBloc.add(FetchNewsEvent());
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Headlines"),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider<HeadlinesBloc>(
              create: (context) => _headlinesBloc,
            ),
            BlocProvider<NewsBloc>(
              create: (context) => _newsBloc,
              lazy: false,
            ),
          ],
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<HeadlinesBloc, HeadlinesState>(
                  builder: (context, state) {
                    if (state is HeadlinesPageLoading) {
                      return AppWidgets.centerLoading();
                    } else if (state is HeadlinesPageLoaded) {
                      if (state.data.isNotEmpty == true) {
                        _headlinesList = state.data;
                      } else {
                        return AppWidgets.noResult(context, "Data not found");
                      }
                    } else if (state is HeadlinesPageError) {
                      return AppWidgets.noResult(context, state.errorMessage);
                    }
                    return NewsHeadLines(
                      newsList: _headlinesList,
                    );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "News",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: searchCtrl,
                    decoration: InputDecoration(
                        hintText: "Search.....",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                searchCtrl.clear();
                              });
                              _newsBloc.add(ClearSearchEvent());
                            },
                            icon: const Icon(Icons.cancel_outlined))),
                    onChanged: (value) {
                      if (_debounce?.isActive ?? false) _debounce?.cancel();
                      _debounce = Timer(const Duration(milliseconds: 500), () {
                        if (value.isNotEmpty) {
                          _newsBloc.add(SearchNewsEvent(searchCtrl.text));
                        } else {
                          _newsBloc.add(ClearSearchEvent());
                        }
                      });
                    },
                  ),
                ),
                BlocConsumer<NewsBloc, NewsState>(
                  builder: (context, state) {
                    if (kDebugMode) {
                      print("${HomeScreen.id} -->> $state");
                    }
                    if (state is NewsPageLoading) {
                      return AppWidgets.centerLoading();
                    } else if (state is NewsPageLoaded) {
                      if (state.data.isNotEmpty == true) {
                        _newsList = state.data;
                      } else {
                        return AppWidgets.noResult(context, "Data not found");
                      }
                    } else if (state is NewsPageError) {
                      return AppWidgets.noResult(context, state.errorMessage);
                    }
                    return NewsList(newsList: _newsList);
                  },
                  listener: (context, state) {},
                ),
              ],
            ),
          ),
        ));
  }
}
