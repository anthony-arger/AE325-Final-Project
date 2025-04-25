function [CL, CDi] = vortex_lattice_method(wing_geom, alpha_deg, N_span, N_chord, U, rho)
% VORTEX_LATTICE_METHOD Computes CL and CDi using a basic VLM implementation
%   wing_geom: struct with fields
%     .b: wingspan (m)
%     .c: chord length (m)
%     .sweep: sweep angle in degrees
%   alpha_deg: angle of attack in degrees
%   U: the speed the aircraft is flying at
%   N_span: number of panels along span
%   N_chord: number of panels along chord
% Assumes a thin, symmetric, infinitely thin wing (no camber or thickness)

% Convert inputs
alpha = deg2rad(alpha_deg);
sweep = deg2rad(wing_geom.sweep);
b = wing_geom.b;
c = wing_geom.c;

% Discretization
half_span = b / 2;
dy = half_span / N_span;
dx = c / N_chord;

% Control points and vortex points
% note that x is in the freestream direction, not the y which goes from
% wingtip to wingtip
x_cp = dx * (0.75:1:N_chord)';
x_vortex = dx * (0.25:1:N_chord)';
y_cp = dy * (0.5:1:N_span);
y_vortex = dy * (0:1:N_span);

% Create grid of control points
[X_cp, Y_cp] = meshgrid(x_cp, y_cp);
[X_vor, Y_vor] = meshgrid(x_vortex, y_vortex);

% Add sweep changes
X_cp = X_cp + tan(sweep) * Y_cp;
X_vor = X_vor + tan(sweep) * Y_vor;

n_panels = N_chord * N_span;
A = zeros(n_panels);
RHS = zeros(n_panels, 1);

% Loop over control points (i) and vortex segments (j)
for i = 1:n_panels
    ix = mod(i-1, N_chord) + 1;
    iy = floor((i-1)/N_chord) + 1;
    x_i = X_cp(iy,ix);
    y_i = Y_cp(iy,ix);
    
    for j = 1:n_panels
        jx = mod(j-1,N_chord) + 1;
        jy = floor((j-1)/N_chord) + 1;
        xj = X_vor(jy,jx);
        yj1 = Y_vor(jy,jx);
        yj2 = Y_vor(jy+1,jx);

        W(i,j) = (-1/(iy-yj1)+1/(iy-yj2))/(4*pi);
        A(i,j) = 2*kroneckerDelta(i,j)/(U*dy)-(a0/U)*W(i,j);

        % Biot-Savart influence calculation
        % r1 = [x_i - xj, y_i - yj1, 0];
        % r2 = [x_i - xj, y_i - yj2, 0];
        % dl = [0, yj2 - yj1, 0];
        % r0 = cross(dl, (r1 + r2));
        % r_mag = norm(r1) * norm(r2) + dot(r1, r2);
        % V_ind = r0 / (4 * pi * norm(cross(dl, r1))^2 + eps);

        % A(i, j) = dot([nx, ny, nz], V_ind);
    end
    % do the uinf(alpha-apanel) apanel is assumed to be 0 here but need to
    % affirm
    RHS(i) = -U*(alpha);
end

% Solve linear system
Gamma = A \ RHS;


q_inf = 0.5*rho*U^2;
% use the 3D kutta condition - need to affirm
lift = sum(Gamma)*dx*dy*q_inf;
CL=2*lift/(rho*U^2*b*c);

% Induced drag (simplified)
CDi = CL^2/(pi*b^2/c);
end


