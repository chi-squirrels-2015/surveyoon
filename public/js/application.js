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

  // Kevin Edit
  // We could use this and then we can take the id off of the submit button in the views
  $("#create-frm").on('submit', '#questions_and_answers_form', function(event) {
    event.preventDefault();
    var payload = $(this).serialize();
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

  // $("#create-frm").on('click', '#add_question', function(event) {
  //   event.preventDefault();
  //   var payload = $(this).parents("form").serialize();
  //   var request = $.ajax({
  //     url: '/questions',
  //     method: 'post',
  //     data: payload
  //   });

  //   request.done(function(response) {
  //     $("#for_appending").append(response);
  //     $("#questions_and_answers_form").each(function(){
  //       this.reset();
  //     })
  //   })
  // })

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

});
