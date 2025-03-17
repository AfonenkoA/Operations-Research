settings.outformat="svg";

import graph;
size(150,250);
pen p = opacity(0);
dot((0,0),p);
dot((300,500),p);
pen thin=linewidth(0.5*linewidth());
xaxis("$x$",BottomTop,black,
      LeftTicks(begin=false,
                end=false,
                extend=true,
                ptick=thin));
yaxis("$y$",LeftRight,black,
      RightTicks(begin=false,
                 end=false,
                 extend=true,
                 ptick=thin));
