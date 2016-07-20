$(document).ready(function() {
  $('body.admin-projects ul.projects').sortable({
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
