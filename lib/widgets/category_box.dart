import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:whenflix/models/models.dart';
import 'package:whenflix/screens/details_screen/details_screen.dart';
import 'package:whenflix/shared/config.dart';

class CategoryBox extends StatelessWidget {
  final String categoryName;
  final List<MovieModel> categoryMovies;

  const CategoryBox({
    Key? key,
    required this.categoryName,
    required this.categoryMovies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  categoryName,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  "See all",
                  style: TextStyle(color: Color(0xFF4a749e), fontSize: 18),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 180,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: categoryMovies.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            DetailsScreen(movie: categoryMovies[index])));
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          placeholder: (context, url) => new Shimmer(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF15212a),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 140,
                              width: 140,
                            ),
                            gradient: shimmerGradient,
                          ),
                          errorWidget: (context, url, error) =>
                              Center(child: new Icon(Icons.error)),
                          imageUrl: categoryMovies[index].images[0],
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 140,
                              width: 140,
                            );
                          },
                        ),
                        SizedBox(
                          width: 140,
                          child: Text(
                            categoryMovies[index].title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          "Rating: ${categoryMovies[index].rating}%",
                          style: TextStyle(
                            color: Colors.lightGreen,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
