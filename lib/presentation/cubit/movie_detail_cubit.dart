import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:interview_test/domain/entities/movie_detail.dart';
import 'package:interview_test/domain/usecases/get_movie_detail.dart';

part 'movie_detail_state.dart';

@injectable
class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  MovieDetailCubit(this.getMovieDetail) : super(MovieDetailEmpty());

  fetch(int id) async {
    try {
      emit(MovieDetailLoading());
      final result = await getMovieDetail.execute(id);
      result.fold(
        (failure) => emit(MovieDetailError(failure.message)),
        (data) {
          emit(MovieDetailData(data));
        },
      );
    } catch (e) {
      emit(const MovieDetailError('Something Went Wrong!'));
    }
  }
}
