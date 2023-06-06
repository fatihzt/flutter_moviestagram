import 'package:flutter/material.dart';
import 'package:flutter_moviestagram/api_service.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final ApiService apiService = ApiService();
  int currentPage = 1;
  int totalPages = 0;
  List<dynamic> movies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  void fetchMovies() async {
    try {
      final result = await apiService.getPopularMovies(currentPage);
      setState(() {
        movies = result['Results'];
        totalPages = result['TotalPages'];
      });
    } catch (e) {
      print('Error fetching popular movies: $e');
    }
  }

  void nextPage() {
    if (currentPage < totalPages) {
      setState(() {
        currentPage++;
        fetchMovies();
      });
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
        fetchMovies();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/moviebackground.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (BuildContext context, int index) {
                  final movie = movies[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetail(movie: movie),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Image.network(
                          'https://image.tmdb.org/t/p/w400${movie['PosterPath']}',
                          width: 80,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie['Title'].toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: previousPage,
                  icon: Icon(Icons.arrow_back),
                ),
                SizedBox(width: 16),
                IconButton(
                  onPressed: nextPage,
                  icon: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MovieDetail extends StatelessWidget {
  final dynamic movie;

  MovieDetail({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie['Title']),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://image.tmdb.org/t/p/original${movie['BackdropPath']}',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Image.network(
                'https://image.tmdb.org/t/p/w400${movie['PosterPath']}',
                width: 200,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              'Title: ${movie['Title']}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'IMDb Rating: ${movie['IMDbRating']}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
