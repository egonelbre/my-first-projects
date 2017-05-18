program loppvark;
uses graph,crt;

type Node = ^NodePtr;
     NodePtr = Record
                 vasak, vanem, parem:Node;
                 st:string;
               end;
		{Puu ehitamiseks pointerid}
const eps=0.001;
var  root:node; funkts,bigstr:String; gd,gm:integer;


{funktsioon avaldise lahti vıtmiseks.... ehitab selle pıhjal binaarpuu}
function make_tree(avaldis:string; ulemine:node):node;
 var abi_st1,abi_st2,abi_av:string;
     abi:node;
     i,br:shortint; err:boolean;
 begin
  new(abi);
  abi^.vanem:=ulemine;

  {vıtab ‰ra liigsed sulud}

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
               if abi_av[i]='(' then inc(br);if abi_av[i]=')' then dec(br);
               if br<0 then err:=false;
         until not err or (i>length(avaldis)-2);
         if err then avaldis:=copy(avaldis,2,length(avaldis)-2);
       end
    else err:=false;
   until not err;

   {kustutab kıik, mis ei ole kırgema tehte j‰rjekorras.... 2*(45+62)+((22+1)*(13-2)) --> 2*(     )+(             )}
   br:=0;
   i:=0;
   repeat
     inc(i);
     if abi_av[i]='(' then inc(br);
     if abi_av[i]=')' then dec(br);
     if br<>0 then abi_av[i]:=' ';
   until i>length(abi_av)-1;

   {leiab vastava m‰rgi ning jaotab ta kaheks puus
   tehete j‰rjekord on pˆˆratud
   ntks.   (4+62)*(23-56)-->vasakule=(4+62)   paremale=(23-56)   st=*
   ning siis k‰ivitab mılema s‰‰re kohta sama protseduuri}
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

{siin ehitab puu pıhjal vastavatele funktsioonidele}
function makebigstring(sisse:node):string;
 var n:real;kood:integer; T1,T2:string;
 begin
  if (sisse^.vasak=nil) and (sisse^.parem=nil) then makebigstring:=sisse^.st
    else
      begin
         T1:='('+makebigstring(sisse^.vasak)+')';
         if sisse^.parem<>nil then T2:='('+makebigstring(sisse^.parem)+')' else T2:='0';
         case sisse^.st[1] of
          '+':makebigstring:='sum('+T1+','+T2+')';
          '-':makebigstring:='sub('+T1+','+T2+')';
          '*':makebigstring:='mul('+T1+','+T2+')';
          '/':makebigstring:='div('+T1+','+T2+')';
          's':makebigstring:='sin'+T1;
          'a':makebigstring:='abs'+T1;
          'c':makebigstring:='cos'+T1;
          'r':makebigstring:='random'+T1;
          'u':makebigstring:='round'+T1;
          't':makebigstring:='div(sin'+T1+',cos'+T2+')';
          'l':makebigstring:='div(ln('+T2+','+T2+'))';
          'j':makebigstring:='sqrt'+T1;
          end;
      end;
 end;

 {arvutab puu v‰‰rtuse sarnaselt eelmise funktsiooniga}
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

{protseduur puu kustutamiseks}
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

function length_tree(sisse:node):integer;
 var i1,i2:integer;
 begin
  i1:=0; i2:=0;
  if sisse^.vasak<>nil then i1:=length_tree(sisse^.vasak);
  if sisse^.parem<>nil then i2:=length_tree(sisse^.parem);
  if i1>i2 then length_tree:=i1+1 else length_tree:=i2+1;
 end;

procedure draw_tree(sisse:node);
		procedure  draw_sub(sisse:node;dy:integer; level,nr:integer; x,y:integer);

                    function aste(a,b:integer):longint;
                     var i,n:longint;
                     begin
                      if b=0 then aste:=1 else
                      begin
                        n:=1;
                        for i:=1 to b do n:=n*a;
                        aste:=n;
                      end;
                     end;

                        var x0,y0:integer;
			begin
			{joonistame puu... :D :P
			joonistame
                         kırgusele y0:=(dy*(i-0.5)) m‰rgi sisse^.st
                         kaugusele x0:=(getmaxx/(2~(i-1)+1))*nr
			joonistame joone x,y-sse}
                        y0:=round(dy*(level-0.5));
                        x0:=round((getmaxx div (aste(2,level-1)+1))*nr);
                        setcolor(white);
                        line(x,y+10,x0,y0-10);
                        circle(x0,y0,10); outtextxy(x0-textwidth(sisse^.st) div 2,y0,sisse^.st);
			if sisse^.vasak<>nil then draw_sub(sisse^.vasak,dy,level+1,2*nr-1,x0,y0);
			if sisse^.parem<>nil then draw_sub(sisse^.parem,dy,level+1,2*nr,x0,y0);
			end;
	var dy:integer;
 begin
  {leia pikim haru}
  dy:=getmaxy div length_tree(sisse);
  draw_sub(sisse,dy,1,1,getmaxx div 2,0);
 end;
 {--------------------Programmi algus-------------------------------------}
 begin
   clrscr;
   funkts:='(6*3+4*2)/(s(3)+8*1*(-5))';
   root:=make_tree(funkts,nil);
   bigstr:=makebigstring(root);
   writeln(funkts);
   writeln;
   writeln(bigstr);
   writeln(length_tree(root));
   readln;
   gd:=detect;
   initgraph(gd,gm,' ');
   draw_tree(root);
   readkey;
   closegraph;
   delete_tree(root);
 end.