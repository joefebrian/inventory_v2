var unit_length = 0;
var first_unit_value = 0;
var categories;

$(function() {
  unit_length = $('#units li').length;
  $('#units li input[name*=conversion_rate]:first').attr('readonly', 'readonly');
  first_unit_value = $('#units li input[name*=value]')[0].value;
  $('#units li:first-child').find('a.unit_remover').remove();

  $($('#units li input[name*=value]')[0]).blur(function() {
    first_unit_value = parseInt(this.value);
    return false;
  });
});

$('#units li input[name*=conversion_rate]').live('keyup', function() {
  var value = this.value;
  if($(this).parent('li').index() != 0) {
    $(this).parent('li').find('input[name*=value]').val(first_unit_value * parseInt(value));
  }
});
