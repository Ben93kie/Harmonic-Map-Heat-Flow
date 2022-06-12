function [ coorKnoten,coorElemente,coorDRand, coorNRand ] = Gebietsdefinition( Mittelpunkt,Groesse )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


if Groesse < 0 | mod(log2(Groesse),1)~=0 %Überprüfe, ob Groesse zulässig ist (also der Form 2^n für n natürliche Zahl)    
        msg = 'Bitte zulässige Größe eingeben (Zahlen der Form 2^n, wobei n aus N_0 ist)';
        error(msg)        
else
    halbiert=0.5*Groesse;
    if length(Mittelpunkt) == 1
    coorKnoten(1) = Mittelpunkt-halbiert;
    coorKnoten(2) = Mittelpunkt+halbiert;
    coorElemente = [1,2]; coorDRand = 1; coorNRand = 2;
    
    elseif length(Mittelpunkt) == 2   
    
    coorKnoten(1,1) = Mittelpunkt(1)-halbiert;
    coorKnoten(1,2) = Mittelpunkt(2)-halbiert;
    coorKnoten(2,1) = Mittelpunkt(1)+halbiert;
    coorKnoten(2,2) = Mittelpunkt(2)-halbiert;
    coorKnoten(3,1) = Mittelpunkt(1)+halbiert;
    coorKnoten(3,2) = Mittelpunkt(2)+halbiert;
    coorKnoten(4,1) = Mittelpunkt(1)-halbiert;
    coorKnoten(4,2) = Mittelpunkt(2)+halbiert;            
    
    coorElemente = [1,2,3;1,3,4];
    coorNRand = [1,1] ; coorDRand = [1,2;2,3;3,4;4,1];   
    
    elseif length(Mittelpunkt) == 3  
        
    coorKnoten(1,1) = Mittelpunkt(1)-halbiert;
    coorKnoten(1,2) = Mittelpunkt(2)-halbiert;
    coorKnoten(1,3) = Mittelpunkt(3)-halbiert;
    coorKnoten(2,1) = Mittelpunkt(1)+halbiert;
    coorKnoten(2,2) = Mittelpunkt(2)-halbiert;
    coorKnoten(2,3) = Mittelpunkt(3)-halbiert;
    coorKnoten(3,1) = Mittelpunkt(1)+halbiert;
    coorKnoten(3,2) = Mittelpunkt(2)+halbiert;
    coorKnoten(3,3) = Mittelpunkt(3)-halbiert;
    coorKnoten(4,1) = Mittelpunkt(1)-halbiert;
    coorKnoten(4,2) = Mittelpunkt(2)+halbiert;
    coorKnoten(4,3) = Mittelpunkt(3)-halbiert;
    coorKnoten(5,1) = Mittelpunkt(1)-halbiert;
    coorKnoten(5,2) = Mittelpunkt(2)-halbiert;
    coorKnoten(5,3) = Mittelpunkt(3)+halbiert;
    coorKnoten(6,1) = Mittelpunkt(1)+halbiert;
    coorKnoten(6,2) = Mittelpunkt(2)-halbiert;
    coorKnoten(6,3) = Mittelpunkt(3)+halbiert;
    coorKnoten(7,1) = Mittelpunkt(1)+halbiert;
    coorKnoten(7,2) = Mittelpunkt(2)+halbiert;
    coorKnoten(7,3) = Mittelpunkt(3)+halbiert;
    coorKnoten(8,1) = Mittelpunkt(1)-halbiert;
    coorKnoten(8,2) = Mittelpunkt(2)+halbiert;
    coorKnoten(8,3) = Mittelpunkt(3)+halbiert;
    
    coorElemente = [1,2,3,7;1,6,2,7;1,5,6,7;1,8,5,7;1,4,8,7;1,3,4,7];
    coorDRand = [1,1,1];
    coorNRand = [2,3,7;2,7,6;1,2,6;1,6,5;5,6,7;1,8,5;5,7,8;1,4,8;...
        4,7,8;3,4,7];
end



end

