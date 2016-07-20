$(document).ready(function() {
  $('ul.sortable').sortable({
    axis: 'y',
    update: updatePositions
  })

  function updatePositions() {
    $.post(
      $(this).data('update-url'),
      $(this).sortable('serialize')
    );
  }
});
