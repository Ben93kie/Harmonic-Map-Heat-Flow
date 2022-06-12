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
 for h=4:1:7                                       %Hier iteriren wir die Schrittweite h
     Linienart=1;
     
     for tau=6:1:9                                 %Hier iterieren wir die Zeitschrittweite tau
         Legendenzaehler=Legendenzaehler+1;
         if Linienart>4
             Linienart=1;
         end
         Beschriftung(Legendenzaehler)=tau;
        [~,Fehler]=Waermefluss(h,tau,2,[0,0],1);   %Fehlerwerte in Abhängigkeit des Zeitpunkts
        Zeitschritte=zeros(length(Fehler),1);      %Zeitschritt(k) für Omega (-1/2,1/2), sprich 
                                                   %Mittelpunkt [0,0] und
                                                   %Laenge 1
   for k=0:length(Fehler)-1
       Zeitschritte(k+1)=k*(1/2^(tau));
   end
  
       figure(Plotfenster);                        %Hier werden die Resultate geplottet, wobei für jedes h ein neues Fenster geöffnet wird
       plot(Zeitschritte,Fehler,Linienvektor{Linienart})
       legend(sprintf('2^{-%d}',Beschriftung(1)),...
              sprintf('2^{-%d}',Beschriftung(2)),...
              sprintf('2^{-%d}',Beschriftung(3)),...
              sprintf('2^{-%d}',Beschriftung(4)));
           
       title(sprintf('Verschiedene Zeitschrittweiten für h=2^{-%d}',h))
       axis([0 2 0 0.6])
       hold on
 
       Linienart=Linienart+1;
     end
     Plotfenster=Plotfenster+1;
 end
  



