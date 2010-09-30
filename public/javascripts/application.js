$(function() {
  $('input.default').focus();
  $('.popup_note').hide();
  $('.number_suggestion').click(function() {
    $(this).parents('li').children('input[type=text]').val(this.rel);
    return false;
  });
  attach_datepicker();
  if($(".select").length || $('.multiselect').length) {
    run_multiselect();
  };
  $('#from').change(function() {
    $('#notifier').show();
    $.get("/transactions/created",
      { from: this.value,
        until: $('#until').val(),
        category: $('#category').val(),
        warehouse: $('#warehouse').val() },
      function() { $('#notifier').hide(); },
      'script');
  });
  $('#until').change(function() {
    $('#notifier').show();
    $.get("/transactions/created",
      { from: $('#from').val(),
        until: this.value,
        category: $('#category').val(),
        warehouse: $('#warehouse').val() },
      function() { $('#notifier').hide(); }, 'script');
  });
  $('#category').change(function() {
    $('#notifier').show();
    $.get("/transactions/created",
      { from: $('#from').val(),
        until: $('#until').val(),
        category: this.value,
        warehouse: $('#warehouse').val() },
      function() { $('#notifier').hide(); }, 'script');
  });
  $('#warehouse').change(function() {
    $('#notifier').show();
    $.get("/transactions/created",
      { from: $('#from').val(),
        until: $('#until').val(),
        category: $('#category').val(),
        warehouse: this.value },
      function() { $('#notifier').hide(); }, 'script');
  });
  $('#all').click(function() {
    if(this.checked) {
      $('.transaction_type:visible').attr('checked', 'checked');
    } else {
      $('.transaction_type').removeAttr('checked');
    }
  });
  if($('table#enhanced').length) {
    $('table#enhanced').dataTable({"bJQueryUI": true, "sPaginationType": "full_numbers"});
  }
  if($('.item_chooser').length) {
    $('.item_chooser').autocomplete(items, {
      formatItem: function(row, i) { return row.item.name; },
      autoFill: true,
      mustMatch: true }
    )
    .result(function(event, data) {
      var input = $(this);
      if(data) {
        event.stopImmediatePropagation();
      }
    });
  }
  $('#check_master').click(function() {
    if(this.checked) {
      $('.check_slave').attr('checked', 'checked');
    } else {
      $('.check_slave').removeAttr('checked');
    }
  });
  $('#sidemenu ul.submenu').hide();
  $('#sidemenu li.submenu_handler').click(function() {
    $(this).children('ul.submenu').toggle('blind');
  });
  $('#sidemenu ul.submenu li a.current').parents('ul.submenu').show();
  $('.item_chooser_link').live('click', function() {
    Boxy.load(this.href, {
      //modal: true,
      draggable: true,
      unloadOnHide: true,
      title: this.title,
      closeText: "<img src='/images/icons/cross.png' alt='close'/>",
      afterShow: function() {
        $('#keyword').focus();
      }
    });
    return false;
  });
  // add the button replacer after the primary submit button
  $('#primary-button, .primary-button').after('<span id="button-replacer" style="display:none;"><img src="/images/ajax-loader.gif" alt="" /> <span>Saving... please wait</span></span>');
});

$('#primary-button, .primary-button').click(function() {
  $(this).hide();
  $('#button-replacer').show();
  return true;
});

$('input.item_autocomplete').live('focus', function() {
  var input = $(this);
  input.autocomplete({
    source: '/items/search.js',
    focus:  function(event, ui) { $(this).val(ui.item.name); return false; },
    select: function(event, ui) {
      $(this).val(ui.item.name);
      $(this).next().val(ui.item.id);
      var form = $(this).parents('form');
      // run when you want to add new set of inputs
      if(window.insert_fields) {
        var elem = template.replace(regexp1, "[" + new_id + "]");
        elem = elem.replace(regexp2, "_" + new_id + "_");
        elem = "<tr>" + elem + "</tr>";
        input.parents('tr').after(elem);
        $('.should_hidden').hide();
        attach_datepicker();
        new_id++;
      }
      // only used in price list form
      if(window.insert_units) {
        $.ajax({
          url: form[0].action,
          type: 'post',
          data: form.serialize(),
          success: function(response, status) {
            var html = $(response);
            var tbody = form.find('tbody');
            html.find('tbody tr:last').appendTo(tbody);
            tbody.find('tr:last').find('input[type=text]:first').select();
            form.find('#item').val('');
          }
        });
      }
      // get the item price for the customer
      if(window.get_customer_price) {
        var cust_id = $('#quotation_customer_id').multiselect('getChecked');
        if(typeof(cust_id[0]) != 'undefined') {
          $.ajax({
            url: '/customers/'+cust_id[0].value+'/price.js',
            data: 'item_id='+ui.item.id,
            success: function(response, status) {
              input.parents('td').next().next().children('input').val(response);
            }
          });
        } else {
          input.parents('td').next().next().children('input').val(0);
        }
      }
      return false;
    }
  })
  .data("autocomplete")
  ._renderItem = function(ul, item) {
    return $("<li></li>")
    .data("item.autocomplete", item)
    .append("<a>" + item.name + "</a>")
    .appendTo(ul);
  };
});

$('.units_remover').live('click', function() {
  $(this).parents('tr').find('input[name*=_destroy]').val('1').andSelf().fadeOut('fast');
  return false;
})

function attach_datepicker() {
  $('input.datepicker').datepicker({
    showOn:'both',
    buttonImage: '/images/icons/silk/calendar_select_day.png',
    buttonImageOnly: true
  });
}

$('.price').live('focus', function(){
  var itemname=$(this).parent('td').prev().prev().children('input').val();
  var customerid=$('#quotation_customer_id').val();
  var qty=$(this).parent('td').prev().children('input').val();
  var input=$(this);
  $.ajax({
    url:'/customers/price.js',
    type:'get',
    data:'customer='+customerid+'&item='+itemname,
    success: function(respone, status){
      input.val(parseInt(respone)*parseInt(qty));
    }
  });
});

$('.plu_input').live('click', function() {
  var input_id = $(this).prevAll('input[type=text]').attr("id");
  $('body').data('input_id', '#' + input_id);
  Boxy.load(this.href, {
    //modal: true,
    draggable: true,
    unloadOnHide: true,
    title: "Item Lookup",
    closeText: "<img src='/images/icons/cross.png' alt='close'/>",
    afterShow: function() {
      $('#keyword').focus();
    }
  });
  return false;
});

$("form#search").live('submit', function() {
  $(this).find('button[type=submit]').html('Searching...');
  //.after("<span id='progress' style='font-style:italic;color:green;padding-left:5px;'>searching...</span>");
  $.ajax({ url: this.action,
    type: this.method,
    data: $(this).serialize(),
    success: function(response, status) {
      $('#progress').remove();
      $('#searchresult').html(response)
      $('.searchresults tr:nth-child(2) td ul li:first-child a').focus();
      $('.plu_code_handle').bind('click', function() {
        if($('body').data('input_id')) {
          $($('body').data('input_id')).val(this.title).search().parent('td').next().next().children()[0].focus();
          Boxy.get(this).hideAndUnload();
        } else if($('body').data('type') == 'customer_prices') {
          $('body').data('item_id', $(this).next().value);
          //console.log($('body').data('item_id'));
          Boxy.get(this).hideAndUnload();
        }
        return false;
      });
    }
  });
  return false;
});

$("form#search2").live('submit', function() {
  var button = $(this).find('button[type=submit]');
  button.html('Searching...');
  button.attr('disabled', 'disabled');
  $.ajax({ url: this.action,
    type: this.method,
    data: $(this).serialize(),
    dataType: 'script',
    success: function(response, status) {
      response;
      button.html('Search items');
      button.removeAttr('disabled');
    }
  });
  return false;
});

$("form#item_picker").live('submit', function() {
  $.ajax({ url: this.action,
    data: $(this).serialize(),
    type: this.method,
    dataType: 'script',
    success: function(response, status) {
      response;
    }
  });
  return false;
});

$('#sidemenu li a.revealer').click(function() {
  $(this).next('ul').toggle();
  return false;
});

function boxy_ajaxify(formwrapper) {
  var form = formwrapper;
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
}

$('#add_entries').live('click', function(e) {
  var entries_count = $('#transaction_entries tr').length - 1; // 1 is the table header, we're only intersted in rows with input fields in it
  $('#transaction_entries').append(entry_row(entries_count));
  return false;
});

$('#add_items').live('click', function(e) {
  var entries_count = $('#transaction_entries tr').length - 1; // 1 is the table header, we're only intersted in rows with input fields in it
  $('#transaction_entries').append(item_row(entries_count));
  return false;
});

$('input.entries_quantity, input.entries_value').live('keypress', function(e) {
  if(e.keyCode == 13 && this.value != '') {
    $('#add_entries').click();
    $('#transaction_entries tbody tr:last td:first').children()[0].focus();
    // set_autocomplete();
    return false;
  }
});

function entry_row(count) {
  var idx = count;
  var html = "<tr><td class=\"td_20\">" +
    "<input type=\"text\" name=\""+model+"[entries_attributes]["+idx+"][plu_code]\" id=\""+model+"_entries_attributes_"+idx+"_plu_code\" class=\"plu_code ac_input\" autocomplete=\"off\">" +
    "<input type=\"hidden\" name=\""+model+"[entries_attributes]["+idx+"][plu_id]\" id=\""+model+"_entries_attributes_"+idx+"_plu_id\" value=\"\">" +
    "<a class=\"plu_input\" href=\"/items/lookup.js\"><img src=\"/images/icons/silk/magnifier.png\" alt=\"Magnifier\"></a></td> " +
    "<td class=\"td_50\"></td> <td class=\"actions td_10\">" +
    "<input type=\"text\" size=\"10\" name=\""+model+"[entries_attributes]["+idx+"][quantity]\" id=\""+model+"_entries_attributes_"+idx+"_quantity\" class=\"numbers entries_quantity\">" +
    "<input type=\"hidden\" name=\""+model+"[entries_attributes]["+idx+"][item_id]\" id=\""+model+"_entries_attributes_"+idx+"_item_id\"></td>";
  if(window.with_value == true) {
    html += "<td class=\"actions td_20\"><input type=\"text\" size=\"30\" name=\""+model+"[entries_attributes]["+idx+"][value]\" id=\""+model+"_entries_attributes_"+idx+"_value\" class=\"numbers entries_value\"></td>";
  }
  html += "</tr>";
  return html;
}

function item_row(count) {
  var idx = count;
  var html = "<tr><td class=\"td_20\">" +
    "<input type=\"text\" name=\""+model+"[detail_assemblies_attributes]["+idx+"][item_id]\" id=\""+model+"_detail_assemblies_attributes_"+idx+"_item_id\" class=\"plu_code ac_input\" autocomplete=\"off\">" +
    "<input type=\"hidden\" name=\""+model+"[detail_assemblies_attributes]["+idx+"][item_id]\" id=\""+model+"_detail_assemblies_attributes_"+idx+"_item_id\" value=\"\">" +
    "<a class=\"plu_input\" href=\"/items/lookup2.js\"><img src=\"/images/icons/silk/magnifier.png\" alt=\"Magnifier\"></a></td> " +
    "<td class=\"td_50\"></td> <td class=\"actions td_10\">" +
    "<input type=\"text\" size=\"10\" name=\""+model+"[detail_assemblies_attributes]["+idx+"][quantity]\" id=\""+model+"_detail-assemblies_attributes_"+idx+"_quantity\" class=\"numbers detail_assemblies_quantity\">" +
    "<input type=\"hidden\" name=\""+model+"[detail_assemblies_attributes]["+idx+"][item_id]\" id=\""+model+"_detail_assemblies_attributes_"+idx+"_item_id\"></td>";
  if(window.with_value == true) {
    html += "<td class=\"actions td_20\"><input type=\"text\" size=\"30\" name=\""+model+"[detail_assemblies_attributes]["+idx+"][value]\" id=\""+model+"_detail_assemblies_attributes_"+idx+"_value\" class=\"numbers detail_assemblies_value\"></td>";
  }
  html += "</tr>";
  return html;
}

$('#add_item').live('click', function() {
  $('body').data('type', 'customer_prices');
  Boxy.load(this.href, {
    //modal: true,
    draggable: true,
    unloadOnHide: true,
    title: "Item Lookup",
    closeText: "<img src='/images/icons/cross.png' alt='close'/>",
    afterShow: function() {
      $('#keyword').focus();
    },
    beforeUnload: function() {
      var item_id = $('body').data('item_id');
      window.location = window.location.toString().replace(/\/+$/,'') + '/new?item=' + item_id;
    }
  });
  return false;
});

$('.popup_handle').live('click', function() {
  var link = $(this);
  var link_pos = link.position();
  var p = link.next('p');
  var input = p.children().attr('name');
  $.prompt("<h6>Add note</h6><br/>"+p.html(),
    {
      prefix: 'pop_',
      top: parseInt(link_pos.top) - 130,
      loaded: function() { $('#pop_').css('margin-left', parseInt(link_pos.left) - $('#pop_').width()); },
      submit: function(v, m, f) {
        p.children().val($.trim(f[input]));
        if($.trim(f[input]).length == 0) { link.children().attr('src', '/images/icons/silk/comment.png'); }
        else { link.children().attr('src', '/images/icons/silk/comment_filled.png'); }
      }
    }
  );
  $('.pop_close').html('<img src="/images/icons/silk/cross.png"/>');
  $('.pop_message input')[0].focus();
});

$('.row_remover').live('click', function() {
  var tr = $(this).parents('tr');
  $(tr).find('input[name*="_destroy"][type=checkbox]').attr('checked', 'checked').andSelf().hide();
  return false;
});

$('.tracker_remover').live('click', function() {
  var li = $(this).parents('li');
  li = $(li[0]);
  li.find('input[name*="_destroy"]').val(1);
  li.hide();
  var input = li.parents('tr').find('.mr_qty');
  var total_value = parseInt(input.val());
  var tracker_value = parseInt(li.find('.tracker_quantity').val());
  input.val((total_value >= tracker_value) ? (total_value - tracker_value) : 0);
  return false;
});

//customer auto_complete
$('#sales_order_customer_name').live('focus', function() {
  var input = $(this);
  input.autocomplete({
    source: '/customers/search.js',
    focus:  function(event, ui) { $(this).val(ui.item.fullname); return false; },
    select: function(event, ui) {
      $(this).parents('form').find('#sales_order_customer_id').val(ui.item.id);
      var form = $(this).parents('form')
      $.ajax({
        source: form[0].action,
        data: form.serialize(),
        success: function(response, status) {
          var form_html = $(response).find('form').html();
          form.replaceWith(response);
          run_multiselect();
          attach_datepicker();
          multiselect_response();
        }
      });
    }
  })
  .data("autocomplete")
  ._renderItem = function(ul, customers) {
    return $("<li></li>")
    .data("item.autocomplete", customers)
    .append("<a>" + customers.fullname + "</a>")
    .appendTo(ul);
  };
 });

//customer auto_complete  for quotations
$('#quotation_customer_name').live('focus', function() {
  var input = $(this);
  input.autocomplete({
    source: '/customers/search.js',
    focus:  function(event, ui) {$(this).val(ui.item.fullname); return false;},
    select: function(event, ui) {
      $(this).parents('form').find('#quotation_customer_id').val(ui.item.id);
      /*var form = $(this).parents('form')
      $.ajax({
        source: form[0].action,
        data: form.serialize(),
        success: function(response, status) {
          var form_html = $(response).find('form').html();
          form.replaceWith(response);
          run_multiselect();
          attach_datepicker();
          multiselect_response();
        }
      });*/
    }
  })
  .data("autocomplete")
  ._renderItem = function(ul, customers) {
    //console.log(customer);
    return $("<li></li>")
    .data("item.autocomplete", customers)
    .append("<a>" + customers.fullname + "</a>")
    .appendTo(ul);
  };
 });



//customer auto_complete  for form delivery orders
$('#delivery_order_customer_name').live('focus', function() {
  var input = $(this);
  input.autocomplete({
    source: '/customers/search.js',
    focus:  function(event, ui) { $(this).val(ui.item.fullname); return false; },
    select: function(event, ui) {
    }
  })
  .data("autocomplete")
  ._renderItem = function(ul, customers) {
    return $("<li></li>")
    .data("item.autocomplete", customers)
    .append("<a>" + customers.fullname + "</a>")
    .appendTo(ul);
  };
 });

function run_multiselect() {
  $("select.select").multiselect({
    multiple: false,
    header: "Select an option",
    noneSelectedText: "Select an option",
    selectedList: 1,
    show: 'blind',
    hide: 'blind'
  });
  $('.multiselect').multiselect({show: 'blind', hide: 'blind'}).multiselectfilter();
}
