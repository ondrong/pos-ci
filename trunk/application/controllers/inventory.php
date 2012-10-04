<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/*
Class name: Inventory controller
version : 1.0
Author : Iswan Putera
*/

class Inventory extends CI_Controller {
	
	function __construct(){
		parent::__construct();
		$this->load->model("Admin_model");
		$this->load->model("inv_model");
		$this->load->library('zetro_auth');
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
		$this->zetro_auth->menu_id(array('add','list','unit','kunit','hargabeli'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('inventory/material_list');

	}
	function general(){
		$data=array();
		$this->inv_model->create_table();
		$this->zetro_auth->menu_id(array('jenis','kategori','golongan'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('inventory/master_inv');
	}
	function show_konversi(){
	$id=$_POST['nm_barang'];
	echo "<hr/>";
	$sql2="select * from inv_konversi where nm_barang='$id' order by sat_beli";
		$this->zetro_buildlist->section('Konversi');
		$this->zetro_buildlist->aksi(true);
		$this->zetro_buildlist->icon('deleted');
		$this->zetro_buildlist->query($sql2);
		$this->zetro_buildlist->Header('50%');
		$this->zetro_buildlist->list_data('Konversi');
		$this->zetro_buildlist->BuildListData('nm_barang');
		echo "</tbody></table>";
	}
	//save data
	
	function simpan_jenis(){
		$data=array();
		$nm_jenis=ucwords($_POST['nm_jenis']);
		$induk=$_POST['induk'];
		$data['JenisBarang']=($nm_jenis);
		//$data['created_by']=$this->session->userdata("userid");
		$this->Admin_model->replace_data('inv_barang_jenis',$data);
		$this->zetro_auth->tab_select('tambahdata');
		if($induk==''){
			dropdown('inv_barang_jenis','ID','JenisBarang','',$nm_jenis);
		}else{
			$this->_filename();
			$this->zetro_buildlist->icon('deleted');
			$this->zetro_buildlist->section('Jenis');
			$sql2="select * from inv_barang_jenis order by JenisBarang";
			$this->zetro_buildlist->query($sql2);
			$this->zetro_buildlist->list_data('Jenis');
			$this->zetro_buildlist->BuildListData('JenisBarang');
		}
	}
	function simpan_kategori(){
		$data=array();
		$nm_jenis=($_POST['nm_kategori']);
		$induk=$_POST['induk'];
		$data['Kategori']=ucwords($nm_jenis);
		//$data['created_by']=$this->session->userdata("userid");
		$this->Admin_model->replace_data('inv_barang_kategori',$data);
		if($induk==''){
		dropdown('inv_barang_kategori','ID','Kategori','',$nm_jenis);
		}else{
			$this->_filename();
			$this->zetro_buildlist->icon('deleted');
			$this->zetro_buildlist->section('Kategori');
			$sql2="select * from inv_barang_kategori order by Kategori";
			$this->zetro_buildlist->query($sql2);
			$this->zetro_buildlist->list_data('Kategori');
			$this->zetro_buildlist->BuildListData('Kategori');
		}
	}
	function simpan_golongan(){
		$data=array();
		$nm_jenis=strtoupper($_POST['nm_golongan']);
		$induk=$_POST['induk'];
		$data['nm_golongan']=$nm_jenis;
		//$data['created_by']=$this->session->userdata("userid");
		$this->Admin_model->replace_data('inv_golongan',$data);
		if($induk==''){
		dropdown('inv_golongan','nm_golongan','nm_golongan','',$nm_jenis);
		}else{
			$this->_filename();
			$this->zetro_buildlist->icon('deleted');
			$this->zetro_buildlist->section('Golongan');
			$sql2="select * from inv_golongan order by nm_golongan";
			$this->zetro_buildlist->query($sql2);
			$this->zetro_buildlist->list_data('Golongan');
			$this->zetro_buildlist->BuildListData('nm_golongan');
		}
	}
	function simpan_satuan(){
		$data=array();
		$nm_jenis=strtoupper($_POST['nm_satuan']);
		$linked=$_POST['linked'];
		$induk=$_POST['induk'];
		$data['Satuan']=$nm_jenis;
		//$data['created_by']=$this->session->userdata("userid");
		$this->Admin_model->replace_data('inv_barang_satuan',$data);
		if($induk=='frm1'){
		dropdown('inv_barang_satuan','ID','Satuan','',$nm_jenis,true);
		}else{
	 	$this->_filename();
		$this->zetro_buildlist->section('Satuan');
		$this->zetro_buildlist->icon('deleted');
		$sql2="select * from inv_barang_satuan order by Satuan";
		$this->zetro_buildlist->query($sql2);
		$this->zetro_buildlist->list_data('Satuan');
		$this->zetro_buildlist->BuildListData('Satuan');
		}
	}
	function simpan_barang(){
		$data=array();
		$data['ID_Jenis']=$_POST['nm_jenis'];
		$data['Kode']=$_POST['id_barang'];
		$data['ID_Kategori']=$_POST['nm_kategori'];
		$data['Nama_Barang']=addslashes(strtoupper($_POST['nm_barang']));
		$data['ID_Satuan']=$_POST['nm_satuan'];
		$data['Status']=ucwords($_POST['status_barang']);
		$data['Harga_Beli']=$_POST['stokmin'];
		$data['Harga_Jual']=$_POST['stokmax'];
		//$data['created_by']=$this->session->userdata("userid");
		$this->Admin_model->replace_data('inv_barang',$data);
		/*$this->zetro_auth->tab_select($_POST['linked']);
		//generate list table
	 	$this->_filename();
		$this->zetro_buildlist->section('Barang');
		$sql2="select * from inv_material order by nm_barang";
		$this->zetro_buildlist->query($sql2);
		$this->zetro_buildlist->list_data('Barang');
		$this->zetro_buildlist->BuildListData('nm_barang');*/
	}
	function data_hgb(){
		$data=array();
		$nm_barang=$_POST['nm_barang'];
		$this->zetro_auth->frm_filename('asset/bin/zetro_inv.frm');
		$data=$this->zetro_auth->show_data_field('Harga Beli','inv_harga_beli',"where nm_barang='$nm_barang'");
		echo json_encode($data);	
	}
	function data_konversi(){
		$data=array();
		$nm_barang=$_POST['nm_barang'];
		$this->zetro_auth->frm_filename('asset/bin/zetro_inv.frm');
		$data=$this->zetro_auth->show_data_field('Barang','inv_material',"where nm_barang='$nm_barang'");
		echo json_encode($data);	
	}
	function list_hgb(){
	 	$this->_filename();
		$this->zetro_buildlist->section('Harga Beli');
		$sql2="select * from inv_barang where Nama_Barang='".strtoupper($_POST['nm_barang'])."' order by nm_barang";
		$this->zetro_buildlist->query($sql2);
		$this->zetro_buildlist->list_data('Harga Beli');
		$this->zetro_buildlist->BuildListData('Pemasok');
	}
	function list_konversi(){
	 	$this->_filename();
		$this->zetro_buildlist->icon('deleted');
		$this->zetro_buildlist->section('Konversi');
		$sql2="select k.nm_barang as nm_barang,s.Satuan as nm_satuan, sb.Satuan as sat_beli,k.isi_konversi
		 from inv_konversi as k
		 left join inv_barang_satuan as s
		 on s.ID=k.nm_satuan
		 left join inv_barang_satuan as sb
		 on sb.ID=k.sat_beli
		 where nm_barang='".strtoupper($_POST['nm_barang'])."' order by nm_barang";
		$this->zetro_buildlist->query($sql2);
		$this->zetro_buildlist->list_data('Konversi');
		$this->zetro_buildlist->BuildListData('sat_beli');
	}
	function simpan_hgb(){
		$data=array();$datax=array();
		$data['nm_barang']   =strtoupper($_POST['nm_barang']);
		$data['nm_produsen'] =strtoupper($_POST['nm_produsen']);
		$data['hg_beli']     =$_POST['hg_beli'];
		$data['sat_beli']    =$_POST['sat_beli'];
		//$data['created_by']  =$this->session->userdata("userid");
		$datax['nm_produsen']=strtoupper($_POST['nm_produsen']);
		$this->Admin_model->replace_data('inv_harga_beli',$data);
		$this->Admin_model->replace_data('mst_produsen',$datax);
		//generate list table
	 	$this->_filename();
		$this->zetro_buildlist->section('Harga Beli');
		$sql2="select * from inv_harga_beli where nm_barang='".strtoupper($_POST['nm_barang'])."' order by nm_barang";
		$this->zetro_buildlist->query($sql2);
		$this->zetro_buildlist->list_data('Harga Beli');
		$this->zetro_buildlist->BuildListData('nm_produsen');
	}
	function simpan_konversi(){
		$data=array();$datax=array();
		$data['id_barang']	 =rdb('inv_barang','ID','ID',"where Nama_Barang='".$_POST['nm_barang']."'");
		$data['nm_barang']   =strtoupper($_POST['nm_barang']);
		$data['nm_satuan']   =$_POST['nm_satuan'];
		$data['isi_konversi']=$_POST['isi_konversi'];
		$data['sat_beli']    =$_POST['sat_beli'];
		//$data['created_by']  =$this->session->userdata("userid");
		$this->Admin_model->replace_data('inv_konversi',$data);
		//generate list table
		$this->list_konversi();
	}
	//auto sugetion 
	function jenis_obat(){
		$str=addslashes($_POST['str']);
		$induk=$_POST['induk'];
		$this->inv_model->tabel('inv_jenis');
		$this->inv_model->field('nm_jenis');
		$datax=$this->inv_model->auto_sugest($str);
		if($datax->num_rows>0){
			echo "<ul>";
				foreach ($datax->result() as $lst){
					echo '<li onclick="suggest_click(\''.$lst->nm_jenis.'\',\'nm_jenis\',\''.$induk.'\');">'.$lst->nm_jenis."</li>";
				}
			echo "</ul>";
		}		
	}
	function kategori_obat(){
		$str=addslashes($_POST['str']);
		$induk=$_POST['induk'];
		$this->inv_model->tabel('inv_kategori');
		$fld='nm_kategori';
		$this->inv_model->field($fld);
		$datax=$this->inv_model->auto_sugest($str);
		if($datax->num_rows>0){
			echo "<ul>";
				foreach ($datax->result() as $lst){
					echo '<li onclick="suggest_click(\''.$lst->$fld.'\',\'nm_kategori\',\''.$induk.'\');">'.$lst->$fld."</li>";
				}
			echo "</ul>";
		}		
	}

	function data_material(){
		$datax=array();
		$str	=$_GET['str'];
		$limit	=$_GET['limit'];
		$fld	=$_GET['fld'];
		$dest	=empty($_GET['dest'])?'':$dest;
		$datax=$this->inv_model->get_nm_material($str,$limit,$fld,$dest);
		echo json_encode($datax);	
	}
	function data_produsen(){
		$str=addslashes($_POST['str']);
		$induk=$_POST['induk'];
		$fld='nm_produsen';
		$this->inv_model->tabel('mst_produsen');
		$this->inv_model->field($fld);
		$datax=$this->inv_model->auto_sugest($str);
		if($datax->num_rows>0){
			echo "<ul>";
				foreach ($datax->result() as $lst){
					echo '<li onclick="suggest_click(\''.$lst->$fld.'\',\'nm_produsen\',\''.$induk.'\');">'.$lst->$fld."</li>";
				}
			echo "</ul>";
		}		
	}
	function dropdown(){
		$table=$_POST['tbl'];
		$field=$_POST['field'];
		dropdown($table,$field,$field);
	}
	function show_list(){
		$data=array();$n=0; $where ="";
		$id			=empty($_POST['id'])?'':$_POST['id'];
		$id_jenis	=empty($_POST['id_jenis'])?'':"and id_jenis='".$_POST['id_jenis']."'";
		$stat		=($_POST['stat']=='all')?'':"and status='".$_POST['stat']."'";
		$cari		=empty($_POST['cari'])?'': "and Nama_Barang like '".$_POST['cari']."%'";
		if($id!='' && $id_jenis!=''){
			 $where="where ID_Kategori='$id' $id_jenis $stat $cari order by ID_Jenis,nama_barang";
		}else if ($id=='' && $id_jenis!=''){
			 $where="where id_jenis='".$_POST['id_jenis']."' $stat $cari order by ID_Jenis,nama_barang";
		}else if ($id=='' && $id_jenis==''){
		 	 $where="where Nama_Barang like '".$_POST['cari']."%' $stat order by ID_Jenis,nama_barang";
		}else if ($id!='' && $id_jenis==''){
			 $where="where ID_Kategori='$id' $stat $cari order by ID_Jenis,nama_barang";
		}
		/* echo $id.'='. $where; //for debug only*/
		$data=$this->inv_model->list_barang($where);
		foreach($data as $r){
			$n++;
			echo tr('xx','nm-'.$r->ID).td($n,'center').td($r->Kategori,'kotak\' nowrap=\'nowrap' ).td($r->JenisBarang). td(strtoupper($r->Kode)).
				 td(strtoupper($r->Nama_Barang)).td($r->Satuan).
				 td(number_format($r->Harga_Beli,2),'right').td(number_format($r->Harga_Jual,2),'right').td($r->Status);
			echo ($this->zetro_auth->cek_oto('e','list')!='')?
				 td(aksi('asset/images/editor.png','edit','Click for edit',"upd_barang('".$r->ID."');").'&nbsp;'.
				 	aksi('asset/images/no.png','del','Click for delete',"delet_barang('".$r->ID."');"),'center'):'';
			echo _tr();
		}
		
	}
	//edit section
	function get_unit_konv(){
		$data=array();
		$nm_barang=$_POST['nm_barang'];
		$data=$this->inv_model->get_unit_konv($nm_barang);
		foreach($data as $r){
			echo "<option value='".$r->sat_beli."'>".rdb('inv_barang_satuan','Satuan','Satuan',"where ID='".$r->sat_beli."'")."</option>";	
		}
	}
	function edit_material(){
		$data=array();
		$nm_barang=str_replace('_',' ',$_POST['nm_barang']);
		//$this->zetro_auth->frm_filename('asset/bin/zetro_inv.frm');
		//$data=$this->zetro_auth->show_data_field('Barang','inv_barang',"where nama_barang='$nm_barang'");
		$data=$this->inv_model->update_barang($nm_barang);
		echo json_encode($data[0]);	
	}
	
	function hapus_inv(){
		$fld=$_POST['fld'];
		$tbl=$_POST['tbl'];
		$where=str_replace('_',' ',$_POST['id']);
		$this->Admin_model->hapus_table($tbl,$fld,$where);
		echo $_POST['id'];
	}
	function hapus_konversi(){
		$fld=$_POST['fld'];
		$tbl=rdb('inv_barang_satuan','ID','ID',"where Satuan='".$_POST['tbl']."'");
		$this->Admin_model->hps_data('inv_konversi',"where nm_barang='$fld' and sat_beli='$tbl'");
	}
	//get additional constantdata for buildlist
	function _filename(){
		$this->zetro_buildlist->config_file('asset/bin/zetro_inv.frm');
		$this->zetro_buildlist->aksi();
		$this->zetro_buildlist->icon();
	}
	
	//get data status [akctive, no aktive]
	function get_status(){
		$str=addslashes($_POST['str']);
		$induk=$_POST['induk'];
		$fld=$_POST['fld'];
		$datax=$this->inv_model->get_status();
			echo "<ul>";
				foreach ($datax->result() as $lst){
					echo '<li onclick="suggest_click(\''.$lst->nm_status.'\',\''.$fld.'\',\''.$induk.'\');">'.$lst->nm_status."</li>";
				}
			echo "</ul>";
	}
	function get_satuan(){
		$id_barang=$_POST['id_barang'];
	}
}