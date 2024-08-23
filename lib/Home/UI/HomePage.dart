import 'package:error_products/Home/UI/DialogListSubmit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:error_products/Home/UI/ProductCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Bloc/app_bloc.dart';
import '../Model/ErrorProductItem.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final appBloc = context.read<AppBloc>();
      if (appBloc.state.hasMore) {
        appBloc.add(LoadMore());
      }    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            if (state is AppLoadingState && state is! AppLoadingMoreState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.listItem.isEmpty) {
              return const Center(
                child: Text('No data available'),
              );
            }
            return RefreshIndicator(
              onRefresh: () {
                context.read<AppBloc>().add(AppStartedEvent());
                return Future.delayed(Duration.zero);
              },
              child: ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    ErrorProductItem item = state.listItem[index];
                    return Column(
                      children: [
                        ProductCard(
                          item: item,
                        ),
                        if (index == state.listItem.length - 1 && state.hasMore)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                            child: Center(
                              child: SpinKitThreeBounce(
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
                              ),
                            ),
                          )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 12,
                      ),
                  itemCount: state.listItem.length),
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: CupertinoButton(
              color: Colors.blue,
              child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.zero,
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  )),
              onPressed: () {
                showDialog(context: context, builder: (context) => const DialogListSubmit());
              }),
        ),
      ),
    );
  }
}
