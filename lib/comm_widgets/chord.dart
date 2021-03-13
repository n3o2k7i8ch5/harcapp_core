import 'dart:math';

abstract class Chord{

  final String name;
  final int bar;
  final List<int> strings;

  const Chord(this.name, this.bar, this.strings);

  int get nearestDotPosition{
    int nearestDotPostion;

    if(bar!=0)
      nearestDotPostion = bar;
    else{
      nearestDotPostion = 999999999;
      for(int pos in strings)
        if(pos != 0 && pos < nearestDotPostion)
          nearestDotPostion = pos;
    }

    return nearestDotPostion;
  }

  Chord shiftToFirstDot();

  int min(int i1, int i2){

    if(i1<1)
      return i2;
    else if(i2<1)
      return i1;
    else
      return i1<i2?i1:i2;
  }
}

class GChord extends Chord{

  static const GChord empty = null;

  static const GChord c_1 = const GChord("c", 3, [0, 0, 5, 5, 4, 0]);
  static const GChord c_2 = const GChord("c", 8, [0, 10, 10, 0, 0, 0]);
  static const List<GChord> c = const [c_1, c_2];

  static const GChord c6_1 = const GChord("c6", 8, [0, 10, 10, 0, 10, 0]);
  static const List<GChord> c6 = const [c6_1];

  static const GChord c7_1 = const GChord("c7", 3, [0, 0, 5, 0, 4, 0]);
  static const List<GChord> c7 = const [c7_1];

  static const GChord c9_1 = const GChord("c9", 0, [3, 3, 5, 0, 4, 3]);
  static const List<GChord> c9 = const [c9_1];

  static const GChord C_1 = const GChord("C", 0, [0, 3, 2, 0, 1, 0]);
  static const GChord C_2 = const GChord("C", 3, [0, 0, 5, 5, 5, 0]);
  static const GChord C_3 = const GChord("C", 8, [0, 10, 10, 9, 0, 0]);
  static const List<GChord> C = const [C_1, C_2, C_3];

  static const GChord C0_1 = const GChord("C0", 0, [0, 3, 2, 0, 0, 0]);
  static const List<GChord> C0 = const [C0_1];

  static const GChord C6_1 = const GChord("C6", 0, [0, 3, 2, 2, 1, 0]);
  static const List<GChord> C6 = const [C6_1];

  static const GChord C7_1 = const GChord("C7", 0, [0, 3, 2, 3, 1, 0]);
  static const GChord C7_2 = const GChord("C7", 3, [0, 0, 5, 0, 5, 0]);
  static const List<GChord> C7 = const [C7_1, C7_2];

  static const GChord C9_1 = const GChord("C9", 0, [0, 4, 3, 4, 4, 4]);
  static const List<GChord> C9 = const [C9_1];

  static const List<List<GChord>> C_set = const [C, C0, C6, C7, C9, c, c6, c7, c9];


  static const GChord cis_1 = GChord("cis", 4, [0, 0, 6, 6, 5, 0]);
  static const List<GChord> cis = [cis_1];

  static const GChord cis6_1 = GChord("cis6", 9, [0, 0, 11, 11, 0, 11]);
  static const List<GChord> cis6 = [cis6_1];

  static const GChord cis7_1 = GChord("cis7", 4, [0, 0, 6, 5, 6, 0]);
  static const List<GChord> cis7 = [cis7_1];

  static const GChord cis9_1 = GChord("cis9", 0, [0, 4, 2, 4, 4, 0]);
  static const List<GChord> cis9 = [cis9_1];

  static const GChord Cis_1 = GChord("Cis", 1, [0, 4, 3, 0, 2, 0]);
  static const GChord Cis_2 = GChord("Cis", 4, [0, 0, 6, 6, 6, 0]);
  static const GChord Cis_3 = GChord("Cis", 9, [0, 0, 11, 11, 10, 0]);
  static const List<GChord> Cis = [Cis_1, Cis_2, Cis_3];

  static const GChord Cis0_1 = GChord("Cis0", 0, [0, 4, 3, 1, 1, 1]);
  static const List<GChord> Cis0 = [Cis0_1];

  static const GChord Cis6_1 = GChord("Cis6", 0, [0, 0, 3, 3, 2, 4]);
  static const List<GChord> Cis6 = [Cis6_1];

  static const GChord Cis7_1 = GChord("Cis7", 4, [0, 0, 6, 0, 6, 0]);
  static const List<GChord> Cis7 = [Cis7_1];

  static const GChord Cis9_1 = GChord("Cis9", 0, [0, 0, 6, 0, 6, 0]);
  static const List<GChord> Cis9 = [Cis9_1];

  static const List<List<GChord>> Cis_set = [Cis, Cis0, Cis6, Cis7, Cis9, cis, cis6, cis7, cis9];


  static const GChord d_1 = GChord("d", 0, [0, 0, 0, 2, 3, 1]);
  static const GChord d_2 = GChord("d", 5, [0, 0, 7, 7, 6, 0]);
  static const GChord d_3 = GChord("d", 10, [0, 12, 12, 0, 0, 0]);
  static const List<GChord> d = [d_1, d_2, d_3];

  static const GChord d6_1 = GChord("d6", 0, [0, 0, 0, 2, 0, 1]);
  static const List<GChord> d6 = [d6_1];

  static const GChord d7_1 = GChord("d7", 0, [0, 0, 0, 2, 1, 1]);
  static const GChord d7_2 = GChord("d7", 5, [0, 0, 7, 0, 6, 0]);
  static const List<GChord> d7 = [d7_1, d7_2];

  static const GChord d9_1 = GChord("d9", 0, [0, 0, 3, 2, 3, 0]);
  static const List<GChord> d9 = [d9_1];

  static const GChord D_1 = GChord("D", 0, [0, 0, 0, 2, 3, 2]);
  static const GChord D_2 = GChord("D", 5, [0, 0, 7, 7, 7, 0]);
  static const GChord D_3 = GChord("D", 10, [0, 12, 12, 11, 0, 0]);
  static const List<GChord> D = [D_1, D_2, D_3];

  static const GChord D0_1 = GChord("D0", 0, [0, 0, 4, 3, 2, 1]);
  static const List<GChord> D0 = [D0_1];

  static const GChord D6_1 = GChord("D6", 0, [0, 0, 0, 2, 0, 2]);
  static const List<GChord> D6 = [D6_1];

  static const GChord D7_1 = GChord("D7", 0, [0, 0, 0, 2, 1, 2]);
  static const GChord D7_2 = GChord("D7", 5, [0, 0, 7, 0, 7, 0]);
  static const List<GChord> D7 = [D7_1, D7_2];

  static const GChord D9_1 = GChord("D9", 0, [0, 0, 0, 2, 1, 0]);
  static const List<GChord> D9 = [D9_1];

  static const List<List<GChord>> D_set = [D, D0, D6, D7, D9, d, d6, d7, d9];


  static const GChord dis_1 = GChord("dis", 6, [0, 0, 8, 8, 7, 0]);
  static const GChord dis_2 = GChord("dis", 11, [0, 13, 13, 0, 0, 0]);
  static const List<GChord> dis = [dis_1, dis_2];

  static const GChord dis6_1 = GChord("dis6", 1, [0, 0, 0, 3, 0, 2]);
  static const List<GChord> dis6 = [dis6_1];

  static const GChord dis7_1 = GChord("dis7", 6, [0, 0, 8, 7, 8, 0]);
  static const List<GChord> dis7 = [dis7_1];

  static const GChord dis9_1 = GChord("dis9", 6, [0, 0, 8, 8, 0, 0]);
  static const List<GChord> dis9 = [dis9_1];

  static const GChord Dis_1 = GChord("Dis", 6, [0, 0, 8, 8, 8, 0]);
  static const GChord Dis_2 = GChord("Dis", 11, [0, 13, 13, 12, 0, 0]);
  static const List<GChord> Dis = [Dis_1, Dis_2];

  static const GChord Dis0_1 = GChord("Dis0", 6, [0, 0, 1, 3, 3, 3]);
  static const List<GChord> Dis0 = [Dis0_1];

  static const GChord Dis6_1 = GChord("Dis6", 0, [0, 0, 1, 3, 1, 3]);
  static const List<GChord> Dis6 = [Dis6_1];

  static const GChord Dis7_1 = GChord("Dis7", 0, [0, 0, 8, 0, 8, 0]);
  static const List<GChord> Dis7 = [Dis7_1];

  static const GChord Dis9_1 = GChord("Dis9", 0, [0, 0, 1, 0, 2, 1]);
  static const List<GChord> Dis9 = [Dis9_1];

  static const List<List<GChord>> Dis_set = [Dis, Dis0, Dis6, Dis7, Dis9, dis, dis6, dis7, dis9];

  static const GChord e_1 = GChord("e", 0, [0, 2, 2, 0, 0, 0]);
  static const GChord e_2 = GChord("e", 7, [0, 0, 9, 9, 8, 0]);
  static const List<GChord> e = [e_1, e_2];

  static const GChord e6_1 = GChord("e6", 0, [0, 2, 2, 0, 2, 0]);
  static const List<GChord> e6 = [e6_1];

  static const GChord e7_1 = GChord("e7", 0, [0, 2, 0, 0, 0, 0]);
  static const List<GChord> e7 = [e7_1];

  static const GChord e9_1 = GChord("e9", 0, [0, 2, 4, 0, 0, 0]);
  static const List<GChord> e9 = [e9_1];

  static const GChord E_1 = GChord("E", 0, [0, 2, 2, 1, 0, 0]);
  static const GChord E_2 = GChord("E", 7, [0, 0, 9, 9, 9, 0]);
  static const List<GChord> E = [E_1, E_2];

  static const GChord E0_1 = GChord("E0", 0, [0, 2, 1, 1, 0, 0]);
  static const List<GChord> E0 = [E0_1];

  static const GChord E6_1 = GChord("E6", 0, [0, 2, 2, 1, 2, 0]);
  static const List<GChord> E6 = [E6_1];

  static const GChord E7_1 = GChord("E7", 0, [0, 2, 0, 1, 0, 0]);
  static const List<GChord> E7 = [E7_1];

  static const GChord E9_1 = GChord("E9", 0, [0, 2, 0, 1, 0, 2]);
  static const List<GChord> E9 = [E9_1];

  static const List<List<GChord>> E_set = [E, E0, E6, E7, E9, e, e6, e7, e9];


  static const GChord f_1 = GChord("f", 1, [0, 3, 3, 0, 0, 0]);
  static const GChord f_2 = GChord("f", 8, [0, 0, 10, 10, 9, 0]);
  static const List<GChord> f = [f_1, f_2];

  static const GChord f6_1 = GChord("f6", 1, [0, 3, 3, 0, 3, 0]);
  static const List<GChord> f6 = [f6_1];

  static const GChord f7_1 = GChord("f7", 1, [0, 3, 0, 0, 0, 0]);
  static const List<GChord> f7 = [f7_1];

  static const GChord f9_1 = GChord("f9", 1, [0, 3, 3, 0, 0, 3]);
  static const List<GChord> f9 = [f9_1];

  static const GChord F_1 = GChord("F", 1, [0, 3, 3, 2, 0, 0]);
  static const GChord F_2 = GChord("F", 8, [0, 0, 10, 10, 10, 0]);
  static const List<GChord> F = [F_1, F_2];

  static const GChord F0_1 = GChord("F0", 0, [0, 0, 3, 2, 1, 0]);
  static const GChord F0_2 = GChord("F0", 0, [1, 0, 2, 2, 1, 0]);
  static const List<GChord> F0 = [F0_1, F0_2];

  static const GChord F6_1 = GChord("F6", 0, [0, 0, 3, 2, 3, 1]);
  static const List<GChord> F6 = [F6_1];

  static const GChord F7_1 = GChord("F7", 1, [0, 3, 0, 2, 0, 0]);
  static const List<GChord> F7 = [F7_1];

  static const GChord F9_1 = GChord("F9", 1, [0, 3, 0, 2, 0, 3]);
  static const List<GChord> F9 = [F9_1];

  static const List<List<GChord>> F_set = [F, F0, F6, F7, F9, f, f6, f7, f9];


  static const GChord fis_1 = GChord("fis", 2, [0, 4, 4, 0, 0, 0]);
  static const GChord fis_2 = GChord("fis", 9, [0, 0, 11, 11, 10, 0]);
  static const List<GChord> fis = [fis_1, fis_2];

  static const GChord fis6_1 = GChord("fis6", 2, [0, 4, 4, 0, 4, 0]);
  static const List<GChord> fis6 = [fis6_1];

  static const GChord fis7_1 = GChord("fis7", 2, [0, 4, 0, 0, 0, 0]);
  static const List<GChord> fis7 = [fis7_1];

  static const GChord fis9_1 = GChord("fis9", 2, [0, 4, 4, 0, 0, 4]);
  static const List<GChord> fis9 = [fis9_1];

  static const GChord Fis_1 = GChord("Fis", 2, [0, 4, 4, 3, 0, 0]);
  static const GChord Fis_2 = GChord("Fis", 9, [0, 0, 11, 11, 11, 0]);
  static const List<GChord> Fis = [Fis_1, Fis_2];

  static const GChord Fis0_1 = GChord("Fis0", 0, [2, 0, 3, 3, 2, 0]);
  static const List<GChord> Fis0 = [Fis0_1];

  static const GChord Fis6_1 = GChord("Fis6", 0, [2, 0, 1, 3, 2, 0]);
  static const List<GChord> Fis6 = [Fis6_1];

  static const GChord Fis7_1 = GChord("Fis7", 2, [0, 4, 0, 3, 0, 0]);
  static const List<GChord> Fis7 = [Fis7_1];

  static const GChord Fis9_1 = GChord("Fis9", 0, [0, 0, 4, 3, 5, 4]);
  static const List<GChord> Fis9 = [Fis9_1];

  static const List<List<GChord>> Fis_set = [Fis, Fis0, Fis6, Fis7, Fis9, fis, fis6, fis7, fis9];


  static const GChord g_1 = GChord("g", 3, [0, 5, 5, 0, 0, 0]);
  static const GChord g_2 = GChord("g", 10, [0, 0, 12, 12, 11, 0]);
  static const List<GChord> g = [g_1, g_2];

  static const GChord g6_1 = GChord("g6", 3, [0, 5, 5, 0, 5, 0]);
  static const List<GChord> g6 = [g6_1];

  static const GChord g7_1 = GChord("g7", 3, [0, 5, 0, 0, 0, 0]);
  static const List<GChord> g7 = [g7_1];

  static const GChord g9_1 = GChord("g9", 3, [0, 5, 5, 0, 0, 5]);
  static const List<GChord> g9 = [g9_1];

  static const GChord G_1 = GChord("G", 0, [3, 2, 0, 0, 3, 3]);
  static const GChord G_2 = GChord("G", 3, [0, 5, 5, 4, 0, 0]);
  static const GChord G_3 = GChord("G", 10, [0, 0, 12, 12, 12, 0]);
  static const List<GChord> G = [G_1, G_2, G_3];

  static const GChord G0_1 = GChord("G0", 0, [3, 2, 0, 0, 2, 0]);
  static const List<GChord> G0 = [G0_1];

  static const GChord G6_1 = GChord("G6", 0, [3, 2, 0, 0, 3, 0]);
  static const List<GChord> G6 = [G6_1];

  static const GChord G7_1 = GChord("G7", 0, [3, 2, 0, 0, 0, 1]);
  static const GChord G7_2 = GChord("G7", 3, [0, 5, 0, 4, 0, 0]);
  static const List<GChord> G7 = [G7_1, G7_2];

  static const GChord G9_1 = GChord("G9", 0, [3, 0, 0, 2, 0, 1]);
  static const List<GChord> G9 = [G9_1];

  static const List<List<GChord>> G_set = [G, G0, G6, G7, G9, g, g6, g7, g9];


  static const GChord gis_1 = GChord("gis", 4, [0, 6, 6, 0, 0, 0]);
  static const List<GChord> gis = [gis_1];

  static const GChord gis6_1 = GChord("gis6", 4, [0, 6, 6, 0, 6, 0]);
  static const List<GChord> gis6 = [gis6_1];

  static const GChord gis7_1 = GChord("gis7", 4, [0, 6, 0, 0, 0, 0]);
  static const List<GChord> gis7 = [gis7_1];

  static const GChord gis9_1 = GChord("gis9", 4, [0, 6, 6, 0, 0, 6]);
  static const List<GChord> gis9 = [gis9_1];

  static const GChord Gis_1 = GChord("Gis", 4, [0, 6, 6, 5, 0, 0]);
  static const List<GChord> Gis = [Gis_1];

  static const GChord Gis0_1 = GChord("Gis0", 0, [0, 0, 1, 1, 1, 3]);
  static const List<GChord> Gis0 = [Gis0_1];

  static const GChord Gis6_1 = GChord("Gis6", 0, [0, 0, 1, 1, 1, 1]);
  static const List<GChord> Gis6 = [Gis6_1];

  static const GChord Gis7_1 = GChord("Gis7", 4, [0, 6, 0, 5, 0, 0]);
  static const List<GChord> Gis7 = [Gis7_1];

  static const GChord Gis9_1 = GChord("Gis9", 0, [4, 0, 4, 3, 1, 0]);
  static const List<GChord> Gis9 = [Gis9_1];

  static const List<List<GChord>> Gis_set = [Gis, Gis0, Gis6, Gis7, Gis9, gis, gis6, gis7, gis9];


  static const GChord a_1 = GChord("a", 0, [0, 0, 2, 2, 1, 0]);
  static const GChord a_2 = GChord("a", 5, [0, 7, 7, 0, 0, 0]);
  static const List<GChord> a = [a_1, a_2];

  static const GChord a6_1 = GChord("a6", 0, [0, 0, 2, 2, 1, 2]);
  static const List<GChord> a6 = [a6_1];

  static const GChord a7_1 = GChord("a7", 0, [0, 0, 2, 0, 1, 0]);
  static const GChord a7_2 = GChord("a7", 5, [0, 7, 0, 0, 0, 0]);
  static const List<GChord> a7 = [a7_1, a7_2];

  static const GChord a9_1 = GChord("a9", 0, [0, 0, 2, 2, 0, 0]);
  static const List<GChord> a9 = [a9_1];

  static const GChord A_1 = GChord("A", 0, [0, 0, 2, 2, 2, 0]);
  static const GChord A_2 = GChord("A", 5, [0, 7, 7, 6, 0, 0]);
  static const List<GChord> A = [A_1, A_2];

  static const GChord A0_1 = GChord("A0", 0, [0, 0, 2, 1, 2, 0]);
  static const List<GChord> A0 = [A0_1];

  static const GChord A6_1 = GChord("A6", 0, [0, 0, 2, 2, 2, 2]);
  static const List<GChord> A6 = [A6_1];

  static const GChord A7_1 = GChord("A7", 0, [0, 0, 2, 0, 2, 0]);
  static const GChord A7_2 = GChord("A7", 5, [0, 7, 0, 6, 0, 0]);
  static const List<GChord> A7 = [A7_1, A7_2];

  static const GChord A9_1 = GChord("A9", 0, [0, 0, 2, 4, 2, 3]);
  static const List<GChord> A9 = [A9_1];

  static const List<List<GChord>> A_set = [A, A0, A6, A7, A9, a, a6, a7, a9];


  static const GChord b_1 = GChord("b", 1, [0, 0, 3, 3, 2, 0]);
  static const GChord b_2 = GChord("b", 6, [0, 8, 8, 0, 0, 0]);
  static const List<GChord> b = [b_1, b_2];

  static const GChord b6_1 = GChord("b6", 1, [0, 3, 3, 0, 3, 0]);
  static const List<GChord> b6 = [b6_1];

  static const GChord b7_1 = GChord("b7", 1, [0, 0, 3, 0, 2, 0]);
  static const List<GChord> b7 = [b7_1];

  static const GChord b9_1 = GChord("b9", 1, [0, 0, 3, 3, 0, 0]);
  static const List<GChord> b9 = [b9_1];

  static const GChord B_1 = GChord("B", 1, [0, 0, 3, 3, 3, 0]);
  static const GChord B_2 = GChord("B", 6, [0, 8, 8, 7, 0, 0]);
  static const List<GChord> B = [B_1, B_2];

  static const GChord B0_1 = GChord("B0", 1, [0, 0, 3, 2, 3, 0]);
  static const List<GChord> B0 = [B0_1];

  static const GChord B6_1 = GChord("B6", 0, [0, 1, 3, 3, 3, 3]);
  static const List<GChord> B6 = [B6_1];

  static const GChord B7_1 = GChord("B7", 1, [0, 0, 3, 0, 3, 0]);
  static const GChord B7_2 = GChord("B7", 6, [0, 8, 0, 7, 0, 0]);
  static const List<GChord> B7 = [B7_1, B7_2];

  static const GChord B9_1 = GChord("B9", 0, [0, 1, 0, 1, 1, 1]);
  static const List<GChord> B9 = [B9_1];

  static const List<List<GChord>> B_set = [B, B0, B6, B7, B9, b, b6, b7, b9];


  static const GChord h_1 = GChord("h", 2, [0, 0, 4, 4, 3, 0]);
  static const GChord h_2 = GChord("h", 7, [0, 9, 9, 0, 0, 0]);
  static const List<GChord> h = [h_1, h_2];

  static const GChord h6_1 = GChord("h6", 7, [0, 9, 9, 0, 9, 0]);
  static const List<GChord> h6 = [h6_1];

  static const GChord h7_1 = GChord("h7", 2, [0, 0, 4, 0, 3, 0]);
  static const GChord h7_2 = GChord("h7", 7, [0, 9, 0, 0, 0, 0]);
  static const List<GChord> h7 = [h7_1, h7_2];

  static const GChord h9_1 = GChord("h9", 0, [0, 2, 0, 2, 2, 2]);
  static const List<GChord> h9 = [h9_1];

  static const GChord H_1 = GChord("H", 2, [0, 0, 4, 4, 4, 0]);
  static const GChord H_2 = GChord("H", 7, [0, 9, 9, 8, 0, 0]);
  static const List<GChord> H = [H_1, H_2];

  static const GChord H0_1 = const GChord("H0", 0, [2, 2, 1, 4, 0, 0]);
  static const List<GChord> H0 = const [H0_1];

  static const GChord H6_1 = const GChord("H6", 0, [2, 2, 1, 1, 0, 0]);
  static const List<GChord> H6 = const [H6_1];

  static const GChord H7_1 = const GChord("H7", 0, [0, 2, 1, 2, 0, 2]);
  static const GChord H7_2 = const GChord("H7", 2, [0, 0, 4, 0, 4, 0]);
  static const GChord H7_3 = const GChord("H7", 7, [0, 9, 0, 8, 0, 0]);
  static const List<GChord> H7 = const [H7_1, H7_2, H7_3];

  static const GChord H9_1 = const GChord("H9", 0, [0, 2, 1, 2, 2, 2]);
  static const List<GChord> H9 = const [H9_1];

  static const List<List<GChord>> H_set = const [H, H0, H6, H7, H9, h, h6, h7, h9];

  static const Map<String, List<GChord>> chordDrawableMap = {
    "c" :c,
    "c6" :c6,
    "c7" :c7,
    "c9" :c9,
    "C" :C,
    "C0" :C0,
    "C6" :C6,
    "C7" :C7,
    "C9" :C9,
    "cis" :cis,
    "cis6" :cis6,
    "cis7" :cis7,
    "cis9" :cis9,
    "Cis" :Cis,
    "Cis0" :Cis0,
    "Cis6" :Cis6,
    "Cis7" :Cis7,
    "Cis9" :Cis9,
    "d" :d,
    "d6" :d6,
    "d7" :d7,
    "d9" :d9,
    "D" :D,
    "D0" :D0,
    "D6" :D6,
    "D7" :D7,
    "D9" :D9,
    "dis" :dis,
    "dis6" :dis6,
    "dis7" :dis7,
    "dis9" :dis9,
    "Dis" :Dis,
    "Dis0" :Dis0,
    "Dis6" :Dis6,
    "Dis7" :Dis7,
    "Dis9" :Dis9,
    "e" :e,
    "e6" :e6,
    "e7" :e7,
    "e9" :e9,
    "E" :E,
    "E0" :E0,
    "E6" :E6,
    "E7" :E7,
    "E9" :E9,
    "f" :f,
    "f6" :f6,
    "f7" :f7,
    "f9" :f9,
    "F" :F,
    "F0" :F0,
    "F6" :F6,
    "F7" :F7,
    "F9" :F9,
    "fis" :fis,
    "fis6" :fis6,
    "fis7" :fis7,
    "fis9" :fis9,
    "Fis" :Fis,
    "Fis0" :Fis0,
    "Fis6" :Fis6,
    "Fis7" :Fis7,
    "Fis9" :Fis9,
    "g" :g,
    "g6" :g6,
    "g7" :g7,
    "g9" :g9,
    "G" :G,
    "G0" :G0,
    "G6" :G6,
    "G7" :G7,
    "G9" :G9,
    "gis" :gis,
    "gis6" :gis6,
    "gis7" :gis7,
    "gis9" :gis9,
    "Gis" :Gis,
    "Gis0" :Gis0,
    "Gis6" :Gis6,
    "Gis7" :Gis7,
    "Gis9" :Gis9,
    "a" :a,
    "a6" :a6,
    "a7" :a7,
    "a9" :a9,
    "A" :A,
    "A0" :A0,
    "A6" :A6,
    "A7" :A7,
    "A9" :A9,
    "b" :b,
    "b6" :b6,
    "b7" :b7,
    "b9" :b9,
    "B" :B,
    "B0" :B0,
    "B6" :B6,
    "B7" :B7,
    "B9" :B9,
    "h" :h,
    "h6" :h6,
    "h7" :h7,
    "h9" :h9,
    "H" :H,
    "H0" :H0,
    "H6" :H6,
    "H7" :H7,
    "H9" :H9,
  };

  static const int CHORD_SET_C = 0;
  static const int CHORD_SET_Cis = 1;
  static const int CHORD_SET_D = 2;
  static const int CHORD_SET_Dis = 3;
  static const int CHORD_SET_E = 4;
  static const int CHORD_SET_F = 5;
  static const int CHORD_SET_Fis = 6;
  static const int CHORD_SET_G = 7;
  static const int CHORD_SET_Gis = 8;
  static const int CHORD_SET_A = 9;
  static const int CHORD_SET_B = 10;
  static const int CHORD_SET_H = 11;

  static List<List<GChord>> getChordSet(final int set){
    switch (set){
      case CHORD_SET_C: return C_set;
      case CHORD_SET_Cis: return Cis_set;
      case CHORD_SET_D: return D_set;
      case CHORD_SET_Dis: return Dis_set;
      case CHORD_SET_E: return E_set;
      case CHORD_SET_F: return F_set;
      case CHORD_SET_Fis: return Fis_set;
      case CHORD_SET_G: return G_set;
      case CHORD_SET_Gis: return Gis_set;
      case CHORD_SET_A: return A_set;
      case CHORD_SET_B: return B_set;
      case CHORD_SET_H: return H_set;
      default: return null;
    }
  }

  static GChord getChord(final int set, final int group, final int position){
    List<List<GChord>> chordSet = getChordSet(set);
    List<GChord> chordGroup = chordSet[group];
    return chordGroup[position];
  }

  const GChord(String name, int bar, List<int> strings) : super(name, bar, strings);

  @override
  GChord shiftToFirstDot(){
    int pos = nearestDotPosition - 1;
    return GChord(
        name,
        bar==0?0:bar-pos,
        [max(0, strings[0]-pos),
          max(0, strings[1]-pos),
          max(0, strings[2]-pos),
          max(0, strings[3]-pos),
          max(0, strings[4]-pos),
          max(0, strings[5]-pos)
        ]);
  }
}

class UChord extends Chord {

  static const UChord empty = null;

  static const UChord c =  UChord("c", 0, [0, 3, 3, 3]);
  static const UChord C =  UChord("C", 0, [0, 0, 0, 3]);
  static const UChord cis =  UChord("cis", 0, [ 5, 3, 3, 3]);
  static const UChord Cis =  UChord("Cis", 0, [ 1, 1, 1, 4]);
  static const UChord d =  UChord("d", 0, [ 2, 2, 1, 0]);
  static const UChord D =  UChord("D", 0, [ 2, 2, 2, 0]);
  static const UChord dis =  UChord("dis", 0, [ 3, 3, 2, 1]);
  static const UChord Dis =  UChord("Dis", 0, [ 0, 3, 3, 1]);
  static const UChord e =  UChord("e", 0, [ 0, 4, 3, 2]);
  static const UChord E =  UChord("E", 0, [ 4, 4, 4, 2]);
  static const UChord f =  UChord("f", 0, [ 1, 0, 1, 3]);
  static const UChord F =  UChord("F", 0, [ 2, 0, 1, 0]);
  static const UChord fis =  UChord("fis", 0, [ 2, 1, 2, 0]);
  static const UChord Fis =  UChord("Fis", 0, [ 3, 1, 2, 1]);
  static const UChord g =  UChord("g", 0, [ 0, 2, 3, 1]);
  static const UChord G =  UChord("G", 0, [ 0, 2, 3, 2]);
  static const UChord gis =  UChord("gis", 0, [ 4, 3, 4, 2]);
  static const UChord Gis =  UChord("Gis", 0, [ 5, 3, 4, 3]);
  static const UChord a =  UChord("a", 0, [ 2, 0, 0, 0]);
  static const UChord A =  UChord("A", 0, [ 2, 1, 0, 0]);
  static const UChord b =  UChord("b", 0, [ 3, 1, 1, 1]);
  static const UChord B =  UChord("B", 0, [ 3, 2, 1, 1]);
  static const UChord h =  UChord("h", 0, [ 4, 2, 2, 2]);
  static const UChord H =  UChord("H", 0, [ 4, 3, 2, 2]);

  static const int CHORD_SET_C = 0;
  static const int CHORD_SET_Cis = 1;
  static const int CHORD_SET_D = 2;
  static const int CHORD_SET_Dis = 3;
  static const int CHORD_SET_E = 4;
  static const int CHORD_SET_F = 5;
  static const int CHORD_SET_Fis = 6;
  static const int CHORD_SET_G = 7;
  static const int CHORD_SET_Gis = 8;
  static const int CHORD_SET_A = 9;
  static const int CHORD_SET_B = 10;
  static const int CHORD_SET_H = 11;

  static const Map<String, UChord> chordDrawableMap = {
    "c" :c,
    "C" :C,
    "cis" :cis,
    "Cis" :Cis,
    "d" :d,
    "D" :D,
    "dis" :dis,
    "Dis" :Dis,
    "e" :e,
    "E" :E,
    "f" :f,
    "F" :F,
    "fis" :fis,
    "Fis" :Fis,
    "g" :g,
    "G" :G,
    "gis" :gis,
    "Gis" :Gis,
    "a" :a,
    "A" :A,
    "b" :b,
    "B" :B,
    "h" :h,
    "H" :H,
  };

  const UChord(String name, int bar, List<int> strings) : super(name, bar, strings);

  @override
  UChord shiftToFirstDot(){
    int pos = nearestDotPosition - 1;

    return UChord(
        name,
        bar==0?0:bar-pos,
        [max(0, strings[0]-pos),
          max(0, strings[1]-pos),
          max(0, strings[2]-pos),
          max(0, strings[3]-pos)
    ]);
  }
}

class EmptyChord extends Chord{

  const EmptyChord() : super('', 0, const [0, 0, 0, 0, 0, 0]);

  @override
  int get nearestDotPosition {
    return 0;
  }

  @override
  Chord shiftToFirstDot() {
    return EmptyChord();
  }

}