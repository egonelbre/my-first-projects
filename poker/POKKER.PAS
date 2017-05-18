{0=2  1=3  2=4  3=5  4=6  5=7  6=8  7=9  8=10  9=J  10=Q  11=K  12=A}
program pokker;
 uses crt,graph,mouse;
 const crd: record w,h:integer end =(w:32;h:40);
       cheatmode=false;
 type card=record
           v:shortint;
           m:shortint;
          end;
      cursor=record x,y:integer end;
      tab=array [0..4,0..4] of shortint;

 var Driver,Mode: Integer;
     deck: array[0..51] of card;
     i,i2,n:shortint;
     ch:char;
     temp_rida: array[0..4] of shortint;
     punkte:integer;
     st,st2:string;
     screen:boolean;
     laud: tab;
     cur,hiir:cursor;
     scr:boolean;
     nobutton:boolean;
     x:integer;

  procedure swap(var a,b: card);
     var c:card;   begin c:=a; a:=b; b:=c; end;

  procedure scramble(var ab: array of card);
   var i:shortint; begin for i:=0 to 51 do swap(ab[i],ab[random(51)]); end;

  procedure init_deck(var ab: array of card);
   var i:shortint;
   begin
    for i:=0 to 51 do
     begin
       ab[i].v:=(i+4) div 4;
       ab[i].m:=(i+4) mod 4;
     end;
   end;

  procedure draw_card(ab: card;x,y:integer);
   const mast:array[0..3] of char = (#3,#4,#5,#6);
   var st:string;
    begin
     SetFillStyle(1, white);
     setcolor(white);
     bar(x,y,x+crd.w,y+crd.h);
     setcolor(blue);
     rectangle(x,y,x+crd.w,y+crd.h);
     SetTextStyle(DefaultFont, HorizDir, 1);
     case ab.v of
      0..9: str(ab.v+1,st);
        10: st:='J';
        11: st:='Q';
        12: st:='K';
        13: st:='A';
      end;
     setcolor(black);
     outtextxy(x+2,y+2,st);
     outtextxy(x+crd.w-textwidth(st),
               y+crd.h-textheight('A'),st);
     if ab.m in [0,1] then setcolor(red) else setcolor(Black);

     outtextxy(x+2,y+4+textheight(st),mast[ab.m]);
     outtextxy(x+crd.w-textwidth('A'),
               y+crd.h-2-2*textheight('A'),mast[ab.m]);
   end;

{bleh olemas}
 function calc_points(temp:array of shortint;diag:boolean):integer;
  var tabel: array[0..13] of shortint; points:integer;
  begin
    points:=0;
    for i:=0 to 13 do tabel[i]:=0;
    for i:=0 to 4 do if temp[i]>=0 then tabel[temp[i]]:=tabel[temp[i]]+1;
    for i:=0 to 13 do
         case tabel[i] of
          2: points:=points+10;
          3: points:=points+40;
          4: points:=points+160;
         end;
    if points=50 then points:=80;
    if (tabel[13]=3) and (tabel[12]=2) then points:=100;
    for i:=0 to 9 do if (tabel[i]=1) and (tabel[i+1]=1)
                    and (tabel[i+2]=1) and (tabel[i+3]=1) and (tabel[i+4]=1)
                    then points:=50;
    if (tabel[13]=1) and (tabel[12]=1) and (tabel[11]=1) and (tabel[10]=1) and (tabel[9]=1) then points:=150;
    if tabel[13]=4 then points:=200;
    if diag and (points>0) then points:=points+10;
    calc_points:=points;
  end;

  procedure draw_matrix(x,y:integer; c:tab; ab:array of card;cur:cursor);
  var max,i,i2,I_pts:integer;st_pts:string; temp:array [0..4] of shortint;
   begin
    punkte:=0;
    if crd.h>crd.w then max:=crd.h+10 else max:=crd.w+10;
    for i:=0 to 4 do
     for i2:=0 to 4 do
      begin
       if c[i,i2]>=0 then
       draw_card(ab[c[i,i2]],x+i*max+(max-crd.w) div 2,
                             y+i2*max+(max-crd.h) div 2);
       setcolor(white);
       rectangle(x+i*max,y+i2*max,x+(i+1)*max,y+(i2+1)*max);
      end;
    for i:=0 to 4 do
     begin
      for i2:=0 to 4 do temp[i2]:=-1;
      for i2:=0 to 4 do  if c[i,i2]>=0 then temp[i2]:=ab[c[i,i2]].v;
      I_pts:=calc_points(temp,false);
      punkte:=I_pts+punkte;
      str(i_pts,st_pts);
      outtextxy(x+i*max+(max-crd.w) div 2,
                y+5*max+(max-crd.h) div 2,
                st_pts);
      for i2:=0 to 4 do
       begin
        str(temp[i2],st_pts);
        outtextxy(x+i*max+(max-crd.w) div 2,
                y+i2*5+6*max+(max-crd.h) div 2,
                st_pts);
       end;
     end;

    for i:=0 to 4 do
     begin
      for i2:=0 to 4 do temp[i2]:=-1;
      for i2:=0 to 4 do  if c[i2,i]>=0 then temp[i2]:=ab[c[i2,i]].v;
      I_pts:=calc_points(temp,false);
      punkte:=I_pts+punkte;
      str(i_pts,st_pts);
      outtextxy(x+5*max+(max-crd.w) div 2,
                y+i*max+(max-crd.h) div 2,
                st_pts);
      for i2:=0 to 4 do
       begin
        str(temp[i2],st_pts);
        outtextxy(x+i*max+(max-crd.w) div 2,
                y+i2*5+6*max+(max-crd.h) div 2,
                st_pts);
       end;
     end;

   for i:=0 to 4 do  if c[i,i]>=0 then temp[i]:=ab[c[i,i]].v;
   I_pts:=calc_points(temp,true);
   punkte:=i_pts+punkte;
   str(i_pts,st_pts);
   outtextxy(x+5*max+(max-crd.w) div 2,
                y+5*max+(max-crd.h) div 2,
                st_pts);
   for i:=0 to 4 do if c[i,4-i]>=0 then temp[i]:=ab[c[i,4-i]].v;
   setcolor(white);
   I_pts:=calc_points(temp,true);
   punkte:=i_pts+punkte;
   str(i_pts,st_pts);
   outtextxy(x+5*max+(max-crd.w) div 2,y-15,st_pts);
   end;

procedure draw_visual;
 var st:string;
  begin
{        for i:=0 to 51  do draw_card(deck[i],2+i*10,2);}
        draw_matrix(5,5+crd.h,laud,deck,cur);
        draw_card(deck[n],320,80);
        setcolor(white);
        rectangle(0,20,296,320);
        rectangle(296,20,380,320);
        rectangle(380,20,620,320);
        outtextxy(300,50,'J„rgmine');
        outtextxy(330,59,'kaart');
        outtextxy(300,160,'Punkte');
        str(punkte,st);
        outtextxy(340,169,st);

        rectangle(400,60,580,80);
        outtextxy(420,65,'SEGA PAKK');

        rectangle(400,100,580,120);
        outtextxy(420,105,'VŽLJU');

  end;


begin
    initmouse;
    SetGraphBufSize(1*1024);
    Driver := 3;
    Mode := 1;
    InitGraph(Driver, Mode,'');
    if GraphResult <> grOk then halt(1);
    randomize;
    init_deck(deck);
    scramble(deck);
    for i2:=0 to 4 do for i:=0 to 4 do laud[i,i2]:=-1;
    n:=0;
    scr:=false;
    showmouse;
    for i2:=0 to 4 do for i:=0 to 4 do laud[i,i2]:=-1;

    while true do
      begin
        scr:= not scr;
        hidemouse;

        if scr then setactivepage(1) else setactivepage(0);
        clearviewport;
        draw_visual;
        circle(hiir.x,hiir.y,10);

        if scr then setvisualpage(1) else setvisualpage(0);
        scr:=not scr;
        if scr then setactivepage(1) else setactivepage(0);
        clearviewport;
        draw_visual;
        if cheatmode then for i:=0 to 24 do draw_card(deck[i],i*10+5,310);
        if scr then setvisualpage(1) else setvisualpage(0);
        nobutton:=false;
        showmouse;
        repeat
        if GetMouseDown(0, hiir.x, hiir.y)>0 then
          begin
            circle(hiir.x,hiir.y,5);
            case hiir.x of
                 5..255:begin
                         case hiir.x of
                            6..54:cur.x:=0;
                            56..104:cur.x:=1;
                            106..154:cur.x:=2;
                            156..204:cur.x:=3;
                            206..254:cur.x:=4;
                            end;
                         case hiir.y of
                            46..94:cur.y:=0;
                            96..144:cur.y:=1;
                            146..194:cur.y:=2;
                            196..244:cur.y:=3;
                            246..294:cur.y:=4;
                            end;

                         if laud[cur.x,cur.y]<0 then
                           begin
                            laud[cur.x,cur.y]:=n;
                            inc(n);
                           end;
                        end;

               400..580:begin
                          case hiir.y of
                           60..80:begin
                                     scramble(deck);
                                     for i2:=0 to 4 do for i:=0 to 4 do laud[i,i2]:=-1;
                                     n:=0;
                                  end;
                           100..120:exit;
                          end;
                        end;
           end;
            nobutton:=true;
          end;
        until nobutton;
      end;

    closegraph;
end.