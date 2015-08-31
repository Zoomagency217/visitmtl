(function() {
  var toggle;

  toggle = function(item) {
    switch (item) {
      case 'hamburger':
        if ($('#hamburger').length) {
          return $('#hamburger').toggleClass('active');
        }
    }
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
