// remove class by wildcard
(function($) {
    $.fn.removeWildClass = function(mask) {
        return this.removeClass(function(index, cls) {
            var re = mask.replace(/\*/g, '\\S+');
            return (cls.match(new RegExp('\\b' + re + '', 'g')) || []).join(' ');
        });
    };
})(jQuery);

// set remove timer after create notice li element
function rmNotice() {
  setTimeout(function() {
    $('ul#c-notice').children().first().remove();
  }, 5000);
}

// push notice message on page
function cNotify(msg) {
  var msg = '<li>'+msg+'</li>',
      notice = $('ul#c-notice');
  if(notice.size() < 1) {
    $('body').append($('<ul id="c-notice">'+msg+'</ul>'));
  } else {
    notice.append(msg);
  }
  rmNotice();
}

// main bindings
$(document).ready(function cMain() {
  $('body').delegate('a.c-remote', 'click', function cRemoteLink(e) {
    body = $('body');
    body.addClass('on-load');
    if(container = e.target.attributes['data-target']) {
      container = container.nodeValue;
    } else {
      container = '#yield';
    }

    target = e.target.pathname || $(e.target).parent('a').attr('href') || '/';
    $.get(target, function(data) {
      $(container).html(data);
      history.pushState('', '', target);
      body.removeWildClass('page-*')
      body.removeWildClass('path-*')
      if(target == '/') {
        body.removeClass('on-page').addClass('on-root');
      } else {
        body.addClass('path' + target.replace('/', '-'));
        body.addClass('page-' + target.split('/').filter(function(e){return e}).pop());
        body.removeClass('on-root').addClass('on-page');
      }
      body.removeClass('on-load').trigger('loaded');
    }).fail( function() {
      cNotify('page not found');
      body.removeClass('on-load');
    });

    return false;
  });
});

