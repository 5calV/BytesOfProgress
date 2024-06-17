
//-------------------------------------------------------------------------------------------------------------------------------------*/

// ╭∩╮     ╭∩╮
//  \(͡⚈ᴗ͡⚈)/

//-------------------------------------------------------------------------------------------------------------------------------------*/
document.addEventListener("DOMContentLoaded", function() {
    const toggleButton = document.getElementById("navbarOpenButton");
    const navbarContainer = document.getElementById("navbarContainer");

    // Überprüfen, ob toggleButton und navbarContainer erfolgreich gefunden wurden
    if (toggleButton && navbarContainer) {
        toggleButton.addEventListener("click", function() {
            if (navbarContainer.classList.contains("navbar-open")) {
                // Navbar schließen
                navbarContainer.classList.remove("navbar-open");
                navbarContainer.style.width = "0";
                console.log("Navbar geschlossen");
            } else {
                // Navbar öffnen
                navbarContainer.classList.add("navbar-open");
                navbarContainer.style.width = "475px";
                console.log("Navbar geöffnet");
            }
        });

        // Scrollverhalten der Hauptseite überwachen
        window.addEventListener("scroll", function() {
            const scrollPosition = window.scrollY;
            navbarContainer.style.top = scrollPosition + "px";
        });
    } else {
        console.error("toggleButton oder navbarContainer nicht gefunden");
    }
});
