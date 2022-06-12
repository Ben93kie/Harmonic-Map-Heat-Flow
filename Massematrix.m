function [ M ] = Massematrix( coorKnoten,coorElem )

%Diese Funktion erzeugt die Massematrix anhand der eingegebenen
%Vektoren "Knoten" und "Elemente". Wie sich die Einträge ergeben, ist in
%der schriftlichen Bachelorarbeit beschrieben.

M=zeros(length(coorKnoten),length(coorKnoten));
Schrittweite=coorKnoten(2,1)-coorKnoten(1,1);
for j=1:length(coorElem(:,1))
    M(coorElem(j,1),coorElem(j,1))=M(coorElem(j,1),coorElem(j,1))+Schrittweite^2/12;
    M(coorElem(j,1),coorElem(j,2))=M(coorElem(j,1),coorElem(j,2))+Schrittweite^2/24;
    M(coorElem(j,1),coorElem(j,3))=M(coorElem(j,1),coorElem(j,3))+Schrittweite^2/24;
    M(coorElem(j,2),coorElem(j,2))=M(coorElem(j,2),coorElem(j,2))+Schrittweite^2/12;
    M(coorElem(j,2),coorElem(j,3))=M(coorElem(j,2),coorElem(j,3))+Schrittweite^2/24;
    M(coorElem(j,3),coorElem(j,3))=M(coorElem(j,3),coorElem(j,3))+Schrittweite^2/12; 
end
  
Transpo=M';
for j=1:length(M)
    Transpo(j,j)=0;
end
M=M+Transpo;                            %Die Massematrix ist symmetrisch, was hier ausgenutzt wird.
end

