class NVector {
  int x, y, z, w, v, u, t, s, r, q;
  int length;

  NVector(int[] c) {
    this.length = c.length;
    this.x = c[0];
    if (c.length>=2) this.y = c[1];
    if (c.length>=3) this.z = c[2];
    if (c.length>=4) this.w = c[3];
    if (c.length>=5) this.v = c[4];
    if (c.length>=6) this.u = c[5];
    if (c.length>=7) this.t = c[6];
    if (c.length>=8) this.s = c[7];
    if (c.length>=9) this.r = c[8];
    if (c.length>=10) this.q = c[9];
  }
  
  
  int get(int idx) {
    switch (idx) {
      case 0: return x;
      case 1: return y;
      case 2: return z;
      case 3: return w;
      case 4: return v;
      case 5: return u;
      case 6: return t;
      case 7: return s;
      case 8: return r;
      case 9: return q;
      default: return x;
    }
  }
}
