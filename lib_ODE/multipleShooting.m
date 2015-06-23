function [ya] = multipleShooting(yStartEst, r, g, ta, te, Nt, Nb, Ntb, dimsys)
% y' = g(t,y(t)) ODE

%sensitivity ode
f = @(t, S, ii, para) [ -S(3); -3*para(ii)*S(1); -S(4); -3*para(ii)*S(2)];
dimSensi = 4;
%determine time interval of each block (assuming equidistancy)
deltaT = (te-ta)/Nb;
%storeage of current time evo in sliced and vertically appended blocks
currStatesEvo = zeros(dimsys*Nb,Ntb);
%variable for sensitivities at ends of blocks respectively
SvecEndBlocks = zeros(dimSensi*Nb,1);
%initialize FF and DF
FF = zeros(length(yStartEst),1);
DF = zeros(length(yStartEst),length(yStartEst));
%check if dimensions are consistent
if Nb*dimsys ~= length(yStartEst); disp('ERROR: check dimensionalities!!'); end

norm_dd = 1;
norm_rr = 1;
z=0;
while norm_dd > 10^3*eps && norm_rr > 10^-8 && z<10^4
    z = z+1;
    if z == 1
        ya = yStartEst;
    end
    
    %Time propagation of states on all blocks (parallely)
    for ib = 1:Nb %Iterate over time multiple shooting blocks
        yab = ya((ib-1)*dimsys+1:ib*dimsys); %extract initial vals of block eta_i
        [tgrid, y] = ode45(g, linspace((ib-1)*deltaT, ib*deltaT,Ntb), yab); %propagate block forward
        currStatesEvo(((ib-1)*dimsys+1):ib*dimsys,:) = y'; %save time evolution
    end
    
    %Propagation of sensitivity ode of all blocks (parallely)
    for ib = 1:Nb
        para = currStatesEvo((ib-1)*dimsys+1,:);
        tab = (ib-1)*deltaT; teb = ib*deltaT;
        [Svec, t_test] = explEulerPara(f, [1;0;0;1], tab, teb, Ntb, para);
        SvecEndBlocks(((ib-1)*dimSensi+1):ib*dimSensi) = Svec(:,end);
    end
    
    %calculate/ update vector FF containing current deviations from zero
    for ib = 1:(Nb-1)
        FF(((ib-1)*dimsys+1):ib*dimsys) = currStatesEvo(((ib-1)*dimsys+1):ib*dimsys,end) - ya(((ib)*dimsys+1):(ib+1)*dimsys);
    end
    %add last rows --> R part
    FF(((Nb-1)*dimsys+1):Nb*dimsys) = r(0, ya(1), currStatesEvo(((Nb-1)*dimsys+1):end,end));
    
    %calc/ update matrix DF containing derivative infos of FF
    for ib = 1:(Nb-1)
        Svecib = SvecEndBlocks((ib-1)*dimSensi+1:ib*dimSensi);
        Sib = [Svecib(1), Svecib(2); Svecib(3), Svecib(4)];
        DF((ib-1)*dimsys+1:ib*dimsys,(ib-1)*dimsys+1:ib*dimsys) = Sib;
        DF((ib-1)*dimsys+1:ib*dimsys,(ib)*dimsys+1:(ib+1)*dimsys) = -eye(dimsys,dimsys);       
    end
    %add last row block --> R part
    DF((Nb-1)*dimsys+1:Nb*dimsys,1:dimsys) = [-1 0;0 0];
    SvecNb = SvecEndBlocks((Nb-1)*dimSensi+1:Nb*dimSensi);
    SNb = [SvecNb(1), SvecNb(2); SvecNb(3), SvecNb(4)];
    DF((Nb-1)*dimsys+1:Nb*dimsys,(Nb-1)*dimsys+1:Nb*dimsys) = [0, 0; 5, -1]*SNb;
    
    %first: try unged = normales newton verfahren
    dd = DF\(-FF);
    
    %update ya
    ya = ya + dd;
    
    %calculate norms used for termination criterion
    norm_dd = norm(dd);
    norm_rr = norm(FF);
    
    
%     [tgrid, y] = ode45(g, linspace(ta,te,Nt), ya);
%     % calc S
%     para = y(:,1);
%     
%     [Svec, t_test] = explEulerPara(f, [1;0;0;1], ta, te, Nt, para);
%     %solve lin sys
%     AA = [-1 0;0 0] + [0 0;5*Svec(1,Nt)-Svec(2,Nt) 5*Svec(3,Nt)-Svec(4,Nt)];
%     bb = -r(0,ya(1),y(end,:));
%     dd = AA\bb;
%     ya = ya + dd
%     norm_dd = norm(dd);
%     norm_rr = norm(bb);
    
end


end