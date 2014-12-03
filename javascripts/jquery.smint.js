/*

  SMINT V1.0 by Robert McCracken

  SMINT is my first dabble into jQuery plugins!

  http://www.outyear.co.uk/smint/

  If you like Smint, or have suggestions on how it could be improved, send me a tweet @rabmyself

*/
(function(){

    
    $.fn.smintMenu = function(options) {
	var menu = $(this), stickyTop, stickyMenu;

	// get initial top offset for the menu 
	menu.prop("stickyTop", menu.offset().top);
	menu.prop("stickyInitialPosition", menu.css('position'));
	menu.prop("stickyInitialTop", menu.css('top'));

	stickyTop = menu.prop("stickyTop");
	// fix position once and for all
	menu.css({ 'position': 'fixed', 'top': 0 }).addClass('fixed').removeClass('unfixed'); 
    }



    $.fn.smint = function(options) {
	var link = $(this), scrollSpeed, menu;

	scrollSpeed = link.data('scroll-speed') || 500;
	if ( options.scrollSpeed ) {
	    scrollSpeed = options.scrollSpeed
	}
	
	menu = $('*[data-smint-menu="' + link.data('smint') + '"]').first();
	if (menu[0] === undefined || menu[0] === null) {
	    console.log("Cannot find smint menu: " + link.data('smint'));
	    return link;
	}
	link.prop("smintMenu", menu);

        link.on('click', function(e){
	    var element = $(this), selectorHeight, id, goTo;
	    
	    // gets the height of the users div. This is used for off-setting the scroll so th emenu doesnt overlap any content in the div they jst scrolled to
	    selectorHeight = element.prop("smintMenu").height();   
	    
	    // get id of the button you just clicked
	    id = element.attr('href');
	    
	    // gets the distance from top of the div class that matches your button id minus the height of the nav menu. This means the nav wont initially overlap the content.
	    goTo = $(id).offset().top - selectorHeight + 1;
	    
	    // Scroll the page to the desired position!
	    $("html, body").animate({ scrollTop: goTo }, scrollSpeed);

	    // Stop event propagation
	    return true;
	});	
	return link;
    }



    $(document).ready(function () {
	$('*[data-smint-menu]').smintMenu();
    });

    $(document).ready(function () {
	$('*[data-smint]').smint({scrollSpeed: 1234});
    });

    $(document).on("page:load", function () {
	$('*[data-smint-menu]').smintMenu();
	$('*[data-smint]').smint({scrollSpeed: 1234});
    });


})();
