/*
 *
 *   INSPINIA - Responsive Admin Theme
 *   version 2.4
 *
 */


$(document).ready(function () {



    // MetsiMenu
    $('#side-menu').metisMenu();







    // Open close right sidebar
    $('.right-sidebar-toggle').click(function () {
        $('#right-sidebar').toggleClass('sidebar-open');
    });

});

