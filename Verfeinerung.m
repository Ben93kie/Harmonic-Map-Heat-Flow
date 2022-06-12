function [ KnotenNew,ElementeNew ] = Verfeinerung( Knoten,Elemente,...
                                                            Schrittweite )


%Diese Funktion gibt für ein bereits definiertes quadratisches Gebiet der
%Länge 2^n eine reguläre, gleichmäßige Triangulierung mit Dreiecken der
%Schrittweite "Schrittweite" zurück, wobei Schrittweiten der Form 2^-n
%erlaubt sind. Dabei zählen wir die Knoten von unten links beginnend und
%gehen die Zeilen hoch (immer von links), bis wir beim rechten oberen
%Element angelangt sind. Die Dreiecke, deren 90°-Ecke nach unten
%rechts schaut, zählen wir genauso durch. Anschließend das Gleiche mit den
%Dreiecken, deren 90°-Ecke nach oben links schaut.

if  Schrittweite < 0 | mod(log2(Schrittweite),1)~=0   %Es sind nur Schrittweiten der Form 2^-n erlaubt
    msg = 'Bitte zulässige Schrittweite eingeben (Zahlen der Form 2^-n, wobei n aus N_0 ist)';
        error(msg) 
end

 Gebietslaenge=Knoten(2,1)-Knoten(1,1);                 %Die Länge des Gebiets ist die Differenz der ersten beiden Knoten
 NeueElementeTest=(Gebietslaenge/Schrittweite);         %Testvariable, zur Prüfung, ob Verfeinerung möglich ist
 
 if NeueElementeTest==1                                 %Die ursprüngliche Triangulierung bleibt erhalten
     KnotenNew=Knoten;
     ElementeNew=Elemente;
     return;
 elseif NeueElementeTest<1                              %Die Schrittweite ist hier größer als erlaubt
     msg = 'Schrittweite unzulässig (zu groß)';
        error(msg)
 end
 
KnotenanzahlNew=(Gebietslaenge/Schrittweite+1)^2;       %Neue Knotenanzahl
Laenge=sqrt(KnotenanzahlNew);                           %Speichert die Länge des Gebiets
KnotenNew=zeros(KnotenanzahlNew,2);                     %Setzt den neuen Knotenvektor
k=0;                                                    %Laufindizes für Schrittweite
h=0;
j=1;
while j<KnotenanzahlNew                                 %Solange wir nicht am rechten oberen Knoten ist, iterieren wir
    
    if  h+Knoten(1,1)>Knoten(length(Knoten)-1,1)        %Falls wir über dem rechten Rand sind, neue Zeile darüber
        k=k+Schrittweite;
        h=0;
    end
        KnotenNew(j,1)=Knoten(1,1)+h;                   %Ansonsten setze neuen Knoten in derselben Zeile einen Schritt
        KnotenNew(j,2)=Knoten(1,2)+k;                   %Nach rechts
        h=h+Schrittweite;
        j=j+1;
end
KnotenNew(j,:)=Knoten(length(Knoten)-1,:);              %Der letzte Knoten wird manuell eingefügt

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
    
