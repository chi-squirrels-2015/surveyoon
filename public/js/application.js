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
      $("#create-frm").prepend("<h4> Survey: " + response.title + "</h4>");
      $(".question-answer").css("display", "block");
    })
  })

  // Kevin Edit: I changed it to "document" instead of "#create-frm"
  $(document).on('click', '#add_answer_option', function(event) {
    event.preventDefault();
    $(this).parents("form").children("div").append("<p><input type='text' name='answer[]' placeholder='Choice'><a id='delete_answer' href='#'><img src='https://www.chicobag.com/images/minus_icon.gif'></a></p>");
  })

  // Kevin Edit
  $("#create-frm").on('click', '#add_question', function(event) {
    event.preventDefault();
    var payload = $(this).parents("form").serialize();
    var request = $.ajax({
      url: '/questions',
      method: 'post',
      data: payload
    });

    request.done(function(response) {
      $("#for_appending").append(response);
      $("#questions_and_answers_form").each(function(){
        this.reset();
      })
    })
  })

  $(".question-answer").on('click', '#delete_answer', function(event) {
    event.preventDefault();
    $(this).parent("p").remove();
    $(this).remove();
  })

  $("#create-frm").on('click', '#submit_survey', function(event) {
    event.preventDefault();
    var payload = $(this).parents("form").serialize();
    var request = $.ajax({
      url: '/questions',
      method: 'post',
      data: payload
    });

    request.done(function(response) {
      window.location.replace("/surveys");
    })
  })

  // Kevin edit
  // send an HTTP DELETE request for the sign-out link
  $('a#sign-out').on("click", function (e) {
    e.preventDefault();
    var request = $.ajax({
      url: $(this).attr('href'),
      type: 'delete'
    });

    request.done(function () {
      window.location = "/";
    });
  });

  // Kevin edit - Confirming to edit the survey
  $("#survey_edit_confirm_button").on("click", function(e) {
    e.preventDefault();
    $("#editing_confirmation").hide();
    $(".question-answer").css("display", "block");
  })

 // Kevin Edit - Saving an edited question
 $(".question-answer").on('submit', '#questions_and_answers_form', function(event) {
  event.preventDefault();
  var toDeleteForm = $(this);
  var request = $.ajax({
    url: $(this).attr("action"),
    type: 'put',
    data: $(this).serialize()
  });

  request.done(function(response) {
    toDeleteForm.empty();
    $(".question-answer").prepend(response);
  })
})

});
