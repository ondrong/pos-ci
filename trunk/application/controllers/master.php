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
	
	function set_config_file($filename){
		$this->filename=$filename;
	}
	function simpan_kas(){
		$data=array();
		$data['id_kas']	=strtoupper($_POST['id_kas']);
		$data['nm_kas']	=strtoupper($_POST['nm_kas']);
		$data['sa_kas']	=($_POST['sa_kas']);
		$data['sl_kas']	=($_POST['sl_kas']);
		$data['created_by']	=$this->session->userdata('userid');
			$this->Admin_model->replace_data('mst_kas',$data);
			
			$sql='select * from mst_kas order by nm_kas';
			$this->_generate_list($sql,'Kas',$list_key='id_kas');
	}
	function simpan_kas_harian(){
		$data=array();
		$data['id_kas']	=strtoupper($_POST['id_kas']);
		$data['nm_kas']	=strtoupper($_POST['nm_kas']);
		$data['sa_kas']	=($_POST['sa_kas']);
		$data['tgl_kas']=tglToSql($_POST['tgl_kas']);
		$data['created_by']	=$this->session->userdata('userid');
			$this->Admin_model->replace_data('mst_kas_harian',$data);
			
			$sql='select * from mst_kas_harian order by tgl_kas,nm_kas';
			$this->_generate_list($sql,'kasharian',$list_key='tgl_kas');
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
		$str=addslashes($_POST['str']);
		$induk=$_POST['induk'];
		$this->inv_model->tabel('mst_kas');
		$this->inv_model->field('id_kas');
		$datax=$this->inv_model->get_datakas();
		if($datax->num_rows>0){
			echo "<ul>";
				foreach ($datax->result() as $lst){
					echo '<li onclick="suggest_click(\''.$lst->id_kas.'\',\''.$_POST['fld'].'\',\''.$induk.'\');">'.$lst->id_kas."</li>";
				}
			echo "</ul>";
		}		
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
}
