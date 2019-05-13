$(document).on('turbolinks:load', function(){
  $('.questions').on('click', '.edit-question-link', function(e) {
    e.preventDefault();
    $(this).hide();
    var questionId = $(this).data('questionId');
    $('form#edit-question-' + questionId).removeClass('hidden');
  })

  $('.questions').on('click', '.delete-question-link', function(e) {
    e.preventDefault();

    if(confirm('Are you Sure?')) {
      var questionId = $(this).data('questionId');
      var data = {'question_id': questionId};
      var url = '/questions/'+ questionId;
      sendAjax(url, data, questionId);
      return false;
    }
  })

});

function sendAjax(url, data, questionId ) {
  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  });
  $.ajax({
    type: 'DELETE',
    url: url,
    data: data,
    dataType: "js"
  }).done(function(res){
    // console.log('Ответ получен:', res);
    // if (res.success) { // если все хорошо
    //   console.log('ОК!)');
    function res(){
      $('tr#delete-question-' + questionId).removeSmoothly(); // строка имеет id вида "row-17"
    }
    // } else { // если не нравится результат
    //   console.log('Пришли не те данные!');
    //   console.log(res.message);
    // }
  }).fail(function(){
    console.log('Ошибка выполнения запроса');
  })
}

