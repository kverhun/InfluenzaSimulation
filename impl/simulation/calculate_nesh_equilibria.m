function [equ_kappa, equ_costs] = calculate_nesh_equilibria(...
    L, ...
    c_kappa, ...
    eff ...
    )

    equ_kappa = 0:0.025:0.5;
    c_values = [];
    r_values = [];
    
    equ_kappa = cartesianProduct({equ_kappa,equ_kappa,equ_kappa,equ_kappa,equ_kappa});
    
    for j = 1:length(equ_kappa)
        %r_values(end+1) = risk(j, eff);
        c_values(end+1) = cost(equ_kappa(j,:), eff, L, c_kappa);
    end
    
    %figure
    %plot(equ_kappa,r_values);
    
    %figure
    %plot(equ_kappa,c_values)
    [ymax,imax,ymin,imin] = extrema(c_values);
    %hold on
    %plot(equ_kappa(imax),ymax,'r*',equ_kappa(imin),ymin,'g*');
    
    equ_kappa = equ_kappa(imin,:);
    equ_costs = ymin;
end

