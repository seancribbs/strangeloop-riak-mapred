window.$ = window.$ || jQuery;
$(function(){
  $('#job').text(JSON.stringify(window.job, null, '  '));
  // $('#job').text(window.job.toString());
  $('#run').click(function(){
    $.ajax({
      url: '/mapred',
      type: 'POST',
      contentType: 'application/json',
      cache: false,
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
});
