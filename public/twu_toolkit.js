$(function () {
  $("input[type=submit]").click(function (element) {
    var button = $(element.target);
    button.addClass('button_loading');
    button.attr('disabled', 'disabled'); 
    button.parent().parent().submit();
  });

  var notice = $(".notice");
  notice && notice.slideDown();

});
