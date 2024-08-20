import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/widgets/custom_card_thumbnail.dart';

class NowPlayingList extends StatefulWidget {
  const NowPlayingList({super.key});

  @override
  State<NowPlayingList> createState() => _NowPlayingListState();
}

class _NowPlayingListState extends State<NowPlayingList> {
  PageController pageController = PageController();
  ApiServices apiService = ApiServices();
  List<Movie> movies = [];
  int currentPage = 0;

  @override
  void initState(){
    movies = apiService.getMovies();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child:PageView.builder(
          onPageChanged: (int page){
            setState(() {
              currentPage = page;
              
            });
          },
          controller: pageController,  
          itemCount: movies.length,
          itemBuilder: (context,index){
            return CustomCardThumbnail(imageAsset: movies[index].posterPath);
          },),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildPageIndicators(),
        ),
      ],
    );
  }

  List<Widget> _buildPageIndicators() {
    List<Widget> indicators = [];
    for (var i = 0; i< movies.length;i++){
      indicators.add(_buildIndicator(i == currentPage));
    }
    return indicators;
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      height: 8.0,
      width: 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
