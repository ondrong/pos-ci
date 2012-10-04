<?php
// Fronoffice model

class Kasir_model extends CI_Model {
	
	function __construct(){
		parent::__construct();
	}
	
	function get_trans_jual($no_trans,$tanggal){
		$sql="select dt.* from inv_penjualan as p
			 left join inv_penjualan_detail as dt
			 on dt.ID_Jual=p.ID
			 where p.NoUrut='$no_trans' and p.Tanggal='$tanggal' order by dt.ID";
		$data=$this->db->query($sql);
		return $data->result();
	}
}