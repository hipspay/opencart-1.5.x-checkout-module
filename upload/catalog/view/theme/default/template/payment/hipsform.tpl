<form id="hips-form">
 <h2><?php echo $text_credit_card; ?></h2>
 <div class="content" id="payment"> 
 
    <table class="form">
    <tr>
      <td><?php echo $entry_cc_number; ?></td>
      <td><input type="text" name="cc_number" value="" placeholder="<?php echo $entry_cc_number; ?>" id="input-cc-number" class="form-control" data-hips-tokenizer="number" />
      <input type="hidden" name="tokenValue" id="tokenValue">
      <input type="hidden" name="tokenValueError" id="tokenValueError"></td>
    </tr>
    <tr>
      <td><?php echo $entry_cc_expire_date; ?></td>
      <td><select name="cc_expire_date_month" id="input-cc-expire-date" class="form-control" data-hips-tokenizer="exp_month">
          <?php foreach ($months as $month) { ?>
          <option value="<?php echo $month['value']; ?>"><?php echo $month['text']; ?></option>
          <?php } ?>
        </select>
        /
        <select name="cc_expire_date_year" class="form-control" data-hips-tokenizer="exp_year">
          <?php foreach ($year_expire as $year) { ?>
          <option value="<?php echo $year['value']; ?>"><?php echo $year['text']; ?></option>
          <?php } ?>
        </select>
      </td>
    </tr>
    <tr>
      <td><?php echo $entry_cc_cvv2; ?></td>
      <td><input type="text" name="cc_cvv2" maxlength="4" value="" placeholder="<?php echo $entry_cc_cvv2; ?>" id="input-cc-cvv2" class="form-control" data-hips-tokenizer="cvc" /></td>
    </tr>
  </table>
</div>
<div class="buttons">
  <div class="right">
    <input type="submit" value="<?php echo $button_confirm; ?>" id="button-confirm" data-loading-text="<?php echo $text_loading; ?>" class="button" />
  </div>
</div>
  
</form>


<script type="text/javascript"><!--
$.getScript( "https://cdn.hips.com/js/v1/hips.js" )
  .done(function( script, textStatus ) {
    
    Hips.public_key='<?php echo $hips_key_public;?>';
    Hips.tokenizeCard('#hips-form', function(response){

      if(response.error) 
      {
    alert(response.error.message);
      $('#tokenValue').val('');
      $('#tokenValueError').val(response.error.message);
      }
      else
      {
      $('#tokenValueError').val('');
      $('#tokenValue').val(response.payload.token);
    $.ajax({
      url: 'index.php?route=payment/hips_checkout/send',
      type: 'post',
      data: $("#hips-form").serialize(),
      dataType: 'json',
      cache: false,
      beforeSend: function() {
        $('#button-confirm').button('loading');
      },
      complete: function() {
        $('#button-confirm').button('reset');
      },
      success: function(json) {
        if (json['error']) {
          alert(json['error']);
        }
        if (json['success']) {
          location = json['success'];
        }
      }
    });
      return false;
  } 
});    
    
  })
  .fail(function( jqxhr, settings, exception ) {
   // $( "div.log" ).text( "Triggered ajaxError handler." );
});
//--></script>