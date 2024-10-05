import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:interview_test/core/app_constant.dart';
import 'package:interview_test/inject.dart';

import '../../core/constant.dart';

class CardList extends StatelessWidget {
  final String title;
  final String overview;
  final String posterPath;
  final Function() onTap;
  final double voteAverage;
  final String releaseDate;

  const CardList({
    super.key,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.onTap,
    required this.voteAverage,
    required this.releaseDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16 + 80 + 16,
                  bottom: 8,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      overview,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(releaseDate),
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: voteAverage / 2,
                              itemCount: 5,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: kMikadoYellow,
                              ),
                              itemSize: 15,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(voteAverage.toStringAsFixed(1))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: CachedNetworkImage(
                  imageUrl: '${locator<AppConstant>().baseImageUrl}$posterPath',
                  width: 80,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
