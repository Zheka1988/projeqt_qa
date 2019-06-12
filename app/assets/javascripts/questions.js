$(document).on('turbolinks:load', function(){
  $('.questions').on('click', '.edit-question-link', function(e) {
    e.preventDefault();
    $(this).hide();
    var questionId = $(this).data('questionId');
    $('form#edit-question-' + questionId).removeClass('hidden');
  })

  $('.questions').on('ajax:success', function(e){
    var voiting = e.detail[0];
    $('.questions .table-questions .question-' + voiting.voitingable_id + ' .raiting-' + voiting.voitingable_id).html(voiting.sum_raiting);
  })
  App.cable.subscriptions.create('QuestionsChannel', {
    connected: function() {
      // console.log("Connected!");
      // this.perform('echo', { text: "hello"} )
      this.perform('follow' )
    },

    received: function(data) {
      console.log(data)
      // var data_j = JSON.parse(data)
      // console.log(data_j)
      // var  title = data.detail[0]
      $('.questions .table-questions').append(data);//+"\n"+ data_j.body

      // $('.questions .table-questions').append(data_j.body);
    }
  })

});
