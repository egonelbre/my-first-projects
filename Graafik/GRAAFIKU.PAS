program graafikud;

uses graph,crt;

type Node = ^NodePtr;
     NodePtr = Record
                 vasak, vanem, parem:Node;
                 st:string;
               end;
const eps=0.0001;
var   Driver,Mode: Integer; aste:real;
      st,st2:string;
      alg,lopp,y_min,y_max:real;
      esc:char;
      auto:boolean;
{----------------------------------------------------------------------------}
function iskeypressed :boolean;
 begin
  iskeypressed:=((MEM[$40:17] AND $0F)>0) or (MEM[$40:$18] > 0) or KEYPRESSED;
  {iskeypressed:=false;}
 end;

function astenda(a,n:integer):real;
var abi:real;i:integer;
 begin
  abi:=a;
  for i:=1 to n-1 do abi:=abi*a;
  astenda:=abi;
 end;

function make_tree(avaldis:string; ulemine:node):node;
 var abi_st1,abi_st2,abi_av:string;
     abi:node;
     i,br:shortint; err:boolean;
 begin
  new(abi);
  abi^.vanem:=ulemine;
  repeat
  abi_av:=avaldis;
   if (avaldis[1]='(') and (avaldis[length(avaldis)]=')')
      then
       begin
         err:=true;
         i:=1;
         br:=0;
         repeat
               inc(i);
               if abi_av[i]='(' then br:=br+1;if abi_av[i]=')' then br:=br-1;
               if br<0 then err:=false;
         until not err or (i>length(avaldis)-2);
         if err then avaldis:=copy(avaldis,2,length(avaldis)-2);
       end
    else err:=false;
   until not err;

   br:=0;
   i:=0;
   repeat
     inc(i);
     if abi_av[i]='(' then br:=br+1;
     if abi_av[i]=')' then br:=br-1;
     if br<>0 then abi_av[i]:=' ';
   until i>length(avaldis)-1;

        if pos('+',abi_av)>0 then
              begin
               i:=pos('+',abi_av);
               abi^.st:='+';
               abi_st1:=copy(avaldis,1,i-1);
               abi_st2:=copy(avaldis,i+1,length(avaldis)-i);
               abi^.vasak:=make_tree(abi_st1,abi);
               abi^.parem:=make_tree(abi_st2,abi);
              end
        else
        if pos('-',abi_av)>0 then
              begin
               i:=pos('-',abi_av);
               abi^.st:='-';
               abi_st1:=copy(avaldis,1,i-1);
               abi_st2:=copy(avaldis,i+1,length(avaldis)-i);
               abi^.vasak:=make_tree(abi_st1,abi);
               abi^.parem:=make_tree(abi_st2,abi);
              end
        else
        if pos('*',abi_av)>0 then
              begin
               i:=pos('*',abi_av);
               abi^.st:='*';
               abi_st1:=copy(avaldis,1,i-1);
               abi_st2:=copy(avaldis,i+1,length(avaldis)-i);
               abi^.vasak:=make_tree(abi_st1,abi);
               abi^.parem:=make_tree(abi_st2,abi);
              end
        else
        if pos('/',abi_av)>0 then
              begin
               i:=pos('/',abi_av);
               abi^.st:='/';
               abi_st1:=copy(avaldis,1,i-1);
               abi_st2:=copy(avaldis,i+1,length(avaldis)-i);
               abi^.vasak:=make_tree(abi_st1,abi);
               abi^.parem:=make_tree(abi_st2,abi);
              end
        else
         if pos('s',abi_av)>0 then
              begin
               i:=pos('s',abi_av);
               abi^.st:='s';
               abi_st1:=copy(avaldis,3,length(avaldis)-3);
               abi^.vasak:=make_tree(abi_st1,abi);
               abi^.parem:=nil;
              end
        else
         if pos('c',abi_av)>0 then
              begin
               i:=pos('c',abi_av);
               abi^.st:='c';
               abi_st1:=copy(avaldis,3,length(avaldis)-3);
               abi^.vasak:=make_tree(abi_st1,abi);
               abi^.parem:=nil;
              end
        else
         if pos('t',abi_av)>0 then
              begin
               i:=pos('t',abi_av);
               abi^.st:='t';
               abi_st1:=copy(avaldis,3,length(avaldis)-3);
               abi^.vasak:=make_tree(abi_st1,abi);
               abi^.parem:=nil;
              end
        else
         if pos('a',abi_av)>0 then
              begin
               i:=pos('a',abi_av);
               abi^.st:='a';
               abi_st1:=copy(avaldis,3,length(avaldis)-3);
               abi^.vasak:=make_tree(abi_st1,abi);
               abi^.parem:=nil;
              end
        else
         if pos('r',abi_av)>0 then
              begin
               i:=pos('r',abi_av);
               abi^.st:='r';
               abi_st1:=copy(avaldis,3,length(avaldis)-3);
               abi^.vasak:=make_tree(abi_st1,abi);
               abi^.parem:=nil;
              end
        else
         if pos('u',abi_av)>0 then
              begin
               i:=pos('u',abi_av);
               abi^.st:='u';
               abi_st1:=copy(avaldis,3,length(avaldis)-3);
               abi^.vasak:=make_tree(abi_st1,abi);
               abi^.parem:=nil;
              end
        else
         if pos('j',abi_av)>0 then
              begin
               i:=pos('j',abi_av);
               abi^.st:='j';
               abi_st1:=copy(avaldis,3,length(avaldis)-3);
               abi^.vasak:=make_tree(abi_st1,abi);
               abi^.parem:=nil;
              end
        else
         if pos('l',abi_av)>0 then
              begin
               i:=pos('l',abi_av);
               abi^.st:='l';
               abi_st1:=copy(avaldis,3,length(avaldis)-3);
               abi_st2:=copy(abi_st1,pos(',',abi_st1)+1,
                                     length(avaldis)-pos(',',abi_st1));
               abi_st1:=copy(abi_st1,1,pos(',',abi_st1)-1);
               abi^.vasak:=make_tree(abi_st1,abi);
               abi^.parem:=make_tree(abi_st2,abi);
              end
        else
              begin
               abi^.st:=avaldis;
               abi^.vasak:=nil;
               abi^.parem:=nil;
              end;
  make_tree:=abi;
 end;

function evaluate(sisse:node;x:real;var err:boolean):real;
 var n:real;kood:integer; T1,T2,jag:real; err_temp:boolean;
 begin
  err_temp:=false;
  if (sisse^.vasak=nil) and (sisse^.parem=nil) then
    begin
     if sisse^.st='x' then evaluate:=x
      else
       begin
         val(sisse^.st,n,kood);
         if kood=0 then evaluate:=n else evaluate:=0;
       end;
    end
    else
      begin
         T1:=evaluate(sisse^.vasak,x,err_temp);
         if sisse^.parem<>nil then T2:=evaluate(sisse^.parem,x,err_temp) else T2:=0;
         case sisse^.st[1] of
          '+':evaluate:=T1+T2;
          '-':evaluate:=T1-T2;
          '*':evaluate:=T1*T2;
          '/':
             begin
               if abs(T2)<eps then
                  begin
                    err_temp:=true;
                    if T2<0 then T2:=-0.001 else T2:=0.001;
                  end;
               evaluate:=T1/T2;
             end;
          's':evaluate:=sin(T1);
          'a':evaluate:=abs(T1);
          'c':evaluate:=cos(T1);
          'r':evaluate:=random(abs(round(T1)));
          'u':evaluate:=round(T1);
          't':
             begin
               jag:=cos(T1);
               if abs(jag)<eps then
                  begin
                    err_temp:=true;
                    if cos(T1)<0 then jag:=-0.001 else jag:=0.001;
                  end;
               evaluate:=sin(T1)/jag;
             end;
          'l':
             begin
               if (T1<eps) or ((T1>1-eps) and (T1<1+eps)) or (T2<eps)then
                begin
                 err_temp:=true;
                 evaluate:=0;
                end
                 else
                begin
                 evaluate:=ln(T2)/ln(T1);
                end;
              end;
          'j':if T1>=0 then evaluate:=sqrt(T1) else err_temp:=true;
         end;
      end;
    err:=err_temp;
 end;

procedure delete_tree(abi:node);
 begin
  if (abi^.vasak=nil) and (abi^.parem=nil)
     then dispose(abi)
     else
       begin
        delete_tree(abi^.vasak);
        if abi^.parem<>nil then delete_tree(abi^.parem);
        dispose(abi);
       end;
 end;

 procedure tee_graafik(funkts,funkts2:string;x0,y0,x1,y1,x_alg,x_lopp,
                       y_min,y_max:real;auto:boolean;col:word);
  const step=50;
  var root:node;
      fmax,fmin,fdelta:real;
      x,y,yu,delta,xdelta,abi_y:real;
      ekr_x,ekr_y,h,l,a:real;
      err:boolean;
      i:integer; abi_st:string;
 begin
  root:=make_tree(funkts,nil);
  setcolor(white);
  rectangle(round(x0),round(y0),round(x1),round(y1));
  y0:=y0+1;
  y1:=y1-1;
  x:=x_alg;
  delta:=(x_lopp-x_alg)/((x1-x0)*aste);
  if auto then
    begin
      fmax:=evaluate(root,x,err);
      fmin:=fmax;
        while x<=x_lopp do
           begin
            x:=x+delta;
            yu:=evaluate(root,x,err);
            if ((abs((y-yu)/delta)<200)) and (not (err)) then
                begin
                 if (fmax<yu) then fmax:=yu;
                 if (fmin>yu) then fmin:=yu;
                end;
            y:=yu;
           end;
      if abs(fmax-fmin)<eps then
        begin
          fmin:=y_min;
          fmax:=y_max
        end;
    end
   else
    begin
     fmin:=y_min;
     fmax:=y_max;
    end;
  delta:=(x_lopp-x_alg)/(aste*(x1-x0));
  xdelta:=x_lopp-x_alg;
  fdelta:=fmax-fmin;
  h:=y1-y0;
  x:=x_alg;
  l:=x1-x0;
  ekr_y:=y0+(h/fdelta)*(fmax-evaluate(root,x,err));
  x:=x+delta*aste;
  ekr_x:=x0;

  setcolor(lightblue);
  while x<x_lopp do
   begin
    if (not(err)) and ((ekr_y<y1) and (ekr_y>y0))
         then putpixel(round(ekr_x),round(ekr_y),col);
    x:=x+delta;
    y:=evaluate(root,x,err);
    ekr_y:=y0+(h/fdelta)*(fmax-y);
    ekr_x:=x0+l/xdelta*(x-x_alg);
    if iskeypressed then exit;
   end;
  delete_tree(root);
  if funkts2<>'' then
    begin
  root:=make_tree(funkts2,nil);
  x:=x_alg;
  ekr_y:=y0+(h/fdelta)*(fmax-evaluate(root,x,err));
  x:=x+delta*aste;
  ekr_x:=x0;
  setcolor(cyan);
  while x<x_lopp do
   begin
    if (not(err)) and ((ekr_y<y1) and (ekr_y>y0)) then
                      putpixel(round(ekr_x),round(ekr_y),9)
                else
                     if ekr_y>=0 then ekr_y:=y0 else ekr_y:=y1;
    x:=x+delta;
    y:=evaluate(root,x,err);
    ekr_y:=y0+(h/fdelta)*(fmax-y);
    ekr_x:=x0+l/xdelta*(x-x_alg);
    if iskeypressed then exit;
   end;
  delete_tree(root);
  end;
  SetTextStyle(DefaultFont, HorizDir, 1);
  setcolor(cyan);
  if (x_alg<=0) and (x_lopp>=0) then a:=x0+l/xdelta*(-x_alg) else a:=x0+1;
    setcolor(8);
    i:=step;
    while a+i<x1 do i:=i+step;
    i:=i-step;
    while a+i>x0 do
     begin
      setcolor(8);
      line(round(a+i),round(y0),round(a+i),round(y1));
      abi_y:=x_alg+((a+i)-x0)*xdelta/l;
      str(abi_y:5:1,abi_st);
      setcolor(red);
      outtextxy(round(a+i-step/2),round(y0),abi_st);
      i:=i-step;
     end;
    i:=step;
    setcolor(cyan);
    line(round(a),round(y0),round(a),round(y1));

  if (fmax>=0) and (fmin<=0) then a:=y0+(h/fdelta)*fmax else a:=y0+1;
    i:=step;
    setcolor(8);
    while a+i<y1 do i:=i+step;
    i:=i-step;
    while a+i>y0 do
     begin
      setcolor(8);
      line(round(x0)+1,round(a+i),round(x1)-1,round(a+i));
      abi_y:=fmax+(y0-(a+i))*fdelta/h;
      str(abi_y:5:1,abi_st);
      setcolor(red);
      outtextxy(round(x0),round(a+i),abi_st);
      i:=i-step;
     end;
    setcolor(cyan);
    line(round(x0)+1,round(a),round(x1)-1,round(a));

 end;

 procedure teisenda(tekst:string; var arv:real);
 var abi:string; code:integer; abiarv1,abiarv2:integer;
 begin
  abiarv1:=0;abiarv2:=0;
  if pos('.',tekst)=0 then val(tekst,abiarv1,code) else
   begin
     abi:=copy(tekst,0,pos('.',tekst)-1);
     val(abi,abiarv1,code);
     abi:=copy(tekst,pos('.',tekst)+1,length(tekst)-pos('.',tekst));
     val(abi,abiarv2,code);
   end;
  if pos('.',tekst)=0 then arv:=abiarv1
                      else arv:=abiarv1+abiarv2/astenda(10,length(abi));
 end;

 procedure draw_menu(x0,y0,x1,y1:integer;var st,st2:string;
                     var aste:real;var x_alg,x_lopp:real;
                     var y_min,y_max:real; var auto:boolean);
  type menut=record
              st:string[28];
              valitud:boolean;
            end;
  var i:integer;
     menu : array [1..8] of menut;
     menu_empty: array [1..1] of menut;
     ch:char; u:byte; abi_st3:string;
     abi_nr:real;
     err:integer;

  procedure loe(x0,y0:integer;var st:string);
       const lubatud=['x','u','s','r','c','t','j','a','(',')','0'..'9','.',
                      '+','-','*','/','l',','];
       var tekst:string; taht:char;
   begin
     tekst:=st;
     while true do
       begin
         if keypressed then
           begin
            taht:=readkey;
            begin
            if (not(taht in [#8,#27,#13])) and (taht in lubatud)
                       then tekst:=tekst+taht;
            if (taht=#8) and (tekst<>'') then
              begin
                setcolor(blue);
                outtextxy(x0,y0,'//'+tekst);
                delete(tekst,length(tekst),1);
                setcolor(red);
                outtextxy(x0,y0,'//'+tekst);
              end;
            if taht=#13 then
                            begin
                              st:=tekst;
                              exit;
                            end;
           end;
           end;
       setcolor(red);
       outtextxy(x0,y0,'//'+tekst);
     end;
   end;

  procedure out_menu(menu:array of menut;n:integer);
    var i:integer; abi_st,abi_st2:string;
     begin
        SetFillStyle(1, Blue);
        bar(x0,y0,x1,y1);
        setcolor(white);
        rectangle(x0,y0,x1,y1);
        outtextxy(x0+5,y0+5,'y='+st);
        str(aste:7:2,abi_st);
        outtextxy(x0+5,y0+15,'aste='+abi_st);
        str(x_alg:5:2,abi_st);
        str(x_lopp:5:2,abi_st2);
        outtextxy(x0+5,y0+25,'piirkond=['+abi_st+';'+abi_st2+']');
        str(y_min:5:2,abi_st);
        str(y_max:5:2,abi_st2);
        outtextxy(x0+5,y0+35,'m„„ramispiirkond=['+abi_st+';'+abi_st2+']');
        if auto then  outtextxy(x0+5,y0+45,'auto=sees') else
                      outtextxy(x0+5,y0+45,'auto=v„ljas');
        outtextxy(x0+5,y0+55,'y2='+st2);
        for i:=0 to n-1 do
           begin
             if menu[i].valitud then setcolor(red) else setcolor(yellow);
             outtextxy(x0+5,y0+65+i*(textheight(st)+1),menu[i].st);
           end;
     end;

   begin
    menu[1].st:='Sisesta graafik';
    menu[2].st:='Sisesta aste';
    menu[3].st:='Sisesta piirkond';
    menu[4].st:='Sisesta m„„ramispiirkond';
    menu[5].st:='Automaatne m„„ramispiirkond';
    menu[6].st:='Sisesta teine graafik';
    menu[7].st:='Tagasi';
    menu[8].st:='V„lju';
    menu[1].valitud:=true;
    menu_empty[1].st:='';
    menu_empty[1].valitud:=false;
    for i:=2 to 8 do menu[i].valitud:=false;
    u:=1;
    repeat
      out_menu(menu,8);
      repeat
         ch:=readkey;
        case ch of
         #72:if u>1 then
             begin
               menu[u].valitud:=false;
               u:=u-1;
               menu[u].valitud:=true;
             end;
         #80:if u<8 then
             begin
               menu[u].valitud:=false;
               u:=u+1;
               menu[u].valitud:=true;
             end;
         #27:exit;
        end;
        out_menu(menu,8);
      until ch=#13;
      case u of
       1: begin
            out_menu(menu_empty,1);
            abi_st3:='s( )=sin( )      c( )=cos( )  t( )=tan( )';
            outtextxy(x0+5,y0+80,abi_st3);
            abi_st3:='a( )=absolute( ) j( )=sqrt( ) r( )=random( )';
            outtextxy(x0+5,y0+90,abi_st3);
            abi_st3:='l( , )=log( , )  u( )=round( )';
            outtextxy(x0+5,y0+100,abi_st3);
            abi_st3:=st;
            loe(x0+5,y0+70,abi_st3);
            st:=abi_st3;
          end;
       2: begin
            out_menu(menu_empty,1);
            str(aste:6:0,abi_st3);
            loe(x0+5,y0+70,abi_st3);
            val(abi_st3,abi_nr,err);
            aste:=abi_nr;
          end;
       3: begin
            out_menu(menu_empty,1);
            str(x_alg:6:0,abi_st3);
            loe(x0+5,y0+70,abi_st3);
            val(abi_st3,abi_nr,err);
            x_alg:=abi_nr;
            str(x_lopp:6:0,abi_st3);
            loe(x0+5,y0+85,abi_st3);
            val(abi_st3,abi_nr,err);
            x_lopp:=abi_nr;
          end;
       4: begin
            out_menu(menu_empty,1);
            str(y_min:6:0,abi_st3);
            loe(x0+5,y0+70,abi_st3);
            val(abi_st3,abi_nr,err);
            y_min:=abi_nr;
            str(y_max:6:0,abi_st3);
            loe(x0+5,y0+85,abi_st3);
            val(abi_st3,abi_nr,err);
            y_max:=abi_nr;
          end;
       5: begin
           auto:=not(auto);
          end;
       6: begin
            out_menu(menu_empty,1);
            abi_st3:='s( )=sin( )      c( )=cos( )  t( )=tan( )';
            outtextxy(x0+5,y0+80,abi_st3);
            abi_st3:='a( )=absolute( ) j( )=sqrt( ) r( )=random( )';
            outtextxy(x0+5,y0+90,abi_st3);
            abi_st3:='l( , )=log( , )  u( )=round( )';
            outtextxy(x0+5,y0+100,abi_st3);
            abi_st3:=st2;
            loe(x0+5,y0+70,abi_st3);
            st2:=abi_st3;
          end;
       8: halt;
       end;
    until u=7;
   end;

begin
    clrscr;
    Driver := Detect;
    InitGraph(Driver, Mode,'');
    if GraphResult <> grOk then halt(1);
    randomize;
    aste:=100;
    alg:=-10;
    lopp:=10;
    auto:=true;
    y_min:=-10;
    y_max:=10;
    st:='(x*x*x)/(4*x-2)';
    st2:='';
    repeat
      tee_graafik(st,st2,0,0,getmaxx,getmaxy,alg,lopp,y_min,y_max,auto,10);
      repeat
        esc:=readkey;
      until esc=#27;
      draw_menu(10,10,400,200,st,st2,aste,alg,lopp,y_min,y_max,auto);
      clearviewport;
    until false;
    closegraph;
end.