import 'package:flutter/material.dart';
import 'package:nativefeatures_app/provider/place_provider.dart';
import 'package:nativefeatures_app/screens/addPlace_screen.dart';
import 'package:nativefeatures_app/screens/placeDetails_screen.dart';
import 'package:nativefeatures_app/screens/placesList_screen.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PlaceProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.route : (context) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (context)=> PlaceDetailScreen()
        },
      ),
    );
  }
}

