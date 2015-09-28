(function() {
  var calculateSize, firstTime, hideVideo, lastSize, lastTime, lastTop0, onMenu, onSearch, showVideo, showingVideo, toggle;

  lastSize = window.$size;

  lastTop0 = true;

  lastTime = new Date().getTime();

  showingVideo = true;

  firstTime = true;

  onSearch = false;

  onMenu = false;

  toggle = function(item) {
    switch (item) {
      case 'hamburger':
        if ($('#hamburger').length) {
          $('body').toggleClass('pushed');
          onMenu = $('body').hasClass('pushed');
          if (onMenu) {
            return hideVideo();
          }
        }
        break;
      case 'search':
        if ($('#search').length) {
          $('#search').toggleClass('open');
          $('#search-input').focus();
          $('html').toggleClass('fixed');
          onSearch = $('html').hasClass('fixed');
          if (onSearch) {
            return hideVideo();
          }
        }
    }
  };

  calculateSize = function() {
    if (window.$xs || window.$sm) {
      if (window.$size !== lastSize) {
        return hideVideo();
      }
    } else {
      if ($('body').hasClass('top-0') !== lastTop0) {
        lastTop0 = $('body').hasClass('top-0');
        if (lastTop0) {
          return lastTime = new Date().getTime();
        } else {
          if (firstTime) {
            return firstTime = false;
          } else {
            $('#bg-video video').get(0).pause();
            $('html').removeClass('background-video');
            showingVideo = false;
            return $('#view-more').text('VIEW MORE');
          }
        }
      }
    }
  };

  showVideo = function() {
    $('html').addClass('background-video');
    $('#bg-video video').get(0).play();
    return showingVideo = true;
  };

  hideVideo = function() {
    $('html').removeClass('background-video');
    $('#bg-video video').get(0).pause();
    return lastSize = window.$size;
  };

  $(function() {
    var sizeItv;
    $('.carousel').carousel(function() {
      return {
        interval: 2000
      };
    });
    $('.action-hamburger, #menu_cover').click(function() {
      return toggle('hamburger');
    });
    $('.action-search, .search-close').click(function() {
      return toggle('search');
    });
    sizeItv = setInterval(function() {
      return calculateSize(window.$size);
    }, 100);
    return $(window).on('mousewheel', function() {
      if (!onSearch && !onMenu) {
        if (lastTop0 && !showingVideo) {
          if (new Date().getTime() - lastTime > 500) {
            return showVideo();
          }
        }
      }
    });
  });

}).call(this);
