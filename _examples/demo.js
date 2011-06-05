(function($){
  $('#job').text(JSON.stringify(window.job, null, '  '));
  $('#run').click(function(){
    $.ajax({
      url: '/mapred',
      type: 'POST',
      data: $('#job').text(),
      beforeSend: function(){
        $('#spinner').show();
      },
      complete: function(req){
        $('#results').text(JSON.stringify(JSON.parse(req.responseText), null, '  '));
        $('#spinner').hide();
      }
    });
  });
})(jQuery);
