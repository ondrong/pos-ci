<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/*
	controller laporan kas
*/
class Laptransaksi extends CI_Controller{
	
	 function __construct()
	  {
		parent::__construct();
		$this->load->model("report_model");
		$this->load->model("kasir_model");
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
		$this->zetro_auth->menu_id(array('labarugi'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('akuntansi/kas/laba_rugi');
	}
	function kas_masuk(){
		$this->zetro_auth->menu_id(array('laporankasmasuk'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('akuntansi/kas/kas_masuk');
	}
	function ops_harian(){
		$this->zetro_auth->menu_id(array('operasionalharian'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('akuntansi/kas/operasional');
	}
	
	function get_cash_flow(){
		$data=array();
		$where="where p.Tanggal='".$this->input->post('dari_tgl')."'";
		$where=($this->input->post('sampai_tgl')=='')? $where:
			   "where p.Tanggal between '".$this->input->post('dari_tgl')."' and '".$this->input->post('sampai_tgl')."'"; 
			   
		$data['where']	=$where;
		$data['dari']	=$this->input->post('dari_tgl');
		$data['sampai']	=$this->input->post('sampai_tgl');	
		$data['temp_rec']=$this->report_model->lap_cash_flow();
		
		$this->zetro_auth->menu_id(array('trans_beli'));
		$this->list_data($data);
		$this->View("akuntansi/kas/cash_flow_print");
	}
	
	function get_laba_rugi(){
		$data=array();
		$where="where Tanggal='".tglToSql($this->input->post('dari_tgl'))."'";
		$where=($this->input->post('sampai_tgl')=='')? $where:
			   "where Tanggal between '".tglToSql($this->input->post('dari_tgl'))."' and '".tglToSql($this->input->post('sampai_tgl'))."'"; 
		$where.="and ID_Jenis!='5'";
		$jumlah=$this->kasir_model->totaldata($where);
		$jumlah=($jumlah>4)? round(($jumlah/4),0):$jumlah;
		$orderby="order by dt.Tanggal";
		$data['pajak']	=$this->input->post('pajak');
 		$data['dari']	=$this->input->post('dari_tgl');
		$data['sampai']	=$this->input->post('sampai_tgl');	
		$data['temp_rec']=$this->kasir_model->laba_rugi($where,$orderby);
		$this->zetro_auth->menu_id(array('trans_beli'));
		$this->list_data($data);
		$this->View("laporan/transaksi/lap_laba_rugi_print");
		
	}
	
	function get_kas_masuk(){
		$data=array();
		$where="where p.Tanggal='".tglToSql($this->input->post('dari_tgl'))."'";
		$where=($this->input->post('sampai_tgl')=='')? $where:
			   "where p.Tanggal between '".tglToSql($this->input->post('dari_tgl'))."' and '".tglToSql($this->input->post('sampai_tgl'))."'"; 
		$where.=($this->input->post('id_jenis')=='')?'':" and ID_Jenis='".$this->input->post('id_jenis')."'";	   
 		$where.="and p.ID_Jenis!='5'";
		$jumlah=$this->kasir_model->totaldata($where);
		$jumlah=($jumlah>4)? round(($jumlah/4),0):$jumlah;
		$group =" group by concat(p.ID_Jenis,dt.Tanggal)";
		$orderby=($this->input->post('pajak')=='ok')?"order by rand() limit $jumlah":"order by p.Tanggal";
 		$data['dari']	=$this->input->post('dari_tgl');
		$data['sampai']	=$this->input->post('sampai_tgl');	
		$data['id_jenis']=($this->input->post('id_jenis'))?'Semua':rdb('inv_penjualan_jenis','Jenis_Jual','Jenis_Jual',"where ID='".$this->input->post('id_jenis')."'");
		$data['temp_rec']=$this->kasir_model->kas_masuk($where,$orderby);
		
		$this->zetro_auth->menu_id(array('trans_beli'));
		$this->list_data($data);
		$this->View("laporan/transaksi/lap_kas_print");
	}
	
	function get_operasional(){
		$data=array();
		$where="where tgl_kas='".tglToSql($this->input->post('dari_tgl'))."'";
		$where=($this->input->post('sampai_tgl')=='')? $where:
			   "where tgl_kas between '".tglToSql($this->input->post('dari_tgl'))."' and '".tglToSql($this->input->post('sampai_tgl'))."'"; 
		$orderby="order by tgl_trans";
		//$data['where']	=str_replace('tgl_kas','tgl_trans',$where)." and jumlah!='0'";
		$data['orderby']=$orderby;
 		$data['dari']	=$this->input->post('dari_tgl');
		$data['sampai']	=$this->input->post('sampai_tgl');	
		$data['temp_rec']=$this->kasir_model->get_kas_awal($where);
		$this->zetro_auth->menu_id(array('trans_beli'));
		$this->list_data($data);
		$this->View("laporan/transaksi/lap_operasional_print");
	}
}