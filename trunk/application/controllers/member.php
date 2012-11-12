<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
//class member

class Member extends CI_Controller{
	
	function __construct(){
		parent::__construct();
		$this->load->model("Admin_model");
		$this->load->model("member_model");
		$this->load->model('inv_model');
		$this->load->helper('print_report');	
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
		$this->load->view($view,$this->data);	
		$this->Footer();
	}
	function index(){
		$this->zetro_auth->menu_id(array('pelangganbaru','uploadphoto'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('member/member_view');
	}
	function member_list(){
		empty($_POST['id_dept'])?$where='':$where="where ID_Dept='".$_POST['id_dept']."'";
		empty($_POST['ordby'])? $ordby='order by noUrut':$ordby='order by '.$_POST['ordby'];
		$datax=$this->Admin_model->show_list('mst_anggota',$where.' '.$ordby);
		$this->zetro_auth->menu_id(array('member__member_list'));//array('list'),array($datax))
		$this->list_data($this->zetro_auth->auth());
		$this->View('member/member_list');
	}
	function filter_by(){
		$datax=array();$n=0;
		(empty($_POST['id_dept'])||$_POST['id_dept']=='all')?$where="where id_jenis='1'":$where="where ID_Jenis='1' and ID_Dept='".$_POST['id_dept']."'";
		(empty($_POST['ordby']) || $_POST['ordby']=='undefined')? $ordby='order by noUrut':$ordby='order by '.$_POST['ordby'];
		(empty($_POST['stat'])||$_POST['stat']=='all')? $where .='':
					 $where .=" and id_Aktif='".$_POST['stat']."'";
		 empty($_POST['searchby'])? $where .='':$where .=" and Nama like '%".$_POST['searchby']."%'";
		 echo $where.$ordby;
		$datax=$this->Admin_model->show_list('mst_anggota',$where.' '.$ordby);
		//print_r($datax);
		if(count($datax)>0){
			foreach($datax as $row){
			$n++;
			echo tr().td($n,'center').
					  td($row->No_Agt,'center').
					  td($row->Nama).
					  td($row->Catatan).
					  td($row->Alamat." ".$row->Kota).
					  td($row->Telepon."/".$row->Faksimili).
					  td(number_format($row->Status,2),'right').
					  td(img_aksi($row->ID),'center').
					_tr();
			}
		}else{
			echo "<tr><td colspan='7' class='kotak'>
			<img src='".base_url()."asset/images/16/warning_16.png'> &nbsp;Name not found in Database, please try again </td></tr>";
		}
			//echo $data['list']=count($datax);
	}
	function set_anggota(){
		//table mst_anggota
		$data=array();
		$data['No_Agt']		=$_POST['No_Agt'];
		$data['NoUrut']		=$_POST['No_Agt'];
		$data['ID']			=$_POST['No_Agt'];
		$data['ID_Dept']	='1';//$_POST['NIP'];
		$data['Nama']		=addslashes(strtoupper($_POST['Nama']));
		$data['Catatan']	=empty($_POST['Catatan'])?'':addslashes(strtoupper($_POST['Catatan']));
		$data['Alamat']		=$_POST['Alamat'];
		$data['Kota']		=addslashes(ucwords($_POST['Kota']));
		$data['Propinsi']	=addslashes(ucwords($_POST['Propinsi']));
		$data['Telepon']	=$_POST['Telepon'];
		$data['Faksimili']	=$_POST['Faksimili'];
		$data['ID_Aktif']	=empty($_POST['ID_Aktif'])?'0':$_POST['ID_Aktif'];
		$data['ID_Jenis']	='1';
		$data['TanggalKeluar']=date('Ymd');
		$data['Status']		=empty($_POST['Status'])?'0':$_POST['Status'];
		$this->Admin_model->replace_data('mst_anggota',$data);
	}
	
	function get_nomor_anggota(){
		echo $this->member_model->nomor_anggota();	
	}
	
	function get_anggota(){
		$arr=array();
		$str	=$_GET['str'];
		$limit	=$_GET['limit'];
		$ID_Dept=empty($_GET['dept'])?'':$_GET['dept'];
		$datax=$this->member_model->get_anggota($str,$limit,$ID_Dept);
		echo json_encode($datax);	
	}
	function get_kota(){
		$arr=array();
		$str=$_GET['str'];
		$datax=$this->member_model->get_kota($str);
		echo json_encode($datax);	
	}
	function get_propinsi(){
		$arr=array();
		$str=$_GET['str'];
		$datax=$this->member_model->get_propinsi($str);
		echo json_encode($datax);	
	}
	
	function do_upload()
	{	//upload foto anggota to uploads/member
		$datax=array();
		($this->input->post('NIP')!='')?$nip="(".$this->input->post('NIP').")":$nip="";
		$config['allowed_types'] = 'pdf|gif|jpg|png';
		$config['upload_path'] ='./uploads/member';
		$config['file_name']=str_replace(".",'_',$this->input->post('Nama')).$nip;
		$config['max_size']	= '0';
		$config['max_width']  = '0';
		$config['max_height']  = '0';
		$config['overwrite']=true;
		
		$this->load->library('upload', $config);
		$this->upload->initialize($config);
		if ( ! $this->upload->do_upload('PhotoLink'))
		{
			$this->zetro_auth->menu_id(array('anggotabaru','uploadphoto'));
			$data=$this->zetro_auth->auth(array('upload_data','panel','d_photo','error','nama','nip'),
					array($this->upload->data(),'uploadphoto','block',$this->upload->display_errors(),$this->input->post('Nama'),$this->input->post('NIP')));
			$this->Header();
			$this->load->view('member/member_view', $data);
			$this->Footer();
		}
		else
		{
			$this->zetro_auth->menu_id(array('anggotabaru','uploadphoto'));
			$data=$this->zetro_auth->auth(array('upload_data','panel','d_photo','error','nama','nip','nourut'),
					array($this->upload->data(),'uploadphoto','block',$this->upload->display_errors(),$this->input->post('Nama'),$this->input->post('NIP'),$this->input->post('no_agt')));
			$this->Header();
			$this->load->view('member/member_view', $data);
			$this->Footer();
		}
	}
	function simpan_photo(){
		$no_anggota=$_POST['no_anggota'];
		$photo_anggota=$_POST['photo_anggota'];
		$this->Admin_model->upd_data('mst_anggota',"set PhotoLink='".$photo_anggota."'","where NoUrut='$no_anggota'");
		echo "Tersimpan";
	}
	
	function field_orderby(){
		$data=$this->member_model->show_field('mst_anggota');
		echo json_encode($data);
	}
	function get_nama_simpanan(){
		$data=$this->member_model->jenis_simpanan($_POST['id']);
		echo $data;	
	}
	function member_detail(){
	$data=array();
	$no_anggota				=$_POST['no_anggota'];
	$data['kunci']			=$no_anggota;
	$data['no_anggota']		=$this->Admin_model->show_single_field('mst_anggota','No_Agt',"where ID='".$no_anggota."'");
	$data['nm_anggota']		=$this->Admin_model->show_single_field('mst_anggota','Nama',"where ID='".$no_anggota."'");
	$data['id_department']	=rdb('mst_departemen','Departemen','Departemen',"where ID='".
							$this->Admin_model->show_single_field('mst_anggota','ID_Dept',"where ID='".$no_anggota."'")."'");
	$data['transaksi']=$this->member_model->summary_member_data($no_anggota);
	$this->load->view('member/member_detail',$data);
	}
	function member_detail_trans(){
		$n=0;$total_debet=0;$total_kredit=0;
		$ID_Agt		=$_POST['ID_Agt'];
		$ID_Jenis	=$_POST['ID_Jenis'];
		$data=$this->member_model->detail_member_data($ID_Agt,$ID_Jenis);
		foreach($data->result() as $trn){
			$n++;
			echo "<tr class='xx' align='center'>
				  <td class='kotak'>$n</td>
				  <td class='kotak'>".tglfromSql($trn->Tanggal)."</td>
				  <td class='kotak'>".$trn->Nomor."</td>
				  <td class='kotak' align='left'>".$trn->Keterangan."</td>
				  <td class='kotak' align='right'>".number_format($trn->Debet,2)."</td>
				  <td class='kotak' align='right'>".number_format($trn->Kredit,2)."</td>
				  </tr>";
				  $total_debet +=$trn->Debet;
				  $total_kredit +=$trn->Kredit;
		};
		echo "<tr class='xx'>
			  <td class='kotak list_genap' colspan='4' align='right'>TOTAL &nbsp;&nbsp;</td>
			  <td class='kotak list_genap' align='right'><b>".number_format($total_debet,2)."</b></td>
			  <td class='kotak list_genap' align='right'><b>".number_format($total_kredit,2)."</b></td>
			  </tr>";
	}
	function member_biodata(){
		$datax=array();
		$no_anggota	=$_POST['no_anggota'];
		$data=$this->member_model->biodata_member($no_anggota);
		foreach($data->result() as $rr){
			$datax=$rr;
		}
		echo json_encode($datax);
	}
	//simpanan anggota
	
	function member_saving(){
		$this->zetro_auth->menu_id(array('simpananpokok','simpananwajib','simpanankhusus'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('member/member_simpanan');
	}
	
	function get_member_kredit(){
		$data=array();$n=0;
		$where=($_POST['status']=='')?'':"where p.stat_pinjaman='".$_POST['status']."'";
		$where=empty($_POST['cari'])?$where:"where a.Nama like '".$_POST['cari']."%'";
		$orderby=" order by ".$_POST['orderby'];
		$orderby.=empty($_POST['urutan'])? '':' '.$_POST['urutan'];
		//echo $where;
		$data=$this->member_model->get_data_pinjaman($where,$orderby);
		foreach($data as $r){
			$n++;
			echo tr().td($n,'center').
				 td($r->Nama.' [ <i> '.$r->Catatan.' </i> ]').
				 td(number_format($r->Debet,2),'right').
				 td(number_format($r->Kredit,2),'right').
				 td(number_format($r->Saldo,2),'right').
				 td(tglfromSql($r->mulai_bayar),'center').
				 td(($r->Kredit=='0')?img_aksi($r->ID.'-'.$r->Tahun,true,'del'):'').
				_tr();	 
		}
	}
	function get_member_kredit_print(){
		$data=array();$n=0;
		$where=($this->input->post('stat_tag')=='')?'':"where p.stat_pinjaman='".$this->input->post('stat_tag')."'";
		//$where.=($_POST['cari'])?'':"where a.Nama like '".$_POST['cari']."%'";
		$orderby=" order by ".$this->input->post('orderby');
		$orderby.=($this->input->post('urutan')=='')? '':' '.$this->input->post('urutan');
		$st=$this->input->post('stat_tag');
		if($st==''){$stat='All';}else if($st=='0'){$stat='Belum Lunas';}else{'Lunas';}
		$data['status']=$stat;
		$data['temp_rec']=$this->member_model->get_data_pinjaman($where,$orderby);

		$this->zetro_auth->menu_id(array('trans_beli'));
		$this->list_data($data);
		$this->View("laporan/lap_member_tagihan_print");
	}

}
?>