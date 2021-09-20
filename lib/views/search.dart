import 'dart:convert';
import 'package:dark_stastic/data/data.dart';
import 'package:dark_stastic/model/wallpaper_model.dart';
import 'package:dark_stastic/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

 class search extends StatefulWidget {

   final String searchQuery;
   search({this.searchQuery});

   @override
   _searchState createState() => _searchState();
 }
 
 class _searchState extends State<search> {
   TextEditingController searchController = new TextEditingController();

   List <WallpaperModel> wallpapers = new List();

    // search by user , and pop on to the screen we want to create another
   // get search wallpaper http response page using
   // the api link

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
    getSearchWallpaper(widget.searchQuery);
    super.initState();
    //when user search something , like if user search coding wallpaers ,
     //then Coding name  will be print , in the place of search wallpaper,
     //for that
     searchController.text=widget.searchQuery;
  }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.teal,
         title: BrandName(), //BrandName created for the title , decoration & etc
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

             SizedBox(height: 20,),

             Container(
               decoration: BoxDecoration(
                 //0xFFE0E0E0
                   color: Color(0xFFE0E0E0),
                   borderRadius: BorderRadiusDirectional.circular(35)
               ),

               height: 45,
               width: 230,
               child: Row(
                 children:<Widget> [
                   Expanded(
                     child: TextField(
                       controller: searchController,
                       textAlign: TextAlign.center,
                       decoration: InputDecoration(
                           hintText: ("Search WallPaper"),
                           border: InputBorder.none
                       ),
                     ),
                   ),
                   GestureDetector(
                       onTap: (){
                     getSearchWallpaper(searchController.text);
                       },

                         child: Container(
                           //for any icon , or something else widget in search bar
                         ),
                       )
                 ],
               ),
             ),

                   ],
                 ),
               ),

               SizedBox(
                 height: 20,
               ),
               
               wallapaperList(wallpapers: wallpapers, context: context)
             ],
           ),
         ),
       ),
     );
   }
 }
 