import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/add_place_screen.dart';
import '../provider/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              }),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<GreatPlaces>(context, listen: false).fetchAndSetData(),
        builder: (ctx, snaphsot) =>
            snaphsot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatPlaces>(
                    child: Center(
                      child: Text('Got No Places yet, start adding some!'),
                    ),
                    builder: (ctx, greatPlaces, child) =>
                        greatPlaces.items.length <= 0
                            ? child
                            : ListView.builder(
                                itemCount: greatPlaces.items.length,
                                itemBuilder: (ctx, i) => ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: FileImage(
                                          greatPlaces.items[i].image,
                                        ),
                                      ),
                                      title: Text(greatPlaces.items[i].title),
                                      onTap: () {
                                        //go to detail page..
                                      },
                                    )),
                  ),
      ),
    );
  }
}
