function [ S ] = Steifigkeitsmatrix( Knoten,Elemente )

%Diese Funktion erzeugt die Steifigkeitsmatrix anhand der eingegebenen
%Vektoren "Knoten" und "Elemente". Wie sich die Eintraege ergeben, ist in
%der schriftlichen Bachelorarbeit beschrieben.

S=zeros(length(Knoten),length(Knoten));         
Schrittweite=Knoten(2,1)-Knoten(1,1);
Flaeche=Schrittweite^2/2;
for j=1:length(Elemente(:,1))
    S(Elemente(j,1),Elemente(j,1))=S(Elemente(j,1),Elemente(j,1))+1/Schrittweite^2*Flaeche;
    S(Elemente(j,1),Elemente(j,2))=S(Elemente(j,1),Elemente(j,2))-1/Schrittweite^2*Flaeche;
    S(Elemente(j,2),Elemente(j,2))=S(Elemente(j,2),Elemente(j,2))+2/Schrittweite^2*Flaeche;
    S(Elemente(j,2),Elemente(j,3))=S(Elemente(j,2),Elemente(j,3))-1/Schrittweite^2*Flaeche;
    S(Elemente(j,3),Elemente(j,3))=S(Elemente(j,3),Elemente(j,3))+1/Schrittweite^2*Flaeche; 
end
  
Transpo=S';                 
for j=1:length(S)
    Transpo(j,j)=0;
end
S=S+Transpo;                            %Die Steifigkeitsmatrix ist symmetrisch, was hier ausgenutzt wird.
