$(function () {
    $('#kaptcha').click(function () {
        $(this).attr('src', '/kaptcha.jpg?' + new Date().getTime());
    });
});