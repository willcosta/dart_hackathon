#import('dart:html');
#import('dart:json');

#source("JSONLoader.dart");

class instawhere {
  
  String token;
  List locations;
  int currentLocationIndex;
  instawhere() {
    
  }

  void run() {
    
    if(window.location.hash.indexOf("access_token") < 0){
      window.location = "https://api.instagram.com/oauth/authorize/?client_id=66d4955dca7743de82453f979db455e2&redirect_uri=http://127.0.0.1:3030/Users/dedeee/Dropbox/ig/hackathon/instawhere/instawhere.html&response_type=token";
    }else{
      token = window.location.toString().split("#")[1];
      token = token.split("=")[1];
    }
    
    document.query("#search").on.keyDown.add(searchKeyDown);
    window.on.message.add(onMessageHandler);
    
  }
  
  void getTaggedPhotos(tag){
    //var tag = "boobies";
    var url = "https://api.instagram.com/v1/tags/$tag/media/recent/?callback=jsonCallback&access_token=$token";
    JSONLoader loader = new JSONLoader(url, onGetTaggedPhotosHandler);
  }
  
  void getTaggedPhotosFromURL(url){
    JSONLoader loader = new JSONLoader(url, onGetTaggedPhotosHandler);
  }
  
  void getLatLngPos(lat, lng){
    print("dart $lat $lng");
    Map toJS = {"id":"fromDart", "lat":lat, "lng": lng};
    window.postMessage(JSON.stringify(toJS), "*");
  }
  
  void addPixel(x, y){
    var meucanvinhas = document.query("#map_canvas");
    var ctx = meucanvinhas.getContext('2d');
    ctx.fillStyle = "rgb(200,0,0)";
    ctx.fillRect (x, y, 2, 2);
  }
  
  ///////////////////////////////////////////////
  // EVENT HANDLERS
  ///////////////////////////////////////////////
  void onGetTaggedPhotosHandler(data){
    List images = data["data"];
    
    if(data["meta"]["code"] == 400){
      window.alert(data["meta"]["error_message"]);
      return;
    }
    
    for(int i = 0 ; i < images.length ; i++){
      var imageInfo = images[i];
      var imageURL = imageInfo["images"]["thumbnail"]["url"];
      
      if(imageInfo["location"] != null){
        var lat = imageInfo["location"]["latitude"];
        var lng = imageInfo["location"]["longitude"];
      
        getLatLngPos(lat, lng);
        Element imageElement = new Element.tag("image");
        imageElement.src = imageURL;
        document.query("#images_container").elements.add(imageElement);
      }
    }
    
    
    if(data["pagination"]["next_url"] != null){
      var url = data["pagination"]["next_url"];
      window.setTimeout(function(){
        getTaggedPhotosFromURL(url);
      }, 1000);
    }
  }
  
  void searchKeyDown(event){
    if(event.keyCode == 13){
      Map toJS = {"id":"fromDart"};
      window.postMessage(JSON.stringify(toJS), "*");
      document.query("#images_container").elements.clear();
      getTaggedPhotos(document.query("#search").value);
      document.query("#title").text = "instawhere : " + document.query("#search").value;
    }
  }
  
  
  /**
  * Receives from JS
  */
  void onMessageHandler(MessageEvent e){
    var data = JSON.parse(e.data);
    
    if(data["id"] == "fromJS"){
      if(data["f"] == "mapInitialized"){
        //getLocations();
      }else if(data["f"] == "createPixel"){
        addPixel(data["args"]["point"]["x"], data["args"]["point"]["y"]);
      }
    }
  }

}

void main() {
  new instawhere().run();
}
