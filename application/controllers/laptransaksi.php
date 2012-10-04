<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Laptransaksi extends CI_Controller{
	
	 function __construct()
	  {
		parent::__construct();
		$this->load->model("inv_model");
		$this->load->model("report_model");
		$this->load->helper("print_report");
		$this->load->model("akun_model");
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
}