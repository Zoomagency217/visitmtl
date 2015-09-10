(function() {
  var resizeVideo, toggle;

  toggle = function(item) {
    switch (item) {
      case 'hamburger':
        if ($('#hamburger').length) {
          return $('body').toggleClass('pushed');
        }
    }
  };

  resizeVideo = function(ele) {
    var itv;
    return itv = setInterval(function() {
      var scale;
      if (!scale && $(ele).height()) {
        scale = $(ele).width() / $(ele).height();
      }
      if (scale) {
        if ($(ele).height() < $(window).innerHeight()) {
          $(ele).height($(window).innerHeight());
          $(ele).width($(ele).height() * scale);
          $(ele).css('margin-left', ($(window).innerWidth() - $(ele).width()) / 2 + 'px');
        } else {
          $(ele).width('100%');
          $(ele).height($(ele).width() / scale);
        }
        return clearInterval(itv);
      }
    }, 100);
  };

  $(function() {
    $('.carousel').carousel(function() {
      return {
        interval: 2000
      };
    });
    return $('.action-hamburger').click(function() {
      return toggle('hamburger');
    });
  });

}).call(this);
