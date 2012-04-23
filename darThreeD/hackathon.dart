#import('dart:html');
#import("src/ThreeD.dart");
#import("main/Main.dart");

class hackathon {
  Element container;
  
  /**
  * 3D
  */
  PerspectiveCamera camera;
  Scene scene;
  CanvasRenderer renderer;

  Sphere globe;
  
  hackathon() {
    
  }

  void run() {
    init3D();
    //init3d();
  }
  
  /**
  * Inicia a porra toda do 3d
  */
  void init3D(){
    print("init3D");
    scene = new Scene();

    camera = new PerspectiveCamera( 70, window.innerWidth / window.innerHeight, 1, 1000 );
    camera.position.y = 0;
    camera.position.z = 500;
    scene.add( camera );
    
    globe = new Sphere();
    scene.add(globe);
    
    // Render
    renderer = new CanvasRenderer();
    renderer.setSize( window.innerWidth, window.innerHeight );
    
    // interval
    window.setInterval(f() => animate(), 10);
    
    container = document.query('#stage');
    container.nodes.add( renderer.domElement );
  }
  
  void animate()
  {
    globe.rotation.y += .05;
    globe.rotation.x += .05;
    render();
  }

  void render()
  {
    renderer.render( scene, camera );
  }
}

void main() {
  new hackathon().run();
}
