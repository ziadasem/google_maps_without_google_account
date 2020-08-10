import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps/map_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const Color accentColor = Color(0xFFE2D5CC);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: accentColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

int state = 0 ; // 0 not loading 1 loading 2 save
String _currentAddress = "";
String urlData  = ""; 
Position position = Position(latitude: 0 , longitude: 0);

    void submitFn(String respoanse , int stateFn){
    List<String> locationWithZoom = respoanse.split('@');
    List<String> locations =  locationWithZoom[1].split(',');
    //isLoading = true ; 
     setState(() {
       _currentAddress = locations[0].substring(0 ,locations[0].length - 3 ) +',' + locations[1].substring(0 ,locations[0].length - 3 ) ;
       position = Position(latitude:double.parse(locations[0]) , longitude:double.parse(locations[1])  )  ;
      state =stateFn ;
       });
       print(_currentAddress);
   
    urlData = respoanse ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Page"),
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Text("The Point You Selected is : "), 
            Text(_currentAddress),

        ],),
      ),
      floatingActionButton: FloatingActionButton(
      child: Icon(Icons.map),
      onPressed: (){
       Navigator.of(context).push( MaterialPageRoute(builder: (context) => FindOnMap(submitFn)));
      }),
    );
  }
}

