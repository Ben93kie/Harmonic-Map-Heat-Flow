function [ Knoten,Elemente ] = Gebietsdefinition( Mittelpunkt,Groesse )

%Diese Funktion erlaubt die Definition eines quadratischen Gebiets der
%Laenge 2^n mit beliebigem Mittelpunkt, setzt die Knoten an den Ecken
%und erstellt zwei finite Elemente entsprechend.


if Groesse < 0 | mod(log2(Groesse),1)~=0 %Ueberprüfe, ob Groesse zulaessig ist 
                                         %(also der Form 2^n für n natürliche Zahl)    
        msg = 'Bitte zulaessige Groeße eingeben (Zahlen der Form 2^n, wobei n aus N_0 ist)';
        error(msg)        
else
    halbiert=0.5*Groesse;
    Knoten(1,1) = Mittelpunkt(1)-halbiert;
    Knoten(1,2) = Mittelpunkt(2)-halbiert;
    Knoten(2,1) = Mittelpunkt(1)+halbiert;
    Knoten(2,2) = Mittelpunkt(2)-halbiert;
    Knoten(3,1) = Mittelpunkt(1)+halbiert;
    Knoten(3,2) = Mittelpunkt(2)+halbiert;
    Knoten(4,1) = Mittelpunkt(1)-halbiert;
    Knoten(4,2) = Mittelpunkt(2)+halbiert;            
    
    Elemente = [1,2,3;1,3,4];
    
end
end

