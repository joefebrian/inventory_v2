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

$("a#add_unit").live('click', function() {
  $(this).parent().before(new_unit_fields(unit_length));
  unit_length = $('#units ol li').length - 1;
  return false;
});

function new_unit_fields(n) {
  var html = "<li> "+
    "<label for=\"item_units_attributes_"+n+"_name\">Name</label> "+
    "<input type=\"text\" value=\"\" size=\"20\" name=\"item[units_attributes]["+n+"][name]\" id=\"item_units_attributes_"+n+"_name\"> "+
    "<label for=\"item_units_attributes_"+n+"_conversion_rate\">Conversion rate</label> "+
    "<input type=\"text\" value=\"\" size=\"5\" name=\"item[units_attributes]["+n+"][conversion_rate]\" id=\"item_units_attributes_"+n+"_conversion_rate\" class=\"number\"> "+
    "<label for=\"item_units_attributes_"+n+"_value\">Value</label> "+
    "<input type=\"text\" size=\"13\" name=\"item[units_attributes]["+n+"][value]\" id=\"item_units_attributes_"+n+"_value\" class=\"number\"> "+
    "<input type=\"hidden\" name=\"item[units_attributes]["+n+"][_destroy]\" id=\"item_units_attributes_"+n+"__destroy\"> "+
    "<a class=\"unit_remover\" title=\"remove unit\" href=\"#\"><img src=\"/images/icons/silk/cross.png\" alt=\"Cross\"></a> "+
    "</li>";
  return html;
}

