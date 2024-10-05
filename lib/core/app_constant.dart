import 'package:injectable/injectable.dart';

@lazySingleton
class AppConstant {
  // Private constructor
  AppConstant._privateConstructor();

  // The single instance of the class (singleton)
  static final AppConstant _instance = AppConstant._privateConstructor();

  // Public factory constructor that returns the same instance
  factory AppConstant() {
    return _instance;
  }
  final token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjYTQ0YjY2ZDhmYzNlNDQ2ODhmZTYzMDk0ZTc5ZjdjOSIsIm5iZiI6MTcyODA0MzI3NS4zMjI4OTEsInN1YiI6IjVkZWU0MjU4MDI1NzY0MDAxNjU0OWI5YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.kAa3VNJ-uQTFCRV2viUlUcSgOrWGV7Eaw51EAlbw_Tw";
  final String baseImageUrl = 'https://image.tmdb.org/t/p/w500';
}
