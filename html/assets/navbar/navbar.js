
//-------------------------------------------------------------------------------------------------------------------------------------*/

// ╭∩╮     ╭∩╮
//  \(͡⚈ᴗ͡⚈)/

//-------------------------------------------------------------------------------------------------------------------------------------*/

document.addEventListener("DOMContentLoaded", function() {
    const toggleButton = document.getElementById("navbarOpenButton");
    const navbarContainer = document.getElementById("navbarContainer");

    toggleButton.addEventListener("click", function() {
        if (navbarContainer.classList.contains("navbar-open")) {
            // close navbar
            navbarContainer.classList.remove("navbar-open");
            navbarContainer.style.width = "0";
        } else {
            // open navbar
            navbarContainer.classList.add("navbar-open");
            navbarContainer.style.width = "475px";
        }
    });
});
