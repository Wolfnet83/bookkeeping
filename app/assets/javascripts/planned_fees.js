$(document).on("turbolinks:load", function() {
  $('.best_in_place').on("ajax:success", function () { $(this).closest('tr').toggleClass('success danger'); });
});