<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/*
Class name: Master Data
version : 1.0
Author : Iswan Putera
*/

class Master extends CI_Controller {
	public $userid;
	function __construct(){
		parent::__construct();
		$this->load->model("Admin_model");
		$this->load->model("control_model");
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
	function tools(){
		$datax=$this->akun_model->get_neraca_head("='0'");
		$data=$this->akun_model->get_neraca_head();
		$this->zetro_auth->menu_id(array('settingshu','settingneraca'));
		$this->list_data($this->zetro_auth->auth(array('head','shu'),array($data,$datax)));
		$this->View('master/master_tools');
	}
	function kas_harian(){
		$this->zetro_auth->menu_id(array('kas_harian','kas_keluar'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('master/master_kas_harian');
	}
	function vendor(){
		$this->zetro_auth->menu_id(array('addvendor','listvendor'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('master/master_vendor');
	}
	function general(){
		$this->zetro_auth->menu_id(array('kas'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('master/master_general');
	}
	
	function set_config_file($filename){
		$this->filename=$filename;
	}
	function simpan_kas(){
		$data=array();
		$data['id_kas']	=strtoupper($_POST['id_kas']);
		$data['nm_kas']	=strtoupper($_POST['nm_kas']);
		$data['sa_kas']	=($_POST['sa_kas']);
		$data['sl_kas']	=empty($_POST['sl_kas'])?0:$_POST['sl_kas'];
		$data['created_by']	=$this->session->userdata('userid');
			$this->Admin_model->replace_data('mst_kas',$data);
			$this->list_data_akun();
	}
	function simpan_kas_harian(){
		$data=array();
		$data['no_trans']=$_POST['no_trans'];
		$data['id_kas']	=strtoupper($_POST['id_kas']);
		$data['nm_kas']	=strtoupper($_POST['nm_kas']);
		$data['sa_kas']	=($_POST['sa_kas']);
		$data['tgl_kas']=tglToSql($_POST['tgl_kas']);
		$data['created_by']	=$this->session->userdata('userid');
			$this->Admin_model->replace_data('mst_kas_harian',$data);
	}
	function simpan_kas_keluar(){
		$data=array();$datax=array();
		$data['akun_transaksi']	=strtoupper($_POST['akun_transaksi']);
		$data['no_transaksi']	=($_POST['no_transaksi']);
		$data['jml_transaksi']	=($_POST['jtran']=='DR')?'1':'-1';
		$data['harga_beli']		=($_POST['tipe']=='D')?(0-$_POST['harga_beli']):$_POST['harga_beli'];
		$data['ket_transaksi']	=ucwords($_POST['ket_transaksi']);
		$data['jenis_transaksi']=$_POST['jtran'];
		$data['tgl_transaksi']	=tglToSql($_POST['tgl_transaksi']);
		$data['created_by']		=$this->session->userdata('userid');
		$datax['nomor']				=$_POST['no_transaksi'];
		$datax['jenis_transaksi']	=$_POST['jtran'];
		//print_r($datax);
			$this->Admin_model->replace_data('nomor_transaksi',$datax);
			$this->Admin_model->replace_data('detail_transaksi',$data);
			
			$sql="select * from detail_transaksi where tgl_transaksi='".date('Y-m-d')."' and (jenis_transaksi='D' or jenis_transaksi='DR') order by no_transaksi";
			$this->_generate_list($sql,'kaskeluar',$list_key='no_transaksi','deleted');
	}
	function get_datakas(){
		$data=array();
		$data=$this->Admin_model->show_single_field('mst_kas','id_kas',' order by id_kas');
		echo $data;

	}
	function get_datailkas(){
		$data=array();
		$data=$this->Admin_model->show_list('mst_kas');
		echo json_encode($data[0]);
	}	
	function _filename(){
		//configurasi data untuk generate form & list
		$this->zetro_buildlist->config_file('asset/bin/zetro_master.frm');
		$this->zetro_buildlist->aksi();
		$this->zetro_buildlist->icon();
	}
	function _generate_list($data,$section,$list_key='nm_barang',$icon='deleted',$aksi=true,$sub_total=false){
			//prepare table
			$this->_filename();
			$this->zetro_buildlist->aksi($aksi); 
			$this->zetro_buildlist->section($section);
			$this->zetro_buildlist->icon($icon);
			$this->zetro_buildlist->query($data);
			//bulid subtotal
			$this->zetro_buildlist->sub_total($sub_total);
			$this->zetro_buildlist->sub_total_kolom('4,5');
			$this->zetro_buildlist->sub_total_field('stock,blokstok');
			//show data in table
			$this->zetro_buildlist->list_data($section);
			$this->zetro_buildlist->BuildListData($list_key);
	}
	function list_kas_harian(){
		$data=array();	
		$data=array();$n=0;
		$data=$this->Admin_model->show_list('mst_kas_harian',"where month(tgl_kas)='".date('m')."' and year(tgl_kas)='".date('Y')."' order by id_kas");
		foreach($data as $r){
			$n++;
			echo tr().td($n,'center').
				 td(tglfromSql($r->tgl_kas,'center')).
				 td($r->id_kas).td($r->nm_kas).td($r->sa_kas).
				 td("<img src='".base_url()."asset/images/no.png' onclick=\"image_click('".$r->id_kas."','del');\" >",'center').
				 _tr();
		}
	}
	function list_data_akun(){
		$data=array();$n=0;
		$data=$this->Admin_model->show_list('mst_kas','order by id_kas');
		foreach($data as $r){
			$n++;
			echo tr().td($n,'center').
				 td($r->id_kas).td($r->nm_kas).td($r->sa_kas).
				 td("<img src='".base_url()."asset/images/no.png' onclick=\"image_click('".$r->id_kas."','del');\" >",'center').
				 _tr();
		}
	}
// seting shu dan neraca
	function get_subneraca(){
		$ID=$_POST['ID'];$n=0;
		$data=$this->akun_model->get_neraca_sub($ID);
		foreach($data as $row){
		$n++;	
			echo "<tr class='xx' align='center'>
				 <td class='kotak'>$n</td>
				 <td class='kotak' align='left'>".$row->SubJenis."</td>
				 <td class='kotak' align='left'>".$row->ID_Calc."</td>
				 <td class='kotak'>".$row->ID_KBR."</td>
				 <td class='kotak'>".$row->ID_USP."</td>
				 </tr>\n";
		}
		
	}
	function get_head_shu(){
		echo $data;	
	}
//vendor transaction
	function get_next_id(){
		$data=0;
		$data=$this->Admin_model->show_single_field('inv_pemasok','ID','order by ID desc limit 1');
		$data=($data+1);
		if(strlen($data)==1){
			$data='000'.$data;
		}else if(strlen($data)==2){
			$data='00'.$data;
		}else if(strlen($data)==3){
			$data='0'.$data;
		}else if(strlen($data)==4){
			$data=$data;
		}
		echo $data;
	}
  	
	function set_data_vendor(){
		$data=array();
		$data['ID']		=round($_POST['ID']);
		$data['Pemasok']=addslashes(strtoupper($_POST['pemasok']));
		$data['Alamat']	=ucwords(addslashes($_POST['alamat']));
		$data['Kota']	=ucwords($_POST['kota']);
		$data['Propinsi']=ucwords($_POST['propinsi']);
		$data['Telepon']=$_POST['telepon'];
		$data['cp_nama']=addslashes(strtoupper($_POST['cp_nama']));
		$data['Status'] =$_POST['ID'];
		$this->Admin_model->replace_data('inv_pemasok',$data);
	}
	function list_vendor(){
		$data=array(); $n=0;
		$nama=empty($_POST['nama'])?$where='':$where="where Pemasok like '%".$_POST['nama']."%'";
		$data=$this->Admin_model->show_list('inv_pemasok',$where.' order by Pemasok');
		foreach($data as $row){
			$n++;
			echo tr().td($n,'center').td($row->Status,'center').td($row->Pemasok).
				 td($row->Alamat).td($row->Kota).td($row->Propinsi).
				 td($row->cp_nama).td($row->Telepon).td().
				 _tr();
		}
	}
}
