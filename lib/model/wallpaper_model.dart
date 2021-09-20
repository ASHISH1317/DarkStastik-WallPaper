
// class model for the fetch the data from the photographer name & Url & id
// this info get from api documentation pixels.com

class WallpaperModel{
  String photographer;
  String photographer_url;
  int photographer_id;
   SrcModel src;
  // constructor for the key values
  WallpaperModel({this.src,this.photographer, this.photographer_id,
    this.photographer_url});

  // create factory method for , the getting json file
  factory WallpaperModel.fromMap(Map<String , dynamic> jsonData){
    return WallpaperModel(

        src: SrcModel.fromMap(jsonData["src"]),
        photographer_url: jsonData["photographer_url"],
        photographer_id: jsonData["photographer_id"],
        photographer: jsonData["photographer"]

    );
  }
}

// you can check in the pixels api documentation , there is src (source),
// has itself map , and those map contains some data ,
// for fetching some data from the src , we need to make src Model

class SrcModel{
  String original ;
  String large2x;
  String small;
  String portrait;

  // constructor for the key values
  SrcModel({this.large2x , this.original , this.portrait, this.small});

  // creating factory model for fetching the individual data from the
  // src key model , go to the api documentation\
  factory SrcModel.fromMap(Map<String , dynamic> jsonData ){
    return SrcModel(
        portrait: jsonData["portrait"],
        original: jsonData["original"],
        small: jsonData["small"],
        large2x: jsonData["large2x"],
    );
  }
}

//now go to the home.dart and create the WallpaperModel list view ,
//with the categories view model
//permission_handler: ^4.2.0+hotfi.3