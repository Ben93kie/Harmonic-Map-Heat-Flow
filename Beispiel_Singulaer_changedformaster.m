%In folgendem Skript wird "Waermefluss" gestartet. Wir betrachten dabei
%das Beispiel aus der Bachelorarbeit mit der entsprechenden Startfunktion
%u_0, die bereits in "Waermefluss" integriert ist. Dabei nehmen wir
%Schrittweiten, die die Plots der Bachelorarbeit erzeugen. Ein Durchlauf
%dauert ca. 90 Minuten

clear all
warning('off','MATLAB:legend:IgnoringExtraEntries'); 
 Plotfenster=1;
 Linienvektor={':','-.','--','-'};
 Beschriftung=zeros(4,1);
 Legendenzaehler=0;
 for h=3:1:3                                       %Hier iteriren wir die Schrittweite h
     Linienart=1;
     
     for tau=10:1:10                                 %Hier iterieren wir die Zeitschrittweite tau
         Legendenzaehler=Legendenzaehler+1;
         if Linienart>4
             Linienart=1;
         end
         Beschriftung(Legendenzaehler)=tau;
        [u,Fehler,Knoten,uges,uges2]=Waermefluss(h,tau,2,[0,0],1,1);   %Fehlerwerte in Abhängigkeit des Zeitpunkts
        Zeitschritte=zeros(length(Fehler),1);      %Zeitschritt(k) für Omega (-1/2,1/2), sprich 
                                                   %Mittelpunkt [0,0] und
                                                   %Laenge 1
   for k=0:length(Fehler)-1
       Zeitschritte(k+1)=k*(1/2^(tau));
   end
  
%        figure(1);                        %Hier werden die Resultate geplottet, wobei für jedes h ein neues Fenster geöffnet wird
%        plot(Zeitschritte,Fehler,Linienvektor{Linienart})
%        legend(sprintf('2^{-%d}',Beschriftung(1)),...
%               sprintf('2^{-%d}',Beschriftung(2)),...
%               sprintf('2^{-%d}',Beschriftung(3)),...
%               sprintf('2^{-%d}',Beschriftung(4)));
%            
%        title(sprintf('Verschiedene Zeitschrittweiten für h=2^{-%d}',h))
%        axis([0 2 0 0.6])
       
 
       Linienart=Linienart+1;
     end
     Plotfenster=Plotfenster+1;
 end
  
 
 
 


x=Knoten(:,1);
y=Knoten(:,2);
z=zeros(length(x),1);
for j=1:3:300
ux=uges(1:3:end,j);
ux2=uges2(1:3:end,j);
uy=uges(2:3:end,j);
uy2=uges2(2:3:end,j);
uz=uges(3:3:end,j);
uz2=uges2(3:3:end,j);
quiver3(x,y,z,ux,uy,uz,0,'r')
hold on
quiver3(x,y,z,ux2,uy2,uz2,0,'b')
hold off
axis([-1.5 1.5 -1.5 1.5 -1.5 1.5])
pause(0.0000001)
j

end

k = 1;
 
for t=1:5:250
 
   ux=uges(1:3:end,t);
ux2=uges2(1:3:end,t);
uy=uges(2:3:end,t);
uy2=uges2(2:3:end,t);
uz=uges(3:3:end,t);
uz2=uges2(3:3:end,t);
quiver3(x,y,z,ux,uy,uz,0,'r')
hold on
quiver3(x,y,z,ux2,uy2,uz2,0,'b')
hold off
axis([-1.5 1.5 -1.5 1.5 -1.5 1.5])
 
    % gif utilities
    set(gcf,'color','w'); % set figure background to white
    drawnow;
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    outfile = 'sinewave2.gif';
 
    % On the first loop, create the file. In subsequent loops, append.
    if t==1
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'loopcount',inf);
    else
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'writemode','append');
    end
 
end