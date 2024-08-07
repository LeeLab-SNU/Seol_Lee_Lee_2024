UnitPair=UnitPairT;


pid = 12;

rb = redblue(256);

UP = UnitPair.SUB; UT = UnitsTable.SUB; UTF = UnitsTable_field.SUB; FR = FRMaps.SUB; FRF = FRMaps.SUB_field;
for pid = 1:size(UP,1)
    ID1 = UP.UID1{pid}; id1 = find(strcmp(ID1,UT.ID));
    ID2 = UP.UID2{pid}; id2 = find(strcmp(ID2,UT.ID));

    Clist_f = {'#FF6A68','#00B455','#00A2FF','#FA7344','#00B7A1'};
    Maps_f = FRMaps.SUB_field;


    thisField_1 = UTF(find(strncmp(UTF.ID,UP.UID1{pid},12)),:);
    thisField_2 = UTF(find(strncmp(UTF.ID,UP.UID2{pid},12)),:);
    %%
            Norm_FRf_1 = [];
            for f = 1:size(thisField_1,1)
                FID = find(strcmp(UTf.ID,thisField_1.ID{f}));
                Norm_FRf_1(f,:) = FRF(1,:,FID) ./ max(FRF(1,:,FID));
            end
            Norm_FRf_1 = nanmean(Norm_FRf_1,1); Norm_FRf_1(isnan(Norm_FRf_1))=0;

            Norm_FRf_2 = [];
            for f = 1:size(thisField_2,1)
                FID = find(strcmp(UTf.ID,thisField_2.ID{f}));
                Norm_FRf_2(f,:) = FRF(1,:,FID) ./ max(FRF(1,:,FID));
            end
            Norm_FRf_2 = nanmean(Norm_FRf_2,1); Norm_FRf_2(isnan(Norm_FRf_2))=0;

    RDI_L1 = []; RDI_R1 = []; RDI_C1 = [];
    for f = 1:size(thisField_1,1)
        F = load([ROOT.Unit1 '\' thisField_1.ID{f} '.mat'],'RDIs_field'); F= F.RDIs_field;
        if size(F,1)<3, F(3,:)=nan; end
        RDI_L1 = [RDI_L1;interp1(1:size(F,2),F(1,:),linspace(1,size(F,2),40))];
        RDI_R1 = [RDI_R1; interp1(1:size(F,2),F(2,:),linspace(1,size(F,2),40))];
        RDI_C1 = [RDI_C1; interp1(1:size(F,2),F(3,:),linspace(1,size(F,2),40))];
    end

    RDI_L2 = []; RDI_R2 = []; RDI_C2 = [];
    for f = 1:size(thisField_2,1)
        F = load([ROOT.Unit1 '\' thisField_2.ID{f} '.mat'],'RDIs_field'); F= F.RDIs_field;
        if size(F,1)<3, F(3,:)=nan; end
        RDI_L2 = [RDI_L2;interp1(1:size(F,2),F(1,:),linspace(1,size(F,2),40))];
        RDI_R2 = [RDI_R2; interp1(1:size(F,2),F(2,:),linspace(1,size(F,2),40))];
        RDI_C2 = [RDI_C2; interp1(1:size(F,2),F(3,:),linspace(1,size(F,2),40))];
    end

    RDI_L1(isnan(RDI_L1))=0; RDI_L2(isnan(RDI_L2))=0;
    %             RDI_L1(abs(thisField_1.RDI_LScene)<0.1,:)=[]; if(isempty(RDI_L1)), RDI_L1=nan(1,40); end
    %             RDI_L2(abs(thisField_2.RDI_LScene)<0.1,:)=[]; if(isempty(RDI_L2)), RDI_L2=nan(1,40); end

    RDI_R1(isnan(RDI_R1))=0; RDI_R2(isnan(RDI_R2))=0;
    %             RDI_R1(abs(thisField_1.RDI_RScene)<0.1,:)=[]; if(isempty(RDI_R1)), RDI_R1=nan(1,40); end
    %             RDI_R2(abs(thisField_2.RDI_RScene)<0.1,:)=[]; if(isempty(RDI_R2)), RDI_R2=nan(1,40); end

    RDI_C1(isnan(RDI_C1))=0; RDI_C2(isnan(RDI_C2))=0;
    %             RDI_C1(abs(thisField_1.RDI_LR)<0.1,:)=[]; if(isempty(RDI_C1)), RDI_C1=nan(1,40); end
    %             RDI_C2(abs(thisField_2.RDI_LR)<0.1,:)=[]; if(isempty(RDI_C2)), RDI_C2=nan(1,40); end

    RDI_L1m = nanmean(RDI_L1,1); RDI_R1m = nanmean(RDI_R1,1);  RDI_C1m = nanmean(RDI_C1,1);
    RDI_L2m = nanmean(RDI_L2,1); RDI_R2m = nanmean(RDI_R2,1);  RDI_C2m = nanmean(RDI_C2,1);


%     mdl = corr(RDI_C1m' ,RDI_C2m' )
    %%
    figure('position',[135,80,1041,885])


    subplot('position',[.1 .7 .3 .03])
    FL = FR(1,:,id1)'; FL(isnan(FL))=[]; FL(FL==0)=[];
    imagesc(smooth(Norm_FRf_1)'); axis off
    idf1 = find(strncmp(UT.ID{id1},UTF.ID,12));




    subplot('position',[.5 .7 .3 .03])
    FL = FR(1,:,id2)'; FL(isnan(FL))=[]; FL(FL==0)=[];
    imagesc(smooth(Norm_FRf_2)'); axis off
    
    idf2 = find(strncmp(UT.ID{id2},UTF.ID,12));


    colormap jet


    subplot('position',[.85 .72 .1 .05])
    text(0,0,['Sp.Corr = ' jjnum2str(abs(UP.Sp(pid)),3)],'fontsize',15,'FontWeight','b')
    axis off
    %%
    subplot('position',[.1 .8 .3 .14])
    hold on
    mx=max(FR(1,:,[id1]),[],'all');
    plot(smooth(FR(1,:,id1)')','linewidth',4,'color','k')
    for f = 1:size(idf1,1)
        plot(smooth(Maps_f(1,:,idf1(f))),'linewidth',4,'color',hex2rgb(Clist_f{f}))
        %     p = plot(Maps_f(3,:,idf1(f)),'linewidth',4,'color',hex2rgb(Clist_f{f})); p.Color(4)=0.2;
        %     plot(Maps_f(3,:,idf1(f)),'linewidth',4,'color',hex2rgb(Clist_f{f}),'linestyle',':')
        %     if abs(UTF.RDI_LScene(idf1(f)))>0.1, c=hex2rgb(Clist_f{f}); else, c='k'; end
        %             text(f*5,mx,[jjnum2str(UTF.RDI_LScene(idf1(f)),2)],'color',c,'FontSize',15)
        xlim([0 30]);
        ylim([0 mx*1.1])

        settick(31,mx*1.1)
        xlabel('')
        title(['Cell 1 (' UT.ID{id1} ')'],'FontSize',15)
    end
    % title('Ratemap for Left scene trials')
    set(gca,'FontSize',12,'FontWeight','b')

    subplot('position',[.5 .8 .3 .14])
    hold on
    mx=max(FR(1,:,[id2]),[],'all');
    thisField_2 = UTF(find(strncmp(UTF.ID,UT.ID{id2},12)),:);
    plot(smooth(FR(1,:,id2)')','linewidth',4,'color','k')
    for f = 1:size(idf2,1)
        plot(smooth(Maps_f(1,:,idf2(f))),'linewidth',4,'color',hex2rgb(Clist_f{f}))
        %     p = plot(Maps_f(3,:,idf2(f)),'linewidth',4,'color',hex2rgb(Clist_f{f})); p.Color(4)=0.2;
        %     plot(Maps_f(3,:,idf2(f)),'linewidth',4,'color',hex2rgb(Clist_f{f}),'linestyle',':')
        %     if abs(UTF.RDI_LScene(idf2(f)))>0.1, c=hex2rgb(Clist_f{f}); else, c='k'; end
        xlim([0 30]);
        ylim([0 mx*1.1])

        settick(31,mx*1.1)
        xlabel('')
        title(['Cell 2 (' UT.ID{id2} ')'],'FontSize',15)
    end
    % title('Ratemap for Left scene trials')
    set(gca,'FontSize',12,'FontWeight','b')
    %%

    ax2 = subplot('position',[.1 .6 .3 .025]);
    imagesc(smooth(RDI_L1m)'); axis off
    colormap(ax2,rb); caxis([-1 1])
    title('In-field RDI mean (Left scene)','fontsize',12)

    ax3 = subplot('position',[.5 .6 .3 .025]);
    imagesc(smooth(RDI_L2m)'); axis off
    colormap(ax3,rb); caxis([-1 1])
    title('In-field RDI mean (Left scene)','fontsize',12)


    ax4 = subplot('position',[.1 .5 .3 .025]);
    imagesc(smooth(RDI_R1m)'); axis off
    colormap(ax4,rb); caxis([-1 1])
    title('In-field RDI mean (Right scene)','fontsize',12)

    ax5 = subplot('position',[.5 .5 .3 .025]);
    imagesc(smooth(RDI_R2m)'); axis off
    colormap(ax5,rb); caxis([-1 1])
    title('In-field RDI mean (Right scene)','fontsize',12)


    ax6 = subplot('position',[.1 .4 .3 .025]);
    imagesc(smooth(RDI_C1m)'); axis off
    colormap(ax6,rb); caxis([-1 1])
    title('In-field RDI mean (Choice)','fontsize',12)

    ax7 = subplot('position',[.5 .4 .3 .025]);
    imagesc(smooth(RDI_C2m)'); axis off
    colormap(ax7,rb); caxis([-1 1])
    title('In-field RDI mean (Choice)','fontsize',12)



    subplot('position',[.43 .6 .02 .1])
    text(0,0,[jjnum2str((UP.Nsp_L(pid)),3)],'fontsize',12)
    axis off

    subplot('position',[.43 .5 .02 .1])
    text(0,0,[jjnum2str((UP.Nsp_R(pid)),3)],'fontsize',12)
    axis off

    subplot('position',[.43 .4 .02 .1])
    text(0,0,[jjnum2str((UP.Nsp_C(pid)),3)],'fontsize',12)
    axis off

    subplot('position',[.83 .53 .1 .05])
    text(0,0,['Nsp.Corr = ' jjnum2str((max([UP.Nsp_L(pid) UP.Nsp_R(pid) UP.Nsp_C(pid)])),3)],'fontsize',15,'FontWeight','b')
    axis off

    %%
    %     subplot('position',[.1 .3 .3 .3]);

    %
    % for f = 1:min(4,size(idf1,1))
    %     subplot('position',[.15 .4-.03*f .2 .015]);
    %     imagesc(smooth(FRF(2,:,idf1(f))')'); axis off
    %     title(['Field ' num2str(f)],'fontsize',12,'color',hex2rgb(Clist_f{f}),'FontWeight','b')
    %     text(-3,1,'P','FontSize',15,'FontWeight','b')
    %     caxis([0 max((FRF(2:3,:,idf1(f))),[],'all')])
    %
    %         subplot('position',[.55 .4-.03*f .2 .015]);
    %     imagesc(smooth(FRF(3,:,idf1(f))')'); axis off
    %     text(-3,1,'M','FontSize',15,'FontWeight','b')
    %     caxis([0 max((FRF(2:3,:,idf1(f))),[],'all')])
    %
    % %     subplot('position',[.41 .69-.1*f .04 .05])
    % %     if abs(UTF.RDI_LScene(idf1(f)))>0.1, c='r'; else, c='k'; end
    % %     text(0,0,jjnum2str(UTF.RDI_LScene(idf1(f)),2),'fontsize',12,'FontWeight','b','color',c)
    % %     axis off
    % end


    %%

    % for f = 1:min(4,size(idf2,1))
    %     subplot('position',[.5 .70-.1*f .3 .025]);
    %     imagesc(smooth(FRF(2,:,idf2(f))')'); axis off
    %     title(['Field ' num2str(f)],'fontsize',12,'color',hex2rgb(Clist_f{f}),'FontWeight','b')
    %     text(-3,1,'Z','FontSize',15,'FontWeight','b')
    %     caxis([0 max((FRF(2:3,:,idf2(f))),[],'all')])
    %
    %         subplot('position',[.5 .66-.1*f .3 .025]);
    %     imagesc(smooth(FRF(3,:,idf2(f))')'); axis off
    %     text(-3,1,'B','FontSize',15,'FontWeight','b')
    %     caxis([0 max((FRF(2:3,:,idf2(f))),[],'all')])
    %
    %     subplot('position',[.81 .69-.1*f .04 .05])
    %     if abs(UTF.RDI_LScene(idf2(f)))>0.1, c='r'; else, c='k'; end
    %     text(0,0,jjnum2str(UTF.RDI_LScene(idf2(f)),2),'fontsize',12,'FontWeight','b','color',c)
    %     axis off
    % end
    %
    % subplot('position',[.85 .56 .1 .05])
    % text(0,0,['Nsp.Corr = ' jjnum2str((UP.Nsp_L(pid)),3)],'fontsize',12)
    % axis off
    %%

    subplot('Position',[.3 .05 .3 .26])

    bar([1 2 3 4],[UP.p(pid) UP.q(pid) UP.un(pid) UP.pq(pid)]./ UP.p0(pid))
    xticklabels({'Cell 1', 'Cell 2', '1 or 2', '1 and 2'})
    ylabel('Ripple participation rate')
    % title(['Co-Reactivation Prob. = ' jjnum2str(UP.pq(pid)/UP.un(pid),3)])
    set(gca,'fontsize',12,'FontWeight','b')

    subplot('position',[.7 .1 .1 .05])
    text(0,0,['Co-Reactivation Prob. = ' jjnum2str(UP.pq(pid)/UP.un(pid),3)],'fontsize',15,'FontWeight','b')
    axis off
    %%
    ROOT.Fig = [ROOT.Mother '\Processed Data\units_mat\ProfilingSheet\U7_sub\All'];

    if ~exist(ROOT.Fig), mkdir(ROOT.Fig); end
    saveas(gca,[ROOT.Fig '\'  UP.UID1{pid} '_' UP.UID2{pid} '.svg'])
    saveas(gca,[ROOT.Fig '\'  UP.UID1{pid} '_' UP.UID2{pid} '.png'])
    close all
end
%%
function settick(Dv,mx)
xlabel('position')
xticks([0 Dv 48])
xticklabels({'StBox','Dv','Fd'})
xlim([0 48])
ylabel('firing rate (Hz)')
ylim([0 mx*1.1])
line([Dv Dv],[0 mx*1.1],'linestyle','--','color','k')
end