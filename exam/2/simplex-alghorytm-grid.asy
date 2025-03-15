settings.outformat="svg";

import graph;
size(300,300);
pen p = opacity(0);
dot((0,0),p);
dot((7,7),p);
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
