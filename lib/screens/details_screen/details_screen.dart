import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:whenflix/models/models.dart';
import 'package:whenflix/shared/config.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsScreen extends StatelessWidget {
  final MovieModel movie;

  const DetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _MovieImagesCarousel(movie: movie),
            _MovieDetailsWidget(movie: movie),
            _MovieTrailerPlayer(
              movie: movie,
            ),
          ],
        ),
      ),
    );
  }
}

class _MovieTrailerPlayer extends StatefulWidget {
  final MovieModel movie;

  const _MovieTrailerPlayer({Key? key, required this.movie}) : super(key: key);

  @override
  __MovieTrailerPlayerState createState() => __MovieTrailerPlayerState();
}

class __MovieTrailerPlayerState extends State<_MovieTrailerPlayer> {
  late YoutubePlayerController _controller;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;

  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = true;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.movie.trailerVideoId,
      flags: YoutubePlayerFlags(autoPlay: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Color(0xFF798ea6),
              progressColors: ProgressBarColors(
                playedColor: Color(0xFF798ea6),
                handleColor: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MovieDetailsWidget extends StatelessWidget {
  const _MovieDetailsWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movie.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            movie.description,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          RichText(
            text: TextSpan(
              text: "Cast: ",
              style: TextStyle(
                color: Color(0xFF798ea6),
              ),
              children: [
                TextSpan(
                  text: "${movie.cast}",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          RichText(
            text: TextSpan(
              text: "Writers: ",
              style: TextStyle(
                color: Color(0xFF798ea6),
              ),
              children: [
                TextSpan(
                  text: "${movie.cast}",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieImagesCarousel extends StatefulWidget {
  const _MovieImagesCarousel({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final MovieModel movie;

  @override
  __MovieImagesCarouselState createState() => __MovieImagesCarouselState();
}

class __MovieImagesCarouselState extends State<_MovieImagesCarousel> {
  late int endTime;
  bool ended = false;

  @override
  void initState() {
    if (widget.movie.dateTime != "ENDED") {
      endTime = DateTime.parse(widget.movie.dateTime).millisecondsSinceEpoch;
    } else {
      setState(() {
        ended = true;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        CarouselSlider(
          items: widget.movie.images
              .map(
                (item) => CachedNetworkImage(
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
                  imageUrl:
                      widget.movie.images[widget.movie.images.indexOf(item)],
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: imageProvider,
                        ),
                      ),
                    );
                  },
                ),
              )
              .toList(),
          options: CarouselOptions(
            height: 350,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            enlargeCenterPage: false,
            viewportFraction: 1,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
          ),
        ),
        Container(
          height: 350,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF11191f), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          child: Column(
            children: [
              Text(
                "AVAILABLE: ",
                style: TextStyle(
                  color: Color(0xFF4a749e),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              ended
                  ? Text(
                      "ALREADY AVAILABLE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    )
                  : CountdownTimer(
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
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
