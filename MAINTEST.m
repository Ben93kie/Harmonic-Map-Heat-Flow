 clear all
 
 for j=6:1:6
    
   [u,Fehler]=Waermefluss(4,j,2,[0,0],1);
   x=0:1/(2^j):2;
  
  plot(x,Fehler)
  axis([0 2 0 0.5])
  hold on
   legend('1','2','3');
 end
  
%  plot(x,qws)
%    end
%  end
 

% [eins,zwei,drei,vier,fuenf,sechs,sieben,acht,neun,zehn,elf]=wave_maps(2,5);
% 
%  x=0:1/(2^6):1;
% 
% 
% 
% plot(x,neuenorm(1));
% hold on
%  x=0:1/(2^7):1;
% plot(x,neuenorm(2));
% hold on
%  x=0:1/(2^8):1;
% plot(x,neuenorm(3));
% hold on
%  x=0:1/(2^9):1;
% plot(x,neuenorm(4));




