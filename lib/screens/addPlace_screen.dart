import 'package:flutter/material.dart';
import 'package:nativefeatures_app/model/place_model.dart';
import 'package:nativefeatures_app/provider/place_provider.dart';
import 'dart:io';
import 'package:nativefeatures_app/widgets/customTextFiled.dart';
import 'package:nativefeatures_app/widgets/imagePicker.dart';
import 'package:nativefeatures_app/widgets/locationInput_widget.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const route = 'AddPlaceScreen';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  File _pickedImage;
  PlaceLocation _pickedLocation;
  String _title;

  _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  _selectPlace(double lat,double lng){
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  _submit() {
    if (!_key.currentState.validate()|| _pickedImage == null || _pickedLocation==null) {
      return;
    }
    _key.currentState.save();
    Provider.of<PlaceProvider>(context,listen: false).addPlaces(_title, _pickedImage,_pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add place'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Form(
              key: _key,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextField(
                        title: 'title',
                        validator: (String val) {
                          if (val.isEmpty) {
                            return 'Enter title';
                          }
                        },
                        onSaved: (String val) {
                          _title = val;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ImageInput(_selectImage),
                      SizedBox(height: 10,),
                      LocationInput(_selectPlace)
                    ],
                  ),
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            onPressed: _submit,
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            color: Theme.of(context).accentColor,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          )
        ],
      ),
    );
  }
}
