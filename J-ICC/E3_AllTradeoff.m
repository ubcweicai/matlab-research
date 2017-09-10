clc;
clear;

for cq=10:1:10
    dropbox='../../../';
    filename=[dropbox,'\Code\Java\GeneticResourceSimulation\newresults\all_result'];
    filename=[filename, int2str(cq)];
    filename=[filename, '.csv'];
    display(filename);
    result=csvread(filename);
    result_backup=result;
end

    x=result(:,1);
    y=result(:,2);
    z=result(:,3);

%     plot(x,y,'.');
%     xlabel('Cloud Cost');ylabel('Network Cost');
%     title('Tradeoff between cloud cost and terminal cost');

    plot(x,z,'.');
    xlabel('Cloud Cost');ylabel('Terminal Cost');
    title('Tradeoff between cloud cost and terminal cost');


%     plot(y,z,'.');
%     xlabel('Network Cost');ylabel('Terminal Cost');
%     title('Tradeoff between network cost and terminal cost');


%     plot3(x,y,z,'.');

    hold on;   
%     grid on;
    
%     s=result(:,1)+result(:,3);
%     display(s);
%     plot(s);
    
%     tri=delaunay(x,y);
%     trisurf(tri,x,y,z);

%     rangeY=floor(min(y):2:ceil(max(y)));
%     rangeX=floor(min(x)):2:ceil(max(x));
%     [X,Y]=meshgrid(rangeX,rangeY);
%     Z=griddata(x,y,z,X,Y,'cubic');
%     surf(X,Y,Z);
%     
%     xlabel('Cloud Cost');ylabel('Network Cost');zlabel('Terminal Cost');


set(findall(gcf,'type','text'),'FontSize',14);
hline = findobj(gcf, 'type', 'line');
set(hline,'LineWidth',1);
hFig = figure(1);
set(hFig, 'Position', [300 300 800 600])