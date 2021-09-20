import 'dart:convert';
import 'package:dark_stastic/data/data.dart';
import 'package:dark_stastic/model/categories_models.dart';
import 'package:dark_stastic/model/wallpaper_model.dart';
import 'package:dark_stastic/views/search.dart';
import 'package:dark_stastic/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'categories.dart';

class Home extends StatefulWidget {
   const Home() : super();

   @override
   _HomeState createState() => _HomeState();
 }

 class _HomeState extends State<Home> {

   List <CategorieModel> categories = new List();
   //create wallpaper list after creating the wallpaper model ,
   // to fetch the data
   List <WallpaperModel> wallpapers = new List();

   TextEditingController searchController = new TextEditingController();

   // for getting response from the API we provided to our project
   getTrendingWallpaper() async{
     var response =  await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=200&page=13"),
     //for get access to url we have to pass authorization apikey which we provide
     headers: {
       "Authorization": apiKEY
     } );

     //for get printed data on the our body screen
    //print(response.body.toString());
     //fetch data elements from the api code , we have to implement the map function

     Map<String , dynamic> jsonData = jsonDecode(response.body);
     // jsonData["Photos"] for this go to the api documentation and check in which functions you
     // your data to be store and put the name of those file ,
     //in place of photos
     // froEach function is for creating the loop for
     //get the data on screen one bye one until its done
     jsonData["photos"].forEach((element){

       //print( element);

       //create  wallpapers parameters models
       WallpaperModel wallpaperModel = new WallpaperModel();
       wallpaperModel = WallpaperModel.fromMap(element);
       wallpapers.add(wallpaperModel);
     });

     //if we try to load the images from the internet to the our screen
     //the photos or whatever the data we fetch , it will be on the screen
     // but we cant able to see it , because
     //we need to update the screen , when new data try to update the
     //old data from the screen , for update the screen at , every time new data
     // try to load on the new screen // creating the setState method

     setState(() {

     });
   }

   @override

   void initState(){
     getTrendingWallpaper();
     categories = getCategories();
     super.initState();
   }
   Widget build(BuildContext context) {
     return Scaffold(
       resizeToAvoidBottomInset : false,
       backgroundColor: Colors.white,
       appBar: AppBar(
         backgroundColor: Colors.teal,
         title: BrandName(),
         elevation: 0.0,
       ),

       body: SingleChildScrollView(
         child: Container(
           decoration: BoxDecoration(

             borderRadius: BorderRadiusDirectional.circular(35)

           ),
           margin: EdgeInsets.symmetric(horizontal: 0.1),
           padding: EdgeInsets.symmetric(horizontal: 0.1),

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
                 width: 330, //double.infinity , i am trying on my phone so i put width as 330
                              //otherwise go to the double.infinity for, every device use
                 child: Row(
                   children:<Widget> [
                     Expanded(
                       child: TextField(
                         controller: searchController,
                         textAlign: TextAlign.center,
                         decoration: InputDecoration(
                             hintText: (" Search WallPapers"),
                             border: InputBorder.none
                           ),
                         ),
                     ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>search(
                                  searchQuery: searchController.text,
                              )
                          )
                          );
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              padding: EdgeInsets.symmetric(horizontal: 0.1),
                              child: Icon(Icons.search)))
                   ],
                 ),
               ),

               SizedBox(height:18,),

               // this container is for categories tile
               Container(
                 height:60,
                 child: ListView.builder(
                   padding: EdgeInsets.symmetric(horizontal: 20),
                          itemBuilder: (context, index){
                   return CategorieTile(
                     title: categories[index].categorieName,
                     imgUrl: categories[index].imgUrl,
                   );
                 },

                   shrinkWrap: true,
                   scrollDirection: Axis.horizontal,

                   itemCount:categories.length ,),
               ),

               SizedBox(height:17,),

               wallapaperList(wallpapers: wallpapers, context: context)

             ],
           ),
         ),
       ),
     );
   }
 }

 class CategorieTile extends StatelessWidget {

  final String imgUrl, title;
  CategorieTile({@required this.title ,@required this.imgUrl});

   @override
   Widget build(BuildContext context) {
     return GestureDetector(
       onTap: (){
         Navigator.push(context, MaterialPageRoute(
           builder: (context) => Categorie(
             CategorieName: title.toLowerCase(),
           )
         )
         );
       },
       child: Container(
         margin: EdgeInsets.symmetric(horizontal: 8),
         child: Stack(children: <Widget>[
           //clipRRect for categories view search better UI

           ClipRRect(
             borderRadius: BorderRadius.circular(15),
             child: Image.network(imgUrl, height: 45,width: 100, fit: BoxFit.cover,),),

           // container for Text inside the categories tiles
           Container(
             decoration: BoxDecoration(
               color: Colors.black12,
               borderRadius: BorderRadius.circular(15),
             ),
             height: 45,width: 100,
             alignment: Alignment.center,
             child: Text( title , style: TextStyle(color: Colors.white,
             fontWeight: FontWeight.bold , fontSize: 16),),
           )
         ],)
       ),
     );
   }
 }

