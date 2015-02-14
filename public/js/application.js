$(document).ready(function() {
  $("#create_survey_button").on('click', function(event) {
    event.preventDefault();
    var request = $.ajax({
      url: '/surveys',
      method: 'post',
      data: $(this).parents("form").serialize()
    });

    request.done(function(response) {
      $("#create_survey_form").hide();
      $("#create-frm").prepend(response.title);
      $(".question-answer").css("display", "block");
    })
  })

  $("#create-frm").on('click', '#add_answer_option', function(event) {
    event.preventDefault();
    $("#answer_choices_div").append("<input type='text' name='answer[]' placeholder='Choice'><img src='https://www.chicobag.com/images/minus_icon.gif'></p>");
  })

  $("#create-frm").on('click', '#add_question', function(event) {
    event.preventDefault();
    var payload = $(this).parents("form").serialize();
    var request = $.ajax({
      url: '/questions',
      method: 'post',
      data: payload
    });

    request.done(function(response) {
      $("#create_survey_form").hide();
      $("#create-frm").prepend(response.title);
      $(".question-answer").css("display", "block");
    })
  })

});
