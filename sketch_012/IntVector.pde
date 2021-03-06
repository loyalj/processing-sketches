/***************
 
/***************/
class IntVector {
    public int x, y, z;

    /***************
     
    /***************/
    IntVector() {
        x = 0;
        y = 0; 
        z = 0;
    }

    /***************
     
    /***************/
    IntVector(int _x) {
        x = _x;
        y = 0; 
        z = 0;
    }

    /***************
     
    /***************/
    IntVector(int _x, int _y) {
        x = _x;
        y = _y; 
        z = 0;
    }

    /***************
     
    /***************/
    IntVector(int _x, int _y, int _z) {
        x = _x;
        y = _y; 
        z = _z;
    }
}
