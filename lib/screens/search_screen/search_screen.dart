import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:whenflix/models/api_response.dart';
import 'package:whenflix/models/models.dart';
import 'package:whenflix/screens/screens.dart';
import 'package:whenflix/services/api_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  ApiService get service => GetIt.I<ApiService>();
  bool didFind = false;
  APIResponse<List<MovieModel>>? _apiResponse;

  _fetchMovie(String title) async {
    setState(() {
      didFind = false;
    });
    _apiResponse = await service.getMoviesByTitle(title);
    setState(() {
      didFind = true;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 24,
          ),
          child: Column(
            children: [
              TextFormField(
                onFieldSubmitted: (text) {
                  setState(() {
                    _fetchMovie(text);
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  hintText: "Search...",
                  fillColor: Color(0xFF798ea6),
                ),
              ),
              SizedBox(height: 12,),
              if (didFind)
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                      ),
                      itemCount: _apiResponse!.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsScreen(movie: _apiResponse!.data![index])));
                          },
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                        NetworkImage(_apiResponse!.data![index].images[0]),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                Text(
                                  _apiResponse!.data![index].title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Rating: ${_apiResponse!.data![index].rating}%",
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
                ),
            ],
          ),
        ),
      ),
    );
  }
}
