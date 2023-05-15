$(function () {
  $(".createGame").click(function () {
    $(".modal").fadeIn();
  });

  $(".modalContent").click(function (e) {
    // e.preventDefault();
    e.stopPropagation();
  });

  $(".modal").click(function (e) {
    $(".modal").fadeOut();
  });

  $(".modalOutButton").click(function (e) {
    $(".modal").fadeOut();
  });
});
