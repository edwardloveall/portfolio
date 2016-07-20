$(document).ready(function() {
  $('body.admin-projects ul.projects, body.admin-songs ul.songs').sortable({
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
