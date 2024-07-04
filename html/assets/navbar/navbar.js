//-------------------------------------------------------------------------------------------------------------------------------------*/

// ╭∩╮     ╭∩╮
//  \(͡⚈ᴗ͡⚈)/

//-------------------------------------------------------------------------------------------------------------------------------------*/

document.addEventListener("DOMContentLoaded", function() {
    const toggleButton = document.getElementById("navbarOpenButton");
    const navbarContainer = document.getElementById("navbarContainer");

    if (toggleButton && navbarContainer) {
        toggleButton.addEventListener("click", function() {
            if (navbarContainer.classList.contains("navbar-open")) {
                // Navbar closed
                navbarContainer.classList.remove("navbar-open");
                navbarContainer.style.width = "0";
                console.log("Navbar closed");
              } 
              
            else {
                // Navbar opened
                navbarContainer.classList.add("navbar-open");
                navbarContainer.style.width = "475px";
                console.log("Navbar opened");
            }
        });

        // Observe scrolling-behavior
        window.addEventListener("scroll", function() {
            const scrollPosition = window.scrollY;
            navbarContainer.style.top = scrollPosition + "px";
        });
    } 
    
    else {
        console.error("toggleButton oder navbarContainer not found!");
    }
});