class SphereGeometry extends Geometry {
  num radius;
  
  SphereGeometry([radius = 50, segmentsWidth = 8, segmentsHeight = 6, phiStart = 0, phiLength = Math.PI * 2, thetaStart = 0, thetaLength = Math.PI]){
    print("$radius $segmentsWidth");
    
    var x, y;
    var uvs = [];
    
    var segmentsX = Math.max( 3, segmentsWidth );
    var segmentsY = Math.max( 2, segmentsHeight );
    
    
    
    for ( y = 0; y <= segmentsY; y ++ ) {

      var verticesRow = [];
      var uvsRow = [];
      
      
      for ( x = 0; x <= segmentsX; x ++ ) {
        
        
        var u = x / segmentsX;
        var v = y / segmentsY;

        var xpos = - radius * Math.cos( phiStart + u * phiLength ) * Math.sin( thetaStart + v * thetaLength );
        var ypos = radius * Math.cos( thetaStart + v * thetaLength );
        var zpos = radius * Math.sin( phiStart + u * phiLength ) * Math.sin( thetaStart + v * thetaLength );

        vertices.add( new Vertex( new Vector3( xpos, ypos, zpos ) ) );

        verticesRow.add( this.vertices.length - 1 );
        uvsRow.add( new UV( u, v ) );

      }

      vertices.add( verticesRow );
      uvs.add( uvsRow );

    }
    
    
    for ( y = 0; y < segmentsY; y ++ ) {

      for ( x = 0; x < segmentsX; x ++ ) {

        var v1 = this.vertices[ ];
        var v2 = this.vertices[ y ][ x ];
        var v3 = this.vertices[ y + 1 ][ x ];
        var v4 = this.vertices[ y + 1 ][ x + 1 ];

        var n1 = this.vertices[ v1 ].position.clone().normalize();
        var n2 = this.vertices[ v2 ].position.clone().normalize();
        var n3 = this.vertices[ v3 ].position.clone().normalize();
        var n4 = this.vertices[ v4 ].position.clone().normalize();

        var uv1 = uvs[ y ][ x + 1 ].clone();
        var uv2 = uvs[ y ][ x ].clone();
        var uv3 = uvs[ y + 1 ][ x ].clone();
        var uv4 = uvs[ y + 1 ][ x + 1 ].clone();
       
        
        if (abs(this.vertices[ v1 ].position.y) == radius ) {
          this.faces.add( new Face3( v1, v3, v4, new Vector3( n1, n3, n4 ), new Color(0xFFFFFF), 0 ) );
          this.faceVertexUvs[ 0 ].add( new Vector3( uv1, uv3, uv4 ) );

        } else if ( abs( this.vertices[ v3 ].position.y ) ==  radius ) {
          this.faces.add( new Face3( v1, v2, v3, new Vector3( n1, n2, n3 ), new Color(0xffffff), 0 ) );
          this.faceVertexUvs[ 0 ].add( new Vector3( uv1, uv2, uv3 ) );

        } else {
          this.faces.add( new Face4( v1, v2, v3, v4, new Vector4( n1, n2, n3, n4 ) ) );
          this.faceVertexUvs[ 0 ].add( new Vector4( uv1, uv2, uv3, uv4 ) );

        }

      }

    }
    
    this.computeCentroids();
    this.computeFaceNormals();
    
  }
  
  num abs(number){
    if(number < 0) number *= -1;
    return number;
  }
  
  
}
