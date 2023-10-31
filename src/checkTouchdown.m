function touchdown = checkTouchdown(uav_state, reference)

touchdown = false;

if (abs(uav_state(3) - reference(3,2)) <= 0.05)
    touchdown = true;
end

end