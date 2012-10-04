<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Laporan extends CI_Controller{
	
	 function __construct()
	  {
		parent::__construct();
		$this->load->model("inv_model");
		$this->load->model("report_model");
		$this->load->helper("print_report");
		$this->load->model("control_model");
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
	function beli(){
		$this->zetro_auth->menu_id(array('trans_beli'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('laporan/lap_beli');

	}
	function jual(){
		$this->zetro_auth->menu_id(array('trans_jual','trans_resep','trans_top'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('laporan/lap_jual');

	}
	function stock(){
		$this->zetro_auth->menu_id(array('stocklist','dataexpire','stocklimit'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('laporan/lap_stock');

	}
	function kas(){
		$this->zetro_auth->menu_id(array('kasharian','kasbulanan'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('laporan/lap_kas');

	}
	function faktur(){
		$this->zetro_auth->menu_id(array('faktur'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('laporan/lap_faktur');
	}
	function list_filtered(){
		$nmj=array(); $data='';$valfld='';$datax='';
		(empty($_POST['dari_tgl']))?$dari_tgl='':$dari_tgl=$_POST['dari_tgl'];
		(empty($_POST['sampai_tgl']))?$sampai_tgl=$_POST['dari_tgl']:$sampai_tgl=$_POST['sampai_tgl'];
		if ($_POST['nm_golongan']!='')$nmj['nm_golongan']=$_POST['nm_golongan'];
		if ($_POST['nm_produsen']!='')$nmj['nm_produsen']=$_POST['nm_produsen'];
		
		$section=$_POST['section'];
		$jtran=$_POST['jtran'];
		
		(!empty($dari_tgl))?$datax=" and tgl_transaksi between '".tglToSql($dari_tgl)."' and '".tglToSql($sampai_tgl)."'":$datax='';
		
		foreach(array_keys($nmj) as $nfield){
			$data .=$nfield.",";	
		}
		foreach(array_values($nmj) as $valfield){
			$valfld .=$valfield;
		}
		$data=substr($data,0,(strlen($data)-1));
		if(empty($jtran) && empty($data) && empty($datax)){ $where='';}else{
				if(!empty($jtran)) $where="where (jenis_transaksi='".$jtran.")";
				if(!empty($data)) $where .=" and concat($data)='$valfld'";
				if(!empty($datax))$where .=$datax;
		}
		//echo $where;
			//prepare table
			$this->_filename();
			$this->zetro_buildlist->aksi(false);
			$this->zetro_buildlist->section($section);
			$this->zetro_buildlist->icon();
			$this->zetro_buildlist->query($this->report_model->select_trans($where));
			//bulid subtotal
			$this->zetro_buildlist->sub_total(true);
			$this->zetro_buildlist->sub_total_kolom('7');
			$this->zetro_buildlist->sub_total_field(array('harga_beli'));
			//show data in table
			$this->zetro_buildlist->list_data($section);
			$this->zetro_buildlist->BuildListData('nm_barang');
	}
	
	function _filename(){
		$this->zetro_buildlist->config_file('asset/bin/zetro_beli.frm');
		$this->zetro_buildlist->aksi();
		$this->zetro_buildlist->icon();
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
	function print_laporan(){
		//print laporan to pdf
		$datap=array();
		$nmj=array(); $data='';$valfld='';$datax='';
		if($this->input->post('dari_tgl')==''){$dari_tgl='';}else{$dari_tgl=$this->input->post('dari_tgl');}
		if($this->input->post('sampai_tgl')==''){$sampai_tgl=$this->input->post('dari_tgl');}else{$sampai_tgl=$this->input->post('sampai_tgl');}
		if($this->input->post('nm_golongan')!=''){$nmj['nm_golongan']=$this->input->post('nm_golongan');}
		if($this->input->post('nm_produsen')!=''){
			$nmj['nm_produsen']=$this->input->post('nm_produsen');
			}else{
				if($this->input->post('nm_dokter')!=''){
					$nmj['nm_produsen']=$this->input->post('nm_dokter');
				}
			}
		if($this->input->post('nm_jenis')!=''){$nmj['nm_jenis']=$this->input->post('nm_jenis');}
		
		$section=$this->input->post('section');
		$jtran=$this->input->post('jtran');
		$jenisobat=$this->input->post('nm_jenis').' '.$this->input->post('nm_golongan');
		$nm_vendor=$this->input->post('nm_produsen').' '.$this->input->post('nm_dokter');
		$optional=$this->input->post('optional');
		
		(!empty($dari_tgl))?$datax=" and tgl_transaksi between '".tglToSql($dari_tgl)."' and '".tglToSql($sampai_tgl)."'":$datax='';
		
		foreach(array_keys($nmj) as $nfield){
			$data .=$nfield.",";	
		}
		foreach(array_values($nmj) as $valfield){
			$valfld .=$valfield;
		}
		$data=substr($data,0,(strlen($data)-1));
		if(empty($jtran) && empty($data) && empty($datax)){ $where='';}else{
				if(!empty($jtran)) $where="where (jenis_transaksi='".$jtran.")";
				if(!empty($data)) $where .=" and concat($data)='$valfld'";
				if(!empty($datax))$where .=$datax;
				if(!empty($optional)) $where .=$optional;
		}
		$datap['tanggal']	=(empty($dari_tgl))?'All':$dari_tgl ." s/d ". $sampai_tgl;
		$datap['jenisobat']	=($jenisobat=='')?'All':$jenisobat;
		$datap['nm_vendor']	=($nm_vendor=='')?'All':$nm_vendor;
		$datap['temp_rec']	=$this->report_model->select_trans($where,'Y');
		
		$this->zetro_auth->menu_id(array('trans_beli'));
		$this->list_data($datap);
		$this->View("laporan/lap_".$this->input->post('lap')."_print");
	}
	function print_laporan_stock(){
		$data	=array();
		$datax	=array();	
		$nmj=array(); $datax='';$valfld='';
		if ($this->input->post('nm_jenis')!=''){ $nmj['nm_jenis']=$this->input->post('nm_jenis');}
		if ($this->input->post('nm_kategori')!=''){$nmj['nm_kategori']=$this->input->post('nm_kategori');}
		if ($this->input->post('nm_golongan')!=''){$nmj['nm_golongan']=$this->input->post('nm_golongan');}
		foreach(array_keys($nmj) as $nfield){
			$datax .=$nfield.",";	
		}
		foreach(array_values($nmj) as $valfield){
			$valfld .=$valfield;
		}
		$data['nm_jenis']	=$this->input->post('nm_jenis');
		$data['nm_kategori']=$this->input->post('nm_kategori');
		$data['nm_golongan']=$this->input->post('nm_golongan');
		$tipe=$this->input->post('lap');
		$datax=substr($datax,0,(strlen($datax)-1));
		if(!empty($datax)){
			$where="where concat($datax)='$valfld'";
			if($tipe=='expired')$where .="and stock >'0'";
		}else{
			($tipe=='expired')? $where="where  stock >'0'":$where='';
		}
		$data['temp_rec']	=$this->report_model->stock_list($where,$tipe);
		
		$this->zetro_auth->menu_id(array('trans_beli'));
		$this->list_data($data);
		$this->View("laporan/lap_".$this->input->post('lap')."_print");
	}
	function generate_lapkas(){
		$data=array();
		$dari_tgl	=tglToSql($_POST['dari_tgl']);
		$sampai_tgl	=tglToSql($_POST['sampai_tgl']);
		($_POST['dari_tgl']=='')?$dari_tgl=date('Y-m-d'):$dari_tgl=$dari_tgl;
		($_POST['dari_tgl']=='')?$sampai_tgl=date('Y-m-d'):$sampai_tgl=$sampai_tgl;
		
		$this->report_model->create_tmp_table();
		$this->report_model->copy_to_tmp_table($dari_tgl,$sampai_tgl);
			
	}
	function show_lapkas(){
		$data=array();
		$dari_tgl	=tglToSql($this->input->post('dari_tgl'));
		$sampai_tgl	=tglToSql($this->input->post('sampai_tgl'));
		($this->input->post('dari_tgl')=='')?$dari_tgl=date('Y-m-d'):$dari_tgl=$dari_tgl;
		($this->input->post('dari_tgl')=='')?$sampai_tgl=date('Y-m-d'):$sampai_tgl=$sampai_tgl;
		$where ="where tgl between '".$dari_tgl."' and '".$sampai_tgl."'";
		$data['dari_tgl']	=($this->input->post('dari_tgl')=='')?date('d/m/Y'):$this->input->post('dari_tgl');
		$data['sampai_tgl']	=($this->input->post('dari_tgl')=='')?date('d/m/Y'):$this->input->post('sampai_tgl');
		$data['temp_rec']	=$this->report_model->laporan_kas($where);
		
		$this->zetro_auth->menu_id(array('trans_beli'));
		$this->list_data($data);
		//print_r($data);
		$this->View("laporan/lap_".$this->input->post('lap')."_print");
		
	}
	function last_no_transaksi(){
		$data=$this->Admin_model->penomoran('GI');
		echo $data;	
	}
	function print_faktur(){
		$data=array();
		$no_trans=$this->input->post('no_transaksi');
		$data['nm_nasabah']	=$this->Admin_model->show_single_field("detail_transaksi",'nm_produsen',"where no_transaksi='$no_trans'");
		$data['alamat']		=$this->Admin_model->show_single_field("mst_pelanggan",'alm_pelanggan',"where nm_pelanggan='".$this->Admin_model->show_single_field("detail_transaksi",'nm_produsen',"where no_transaksi='$no_trans'")."'");
		$data['telp']		=$this->Admin_model->show_single_field("mst_pelanggan",'telp_pelanggan',"where nm_pelanggan='".$this->Admin_model->show_single_field("detail_transaksi",'nm_produsen',"where no_transaksi='$no_trans'")."'");
		$data['temp_rec']	=$this->report_model->laporan_faktur($no_trans);
		$data['terbilang']	=$this->Admin_model->show_single_field('bayar_transaksi',"terbilang","where no_transaksi='$no_trans'");
		$this->zetro_auth->menu_id(array('trans_beli'));
		$this->list_data($data);
		$this->View("laporan/lap_".$this->input->post('lap')."_print");
	}
}