$('.feed-link').find('a').click(function(){
  var contentDiv = $(this).parents('.feed-link').find('.content');
  if(contentDiv.hasClass('open')){
    contentDiv.removeClass('open').hide();
  } else {
    if(contentDiv.hasClass('loaded')){
      contentDiv.addClass('open');
    } else {
      var uri = $(this).attr('href');
      var jqxhr = $.ajax(uri)
        .done(function(data){ contentDiv.addClass('open loaded').html(data); })
        .fail(function(error){ contentDiv.text(error); });
    }
    contentDiv.slideDown('fast');
  }
  return false;
});
