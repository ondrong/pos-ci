<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Report extends CI_Controller
{
	 function __construct()
	  {
		parent::__construct();
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
		//tampilkan laporan pembelian
		$this->zetro_auth->menu_id(array('laporanpembelian'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('laporan/transaksi/lap_beli');

	}
	function kas(){
		//tampilkan laporan penjualan
		$this->zetro_auth->menu_id(array('laporankas'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('laporan/transaksi/lap_kas');
	}
	function jual(){
		//tampilkan laporan penggunaan kas
		$this->zetro_auth->menu_id(array('trans_jual'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('laporan/transaksi/lap_jual');
	}
	//ouput laporan dalam pdf
	function print_laporan(){
		//print laporan to pdf
		$datap=array();
		$nmj=array(); $data='';$valfld='';$datax='';
		if($this->input->post('dari_tgl')==''){$dari_tgl='';}else{$dari_tgl=$this->input->post('dari_tgl');}
		if($this->input->post('sampai_tgl')==''){$sampai_tgl=$this->input->post('dari_tgl');}else{$sampai_tgl=$this->input->post('sampai_tgl');}
		//if($this->input->post('nm_golongan')!=''){$nmj['nm_golongan']=$this->input->post('nm_golongan');}
		if($this->input->post('nm_produsen')!=''){
			$nmj['p.ID_Pemasok']=rdb('inv_pemasok','Pemasok','Pemasok',"where ID='".$this->input->post('nm_produsen')."'");
			}else{
				if($this->input->post('nm_dokter')!=''){
					$nmj['ID_Anggota']=rdb('mst_anggota','ID','ID',"where Nama='".$this->input->post('nm_dokter')."'");
				}
			}
		if($this->input->post('nm_jenis')!=''){$nmj['im.ID_Jenis']=$this->input->post('nm_jenis');}
		
		$section=$this->input->post('section');
		$jtran=$this->input->post('jtran');
		$jenisobat=$this->input->post('nm_jenis').' '.$this->input->post('nm_golongan');
		$nm_vendor=$this->input->post('nm_produsen').' '.$this->input->post('nm_dokter');
		$optional=$this->input->post('optional');
		
		(!empty($dari_tgl))?$datax=" and dt.Tanggal between '".tglToSql($dari_tgl)."' and '".tglToSql($sampai_tgl)."'":$datax='';
		
		foreach(array_keys($nmj) as $nfield){
			$data .=$nfield.",";	
		}
		foreach(array_values($nmj) as $valfield){
			$valfld .=$valfield;
		}
		$data=substr($data,0,(strlen($data)-1));
		if(empty($jtran) && empty($data) && empty($datax)){ $where='';}else{
				if(!empty($jtran)) $where="";
				if(!empty($data)) $where .="where concat($data)='$valfld'";
				if(!empty($datax))$where .=$datax;
				//if(!empty($optional)) $where .=$optional;
		}
		$susunan	=$this->input->post('susunan');
		$urutan		=$this->input->post('urutan');
		$urutan		=empty($urutan)?'ASC':strtoupper($urutan);
		$ordby		=empty($susunan)? '':" order by concat(".str_replace('-',',',$susunan).') '.$urutan;
		$datap['tanggal']	=(empty($dari_tgl))?'All':$dari_tgl ." s/d ". $sampai_tgl;
		$datap['jenisobat']	=($jenisobat=='')?'All':rdb('inv_barang_kategori','Kategori','Kategori',"where ID='".$jenisobat."'");
		$datap['nm_vendor']	=($nm_vendor=='')?'All':$nm_vendor;
		$datap['temp_rec']	=$this->report_model->select_trans($where.$ordby,'Y');
		//echo $ordby;
		$this->zetro_auth->menu_id(array('trans_beli'));
		$this->list_data($datap);
		$this->View("laporan/transaksi/lap_".$this->input->post('lap')."_print");
	}
	//report transaksi pembelian 
	
	function print_laporan_beli(){
		$datap=array();
		$nmj=array(); $data='';$valfld='';$datax='';
		if($this->input->post('dari_tgl')==''){$dari_tgl='';}else{$dari_tgl=$this->input->post('dari_tgl');}
		if($this->input->post('sampai_tgl')==''){$sampai_tgl=$this->input->post('dari_tgl');}else{$sampai_tgl=$this->input->post('sampai_tgl');}
		//if($this->input->post('nm_golongan')!=''){$nmj['nm_golongan']=$this->input->post('nm_golongan');}
		if($this->input->post('nm_produsen')!=''){
			$nmj['p.ID_Pemasok']=$this->input->post('ID_Pemasok');
			}else{
				if($this->input->post('nm_dokter')!=''){
					$nmj['ID_Anggota']=rdb('mst_anggota','ID','ID',"where Nama='".$this->input->post('nm_dokter')."'");
				}
			}
		if($this->input->post('nm_jenis')!=''){$nmj['im.ID_Jenis']=$this->input->post('nm_jenis');}
		
		$section=$this->input->post('section');
		$jtran=$this->input->post('jtran');
		$jenisobat=$this->input->post('nm_jenis').' '.$this->input->post('nm_golongan');
		$nm_vendor=$this->input->post('nm_produsen').' '.$this->input->post('nm_dokter');
		$optional=$this->input->post('optional');
		
		(!empty($dari_tgl))?$datax=" and dt.Tanggal between '".tglToSql($dari_tgl)."' and '".tglToSql($sampai_tgl)."'":$datax='';
		
		foreach(array_keys($nmj) as $nfield){
			$data .=$nfield.",";	
		}
		foreach(array_values($nmj) as $valfield){
			$valfld .=$valfield;
		}
		$data=substr($data,0,(strlen($data)-1));
		if(empty($jtran) && empty($data) && empty($datax)){ $where='';}else{
				if(!empty($jtran)) $where="";
				if(!empty($data)) $where .="where concat($data)='$valfld'";
				if(!empty($datax))$where .=$datax;
				//if(!empty($optional)) $where .=$optional;
		}
		$susunan	=$this->input->post('susunan');
		$urutan		=$this->input->post('urutan');
		$urutan		=empty($urutan)?'ASC':strtoupper($urutan);
		$ordby		=empty($susunan)? '':" order by concat(".str_replace('-',',',$susunan).') '.$urutan;
		//echo $ordby;
		$datap['tanggal']	=(empty($dari_tgl))?'All':$dari_tgl ." s/d ". $sampai_tgl;
		$datap['jenisobat']	=($jenisobat=='')?'All':rdb('inv_barang_kategori','Kategori','Kategori',"where ID='".$jenisobat."'");
		$datap['nm_vendor']	=($nm_vendor=='')?'All':$nm_vendor;
		$datap['temp_rec']	=$this->report_model->select_trans_beli($where.$ordby,'Y');
		
		$this->zetro_auth->menu_id(array('trans_beli'));
		$this->list_data($datap);
		$this->View("laporan/transaksi/lap_".$this->input->post('lap')."_print");
	}
	//laporan kas
	function print_laporan_kas(){
		$datap=array();
		$nmj=array(); $data='';$valfld='';$datax='';
		if($this->input->post('dari_tgl')==''){$dari_tgl='';}else{$dari_tgl=$this->input->post('dari_tgl');}
		if($this->input->post('sampai_tgl')==''){$sampai_tgl=$this->input->post('dari_tgl');}else{$sampai_tgl=$this->input->post('sampai_tgl');}
		empty($dari_tgl)?
			$where="":
			$where="where j.Tanggal between '".tglToSql($dari_tgl)."' and '".tglToSql($sampai_tgl)."'";
		$ordby=' order by j.NoUrut';
		$groupby=($this->input->post('jenis_lap')=='')?'':"group by j.Tanggal";
		$datap['tanggal']	=(empty($dari_tgl))?'All':$dari_tgl ." s/d ". $sampai_tgl;
		$datap['temp_rec']	=$this->report_model->get_cash_flow($where,$groupby);
		
		$this->zetro_auth->menu_id(array('trans_beli'));
		$this->list_data($datap);
		$this->View("laporan/transaksi/lap_kas_print");
	}
}
?>
