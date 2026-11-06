// ============================================================
// Dual Scoop Case - Print Ready v3
// Matched to photos: ~100 mm L, 18 mm bowls, removable scoops
// Designed for FDM (Dremel / similar) - minimal supports
// ============================================================

// ---------- GLOBAL PARAMETERS ----------
L               = 100;     // overall length
W               = 42;      // overall width (closed)
H               = 17;      // closed height
wall            = 1.6;

// Scoop / tray
scoop_d         = 18;
handle_l        = 60;
tray_w          = 8.2;
tray_d          = 3.5;
scoop_clear     = 0.4;     // radial clearance for removable scoops

// Hinge (living hinge style)
hinge_len       = 16;
hinge_thick     = 0.9;     // living hinge thickness (print in PETG for flexibility)
hinge_gap       = 0.3;

// Print helpers
$fn = 64;                  // smoothness

// ---------- HELPERS ----------
module rounded_rect(size, r) {
    x = size[0]; y = size[1]; z = size[2];
    translate([r, r, 0])
        linear_extrude(height = z)
            offset(r = r)
                square([x - 2*r, y - 2*r]);
}

// ---------- REMOVABLE SCOOP PIECE ----------
// Print 2 of these. Orient bowl down or on side depending on preference.
module scoop_piece() {
    union() {
        // Linear handle / tray section
        translate([0, -tray_w/2, 0])
            cube([handle_l, tray_w, tray_d]);

        // Round bowl (half-sphere style well)
        translate([handle_l + scoop_d/2 - 1.8, 0, 0]) {
            difference() {
                sphere(d = scoop_d);
                // cut bottom so it sits flat
                translate([-scoop_d, -scoop_d, -scoop_d - 0.1])
                    cube([2*scoop_d, 2*scoop_d, scoop_d]);
            }
        }
    }
}

// ---------- CASE HALF ----------
// Print two (one is mirrored). Living hinge connects them.
module case_half(is_bottom = true) {
    difference() {
        // Outer shell
        rounded_rect([L, W/2 + 0.8, H/2], 3.2);

        // Main interior cavity
        translate([wall, wall, wall])
            rounded_rect([L - 2*wall, W/2 - 0.5, H/2], 2.2);

        // Tray channel for the scoop handle
        translate([wall + 1.5, wall + 1.0, wall - 0.1])
            cube([handle_l + 8, tray_w + scoop_clear*2, tray_d + 1.2]);

        // Bowl well / socket
        translate([
            wall + handle_l + scoop_d/2 - 0.8,
            W/4 + 0.6,
            wall + 0.6
        ])
            sphere(d = scoop_d + scoop_clear*2);

        // Small relief so the hinge can flex cleanly
        if (is_bottom) {
            translate([L/2 - hinge_len/2 - 1, W/2 - 0.5, H/4 - 1])
                cube([hinge_len + 2, 2, 3]);
        }
    }

    // Living hinge tab (print thin in PETG or carefully in PLA)
    translate([L/2 - hinge_len/2, W/2 - 0.15, H/4 - hinge_thick/2])
        cube([hinge_len, 1.8, hinge_thick]);
}

// ============================================================
// PREVIEW (comment out for single-part export)
// ============================================================
// Bottom half
translate([0,  28, 0]) case_half(true);
// Top half (mirrored)
translate([0, -28, 0]) mirror([0, 1, 0]) case_half(false);

// Two scoop pieces
translate([0,  65, 0]) scoop_piece();
translate([0, -65, 0]) scoop_piece();

// ============================================================
// SINGLE PART EXPORTS
// Uncomment ONE of the lines below, comment the preview above,
// then render (F6) and export STL.
// ============================================================
// scoop_piece();          // print 2x
// case_half(true);        // bottom
// case_half(false);       // top (or mirror in slicer)
