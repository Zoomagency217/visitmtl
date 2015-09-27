(function() {
  var calculateSize, firstTime, lastSize, lastTime, lastTop0, showVideo, showingVideo, toggle;

  toggle = function(item) {
    switch (item) {
      case 'hamburger':
        if ($('#hamburger').length) {
          return $('body').toggleClass('pushed');
        }
        break;
      case 'search':
        if ($('#search').length) {
          $('#search').toggleClass('open');
          $('#search-input').focus();
          return $('body').toggleClass('fixed');
        }
    }
  };

  lastSize = window.$size;

  lastTop0 = true;

  lastTime = new Date().getTime();

  showingVideo = true;

  firstTime = true;

  calculateSize = function() {
    if (window.$xs || window.$sm) {
      if (window.$size !== lastSize) {
        $('html').removeClass('background-video');
        $('#bg-video video').get(0).pause();
        return lastSize = window.$size;
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

  $(function() {
    var sizeItv;
    $('.carousel').carousel(function() {
      return {
        interval: 2000
      };
    });
    $('.action-hamburger').click(function() {
      return toggle('hamburger');
    });
    $('.action-search, .search-close').click(function() {
      return toggle('search');
    });
    sizeItv = setInterval(function() {
      return calculateSize(window.$size);
    }, 100);
    return $(window).on('mousewheel', function() {
      if (lastTop0 && !showingVideo) {
        if (new Date().getTime() - lastTime > 500) {
          return showVideo();
        }
      }
    });
  });

}).call(this);
