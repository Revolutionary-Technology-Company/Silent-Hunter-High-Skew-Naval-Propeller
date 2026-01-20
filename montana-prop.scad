// =================================================================
// PROJECT: MONTANA BATTLESHIP PROPULSION FITMENT
// PART:    Aft Hull + 4x Toroidal Propellers
// =================================================================

// --- 1. SHIP CONFIGURATION ---
// Adjust these values to align propellers perfectly with the shafts
// Based on OBJ analysis, the hull is in the negative X, positive Y/Z octant.

// Master Scale (If the OBJ is in inches, set to 0.0254. Assuming Meters = 1)
ship_scale = 1.0; 

// Approximate Shaft Positions (Guessing based on vertex data)
// You MUST tweak these to fit the specific model's shaft exits
inner_prop_pos = [-72, 53, 140]; // Port Inner
outer_prop_pos = [-80, 56, 130]; // Port Outer

// Propeller Specs (Montana Class)
prop_diameter = 7.62;   // 25 ft
shaft_diameter = 0.81;  // 32 inches

// --- 2. IMPORT HULL ---
module battleship_hull() {
    color("LightGrey") 
    import("Montana_Aft.obj");
}

// --- 3. TOROIDAL PROPELLER MODULE (The "Infinity" Design) ---
module torpedo_prop() {
    num_loops = 4;
    root_radius = shaft_diameter * 0.7;
    thickness_base = 0.12; 
    
    module airfoil(w, h) {
        scale([w, h, 1]) circle(r=0.5, $fn=30);
    }

    // Color the prop Bronze/Gold
    color("Goldenrod") 
    union() {
        // HUB
        difference() {
            cylinder(h=shaft_diameter*3, r1=shaft_diameter*1.1, r2=shaft_diameter*0.7, center=true, $fn=50);
            cylinder(h=shaft_diameter*4, r=shaft_diameter*0.5, center=true, $fn=50);
        }

        // BLADES (Simplified for rendering speed in assembly)
        for (b = [0 : num_loops - 1]) {
            rotate([0, 0, b * (360 / num_loops)])
            translate([0,0,-shaft_diameter])
            loop_blade(prop_diameter/2, root_radius);
        }
    }
}

module loop_blade(max_r, root_r) {
    // Optimized loop generation for assembly view
    steps = 40; 
    for (i = [0 : steps-1]) {
        t_curr = i / steps;
        t_next = (i+1) / steps;
        
        rad_c = root_r + (max_r - root_r) * sin(t_curr * 180);
        rad_n = root_r + (max_r - root_r) * sin(t_next * 180);
        
        ang_c = (t_curr * 80) + (20 * sin(t_curr * 360));
        ang_n = (t_next * 80) + (20 * sin(t_next * 360));
        
        z_c = t_curr * 3;
        z_n = t_next * 3;
        
        hull() {
            translate([0,0,z_c]) rotate([0,0,ang_c]) translate([rad_c,0,0]) rotate([45,0,0]) 
                linear_extrude(0.1) circle(r=0.2);
            translate([0,0,z_n]) rotate([0,0,ang_n]) translate([rad_n,0,0]) rotate([45,0,0]) 
                linear_extrude(0.1) circle(r=0.2);
        }
    }
}

// --- 4. FINAL ASSEMBLY ---

// Render the Ship
battleship_hull();

// Render Port Side Propellers
translate(inner_prop_pos) 
    rotate([0, 90, 0]) // Rotate to align with shaft (usually Y or Z axis depending on model)
    torpedo_prop();

translate(outer_prop_pos) 
    rotate([0, 90, 0]) 
    torpedo_prop();

// Render Starboard Side (Mirrored)
// Assuming X=0 is centerline. If model is offset, you must calculate the offset.
// Since vertices are all negative X (-60 to -80), this OBJ might be HALF the ship 
// or offset. I will place the starboard props at positive X approximations.

mirror([1,0,0]) {
    translate(inner_prop_pos) 
        rotate([0, 90, 0]) 
        torpedo_prop();

    translate(outer_prop_pos) 
        rotate([0, 90, 0]) 
        torpedo_prop();
}
