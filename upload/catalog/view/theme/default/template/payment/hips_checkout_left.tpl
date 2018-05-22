<style>
.table {
    width: 100%;
    max-width: 100%;
    margin-bottom: 20px;
    background-color: transparent;
    border-spacing: 0;
    border-collapse: collapse;
    white-space: normal;
    line-height: normal;
    font-weight: normal;
    font-size: medium;
    font-style: normal;
    text-align: start;
    font-variant: normal;
    display: table;
}

.table-bordered {
    border: 1px solid #ddd;
}

.text-left {
    text-align: left;
}

.text-right {
    text-align: right;
}

.table>tbody>tr>td {
    padding: 8px;
    line-height: 1.42857143;
    vertical-align: top;
    /*border-top: 1px solid #ddd;*/
}

tbody tr:nth-child(odd) {
  background: rgba(117, 112, 112, 0.04);

}
</style>

<h3><?php echo $heading_title; ?></h3>
<hr>
<div class="row">
    <div class="product-layout col-lg-12 col-md-12 col-sm-12 col-xs-12">
    <div id="shoppingcart">
        <span>
        <?php if ($products || $vouchers) { ?>
            <table class="table table-striped">
                <?php foreach ($products as $product) { ?>
                <tr>
                    <td class="text-left"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                        <?php if ($product['option']) { ?>
                        <?php foreach ($product['option'] as $option) { ?>
                        <br />
                        - <small><?php echo $option['name']; ?> <?php echo $option['value']; ?></small>
                        <?php } ?>
                        <?php } ?>
                        <?php if ($product['recurring']) { ?>
                        <br />
                        - <small><?php echo $text_recurring; ?> <?php echo $product['recurring']; ?></small>
                        <?php } ?></td>
                    <td class="text-right">
                    
					<a style="text-decoration: none !important;" class="ddd" onclick="updateQuantity('<?php echo $product['cart_id']; ?>', 'minus')" id="minus<?php echo $product['cart_id']; ?>" href="javascript:void(0)">-</a>
						<input type="text" readonly="readonly" value="<?php echo $product['quantity']; ?>" id="fieldValue<?php echo $product['cart_id']; ?>" style="width:90px;">
						<a style="text-decoration: none !important;" class="ddd" onclick="updateQuantity('<?php echo $product['cart_id']; ?>', 'plus')" id="plus<?php echo $product['cart_id']; ?>" href="javascript:void(0)">+</a>
                    </td>
                    <td class="text-right"><?php echo $product['total']; ?></td>
                   
                </tr>
                <?php } ?>
                <?php foreach ($vouchers as $voucher) { ?>
                <tr>
                    <td class="text-center"></td>
                    <td class="text-left"><?php echo $voucher['description']; ?></td>
                    <td class="text-right">x&nbsp;1</td>
                    <td class="text-right"><?php echo $voucher['amount']; ?></td>
                    <td class="text-center text-danger"><a onclick="voucher.remove('<?php echo $voucher['key']; ?>');" title="<?php echo $button_remove; ?>" ><i class="fa fa-times"></i></a></td>
                </tr>
                <?php } ?>
            </table>

            <div>
                <table class="table table-bordered" border="1">
                   <?php foreach ($totals as $total) { ?>
				      <tr>
				        <td class="text-right"><b><?php echo $total['title']; ?>:</b></td>
				        <td class="text-right"><?php echo $total['text']; ?></td>
				      </tr>
				      <?php } ?>
                </table>
              
            </div>
        <?php } else { ?>
            <p class="text-center"><?php echo $text_empty; ?></p>
        <?php } ?>
        </span>
</div>
</div>
</div>

<script>
 
function updateQuantity(id, type)
	{	
		var valuesfield = document.getElementById('fieldValue'+id).value;
		//var currentValue = valuesfield;
		//alert(currentValue);
		if(type=='minus')
		{
		var updatedValue = (parseInt(valuesfield,10) -1);
		}else{
		var updatedValue = (parseInt(valuesfield,10) +1);
		}
		//alert(updatedValue);
			var info = {}
		if($.trim(updatedValue) !='')
		{
			info[id] = updatedValue;
		}
		if(updatedValue>0)
		{
			document.getElementById('fieldValue'+id).value =updatedValue;
			$.ajax({
			url:'index.php?route=checkout/cart',
			type:'POST',
			 data:{'quantity':info, 'type':'partsection'},
			success: function(data)
			{
				 		$.ajax({
						url:'index.php?route=payment/hips_checkout/main',	
						type:'POST',
						data:{'quantity':info, 'type':'partsection'},	
						success: function(data)
						{    
							 var iframe =  document.getElementById('smuze-checkout-iframe');
							 
							 iframe.src = iframe.src; 
								
						 $.ajax({
						url:'index.php?route=payment/hips_checkout/leftHTML',	
						type:'POST',
						 
						success: function(data)
						{    
							  $('#content').html(data);
							  location.reload();
							  // to reload page added the function
								 
						}
						}); 
							
							
							
						}
						}); 
			}
		  });
			 
		}
	}
	
var cart = {
	'remove': function(key) {
		$.ajax({
			url: 'index.php?route=checkout/cart/remove',
			type: 'post',
			data: 'key=' + key,
			dataType: 'json',
			beforeSend: function() {
				$('#cart > button').button('loading');
			},
			complete: function() {
				$('#cart > button').button('reset');
			},
			success: function(json) {
				// Need to set timeout otherwise it wont update the total
				setTimeout(function () {
					$('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
				}, 100);

				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
					location = 'index.php?route=checkout/cart';
				} else {
					location = 'index.php?route=payment/hips_checkout';
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
}
	var voucher = {
	'remove': function(key) {
		$.ajax({
			url: 'index.php?route=checkout/cart/remove',
			type: 'post',
			data: 'key=' + key,
			dataType: 'json',
			beforeSend: function() {
				$('#cart > button').button('loading');
			},
			complete: function() {
				$('#cart > button').button('reset');
			},
			success: function(json) {
				// Need to set timeout otherwise it wont update the total
				setTimeout(function () {
					$('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
				}, 100);

				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
					location = 'index.php?route=checkout/cart';
				} else {
					location = 'index.php?route=payment/hips_checkout';
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
}	
</script>
