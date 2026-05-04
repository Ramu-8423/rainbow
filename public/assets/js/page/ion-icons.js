<<<<<<< HEAD
"use strict";

$("#icons li").each(function () {
  $(this).append('<div class="icon-name">' + $(this).attr('class') + '</div>');
});
$("#icons li").click(function () {
  $(".icon-name").fadeOut();
  $(this).find('.icon-name').fadeIn();
});

=======
"use strict";

$("#icons li").each(function () {
  $(this).append('<div class="icon-name">' + $(this).attr('class') + '</div>');
});
$("#icons li").click(function () {
  $(".icon-name").fadeOut();
  $(this).find('.icon-name').fadeIn();
});

>>>>>>> 49d7cd4 (initial push from server)
