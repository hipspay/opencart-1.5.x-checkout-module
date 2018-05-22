<?php
class ControllerPaymentHipsCheckout extends Controller
{
    private $error = array();
    
    public function index()
    {
        $this->language->load('payment/hips_checkout');
        
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('setting/setting');
        
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('hips', $this->request->post);
            
            $this->session->data['success'] = $this->language->get('text_success');
            
            $this->redirect($this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'));
        }
        
        if (isset($this->data['success'])) {
            $this->data['success'] = $this->language->get('text_success');
        } else {
            $this->data['success'] = '';
        }
        
        $this->data['heading_title'] = $this->language->get('heading_title');
        
        $this->data['entry_key']          = $this->language->get('entry_key');
        $this->data['public_entry_key']   = $this->language->get('public_entry_key');
        $this->data['entry_mode_bar']     = $this->language->get('entry_mode_bar');
        $this->data['entry_payment_type'] = $this->language->get('entry_payment_type');
        $this->data['entry_total']        = $this->language->get('entry_total');
        $this->data['entry_order_status'] = $this->language->get('entry_order_status');
        $this->data['entry_terms']        = $this->language->get('entry_terms');
        $this->data['entry_geo_zone']     = $this->language->get('entry_geo_zone');
        $this->data['entry_status']       = $this->language->get('entry_status');
        $this->data['entry_sort_order']   = $this->language->get('entry_sort_order');
        
        $this->data['text_edit']      = $this->language->get('text_edit');
        $this->data['text_enabled']   = $this->language->get('text_enabled');
        $this->data['text_disabled']  = $this->language->get('text_disabled');
        $this->data['text_all_zones'] = $this->language->get('text_all_zones');
        
        $this->data['help_total']         = $this->language->get('help_total');
        $this->data['help_extended_cart'] = $this->language->get('help_extended_cart');
        
        
        $this->data['button_save']   = $this->language->get('button_save');
        $this->data['button_cancel'] = $this->language->get('button_cancel');
        $this->data['button_clear']  = $this->language->get('button_clear');
        
        $this->data['token'] = $this->session->data['token'];
        
        
        if (isset($this->request->post['hips_key'])) {
            $this->data['hips_key'] = $this->request->post['hips_key'];
        } else {
            $this->data['hips_key'] = $this->config->get('hips_key');
        }
        
        if (isset($this->request->post['hips_key_public'])) {
            $this->data['hips_key_public'] = $this->request->post['hips_key_public'];
        } else {
            $this->data['hips_key_public'] = $this->config->get('hips_key_public');
        }
        
        if (isset($this->request->post['hips_mode'])) {
            $this->data['hips_mode'] = $this->request->post['hips_mode'];
        } else {
            $this->data['hips_mode'] = $this->config->get('hips_mode');
        }
        
        if (isset($this->request->post['hips_mode_bar'])) {
            $this->data['hips_mode_bar'] = $this->request->post['hips_mode_bar'];
        } else {
            $this->data['hips_mode_bar'] = $this->config->get('hips_mode_bar');
        }
        
        if (isset($this->request->post['hips_method'])) {
            $this->data['hips_method'] = $this->request->post['hips_method'];
        } else {
            $this->data['hips_method'] = $this->config->get('hips_method');
        }
        
        if (isset($this->request->post['hips_payment_type'])) {
            $this->data['hips_payment_type'] = $this->request->post['hips_payment_type'];
        } else {
            $this->data['hips_payment_type'] = $this->config->get('hips_payment_type');
        }
        
        if (isset($this->request->post['hips_total'])) {
            $this->data['hips_total'] = $this->request->post['hips_total'];
        } else {
            $this->data['hips_total'] = $this->config->get('hips_total');
        }
        
        if (isset($this->request->post['hips_order_status_id'])) {
            $this->data['hips_order_status_id'] = $this->request->post['hips_order_status_id'];
        } else {
            $this->data['hips_order_status_id'] = $this->config->get('hips_order_status_id');
        }
        
        $this->load->model('localisation/order_status');
        
        $this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
        
        
        if (isset($this->request->post['hips_checkout_status'])) {
            $this->data['hips_checkout_status'] = $this->request->post['hips_checkout_status'];
        } else {
            $this->data['hips_checkout_status'] = $this->config->get('hips_checkout_status');
        }
        
        
        if (isset($this->request->post['hips_checkout_sort_order'])) {
            $this->data['hips_checkout_sort_order'] = $this->request->post['hips_checkout_sort_order'];
        } else {
            $this->data['hips_checkout_sort_order'] = $this->config->get('hips_checkout_sort_order');
        }
        
        if (isset($this->error['key'])) {
            $this->data['error_key'] = $this->language->get('Private_key_error');
        } else {
            $this->data['error_key'] = '';
        }
        
        if (isset($this->error['key_public'])) {
            $this->data['error_key_public'] = $this->language->get('Public_key_error');
        } else {
            $this->data['error_key_public'] = '';
        }
        
        if (isset($this->request->post['hips_geo_zone_id'])) {
            $this->data['hips_geo_zone_id'] = $this->request->post['hips_geo_zone_id'];
        } else {
            $this->data['hips_geo_zone_id'] = $this->config->get('hips_geo_zone_id');
        }
        
        $this->load->model('localisation/language');
        
        $this->data['languages'] = $this->model_localisation_language->getLanguages();
        
        $this->load->model('localisation/country');
        
        $this->data['countries'] = $this->model_localisation_country->getCountries();
        
        $this->load->model('localisation/geo_zone');
        
        $this->data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();
        
        $this->load->model('catalog/information');
        
        $this->data['informations'] = $this->model_catalog_information->getInformations();
        
        $this->load->model('localisation/currency');
        
        $this->data['currencies'] = $this->model_localisation_currency->getCurrencies();
        
        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }
        
        $this->load->model('payment/hips_checkout');
        
        if ($this->model_payment_hips_checkout->checkForPaymentTaxes()) {
            $this->data['error_tax_warning'] = $this->language->get('error_tax_warning');
        } else {
            $this->data['error_tax_warning'] = '';
        }
        
        if (isset($this->error['account_warning'])) {
            $this->data['error_account_warning'] = $this->error['account_warning'];
        } else {
            $this->data['error_account_warning'] = '';
        }
        
        if (isset($this->error['account'])) {
            $this->data['error_account'] = $this->error['account'];
        } else {
            $this->data['error_account'] = array();
        }
        
        if (isset($this->error['settlement_warning'])) {
            $this->data['error_settlement_warning'] = $this->error['settlement_warning'];
        } else {
            $this->data['error_settlement_warning'] = '';
        }
        
        $this->data['breadcrumbs'] = array();
        
        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );
        
        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_payment'),
            'href' => $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );
        
        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('payment/hips_checkout', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );
        
        $this->data['action'] = $this->url->link('payment/hips_checkout', 'token=' . $this->session->data['token'], 'SSL');
        
        $this->data['cancel'] = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');
        
        
        if (isset($this->request->post['hips_checkout_terms'])) {
            $this->data['hips_checkout_terms'] = $this->request->post['hips_checkout_terms'];
        } else {
            $this->data['hips_checkout_terms'] = $this->config->get('hips_checkout_terms');
        }
       
        $this->template = 'payment/hips_checkout.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );
        $this->response->setOutput($this->render());
    }
    
    public function install()
    {
        $this->load->model('payment/hips_checkout');
        $this->model_payment_hips_checkout->install();
    }
    
    public function uninstall()
    {
        $this->load->model('payment/hips_checkout');
        $this->model_payment_hips_checkout->uninstall();
    }
    
    protected function validate()
    {
        $this->load->model('payment/hips_checkout');
        $this->load->model('localisation/geo_zone');
        
        if (version_compare(phpversion(), '5.4.0', '<')) {
            $this->error['warning'] = $this->language->get('error_php_version');
        }
        
        if (!$this->user->hasPermission('modify', 'payment/hips_checkout')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        
        if ($this->error && !isset($this->error['warning'])) {
            $this->error['warning'] = $this->language->get('error_warning');
        }
        
        if (!$this->request->post['hips_key']) {
            $this->error['key'] = $this->language->get('error_key');
        }
        
        if (!$this->request->post['hips_key_public']) {
            $this->error['key_public'] = $this->language->get('Public_key_error');
        }
        
        return !$this->error;
    }
}