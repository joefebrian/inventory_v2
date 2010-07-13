var item_length = 0;
var first_item_value = 0;
var categories;
var item_name = $('input#detail_assembly_item_name');
var item_id = $('input#details_assembly_item_id');

$(function() {
  //item_name.select();
  set_autocomplete();
});

function set_autocomplete() {
  item_name.autocomplete(items, {
    formatItem: function(row, i) { return row.item.name_with_code; },
    mustMatch: true
  })
  .result(function(event, data) {
    if(data) item_id.val(data.item.id);
    else item_id.val('');
  });
 }

$(function() {
  item_length = $('#detail_assemblies ol li').length;
  first_item_value = $('#detail_assemblies ol li input[name*=value]')[0].value;
  $('#detail_assembliess ol li:first-child').find('a.item_remover').remove();
  set_autocomplete();

  $($('#detail_assemblies ol li input[name*=value]')[0]).blur(function() {
    first_item_value = parseInt(this.value);
    return false;
  });

});


$(function() {
  $("input#assemblies_code").select();
});

$("form#assemblies_form").live('submit', function() {
  $(this).find('button[type=submit]')
  .replaceWith("<p><img src='/images/ui-anim.basic.16x16.gif' alt=''/> <span>Saving... please wait</span></p>");
});

$('a.detail_assemblies').live('click', function() {
  Boxy.load(this.href, {
    modal: true,
    title: "Detail " + this.innerHTML,
    closeText: "<img src='/images/icons/cross.png' alt='close'/>"
  });
  return false;
});

$(".alter_record").live('click', function() {
  Boxy.load(this.href, {
    modal: true,
    title: this.title,
    closeText: "<img src='/images/icons/cross.png' alt='close'/>",
    afterShow: function() {
      $('input#assemblies_code').select();
      $('form#assemblies_form').live('submit', function() {
        var form = $("div#dialog_form");
        var button = form.find("button[type=submit]");
        button.replaceWith("<p><img src='/images/ui-anim.basic.16x16.gif' alt=''/> <span>Saving... please wait</span></p>");
        $.ajax({url: this.action,
          data: $(this).serialize(),
          type: 'post',
          success: function(response, status) {
            if(response.status == 'validation error') {
              form.replaceWith(response.form);
            } else {
              window.location = response.location
            }
          }
        });
        return false;
      });
    }
  });
  return false;
}); 


$('#detail_assemblies ol li input[name*=conversion_rate]').live('keyup', function() {
  var value = this.value;
  console.log(value);
  if($(this).parent('li').index() != 0) {
    $(this).parent('li').find('input[name*=value]').val(first_unit_value * parseInt(value));
  }
});


$("a#add_detail_assemblies").live('click', function() {
  $("#detail_assemblies ol").append(new_detail_assemblies_fields(item_length));
  item_length = $('#detail_assemblies ol li').length;
  return false;
});

function new_detail_assemblies_fields(n) {
  var html = "<li> "+
    "<label for=\"assembly_detail_assemblies_attributes_"+n+"_name\">Name</label> "+
    "<input type=\"text\" value=\"\" size=\"20\" name=\"assembly[detail_assemblies_attributes]["+n+"][item_id]\" id=\"assembly_detail_assemblies_attributes_"+n+"_name\"> "+
    "<label for=\"assembly_detail_assemblies_attributes_"+n+"_value\">Qty</label> "+
    "<input type=\"text\" size=\"10\" name=\"assembly[detail_assemblies_attributes]["+n+"][qty]\" id=\"assembly_detail_assemblies_attributes_"+n+"_qty\"> "+
    "<input type=\"hidden\" name=\"assembly[detail_assemblies_attributes]["+n+"][_destroy]\" id=\"assembly_detail_assemblies_attributes_"+n+"__destroy\"> "+
    "<a class=\"item_remover\" title=\"remove item\" href=\"#\"><img src=\"/images/icons/silk/cross.png\" alt=\"Cross\"></a> "+
    "</li>";
  return html;
}

$("a.item_remover").live('click', function() {
  $(this).prev('input[type=hidden]').val(1);
  $(this).parent('li').hide();
  return false;
});
$("#assemblies_form").live("submit", function() {
  $(this).find('button[type=submit]')
  .replaceWith("<p><img src='/images/ui-anim.basic.16x16.gif' alt=''/> <span>Saving... please wait</span></p>");
});

$("a.detail_assemblies").live('click', function() {
  Boxy.load(this.href, {
    modal: true,
    title: this.innerHTML,
    closeText: "<img src='images/icons/cross.png' alt='close'/>"
  });
  return false;
});

$('form#assemblies_form').live('submit', function() {
  $(this).find('button[type=submit]')
  .replaceWith('<p><img src="/images/ajax-loader.gif" alt="" /> <span>saving... please wait</span></p>');
  return true;
});
