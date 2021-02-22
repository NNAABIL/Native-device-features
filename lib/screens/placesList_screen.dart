import 'package:flutter/material.dart';
import 'package:nativefeatures_app/provider/place_provider.dart';
import 'package:nativefeatures_app/screens/addPlace_screen.dart';
import 'package:provider/provider.dart';

import 'placeDetails_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Places'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.route);
              })
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<PlaceProvider>(context,listen: false).fetchPlaces();
        },
        child: Consumer<PlaceProvider>(
          child: Center(child: Text('Start adding places ')),
          builder: (_, data, ch) => data.places.length <= 0
              ? ch
              : ListView.builder(
                  itemCount: data.places.length,
                  itemBuilder: (context, i) => ListTile(
                        leading: (CircleAvatar(
                          backgroundImage: FileImage(data.places[i].image),
                        )),
                        title: Text(data.places[i].title),
                        subtitle: Text(data.places[i].location.address),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            data.removeItem(data.places[i].id);
                          },
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              PlaceDetailScreen.routeName,
                              arguments: data.places[i].id);
                        },
                      )),
        ),
      ),
    );
  }
}
