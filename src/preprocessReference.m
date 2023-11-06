function ref = preprocessReference(ref, x, dT)

uav_usv_distance = x(3) - ref(3,1);
approach_velocity = 1; % m/s

for i=1:length(ref)
    
    uav_usv_distance = uav_usv_distance - approach_velocity*dT;
    
    if uav_usv_distance <= 0
        uav_usv_distance = 0;
    end
    
    ref(3,i) = ref(3,i) + uav_usv_distance;
    ref(9,i) = ref(9,i) - approach_velocity;
    
end

end