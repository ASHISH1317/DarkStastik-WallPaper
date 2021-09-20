import 'dart:convert';

import 'package:dark_stastic/data/data.dart';
import 'package:dark_stastic/model/wallpaper_model.dart';
import 'package:dark_stastic/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Categorie extends StatefulWidget {

  final String CategorieName;
  Categorie({this.CategorieName});


  @override
  _CategorieState createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {

  List <WallpaperModel> wallpapers = new List();
  
  getSearchWallpaper(String query) async{
    var response =  await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=100& per_page=1"),
        headers: {
          "Authorization": apiKEY
        } );
    Map<String , dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element){
      //print( element);
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });
    setState(() {

    });
  }

  @override
  void initState() {
    getSearchWallpaper(widget.CategorieName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: BrandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children:<Widget> [
              Container(
                decoration: BoxDecoration(

                    borderRadius: BorderRadiusDirectional.circular(35)

                ),
                margin: EdgeInsets.symmetric(horizontal: 0.1),
                padding: EdgeInsets.symmetric(horizontal: 0.1,),

                child: Column(
                  children: <Widget>[

                    SizedBox(height: 12,),

                  ],
                ),
              ),

              SizedBox(
                height: 15,
              ),

              wallapaperList(wallpapers: wallpapers, context: context)
            ],
          ),
        ),
      ),
    );

  }
}
