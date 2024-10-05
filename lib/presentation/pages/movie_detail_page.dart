import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_test/presentation/cubit/movie_detail_cubit.dart';
import 'package:interview_test/presentation/widgets/detail_content_movie.dart';

class MovieDetailPage extends StatefulWidget {
  final int id;
  const MovieDetailPage({super.key, required this.id});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    context.read<MovieDetailCubit>().fetch(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailCubit, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailData) {
            return SafeArea(
              child: DetailContentMovie(state.result),
            );
          } else if (state is MovieDetailEmpty) {
            return const Center(
              child: Text('Empty Data'),
            );
          } else if (state is MovieDetailError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
