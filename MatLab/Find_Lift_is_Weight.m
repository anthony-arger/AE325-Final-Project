function U_inf_match = Find_Lift_is_Weight(Fuselage, aerodynamics, conditions, c, b, W)
    % Define U_inf range to check
    U_inf_values = linspace(0, 200, 200); % Adjust range as needed
    found = false;
    
    for U_inf = U_inf_values
        conditions.U_inf = U_inf; % Updating U_inf
        
        % Compute drag and lift with the new value
        [Drag, Lift] = GetTotalAerodynamics(Fuselage, aerodynamics, conditions, c, b);
        
        % Check if Lift is within 5% of W
        if abs(abs(W / Lift) - 1) < 0.05
            found = true;
            U_inf_match = U_inf;
            break;
        end
    end
    
    if ~found
        U_inf_match = NaN; % No match found
        return;
    end
    
    % Refinement to three decimal places using binary search
    lower_bound = U_inf_match - 0.1;
    upper_bound = U_inf_match + 0.1;
    
    while (upper_bound - lower_bound) > 1e-3
        U_inf_refined = (lower_bound + upper_bound) / 2;
        conditions.U_inf = U_inf_refined;
        
        % Compute refined Lift
        [Drag, Lift] = GetTotalAerodynamics(Fuselage, aerodynamics, conditions, c, b);
        
        if abs(abs(W / Lift) - 1) < 0.005  % Tighter tolerance
            U_inf_match = U_inf_refined;
            upper_bound = U_inf_refined;
        else
            lower_bound = U_inf_refined;
        end
    end
end

