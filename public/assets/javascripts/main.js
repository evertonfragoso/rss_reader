$(document).ready(function () {
  $('.feed-link').find('a').click(function () {
    var $this = $(this)
    var uri = $this.attr('href')

    if ($this.hasClass('video')) {
      window.open(uri)
      return false
    }

    var contentDiv = $this.parents('.feed-link').find('.content')

    if (contentDiv.hasClass('open')) {
      contentDiv.removeClass('open').hide()
    } else {
      if (contentDiv.hasClass('loaded')) {
        contentDiv.addClass('open')
      } else {
        $.ajax(uri)
          .done(function (data) { contentDiv.addClass('open loaded').html(data) })
          .fail(function (error) { contentDiv.text(error) })
      }
      contentDiv.slideDown('fast')
    }
    return false
  })
})
