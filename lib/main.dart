import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(){
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MovieApp(),
    );
  }
}

class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  TextEditingController input = TextEditingController();
  bool isLoading = false;
  String movieImageLink = "https://www.programmableweb.com/sites/default/files/OMDb.jpg";
  String movieTitle = "";
  String movieYear = "";
  String movieRated = "";
  String movieRelease = "";
  String movieRuntime = "";
  String movieGenre = "";
  String movieDirector = "";
  String movieWriter = "";
  String movieActor = "";
  String moviePlot = "";
  String movieLanguage = "";
  String movieCountry = "";
  String movieAward = "";
  String movieRating1Source = "";
  String movieRating1Value = "";
  String movieRating2Source = "";
  String movieRating2Value = "";
  String movieRating3Source = "";
  String movieRating3Value = "";
  String movieMetascore = "";
  String movieImdbRating = "";
  String movieImdbVotes = "";
  String movieImdbID = "";
  String movieType = "";
  String movieDVD = "";
  String movieBoxOffice = "";
  String movieProduction = "";
  String movieWebsite = "";
  String movieResponse = "";
  String searchResult = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie App"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 16,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [
                  TextField(
                    controller: input, 
                    decoration: InputDecoration(
                        hintText: "Input Movie Name", 
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
                  ),
                  MaterialButton(onPressed: searchMovie, color: Colors.blue, child: const Text("Search"),),
                  Container(
                    child: isLoading?
                    const CircularProgressIndicator():
                    Column(
                      children: [
                        Image.network(movieImageLink),
                         SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(searchResult)
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  Future<void> searchMovie() async {
    setState(() {
      isLoading = true;
    });
    String searchInput = input.text;
    var apiKey = "95b9f22c";
    var url = Uri.parse('https://www.omdbapi.com/?apikey=$apiKey&t=$searchInput');
    var response = await http.get(url);
    var rescode = response.statusCode;
    if (rescode == 200){
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      setState(() {
            movieTitle = parsedJson['Title'];
            movieYear = parsedJson['Year'];
            movieRated = parsedJson['Rated'];
            movieRelease = parsedJson['Released'];
            movieRuntime = parsedJson['Runtime'];
            movieGenre = parsedJson['Genre'];
            movieDirector = parsedJson['Director'];
            movieWriter = parsedJson['Writer'];
            movieActor = parsedJson['Actors'];
            moviePlot = parsedJson['Plot'];
            movieLanguage = parsedJson['Language'];
            movieCountry = parsedJson['Country'];
            movieAward = parsedJson['Awards'];
            movieImageLink = parsedJson['Poster'];
            movieRating1Source = parsedJson['Ratings'][0]['Source'];
            movieRating1Value = parsedJson['Ratings'][0]['Value'];
            movieRating2Source = parsedJson['Ratings'][1]['Source'];
            movieRating2Value = parsedJson['Ratings'][1]['Value'];
            movieRating3Source = parsedJson['Ratings'][2]['Source'];
            movieRating3Value = parsedJson['Ratings'][2]['Value'];
            movieMetascore = parsedJson['Metascore'];
            movieImdbRating = parsedJson['imdbRating'];
            movieImdbVotes = parsedJson['imdbVotes'];
            movieImdbID = parsedJson['imdbID'];
            movieType = parsedJson['Type'];
            movieDVD = parsedJson['DVD'];
            movieBoxOffice = parsedJson['BoxOffice'];
            movieProduction = parsedJson['Production'];
            movieWebsite = parsedJson['Website'];
            movieResponse = parsedJson['Response'];
            searchResult = """
Title: $movieTitle

Year: $movieYear

Rated: $movieRated

Released: $movieRelease

Runtime: $movieRuntime

Genre: $movieGenre

Director: $movieDirector

Writer: $movieWriter

Actors: $movieActor

Plot: $moviePlot

Language: $movieLanguage

Country: $movieCountry

Awards: $movieAward

Rating: 
        1.  Source: $movieRating1Source
             Value: $movieRating1Value
        2.  Source: $movieRating2Source
             Value: $movieRating2Value
        3.  Source: $movieRating3Source
             Value: $movieRating3Value

Metascore: $movieMetascore

Imdb Rating: $movieImdbRating

Imdb Votes: $movieImdbVotes

Imdb ID: $movieImdbID

Type: $movieType

DVD: $movieDVD

BoxOffice: $movieBoxOffice

Production: $movieProduction

Website: $movieWebsite

Response: $movieResponse""";

//Create the Alert Dialog
AlertDialog alert = const AlertDialog(  
    title: Text("Movie App"),  
    content: Text("Search Completed."),  
);  

//Display the Alert Dialog
showDialog(  
  context: context,  
  builder: (BuildContext context) {  
    return alert;  
  },  
);  

isLoading = false;
      });
    }else{
      setState(() {
          searchResult = "No Record Found";
          //Create the Alert Dialog
          AlertDialog alert = const AlertDialog(  
            title: Text("Movie App"),  
            content: Text("Search Completed."),  
          );  

          //Display the Alert Dialog
          showDialog(  
            context: context,  
            builder: (BuildContext context) {  
            return alert;  
            },  
          );  
          isLoading = false;
      });
    }
    
  }
}