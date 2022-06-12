function [ coorKnoten,coorElemente,coorDRand, coorNRand ] = triang_cube1( d )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if d == 1
    coorKnoten = [0;1]; coorElemente = [1,2]; coorDRand = 1; coorNRand = 2;
elseif d == 2
    coorKnoten = [0,0;1,0;1,1;0,1]; coorElemente = [1,2,3;1,3,4];
    coorNRand = [1,1] ; coorDRand = [1,2;2,3;3,4;4,1];
elseif d == 3  
    coorKnoten = [0,0,0;1,0,0;1,1,0;0,1,0;0,0,1;1,0,1;1,1,1;0,1,1];
    coorElemente = [1,2,3,7;1,6,2,7;1,5,6,7;1,8,5,7;1,4,8,7;1,3,4,7];
    coorDRand = [1,1,1];
    coorNRand = [2,3,7;2,7,6;1,2,6;1,6,5;5,6,7;1,8,5;5,7,8;1,4,8;...
        4,7,8;3,4,7];
end


end

