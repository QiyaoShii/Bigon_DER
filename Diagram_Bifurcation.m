clear all; clc;
%% 2.37 bifurcation diagram

figure('units','normalized','position',[.3 .1 .22 .28]);
axis on
ax = gca;               % get the current axis
ax.Clipping = 'off';
%% Basic solution
[m,BP,Mo,Num_BP,Stability_Sign] = read_BP_data('V2_basic');

%%%graphics
normX=cell2mat(m(2:Num_BP(1),8));disY=cell2mat(m(2:Num_BP(1),12));
plot(normX,disY,'-','Color','k','LineWidth',2)
hold on
axis equal
normX=cell2mat(m(Num_BP(1):end,8));disY=cell2mat(m(Num_BP(1):end,12));
plot(normX,disY,'-','Color','[0.65 0.65 0.65]','LineWidth',2)
hold on
axis equal

%%%Legend
plot(BP(1),Mo(1),'o','MarkerSize',5.0,'MarkerEdgeColor','k','MarkerFaceColor','k')
hold on
text('Position',[BP(1)-0.002,Mo(1)+0.002],'string','$B_1$','Interpreter','latex','FontSize',18)
hold on
plot(BP(2),Mo(2),'o','MarkerSize',5.0,'MarkerEdgeColor','k','MarkerFaceColor','k')
hold on
text('Position',[BP(2)-0.002,Mo(2)+0.002],'string','$B_2$','Interpreter','latex','FontSize',18)
hold on


