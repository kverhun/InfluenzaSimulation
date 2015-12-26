function c = cost(...
    vec_kappa, ... % vector
    eff, ...
    L, ...
    c_kappa ...
    )

    start_state = [0.95 0.025 0 0 0.025 0 0];
    c = 0;
    for i = 1:18
        if i >= 10 && i<=14
            kappa = vec_kappa(i - 9);
        else
            kappa = 0;
        end
        [R_I, start_state] = risk(kappa, eff, start_state);
        c = c + c_kappa(kappa) +  R_I * L;
    end
end

