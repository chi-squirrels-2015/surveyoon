$(document).ready(function() {

  // Creating a survey/title and showing the first question form
  $("#create_survey_button").on('click', function(event) {
    event.preventDefault();
    var request = $.ajax({
      url: '/surveys',
      method: 'post',
      data: $(this).parents("form").serialize()
    });

    request.done(function(response) {
      $("#create_survey_form").hide();
      $("#create-frm").prepend("<h3> Survey: " + response.title + "</h3>");
      $(".question-answer").show();
    })
  })

  // Adding an answer option form
  $(".question-answer").on('click', '#add_answer_option', function(event) {
    event.preventDefault();
    $(this).parents("form").children("div").append("<p><input type='text' name='answer[]' placeholder='Choice'><a id='delete_answer' href='#'><img src='https://www.chicobag.com/images/minus_icon.gif'></a></p>");
  })

  // Saving a question form
  $("#create-frm").on('click', '#add_question', function(event) {
    event.preventDefault();
    var payload = $(this).parents("form").serialize();
    var request = $.ajax({
      url: '/questions',
      method: 'post',
      data: payload
    });

    request.done(function(response) {
      $("#for_appending_saved_questions").append("<h4>" + response + "</h4>");
      $("#questions_and_answers_form").each(function(){
        this.reset();
      })
    })
  })

  // Deleting a single choice form
  $(".question-answer").on('click', '#delete_answer', function(event) {
    event.preventDefault();
    $(this).parent("p").remove();
    $(this).remove();
  })

  // Saving the Survey and the last question form.
  // If there is nothing in the last form, our validations do not save a blank form.
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

  // Confirming to edit the survey
  $("#survey_edit_confirm_button").on("click", function(e) {
    e.preventDefault();
    $("#editing_confirmation").hide();
    $(".question-answer").css("display", "block");
    $(".title_edit").show();
  })

  // Kevin Sunday Edit: Saving an edited title
  $(".title_edit").on('submit', '#edit_title_form', function(event) {
    event.preventDefault();
    var toDeleteTitleForm = $(this);
    var request = $.ajax({
      url: $(this).attr("action"),
      type: 'put',
      data: $(this).serialize()
    });

    request.done(function(response) {
      toDeleteTitleForm.empty();
      $(toDeleteTitleForm).append("<p> New Survey Title: " + response.title + "</p>"); // Kevin Sunday Edit: Changed ".question-answer" to "toDeleteForm"
    })
  })


  // Saving an edited question
  // Kevin Sunday Edit: Changed ".question-answer" to document
  $(".question-answer").on('submit', '#questions_and_answers_form', function(event) {
    event.preventDefault();
    var toDeleteQuestionForm = $(this).closest("div");
    var request = $.ajax({
      url: $(this).attr("action"),
      type: 'put',
      data: $(this).serialize()
    });

    request.done(function(response) {
      toDeleteQuestionForm.empty();
      toDeleteQuestionForm.append(response); // Kevin Sunday Edit: Changed ".question-answer" to "toDeleteForm"
    })
  })

  // Kevin Sunday Edit: When clicking the Edit Question link, they are getting a partial form so that they can edit the selected question.
  $(".question-answer").on('click', '#edit_question_button', function(event) {
    event.preventDefault();
    var toDeleteQuestion = $(this).closest("div");
    var request = $.ajax({
      url: $(this).attr("href"),
      type: "GET",
      data: $(this).attr("value")
    })

    request.done(function(response) {
      toDeleteQuestion.empty();
      toDeleteQuestion.append(response);
    })

  })



});
