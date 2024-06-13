
//-------------------------------------------------------------------------------------------------------------------------------------*/

// ╭∩╮     ╭∩╮
//  \(͡⚈ᴗ͡⚈)/

//-------------------------------------------------------------------------------------------------------------------------------------*/

console.log("TESTTEST")

document.getElementById('navbarOpenButton').addEventListener('click', function() {
    var container = document.getElementById('navbar-container');
    var screenWidth = window.innerWidth;
    var targetWidth = screenWidth * 0.5; // Zielbreite = 50% der Bildschirmbreite

    // Animation starten
    container.style.width = targetWidth + 'px';
});
