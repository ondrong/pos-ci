<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/*
	controller laporan kas
*/
class Laptransaksi extends CI_Controller{
	
	 function __construct()
	  {
		parent::__construct();
		$this->load->model("report_model");
		$this->load->helper("print_report");
		$this->load->library("zetro_auth");
		$this->userid=$this->session->userdata('idlevel');
	  }
	
	function Header(){
		$this->load->view('admin/header');	
	}
	
	function Footer(){
		$this->load->view('admin/footer');	
	}
	function list_data($data){
		$this->data=$data;
	}
	function View($view){
		$this->Header();
		//$this->zetro_auth->view($view);
		$this->load->view($view,$this->data);	
		$this->Footer();
	}
	
	function cash_flow(){
		$this->zetro_auth->menu_id(array('alirankas'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('akuntansi/kas/cash_flow');
	}
	function laba_rugi(){
		$this->zetro_auth->menu_id(array('alirankas'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('akuntansi/kas/cash_flow');
	}
	
	function get_cash_flow(){
		$data=array();
		$where="where p.Tanggal='".$this->input->post('dari_tgl')."'";
		$where=($this->input->post('dari_tgl')=='')? $where:
			   "where p. Tanggal between '".$this->input->post('dari_tgl')."' and '".$this->input->post('sampai_tgl')."'"; 
			   
		$data['where']	=$where;
		$data['dari']	=$this->input->post('dari_tgl');
		$data['sampai']	=$this->input->post('sampai_tgl');	
		$data['temp_rec']=$this->report_model->lap_cash_flow();
		
		$this->zetro_auth->menu_id(array('trans_beli'));
		$this->list_data($data);
		$this->View("akuntansi/kas/cash_flow_print");
	}
}