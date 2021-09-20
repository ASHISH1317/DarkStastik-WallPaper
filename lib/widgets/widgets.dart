import 'package:dark_stastic/model/wallpaper_model.dart';
import 'package:dark_stastic/views/image_view.dart';
import 'package:flutter/material.dart';

Widget BrandName(){
  return Center(
    child: RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
        children: const <TextSpan>[
          TextSpan(text: 'Dark', style: TextStyle(color: Colors.black)),
          TextSpan(text: 'Stastic',style: TextStyle(color: Colors.white)),
        ],
      ),
    ),
  );
}

//this widget is for the gridview wallpaper on the screen
Widget wallapaperList({List <WallpaperModel> wallpapers, context}){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
        //physics is for smooth scrollable screen
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,

      children: wallpapers.map((wallpaper) {
        return GridTile(
          //container be covered by a widget called hero animation ,
          //hero animation function will be , open up our picture in ,
          //animation way
            child:GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=> ImageView(
                      imgUrl: wallpaper.src.portrait,
                    )
                ));
              },
              child: Hero(
                  tag: wallpaper.src.portrait,
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                      child: Image.network(wallpaper.src.portrait, fit: BoxFit.cover,)),
                ),
              ),
            )
        );
      }).toList(),

    ),
  );
}