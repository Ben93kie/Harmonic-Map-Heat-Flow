function [ KnotenNew,ElementeNew ] = Verfeinerung( Knoten,Elemente,...
                                                            Schrittweite )


%Diese Funktion gibt f�r ein bereits definiertes quadratisches Gebiet der
%L�nge 2^n eine regul�re, gleichm��ige Triangulierung mit Dreiecken der
%Schrittweite "Schrittweite" zur�ck, wobei Schrittweiten der Form 2^-n
%erlaubt sind. Dabei z�hlen wir die Knoten von unten links beginnend und
%gehen die Zeilen hoch (immer von links), bis wir beim rechten oberen
%Element angelangt sind. Die Dreiecke, deren 90�-Ecke nach unten
%rechts schaut, z�hlen wir genauso durch. Anschlie�end das Gleiche mit den
%Dreiecken, deren 90�-Ecke nach oben links schaut.

if  Schrittweite < 0 | mod(log2(Schrittweite),1)~=0   %Es sind nur Schrittweiten der Form 2^-n erlaubt
    msg = 'Bitte zul�ssige Schrittweite eingeben (Zahlen der Form 2^-n, wobei n aus N_0 ist)';
        error(msg) 
end

 Gebietslaenge=Knoten(2,1)-Knoten(1,1);                 %Die L�nge des Gebiets ist die Differenz der ersten beiden Knoten
 NeueElementeTest=(Gebietslaenge/Schrittweite);         %Testvariable, zur Pr�fung, ob Verfeinerung m�glich ist
 
 if NeueElementeTest==1                                 %Die urspr�ngliche Triangulierung bleibt erhalten
     KnotenNew=Knoten;
     ElementeNew=Elemente;
     return;
 elseif NeueElementeTest<1                              %Die Schrittweite ist hier gr��er als erlaubt
     msg = 'Schrittweite unzul�ssig (zu gro�)';
        error(msg)
 end
 
KnotenanzahlNew=(Gebietslaenge/Schrittweite+1)^2;       %Neue Knotenanzahl
Laenge=sqrt(KnotenanzahlNew);                           %Speichert die L�nge des Gebiets
KnotenNew=zeros(KnotenanzahlNew,2);                     %Setzt den neuen Knotenvektor
k=0;                                                    %Laufindizes f�r Schrittweite
h=0;
j=1;
while j<KnotenanzahlNew                                 %Solange wir nicht am rechten oberen Knoten ist, iterieren wir
    
    if  h+Knoten(1,1)>Knoten(length(Knoten)-1,1)        %Falls wir �ber dem rechten Rand sind, neue Zeile dar�ber
        k=k+Schrittweite;
        h=0;
    end
        KnotenNew(j,1)=Knoten(1,1)+h;                   %Ansonsten setze neuen Knoten in derselben Zeile einen Schritt
        KnotenNew(j,2)=Knoten(1,2)+k;                   %Nach rechts
        h=h+Schrittweite;
        j=j+1;
end
KnotenNew(j,:)=Knoten(length(Knoten)-1,:);              %Der letzte Knoten wird manuell eingef�gt

j=1;
h=1;

ElementeNew=zeros(NeueElementeTest,3);                  %Setze den Elementvektor

while j<=KnotenanzahlNew-Laenge                         %Solange, bis oberste Zeile erreicht ist werden die Elemente
    if 0~=mod(j,Laenge)                                 %vom Typ 1 gesetzt (90-Grad-Eck zeigt nach unten rechts)
    ElementeNew(h,1)=j;
    ElementeNew(h,2)=j+1;
    ElementeNew(h,3)=j+1+Laenge;
    j=j+1;
    h=h+1;
    else
        j=j+1;
    end
end
j=1;

while j<=KnotenanzahlNew-Laenge                         %Elemente vom Typ zwei werden gesetzt (90-Grad-Eck oben links)
    if 0~=mod(j,Laenge)
    ElementeNew(h,1)=j;
    ElementeNew(h,2)=j+Laenge;
    ElementeNew(h,3)=j+1+Laenge;
    j=j+1;
    h=h+1;
    else
        j=j+1;
    end
end

end
    
