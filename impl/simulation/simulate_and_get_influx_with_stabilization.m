% state:
%  (1) - S
%  (2) - I
%  (3) - G
%  (4) - IG
%  (5) - R_I
%  (6) - R_G
%  (7) - R_IG
% params:
%  (1)  - beta_I
%  (2)  - beta_G
%  (3)  - beta_IG
%  (4)  - gamma_I
%  (5)  - gamma_G
%  (6)  - gamma_IG
%  (7)  - omega_I
%  (8)  - omega_G
%  (9)  - omega_IG
%  (10) - X

% example:
% simulate_and_get_influx_with_stabilization([0.95 0.025 0 0 0.025 0 0], [0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.1], 1, 30, 360, 1000)

function [state, I, G ] = simulate_and_get_influx_with_stabilization(...
    start_state, ... % start state
    params,      ... % params: see above
    delta_t,     ... % time step for simutation
    accumulation_period, ...
    period,      ... % simulation time
    stabilization_period ...
    )
	stabilized_state = simulate_process(start_state, params, delta_t, stabilization_period);
	[state, I, G] = simulate_and_get_influx(stabilized_state, params, delta_t, accumulation_period, period);
end