import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:touch_indicator/touch_indicator.dart';



class FindOnMap extends StatefulWidget {
final Function(String url , int state) submitFn ;

FindOnMap(this.submitFn);
static const routeName = '/findonmap';  

  @override
  _FindOnMapState createState() => _FindOnMapState();
}

class _FindOnMapState extends State<FindOnMap> {
 Completer<WebViewController> _controller = Completer<WebViewController>();
  int state ;
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        appBar: AppBar(  
          title: Text("Tap on time and save"),
        ),
          body:  TouchIndicator(
            enabled: true,
            forceInReleaseMode: true,
            indicatorColor: Colors.red,
            child: WebView(
            javascriptMode: JavascriptMode.unrestricted ,
            initialUrl: 'https://www.google.com/maps/@37.404211,-122.148394,14z',
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },   
            ),
          ),
          floatingActionButton: FloatingActionButton(
          child: Icon(Icons.done),
          onPressed: () async{
          WebViewController result = await _controller.future ;
          final url = await result.currentUrl() ;
          state = 2 ;
          widget.submitFn(url , state); 
          Navigator.of(context).pop();
          }),
    );
  }
}