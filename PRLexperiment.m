
clc
clear
close all

%%

param.ratep         = 0.3 ;
param.rateq         = 0.4 ;
param.nState        = 4 ;

fsigmoid            = @(x, sigma) 1./(1+exp(-(x)./sigma)) ;
sigma               = 0.5 ;

%%

Prob                = 0.8; % [0.6 0.7 0.8]  ;
Lblocks             = 20 ; % [80   60  40] ;

ProbVec             = [Prob;     1-Prob; Prob] ;
LblocksVec          = [Lblocks; Lblocks; Lblocks] ;
Stimulus.prob       = repelem(ProbVec, Lblocks) ;

%% 

S = fSimulateRDMP(param, Stimulus) ;

%%

colorS = [
        254    187    108
        253    158    92
        231    130    77
        181    103    62
        138    80    47]./256 ;
colorW = [
         34    255    109
         29    221    125
         23    179    142
         18    141    162
         13    103    179]./256 ;

extr    = 10 ;
wdth    = 0.03 ;
xrange  = 0.66 ;

%%

figure(1)
hold on
for cnt_cl = 1:param.nState
    plot(1:2*Lblocks, S.strong(Lblocks+1:end,cnt_cl),'LineWidth',4, 'color', colorW(cnt_cl,:))
end
set(gca,'FontName','Helvetica','FontSize',25,'FontWeight','normal','LineWidth',2,'XTick',Lblocks/2:Lblocks/2:2*Lblocks,'ytick',0:0.2:1, 'xticklabel', Lblocks/2:Lblocks/2:2*Lblocks )
set(gca,'TickDir','out')
box off
axis([0 Lblocks+extr 0-wdth xrange])
rectangle('Position',[0,0-wdth,Lblocks, wdth],'FaceColor','g', 'edgeColor','g')
rectangle('Position',[Lblocks,0-wdth,Lblocks+extr, wdth],'FaceColor','m', 'edgeColor','m')

axes('Position',[0.26 0.7 .2 .2])
plot(1:param.nState, mean(S.strong(2*Lblocks-round(Lblocks/4):2*Lblocks,:),1),'d--','color', 'k','LineWidth',3.5,'MarkerFaceColor','k', 'Markersize', 6)
set(gca,'FontName','Helvetica','FontSize',23,'FontWeight','normal','LineWidth',2,'XTick',1:param.nState,'ytick',0:0.2:1,'XTicklabel',{[]})
set(gca,'TickDir','out')
box off
axis([0.5 param.nState+.5 0 0.5])


FigW = 5 ;
FigH = 4.3 ;
set(gcf,'units','centimeters')
set(gcf,'position',[10,10,3*FigW,3*FigH],'PaperSize',[FigW FigH],'PaperPosition',[0,0,FigW,FigH],'units','centimeters'); 
pause(1)
cd Figures
print('-dpdf','-r500',[sprintf('%s%s','RDMP_strong','.pdf')])
cd ../

%%

figure(2)
hold on
for cnt_cl = 1:param.nState
    plot(1:2*Lblocks, S.weak(Lblocks+1:end,cnt_cl),'LineWidth',4, 'color', colorS(cnt_cl,:))
end
set(gca,'FontName','Helvetica','FontSize',25,'FontWeight','normal','LineWidth',2,'XTick',Lblocks/2:Lblocks/2:2*Lblocks,'ytick',0:0.2:1, 'xticklabel', Lblocks/2:Lblocks/2:2*Lblocks )
set(gca,'TickDir','out')
box off
axis([0 Lblocks+extr 0-wdth xrange])
rectangle('Position',[0,0-wdth,Lblocks, wdth],'FaceColor','g', 'edgeColor','g')
rectangle('Position',[Lblocks,0-wdth,Lblocks+extr, wdth],'FaceColor','m', 'edgeColor','m')

 axes('Position',[0.26 0.7 .2 .2])
plot(1:param.nState, mean(S.weak(2*Lblocks-round(Lblocks/4):2*Lblocks,:),1),'d--','color', 'k','LineWidth',3.5,'MarkerFaceColor','k', 'Markersize', 6)
set(gca,'FontName','Helvetica','FontSize',23,'FontWeight','normal','LineWidth',2,'XTick',1:param.nState,'ytick',0:0.2:1,'XTicklabel',{[]})
set(gca,'TickDir','out')
box off
axis([0.5 param.nState+.5 0 0.5])



FigW = 5 ;
FigH = 4.3 ;
set(gcf,'units','centimeters')
set(gcf,'position',[10,10,3*FigW,3*FigH],'PaperSize',[FigW FigH],'PaperPosition',[0,0,FigW,FigH],'units','centimeters'); 
pause(1)
cd Figures
print('-dpdf','-r500',[sprintf('%s%s','RDMP_weak','.pdf')])
cd ../
