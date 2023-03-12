import 'package:flutter/material.dart';

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
            if (snapshot.hasError) {
              return Center(child: Text('Error\n${snapshot.error}'));
            }
            return const Center(child: CircularProgressIndicator());
          } else {
            return builder(context, snapshot.data);
          }
        }
    );
  }
}


