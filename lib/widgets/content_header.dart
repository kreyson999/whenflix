import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:whenflix/models/models.dart';
import 'package:whenflix/screens/details_screen/details_screen.dart';
import 'package:whenflix/shared/config.dart';

class ContentHeader extends StatefulWidget {
  final MovieModel movie;

  const ContentHeader({Key? key, required this.movie}) : super(key: key);

  @override
  _ContentHeaderState createState() => _ContentHeaderState();
}

class _ContentHeaderState extends State<ContentHeader> {
  late int endTime;
  bool ended = false;

  @override
  void initState() {
    endTime = DateTime.parse(widget.movie.dateTime).millisecondsSinceEpoch;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailsScreen(movie: widget.movie)));
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          CachedNetworkImage(
            placeholder: (context, url) => new Shimmer(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF15212a),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 200,
              ),
              gradient: shimmerGradient,
            ),
            errorWidget: (context, url, error) => new Icon(Icons.error),
            imageUrl: widget.movie.images[0],
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                height: 200,
              );
            },
          ),
          Container(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "AVAILABLE:",
                  style: TextStyle(
                      color: Color(0xFF4a749e),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                        ),
                      ]),
                ),
                ended
                    ? Text(
                        "ALREADY AVAILABLE",
                        style: TextStyle(
                            color: Color(0xFF4a749e),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 10,
                              ),
                            ]),
                      )
                    : CountdownTimer(
                        onEnd: () {
                          setState(() {
                            ended = true;
                          });
                        },
                        endTime: endTime,
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 10,
                              ),
                            ]),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
