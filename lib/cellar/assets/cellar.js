function rmNotice() {
  setTimeout(function() {
    $('ul#c-notice').children().first().remove();
  }, 5000);
}

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

$(document).ready(function cMain() {
  $('body').delegate('a.c-remote', 'click', function cRemoteLink(e) {
    body = $('body');
    body.addClass('on-load')
    if(container = e.target.attributes['data-target']) {
      container = container.nodeValue;
    } else {
      container = '#yield';
    }
    target = e.target.pathname || '/';
    $.get(target, function(data) {
      $(container).html(data);
      history.pushState('', '', target);
      if(target == '/') {
        body.removeClass('on-page').addClass('on-root')
      } else {
        body.removeClass('on-root').addClass('on-page')
      }
      body.removeClass('on-load').trigger('loaded')
    }).fail( function() {
      cNotify('page not found');
    });

    return false;
  });
});

