<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/*
Class name: Inventory controller
version : 1.0
Author : Iswan Putera
*/

class Stock extends CI_Controller{
	function __construct(){
		parent::__construct();
		$this->load->model("Admin_model");
		$this->load->model("inv_model");
		$this->load->library('zetro_auth');
		$this->load->model("report_model");
		$this->load->helper("print_report");
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
		$this->zetro_auth->view($view);
		$this->load->view($view,$this->data);	
		$this->Footer();
	}
	function index(){
		$this->zetro_auth->menu_id(array('stockoverview','liststock'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('inventory/material_stock');
	}
	
	function list_stock(){
		$data=array();$n=0;
		$id=$_POST['nm_barang'];
		$data=$this->inv_model->get_detail_stock($id);
		foreach($data as $row){
			$n++;
			echo tr().td($n,'center').td($row->batch,'center').td(number_format($row->stock,2),'right').
				td(number_format($row->blokstok,2),'right').td(rdb('inv_barang_satuan','Satuan','Satuan',"where ID='".$row->nm_satuan."'"),'center').
				td($row->expired,'center').
				_tr();	
		}
	}
	
	function get_bacth(){
		$data=array();
		$id=$_POST['id_barang'];
		$data=$this->inv_model->get_detail_stocked($id);	
		echo (count($data)>0)?json_encode($data[0]):'{"batch":""}';
	}
	function list_filtered(){
		$nmj=array(); $data='';$valfld='';$n=0;
		$section=$_POST['section'];
		empty($_POST['nm_kategori'])?$kat	='':$kat	=$_POST['nm_kategori'];
		empty($_POST['stat_barang'])?$stat	='':$stat	=$_POST['stat_barang'];
		empty($_POST['nam_barang'])?$cari='':$cari=$_POST['nam_barang'];
		if($kat=='' && $stat==''){
			$where='';
		}else if($stat=='' && $kat!=''){
			$where="where ID_Kategori='$kat'";
		}else if($kat=='' && $stat!=''){
			$where="where Status='$stat'";
		}else{
			$where="where ID_Kategori='$kat' and Status='$stat'";
		}
		if($cari!='' && $where !=''){
			$where .= "and Nama_Barang like '".$cari."%'";
		}else if($cari!='' && $where ==''){
			$where ="where Nama_Barang like '".$cari."%'";
		}
		echo $where;
		if($kat!='' || $cari!=''){
		$nmj=$this->inv_model->set_stock($where);
			foreach ($nmj as $row){
				$n++;
				echo tr().td($n,'center').td($row->Kode).td($row->Nama_Barang).
					td($row->Satuan).td(number_format($row->stock,0),'right').td($row->Status);
				echo ($section=='stoklistview')?
					td("<img src='".base_url()."asset/images/editor.png' onclick=\"edited('".$row->ID."');\"",'center'):'';
				echo _tr();
			}
		}else{
			echo tr().td('Data terlalu besar untuk ditampilkan pilih dulu Katgeori','left\' colspan=\'7')._tr();
		}
	}
	function get_material_stock(){
		$data=array();$stok=0;$sat='';
		$id_material=$_POST['id_material'];
		$data=$this->inv_model->get_total_stock($id_material);
		foreach($data as $r){
			$stok	=$r->stock;
			$sat	=$r->satuan;
		}
		($stok=='')?'0':$stok;
		echo json_encode($data[0]);
	}
	function data_material(){
		$str=addslashes($_POST['str']);
		$induk=$_POST['induk'];
		$fld='nm_barang';
		$this->inv_model->tabel('inv_material');
		$this->inv_model->field($fld);
		$datax=$this->inv_model->auto_sugest($str);
		if($datax->num_rows>0){
			echo "<ul>";
				foreach ($datax->result() as $lst){
					echo '<li onclick="suggest_click(\''.$lst->$fld.'\',\'nm_barang\',\''.$induk.'\');">'.$lst->$fld."</li>";
				}
			echo "</ul>";
		}		
	}
	function data_hgb(){
		$data=array();
		$nm_barang=$_POST['nm_barang'];
		$this->zetro_auth->frm_filename('asset/bin/zetro_inv.frm');
		$data=$this->zetro_auth->show_data_field('stokoverview','inv_material',"where nm_barang='$nm_barang'");
		echo json_encode($data);	
	}
	function _filename(){
		$this->zetro_buildlist->config_file('asset/bin/zetro_inv.frm');
		$this->zetro_buildlist->aksi();
		$this->zetro_buildlist->icon();
	}
	
	function counting(){
		$this->zetro_auth->menu_id(array('countsheet','adjust'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('inventory/material_opname');
	}
	function countsheet_prn(){
		$data=array();
		$data['bln']=date('F');
		$data['thn']=date('Y');
		$nmj=array(); $datax='';$valfld='';
		if ($this->input->post('ID_jenis')!='') $nmj['nm_jenis']=$this->input->post('nm_jenis');
		if ($this->input->post('ID_kategori')!='')$nmj['nm_kategori']=$this->input->post('nm_kategori');
		//if ($this->input->post('nm_golongan')!='')$nmj['nm_golongan']=$this->input->post('nm_golongan');
		foreach(array_keys($nmj) as $nfield){
			$datax .=$nfield.",";	
		}
		foreach(array_values($nmj) as $valfield){
			$valfld .=$valfield;
		}
		$datax=substr($datax,0,(strlen($datax)-1));
		!empty($datax)?$where="where concat($datax)='$valfld'":$where='';
		$data['temp_rec']=$this->inv_model->set_stock($where);
		$this->zetro_auth->menu_id(array('trans_beli'));
		$this->list_data($data);
		$this->View("inventory/countsheet_print");
	}
	
	function update_adjust(){
		$data=array();
		$nm_barang=str_replace('_',' ',$_POST['nm_barang']);
		$stock=$_POST['stock'];
		$total_stock=$this->inv_model->total_stock("where nm_barang='$nm_barang'");
		$batch=$this->Admin_model->show_single_field('inv_material_stok','batch',"where nm_barang='$nm_barang'");
		$adjust=($stock-$total_stock);
		$stock_batch=$this->inv_model->total_stock("where nm_barang='$nm_barang' and batch='$batch'");
		
		$data['nm_barang']=$nm_barang;
		$data['batch']=$batch;
		$data['stock']=($stock_batch+$adjust);
		$this->Admin_model->replace_data('inv_material_stok',$data);
	}
}