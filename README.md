# Silent-Hunter-High-Skew-Naval-Propeller

### 1\. Conceptual Design & Material Selection

We started by defining the parameters for a "best-in-class" naval propeller capable of propelling large warships (Battleships/Carriers).

-   **Engineering Goals:** Minimize cavitation noise (stealth), maximize efficiency (fuel economy), and handle massive torque.

-   **Materials:** We established a toggle for **Carbon Fiber** (lighter, stiffer, allows complex shapes) versus **NiBrAl** (traditional high-strength alloy).

-   **Scale:** We set the dimensions to match Iowa-class and Nimitz-class standards: **25-foot diameter** with a **32-inch shaft**.

### 2\. Design Iteration 1: The "Silent Hunter" (Skewed)

-   **Geometry:** We built a script using advanced math to generate a **High-Skew Propeller**.

-   **Features:** It featured non-linear twist and a "scimitar" blade shape. This is the current standard for modern destroyers and submarines because the skewed blade enters the water wake gradually, reducing vibration.

### 3\. Design Iteration 2: The "Infinity" (Toroidal)

-   **Evolution:** You requested we switch to an experimental **Toroidal (Loop) design**, similar to the Sharrow propeller, but scaled up for a battleship.

-   **Geometry:** I rewrote the math to generate continuous loops rather than open-tipped blades.

-   **Benefit:** This creates a "fluid ring" that eliminates tip vortices (the biggest source of energy loss). The closed-loop structure is also inherently stiffer, making it the ideal candidate for the Carbon Fiber material option we discussed.

### 4\. Final Assembly: The "Montana" Fitment

-   **Integration:** We took your specific 3D model files for the **Battleship Montana** (`Montana_Aft.obj`).

-   **Analysis:** I analyzed the vertex data of your file to find the ship's scale and location in 3D space (centered roughly at Z: 140m).

-   **Fitment Script:** I wrote a final assembly script that:

    1.  Imports your specific hull mesh.

    2.  Generates four "Infinity" Toroidal propellers.

    3.  Positions them in the standard 4-shaft configuration (two inboard, two outboard) at the estimated coordinates of the Montana's shaft exits.
