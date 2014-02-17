$ ->
  $(".table tbody tr").hover(
    ->
      $(this).addClass('active')
    ->
      $(this).removeClass('active'))
