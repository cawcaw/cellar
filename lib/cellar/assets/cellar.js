function rmNotice() {
  setTimeout(function() {
    $("ul#c-notice").children().first().remove();
  }, 5000);
}

function cNotify(msg) {
  var msg = "<li>"+msg+"</li>",
      notice = $("ul#c-notice");
  if(notice.size() < 1) {
    $("body").append($("<ul id='c-notice'>"+msg+"</ul>"));
  } else {
    notice.append(msg);
  }
  rmNotice();
}

$(document).ready(function cMain() {
  $("body").delegate("a.c-remote", "click", function cRemoteLink(e) {
    if(container = e.target.attributes["target"]) {
      container = container.nodeValue;
    } else {
      container = "#main";
    }
    console.log(container);
    target = e.target.href || "/";
    $.get(target, function(data) {
      $(container).html(data);
      history.pushState('', '', target);
    }).fail( function() {
      cNotify('page not found');
    });

    return false;
  });
});

