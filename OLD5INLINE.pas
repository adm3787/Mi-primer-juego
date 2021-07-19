Program TaTeTi_5_En_Linea;

uses crt;

type
    jugador=record
                  nom:string[10];
                  g:byte;
                  efi:real;
            end;
    lista=array[1..100]of jugador;
    matriz=array[1..13,1..17] of char;
var
   plyrs:lista;
   c,i,j,el,nroj:byte;
   t:matriz;
   alt:boolean;

procedure inicio_lista(var ahi:lista);
var x:byte;
begin
     for x:=1 to 69 do
         with ahi[x] do begin nom:='Jugador X '; g:=0; end;
end;

procedure ingreso_jugadores(var ahi:lista; var pos:byte);
begin
     clrscr;
     textcolor(white); gotoxy(29,3);
     writeln('INGRESEN SUS NOMBRES');
     gotoxy(28,4); write('(10 caracteres maximo)');
     gotoxy(28,12); textcolor(3+8); pos:=pos+1; ahi[pos].nom:='';
     write('Jugador Nro',pos,' : '); readln(ahi[pos].nom); ahi[pos].g:=0;
     gotoxy(28,13); textcolor(5+8); pos:=pos+1; ahi[pos].nom:='';
     write('Jugador Nro',pos,' : '); readln(ahi[pos].nom); ahi[pos].g:=0;
end;

procedure construye_tablero;
var x,y:byte;
begin
     clrscr;
     textcolor(white);
     For y:=1 to 25 do
         For x:=1 to 33 do
             If odd(y) then
                           if not(odd(x)) then
                                              begin
                                                   gotoxy(2*x,y);
                                                   write('|');
                                              end
                                          else  begin end
                       else
                           if odd(x) then
                                         begin
                                              gotoxy(x*2-1,y);
                                              write('---');
                                         end
                                     else
                                         begin
                                              gotoxy(2*x,y);
                                              write('+');
                                         end;
     For y:=1 to 25 do
         If odd(y) then
                       begin
                            gotoxy(68,y);
                            write('|');
                       end
                   else
                       begin
                            gotoxy(68,y);
                            write('+');
                       end;
end;

procedure al_costado(ahi:lista; pos:byte);
begin
     textcolor(white);
     gotoxy(71,17); write('Nuevos');
     gotoxy(70,18); write('Jugadores');
     gotoxy(73,19); write('(N)');
     gotoxy(70,21); write('Reiniciar');
     gotoxy(73,22); write('(V)');
     gotoxy(72,24); write('Salir');
     gotoxy(73,25); write('(T)');
     gotoxy(70,2); textcolor(3+8); write(ahi[pos-1].nom);
     gotoxy(70,3); write('(',ahi[pos-1].g,')');
     gotoxy(70,7); textcolor(5+8); write(ahi[pos].nom);
     gotoxy(70,8); write('(',ahi[pos].g,')');
end;

procedure limpia_matriz(var mat:matriz);
var xf,xc:byte;
begin
     For xf:=1 to 13 do
         For xc:=1 to 17 do
             mat[xf,xc]:=' ';
end;

procedure turno(var altern:boolean);
begin
     if not(altern) then begin
                              gotoxy(70,1); clreol;
                              textcolor(green+8); gotoxy(70,6); write('JUEGA');
                         end
               else begin
                         gotoxy(70,6); clreol;
                         textcolor(green+8); gotoxy(70,1); write('JUEGA');
                    end;
end;

procedure reiniciar(var cantalin,esplibr,pfil,pcol:byte;var mat:matriz);
var
   xf,xc:byte;
begin
     For xf:=1 to 13 do
         For xc:=1 to 17 do
             begin
                  mat[xf,xc]:=' ';
                  gotoxy(4*xc-3,2*xf-1); write('   ');
             end;
     gotoxy(70,1); clreol; gotoxy(70,6); clreol; gotoxy(69,5); clreol;
     {al_costado(plyrs,nroj);}
     gotoxy(33,13);
     write(' ');
     cantalin:=1; esplibr:=221; pfil:=7; pcol:=9;
     turno(alt);
end;

procedure comandos;
begin
     textcolor(white);
     gotoxy(17,22); write('Presiona Enter para ver los comandos del juego'); readln;
     clrscr;
     gotoxy(15,1); write('Para moverte por la tabla usa las siguientes teclas');
     gotoxy(39,5); write('[W]');
     gotoxy(44,7); write('[D]');
     gotoxy(34,7); write('[A]');
     gotoxy(39,9); write('[S]');
     gotoxy(12,14); write('Para insertar tu ficha');
     gotoxy(21,16); write('[I]');
     gotoxy(52,14); write('Nuevos jugadores');
     gotoxy(58,16); write('[N]');
     gotoxy(10,19); write('Volver a jugar / Reiniciar');
     gotoxy(21,21); write('[V]');
     gotoxy(52,19); write('Salir del juego');
     gotoxy(58,21); write('[T]');
     gotoxy(27,25); write('Presiona Enter para comenzar'); readln;
end;

procedure tabla_d_posiciones(ahi:lista; tot:byte);
var
   aux:jugador;
   h,k,p,de,m:byte;
begin
     for h:=1 to tot-1 do
         for k:=h+1 to tot do
             if ahi[h].g < ahi[k].g
                then
                    begin aux:=ahi[h]; ahi[h]:=ahi[k]; ahi[k]:=aux; end
                else
                    if (ahi[h].g = ahi[k].g) and (ahi[h].efi < ahi[k].efi)
                       then
                           begin aux:=ahi[h]; ahi[h]:=ahi[k]; ahi[k]:=aux; end;
     clrscr;
     textcolor(white); gotoxy(31,1); write('Tabla de posiciones');
     p:=0; de:=4;
     for h:=1 to 3 do
       begin
         for k:=1 to 23 do
             begin
                  p:=p+1;
                  gotoxy(de,k+2); write(p:2,'...',ahi[p].nom);
                  gotoxy(de+16,k+2); write(ahi[p].g:3);
             end;
        de:=de+27;
       end;
     readln;
end;

procedure nuevos_jugadores(var cantalin:byte; pos:byte);
begin
     if pos+1 > 100 then begin tabla_d_posiciones(plyrs,nroj); cantalin:=0; end
                    else begin
                              ingreso_jugadores(plyrs,nroj);
                              comandos;
                              construye_tablero;
                              al_costado(plyrs,nroj);
                              reiniciar(c,el,i,j,t);
                         end;
end;

procedure carga_eficiencia(var ahi:lista; pos:byte);
begin
     if (ahi[pos-1].g+ahi[pos].g)=0
        then begin ahi[pos-1].efi:=0; ahi[pos].efi:=0; end
        else begin ahi[pos-1].efi:=(ahi[pos-1].g)/(ahi[pos-1].g+ahi[pos].g);
                   ahi[pos].efi:=(ahi[pos].g)/(ahi[pos-1].g+ahi[pos].g);
     end;
end;

procedure despues_d_jugar;
begin
     repeat
           case readkey of
                't': begin tabla_d_posiciones(plyrs,nroj); c:=0; end;
                'v': reiniciar(c,el,i,j,t);
                'n': begin carga_eficiencia(plyrs,nroj); nuevos_jugadores(c,nroj); end;
           end;
     until (c=0) or (el=221);
end;

procedure representa_movimiento(fi,co:byte);
begin gotoxy(4*co-3,2*fi-1); write(' '); end;

procedure abajo(var xf,xc:byte);
begin
     repeat
           if xf=13 then begin
                             xf:=1;
                             if xc<17 then xc:=xc+1
                                     else xc:=1;

                        end
                   else xf:=xf+1;
     until t[xf,xc]=' ';
     representa_movimiento(xf,xc);
end;

procedure arriba(var xf,xc:byte);
begin
     repeat
           if xf=1 then begin
                            xf:=13;
                            if xc>1 then xc:=xc-1
                                   else xc:=17;
                       end
                  else xf:=xf-1;
     until t[xf,xc]=' ';
     representa_movimiento(xf,xc);
end;

procedure derecha(var xf,xc:byte);
begin
     repeat
           if xc=17 then begin
                             xc:=1;
                             if xf<13 then xf:=xf+1
                                     else xf:=1;
                        end
                   else xc:=xc+1;
     until t[xf,xc]=' ';
     representa_movimiento(xf,xc);
end;

procedure izquierda(var xf,xc:byte);
begin
     repeat
           if xc=1 then begin
                             xc:=17;
                             if xf>1 then xf:=xf-1
                                     else xf:=13;
                        end
                   else xc:=xc-1;
     until t[xf,xc]=' ';
     representa_movimiento(xf,xc);
end;

function verifica_alineacion(ca:byte):byte;
var v,h:byte; hfi:boolean;
begin
     v:=i-1; hfi:=true;
     while (ca<5) and hfi do
           if (i>v) and (v>=1) and (t[i,j]=t[v,j])
              then begin v:=v-1; ca:=ca+1; end
              else begin
                        if (i>v) then v:=v+ca+1;
                        if (v<=13) and (t[i,j]=t[v,j])
                           then begin ca:=ca+1; v:=v+1; end
                           else begin hfi:=false; ca:=1; v:=i-1; h:=j-1; end;
           end;
     hfi:=true;
     while (ca<5) and hfi do
           if (h<j) and (h>=1) and (t[i,j]=t[i,h])
              then begin h:=h-1; ca:=ca+1; end
              else begin
                        if (h<j) then h:=h+ca+1;
                        if (h<=17) and (t[i,j]=t[i,h])
                           then begin ca:=ca+1; h:=h+1; end
                           else begin hfi:=false; ca:=1; h:=j-1; end;
           end;
     hfi:=true;
     while (ca<5) and hfi do
           if (v<i) and (v>=1) and (h<j) and (h>=1) and (t[i,j]=t[v,h])
              then begin ca:=ca+1; v:=v-1; h:=h-1; end
              else begin
                        if (v<i) then begin v:=v+ca+1; h:=h+ca+1; end;
                        if (v<=13) and (h<=17) and (t[i,j]=t[v,h])
                           then begin ca:=ca+1; v:=v+1; h:=h+1; end
                           else begin hfi:=false; ca:=1; v:=i+1; h:=j-1; end;
           end;
     hfi:=true;
     while (ca<5) and hfi do
           if (v>i) and (v<=13) and (h<j) and (h>=1) and (t[i,j]=t[v,h])
              then begin ca:=ca+1; v:=v+1; h:=h-1; end
              else begin
                        if (v>i) then begin v:=v-ca-1; h:=h+ca+1; end;
                        if (v>=1) and (h<=17) and (t[i,j]=t[v,h])
                           then begin ca:=ca+1; v:=v-1; h:=h+1; end
                           else begin hfi:=false; ca:=1; end;
           end;
    verifica_alineacion:=ca;
end;

procedure insertar(xf,xc:byte;var mat:matriz;var altern:boolean);
begin
     if altern then begin mat[xf,xc]:='B';textcolor(3+8); altern:=false; end
               else begin mat[xf,xc]:='R';textcolor(5+8); altern:=true; end;
     gotoxy(4*xc-3,2*xf-1); write('XXX');
end;

procedure ganador(altern:boolean;var ahi:lista; pos:byte);
begin
     if not(altern) then begin
                           gotoxy(70,1);
                           write('G A N O!!!');
                           ahi[pos-1].g:=ahi[pos-1].g+1;
                      end
                 else begin
                           gotoxy(70,6);
                           write('G A N O!!!');
                           ahi[pos].g:=ahi[pos].g+1;
                      end;
     al_costado(plyrs,nroj);
     despues_d_jugar;
end;

procedure final;
var x:byte;
begin
     clrscr;
     textcolor(white);
     gotoxy(33,4); write('Realizado por:');
     gotoxy(30,6); write('Agustin Dario Medina');
     gotoxy(28,11); write('Terminado el 10/10/2011');
     gotoxy(25,12); write('Ultima modificacion: 09/08/2014');
     gotoxy(33,17); write('Agradecimientos');
     gotoxy(18,19); write('A mi primo "El Gabi" por prestarme su notebook');
     gotoxy(17,20); write('A Vicky por prestarme sus apuntes de Programacion');
     for x:=10 downto 1 do
         begin
              delay(1000);
              gotoxy(40,23);
              clreol;
              write(x);
         end;
         delay(1000);
         gotoxy(40,23);
         clrscr;

end;

BEGIN
     nroj:=0;
     inicio_lista(plyrs); alt:=true;
     nuevos_jugadores(c,nroj);

     while (c <> 0) do

       case readkey of

            's':abajo(i,j);


            'w':arriba(i,j);


            'd':derecha(i,j);


            'a':izquierda(i,j);


            'i':begin
                     el:=el-1;
                     insertar(i,j,t,alt);
                     if verifica_alineacion(c)=1
                        then
                            if el>0 then begin turno(alt); derecha(i,j); end
                                    else begin
                                              gotoxy(70,1); clreol;
                                              textcolor(white);
                                              gotoxy(69,5);
                                              write('EMPATE!!!');
                                              despues_d_jugar;
                                         end
                        else ganador(alt,plyrs,nroj);
                end;

            'v': reiniciar(c,el,i,j,t);

            't': begin tabla_d_posiciones(plyrs,nroj); c:=0; end;

            'n': begin carga_eficiencia(plyrs,nroj); nuevos_jugadores(c,nroj); end;

       end;
     final;

END.
