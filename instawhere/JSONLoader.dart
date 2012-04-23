class JSONLoader {
  Function callback;
  bool loaded;
  Element script;
  String lastEventId;
  String id;
  
  JSONLoader(url, callback, [id = null]){
    this.loaded = false;
    this.callback = callback;
    this.id = id;
    window.on.message.add(onJsonLoaded);
    
    script = new Element.tag("script");
    script.src = url;
    document.body.elements.add(script);
  }
  
  void onJsonLoaded(MessageEvent e){
    var data = JSON.parse(e.data.toString());
    if(!this.loaded && data["_instagram"] == true){
      this.loaded = true;
      data["_id"] = id;
      window.on.message.remove(onJsonLoaded);
      callback(data);
    }
  }
}
