$(document).on('turbolinks:load', function(){
  $('.answers').on('click', '.edit-answer-link', function(e) {
    e.preventDefault();
    $(this).hide();
    var answerId = $(this).data('answerId');
    $('form#edit-answer-' + answerId).removeClass('hidden');
  })
//-----------------AJAH
  // $('form.new-answer').on('ajax:success', function(e){
  //   // console.log(e)
  //   var xhr = e.detail[2];

  //   $('.answers').append(xhr.responseText);
  // }).
  //   on('ajax:error', function(e){
  //     var xhr = e.detail[2];

  //     $('.answer-errors').html(xhr.responseText);
  //   })
//-----------------JSON
  // $('form.new-answer').on('ajax:success', function(e){
  //   // console.log(e.detail);
  //   var answer = e.detail[0];

  //   $('.answers').append('<p>' + answer.body + '</p>');
  // }).
  //   on('ajax:error', function(e){
  //     var errors = e.detail[0];

  //     $.each(errors, function(index, value){
  //       $('.answer-errors').append('<p>'+ value + '</p>')
  //     })
  //   })
  $('.answers').on('ajax:success', function(e){
    // console.log(this);
    var voiting = e.detail[0];
    $('.answers .table-answers .answer-' + voiting.answer_id + ' .raiting-' + voiting.answer_id).html(voiting.raiting);
  })

});
