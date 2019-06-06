$(document).on('turbolinks:load', function(){
  $('.questions').on('click', '.edit-question-link', function(e) {
    e.preventDefault();
    $(this).hide();
    var questionId = $(this).data('questionId');
    $('form#edit-question-' + questionId).removeClass('hidden');
  })

  $('.questions').on('ajax:success', function(e){
    // console.log(this);
    var voiting = e.detail[0];
    $('.questions .table-questions .question-' + voiting.question_id + ' .raiting-' + voiting.question_id).html(voiting.raiting);
  })//.
    // on('ajax:error', function(e){
    //   var errors = e.detail[0];

    //   $.each(errors, function(index, value){
    //     $('.question-errors').append('<p>'+ value + '</p>')
    //   })
    // })

});
 // #delete-question-' + voiting.question_id + ' #raiting


