import 'package:error_products/Home/UI/ProductCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/app_bloc.dart';

class DialogListSubmit extends StatelessWidget {
  const DialogListSubmit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Dialog(
          shape: const RoundedRectangleBorder(),
          backgroundColor: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Submit Changes',style: TextStyle(fontSize: 20),),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    final item = state.listItem[index];
                    return ProductCard(item: item);
                  },
                  itemCount: state.listItem.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 8,),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
