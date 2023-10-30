function touchdown = checkTouchdown(uav_state, reference)

touchdown = false;

if (uav_state(3) - reference(3) <= 0.05)
    touchdown = true;
end

end