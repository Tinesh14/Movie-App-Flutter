import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:interview_test/core/route.dart';
import 'package:interview_test/inject.dart';
import 'package:interview_test/presentation/cubit/movie_detail_cubit.dart';
import 'package:interview_test/presentation/cubit/now_playing_movie_cubit.dart';
import 'package:interview_test/presentation/cubit/search_movie_cubit.dart';
import 'package:path_provider/path_provider.dart';

import 'core/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator<NowPlayingMovieCubit>(),
        ),
        BlocProvider(
          create: (context) => locator<SearchMovieCubit>(),
        ),
        BlocProvider(
          create: (context) => locator<MovieDetailCubit>(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: Routes.router,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
      ),
    );
  }
}
