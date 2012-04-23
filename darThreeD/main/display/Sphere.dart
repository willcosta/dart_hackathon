class Sphere extends Object3D {
  Mesh cube;
  IParticleMaterial material;
  Geometry geometry;
  Mesh particle;
  
  
  Sphere(){
    print("sphere");
    
    var latitudeBands = 20;
    var longitudeBands = 20;
    var radius = 150;
    
    geometry = new Geometry();
    
    for (var latNumber = 0; latNumber <= latitudeBands; latNumber++) {
      var theta = latNumber * Math.PI / latitudeBands;
      var sinTheta = Math.sin(theta);
      var cosTheta = Math.cos(theta);
      
      for (var longNumber = 0; longNumber <= longitudeBands; longNumber++) {
        var phi = longNumber * 2 * Math.PI / longitudeBands;
        var sinPhi = Math.sin(phi);
        var cosPhi = Math.cos(phi);
        
        var x = cosPhi * sinTheta;
        var y = cosTheta;
        var z = sinPhi * sinTheta;
        
        particle = new Mesh( new PlaneGeometry( 5,5,1,1 ), new MeshBasicMaterial( { 'color' : Math.random() * 0xffffff } ));// { 'overdraw' : true }) );
        particle.position.x = x;
        particle.position.y = y;
        particle.doubleSided = true;
        particle.position.z = z;
        particle.position.normalize();
        particle.rotation.y = phi+90;
        particle.rotation.x = theta+90;
        particle.position.multiplyScalar( radius );
        geometry.vertices.add( new Vertex( particle.position ) );
        add(particle);
      }
    }
    
    var line = new Line( geometry, new LineBasicMaterial( { 'color': 0xffffff, 'opacity': 0.5 } ) );
    add( line );
    
  }
  
}
