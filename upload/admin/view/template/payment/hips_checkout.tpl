<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
       <h1><img src="view/image/payment.png" alt="" /> <?php echo $heading_title; ?></h1>
       <div class="buttons"><a onclick="$('#form-hips-checkout').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
  <div class="content">
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-hips-checkout" class="form-horizontal">

    <table class="form">
              <tr>
                <td><?php echo $entry_key; ?></td>
                <td><input type="text" name="hips_key" value="<?php echo $hips_key; ?>" placeholder="<?php echo $entry_key; ?>" id="input-key" class="form-control" /> 
                  <?php if ($error_key) { ?>
                  <div class="text-danger"><?php echo $error_key; ?></div>
                  <?php } ?>
                </td>
              </tr>

              <tr>
                <td><?php echo $public_entry_key; ?></td>
                <td><input type="text" name="hips_key_public" value="<?php echo $hips_key_public; ?>" placeholder="<?php echo $public_entry_key; ?>" id="input-key_public" class="form-control" /> 
                  <?php if ($error_key_public) { ?>
                  <div class="text-danger"><?php echo $error_key_public; ?></div>
                  <?php } ?>
                </td>
              </tr>

              <tr>
                <td><?php echo $entry_mode_bar; ?></td>
                  <td><select name="hips_mode_bar" id="hips_mode_bar" class="form-control">
                <option value="yes" <?php if (isset($hips_mode_bar) && $hips_mode_bar=='yes') {?> selected="selected" <?php }?> >Yes</option>
                <option value="no" <?php if (isset($hips_mode_bar) && $hips_mode_bar=='no') {?> selected="selected" <?php }?>>No</option>
              </select>
                </td>
              </tr>

              <tr>
                <td><?php echo $entry_payment_type; ?></td>
                  <td><select name="hips_payment_type" id="hips_payment_type" class="form-control">
                <option value="full" <?php if (isset($hips_payment_type) && $hips_payment_type=='full') {?> selected="selected" <?php }?> >Full Checkout</option>
                <option value="card" <?php if (isset($hips_payment_type) && $hips_payment_type=='card') {?> selected="selected" <?php }?>>Card Payment</option>
              </select>
                </td>
              </tr>

              <tr>
                <td><?php echo $entry_total; ?></td>
                <td><input type="text" name="hips_total" value="<?php echo $hips_total; ?>" placeholder="<?php echo $hips_total; ?>" id="input-total" class="form-control" />
                </td>
              </tr>

              <tr>
                <td><?php echo $entry_order_status; ?></td>
                  <td><select name="hips_order_status_id" id="input-order-status" class="form-control">
                    <?php foreach ($order_statuses as $order_status) { ?>
                    <?php if ($order_status['order_status_id'] == $hips_order_status_id) { ?>
                    <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                </td>
              </tr>

              <tr>
                <td><?php echo $entry_terms; ?></td>
                  <td><select name="hips_checkout_terms" id="input-terms" class="form-control">
                    <?php foreach ($informations as $information) { ?>
                    <?php if ($information['information_id'] == $hips_checkout_terms) { ?>
                    <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                </td>
              </tr>

              <tr>
                <td><?php echo $entry_geo_zone; ?></td>
                  <td><select name="hips_geo_zone_id" id="input-geo-zone" class="form-control">
                      <option value="0"><?php echo $text_all_zones; ?></option>
                      <?php foreach ($geo_zones as $geo_zone) { ?>
                      <?php if ($geo_zone['geo_zone_id'] == $hips_geo_zone_id) { ?>
                      <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
                      <?php } else { ?>
                      <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
                      <?php } ?>
                      <?php } ?>
                    </select>
                </td>
              </tr>
              
              <tr>
            <td><?php echo $entry_status; ?></td>
            <td><select name="hips_checkout_status">
                <?php if ($hips_checkout_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr>

              <tr>
                <td><?php echo $entry_sort_order; ?></td>
                <td><input type="text" name="hips_checkout_sort_order" value="<?php echo $hips_checkout_sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
                </td>
              </tr>


      </table>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>