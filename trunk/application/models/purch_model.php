<?php
// Inventori model

class Purch_model extends CI_Model {
	
	function __construct(){
		parent::__construct();
	}
	function  get_pemasok($str,$limit){
		$data=array();
		$sql="select * from inv_pemasok where Pemasok like '%".$str."%' order by Pemasok limit $limit";
		$rs=mysql_query($sql) or die(mysql_error());
		while($row=mysql_fetch_object($rs)){
				$data[]=array('data'		=>$row->Pemasok,
							  'description' =>'No. Urut : '.$row->Status.'<br>'.$row->Alamat." ".$row->Kota." ".$row->Propinsi,
							  'id_pemasok'	=>$row->ID
							  );
		}
		return $data;
	}
	
	function get_material_kode($kode){
		$data=array();
		$sql="select * from inv_barang where Kode='$kode'";
		$data=$this->db->query($sql);
		return $data->result();
	}
	
	function get_satuan_konv($nm_barang){
		$data=array();
		$sql="select ik.sat_beli,ik.isi_konversi,n.Satuan from inv_konversi as ik 
			  left join inv_barang_satuan as n
			  on n.ID=ik.sat_beli
			  where nm_barang='$nm_barang'";
		$data=$this->db->query($sql);
		return $data->result();
	}
	function get_total_belanja($notrans,$tanggal){
		$data=array();
		$sql="select sum(Jml_faktur*Harga_Beli) as total from inv_pembelian as p
			 left join inv_pembelian_detail as pd
			 on pd.ID_Beli=p.ID
			 where p.NoUrut='$notrans' and p.Tanggal='".tgltoSql($tanggal)."'";
		$data=$this->db->query($sql);
		return $data->result();
	}
}