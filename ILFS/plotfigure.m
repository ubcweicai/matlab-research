function y = plotfigure(parameter,para_start,para_step,para_end) 

filename=sprintf('FigureData\\CalculationResult%s.txt',parameter);
% disp(filename);
SimResult=csvread(filename);

dots=(para_end-para_start)/para_step;

Scheme1=[];
for i=1:4:(4*dots+1)
    Scheme1=[Scheme1; SimResult(i,5) SimResult(i,6)];
end

Scheme2=[];
for i=2:4:(4*dots+2)
    Scheme2=[Scheme2; SimResult(i,5) SimResult(i,6)];
end

Scheme3=[];
for i=3:4:(4*dots+3)
    Scheme3=[Scheme3; SimResult(i,5) SimResult(i,6)];
end

Scheme4=[];
for i=4:4:(4*dots+4)
    Scheme4=[Scheme4; SimResult(i,5) SimResult(i,6)];
end

plot(Scheme1(:,1),Scheme1(:,2),'-dk',Scheme2(:,1),Scheme2(:,2),'-ob',Scheme3(:,1),Scheme3(:,2),'-*g',Scheme4(:,1),Scheme4(:,2),'-sr');
titlename=sprintf('tradeoff with %s',parameter);
title(titlename);
xlabel('Storage Cost');ylabel('Transmission Rate');
legend('Only I with no caching','Adjacent P with no caching','Adjacent P with caching','Optimized Structure with caching');

end