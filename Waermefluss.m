function [u,Fehler,Knoten,uges,uges2]= Waermefluss(h,tau,T,Mittelpunkt,Laenge,alles)

%Folgende Funktion berechnet entsprechend des Algorithmus 1 der
%Bachelorarbeit die Loesung des harmonischen Waermeflusses ohne
%Projektionsschritt. Der Projektionsschritt kann einfach durch Normieren
%des Vektors u eingeführt werden. Diese Funktion gibt den L^1-Fehler der
%Einschraenkung in Abhaengigkeit des Zeitpunkts k aus. Als Eingabe werden 
%die Parameter Schrittweite=h, Zeitschrittweite=tau, Zeitintervall=[0,T] und
%den Ort des Gebiets Omega mit Mittelpunkt und zulaessiger Laenge
%akzeptiert.

[Knoten,Elemente] = Gebietsdefinition(Mittelpunkt,Laenge);   %Das Gebiet wird erstellt      

tau = 2^(-tau); 
K = ceil(T/tau);
h=2^(-h);

[Knoten,Elemente]=Verfeinerung(Knoten,Elemente,h);           %Das Gebiet wird auf die gewünschte Triangulierung gebracht

nC = size(Knoten,1);                                         %Anzahl der Knoten
if alles==1
    uges=zeros(3*nC,K);
end
s=Steifigkeitsmatrix(Knoten,Elemente);
m=Massematrix(Knoten,Elemente);
SSS = sparse(3*nC,3*nC); MMM = sparse(3*nC,3*nC);            %Wir benutzen sparse-Matrizen, da s und m dünnnesetzt sind
                                                                                                                                                                           
for k = 1 : 3  
    idx = k:3:3*nC; SSS(idx,idx) = s; MMM(idx,idx) = m;      %Wir bringen s und m auf die entsprechende Form für vektor-
end                                                          %wertige Funktionen

u = zeros(3*nC,1);                                           %Dies wird der spätere Lösungsvektor u

for j = 1:nC
    u(3*j-[2,1,0]) = u_0(Knoten(j,:));                       %u wird entsprechend @u_0 im 0-ten Zeitschritt gesetzt
end

Fehler=zeros(K+1,1);                                         %Dies wird der Fehlervektor für alle Zeitschritte
for j=1:length(Elemente)
Fehler(1)=Fehler(1)+(1/2)*(h^2)*(1/3)*(abs(norm(u(3*Elemente(j,1)-[2,1,0]))^2-1)...
                                        +abs(norm(u(3*Elemente(j,2)-[2,1,0]))^2-1)...
                                        +abs(norm(u(3*Elemente(j,3)-[2,1,0]))^2-1));
end

for k = 1:K                                                  %Wir iterieren insgesamt K mal für den harmonischen Wärmefluss
    B = sparse(nC,3*nC);                                     %Hier wird B wie beschrieben gesetzt
    for j = 1:nC
        B(j,3*j-[2,1,0]) = u(3*j-[2,1,0]);
    end
    X = [MMM+tau*SSS,B';B,sparse(nC,nC)];                    %Hier wird das Gleichungssystem aufgestellt und gelöst
    b = [-SSS*u;zeros(nC,1)];
    x = X\b;
    v = x(1:3*nC); 
    u = u+tau*v;                                             %Hier kann ein etwaiger Projektionsschritt eingebaut werden
     for j = 1:nC
         unormiert(3*j-[2,1,0]) = u(3*j-[2,1,0])/norm(u(3*j-[2,1,0]));
     end
    if alles==1
        uges(:,k)=u;
        uges2(:,k)=unormiert;
    end
    
  
    for j=1:length(Elemente)                                 %Der L^1-Fehler im k-ten Schritt wird hier ausgerechnet
   Fehler(k+1)=Fehler(k+1)+(abs(norm(u(3*Elemente(j,1)-[2,1,0]))^2-1)...
                                        +abs(norm(u(3*Elemente(j,2)-[2,1,0]))^2-1)...
                                        +abs(norm(u(3*Elemente(j,3)-[2,1,0]))^2-1));
                                 
    end
    Fehler(k+1)=Fehler(k+1)*(h^2)/2*(1/3);
    
end

function val = u_0(x)                                        %Die Startfunktion u_0 wie im beschriebenen Beispiel.
if x==0
    val=[0,0,1];
else
d = size(x,2);
x = [x,zeros(1,3-d)];
r = norm(x); phi = (3*pi/2)*min(4*r^2,1);
val=(1/r)*[x(1)*sin(phi),x(2)*sin(phi),r*cos(phi)]';
end

