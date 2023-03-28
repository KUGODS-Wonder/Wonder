import 'package:flutter/material.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';

class ApiFetchFutureBuilder<T> extends StatelessWidget {
  final Future<T>? future;
  final Widget Function(BuildContext, T?) builder;

  const ApiFetchFutureBuilder({
    Key? key,
    required this.future,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator(
              color: AppColors.kPrimary100,
            ));
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }
            return builder(context, snapshot.data);
          }
        }
    );
  }
}


