<?php
// Inventori model

class Inv_model extends CI_Model {
	
	function __construct(){
		parent::__construct();
	}
	function tabel($table){
		$this->tabels=$table;	
	}
	function field($query){
		$this->fields=$query;
	}
	
	function auto_sugest($str){
		$this->db->select($this->fields.' from '.$this->tabels." where ".$this->fields." like '".$str."%' order by ". $this->fields,true);
		return $this->db->get();
	}
	function create_table(){
		$sql="CREATE TABLE IF NOT EXISTS `inv_material_stok` (
			`nm_barang` VARCHAR(125) NOT NULL DEFAULT '',
			`batch` VARCHAR(125) NOT NULL DEFAULT '',
			`expired` DATE NULL DEFAULT NULL,
			`stock` DOUBLE NULL DEFAULT '0',
			`blokstok` DOUBLE NULL DEFAULT '0',
			`nm_satuan` VARCHAR(50) NULL DEFAULT '0',
			PRIMARY KEY (`batch`, `nm_barang`)
		)
		COMMENT='data stock material'
		COLLATE='latin1_swedish_ci'
		ENGINE=MyISAM;";
		mysql_query($sql) or die(mysql_error());	
	}
	function satuan_suggest($key='nm_barang'){
		$query=array();
		$sql="select m.nm_satuan from inv_material as m where m.nm_barang='$key'";
		$sql2="select m.sat_beli from inv_konversi as m where m.nm_barang='$key'";
		$rs=mysql_query($sql) or die(mysql_error());
		$rs2=mysql_query($sql2) or die(mysql_error());
		while($row=mysql_fetch_object($rs)){
			$query[]=$row->nm_satuan;
		}
		while($row=mysql_fetch_object($rs2)){
			$query[]=$row->sat_beli;
		}
		
		return $query;
	}
	
	function total_stock($where='',$field='stock',$table='inv_material_stok'){
		$total=0;
		$sql="select sum($field) as $field from $table $where";
		$rw=mysql_query($sql) or die(mysql_error());
		while($rs=mysql_fetch_object($rw)){
			$total=$rs->$field;	
		}
		
		return $total;	
	}
	function total_record($table,$where,$field='*'){
		$sql="select $field from $table $where";
		$rs=mysql_query($sql) or die(mysql_error());
		return mysql_num_rows($rs);
	}
	function show_list_1where($field,$isifield){
        $this->db->select('*');
        $this->db->where($field,$isifield);
        return $query = $this->db->get($this->tabels, 1);

	}
	function hapus_resep_kosong(){
		$sql="select * from inv_material_stok where stock <=0 and left(nm_barang,5)='RESEP'";
		$rs=mysql_query($sql) or die(mysql_error());
			while($row=mysql_fetch_array($rs)){
					mysql_query("delete from inv_material where nm_barang='".$row['nm_barang']."'");
					
			}
		mysql_query("delete from inv_material_stok where stock <=0 and left(nm_barang,5)='RESEP'");
	}
	function get_material($field='',$isifield=''){
		$data=array();
		$sql="select distinct(nm_barang) as nm_barang,sum(jml_transaksi) as jml_transaksi from ".$this->tabels." where $field='".$isifield."' group by nm_barang";
		$rw= mysql_query($sql) or die(mysql_error());
		while($row=mysql_fetch_object($rw)){
			if($row->jml_transaksi>0){
				$data[]=$row->nm_barang;
			}
		}
		return $data;
	}
	function detail_transaksi($notrans,$nm_barang){
		
		$sql="select * from detail_transaksi where no_transaksi='$notrans' and nm_barang='$nm_barang'";
		$rw= $this->db->query($sql);
		return $rw->result_array();
			
	}
	function get_datakas(){
		$sql="select * from mst_kas order by id_kas";
		return $this->db->query($sql);
		//return $rw->result_array();
	}
	function get_status($where=''){
		$sql="select * from mst_status $where";
		return $this->db->query($sql);
	}
	function get_nm_material($str,$limit,$fld,$dest=''){
		$data=array();
		$sql="select * from inv_barang where $fld like '".$str."%' order by nama_barang limit $limit";	
		//echo $sql;
		($dest=='')?$dest='Nama_Barang':$dest=$dest;
		$rw= mysql_query($sql) or die(mysql_error());
		while($row=mysql_fetch_object($rw)){
				$data[]=array('data'		=>$row->$fld,
							  'description' =>$row->$dest,
							  'jenis'		=>$row->ID_Jenis,
							  'kategori'	=>$row->ID_Kategori,
							  'satuan'		=>$row->ID_Satuan,
							  'nm_satuan'	=>rdb('inv_barang_satuan','Satuan','Satuan',"where ID='".$row->ID_Satuan."'"),
							  'status'		=>$row->Status,
							  'kode'		=>$row->Kode,
							  'pemasok'		=>$row->ID_Pemasok."-".rdb('inv_pemasok','Pemasok','Pemasok',"where ID='".$row->ID_Pemasok."'"),
							  'hargabeli'	=>$row->Harga_Beli,
							  'hargajual'	=>$row->Harga_Jual,
							  'id_barang'	=>$row->ID,
							  'nm_kategori'	=>rdb('inv_barang_kategori','Kategori','Kategori',"where ID='".$row->ID_Kategori."'")
							  );
		}
		return $data;
	}
	// daftar barang
	function list_barang($where){
		$data=array();
		$sql="select b.ID,bj.JenisBarang,bk.Kategori,b.Kode,b.Nama_Barang,b.Harga_Beli,b.Harga_Jual,bs.Satuan,b.Status
				from inv_barang as b
				left join inv_barang_jenis as bj
				on bj.ID=b.ID_Jenis
				left join inv_barang_kategori as bk
				on bk.ID=b.ID_Kategori
				left join inv_barang_satuan as bs
				on bs.ID=b.ID_Satuan
				$where ";
		$data=$this->db->query($sql);
		return $data->result();
	}
	function update_barang($id){
		$sql="select * from inv_barang where id='$id'";
		$data=$this->db->query($sql);
		return $data->result();
	}
	function get_unit_konv($material){
		$sql="select * from inv_konversi where nm_barang='$material'";
		$data=$this->db->query($sql);
		return $data->result();
	}
	function set_stock($where){
		$sql="select ms.stock,b.Kode,b.ID,bj.JenisBarang,bk.Kategori,
			  b.Kode,b.Nama_Barang,b.Harga_Beli,b.Harga_Jual,bs.Satuan,b.Status
				from inv_barang as b
				left join inv_material_stok as ms
				on ms.nm_barang=b.Nama_Barang
				left join inv_barang_jenis as bj
				on bj.ID=b.ID_Jenis
				left join inv_barang_kategori as bk
				on bk.ID=b.ID_Kategori
				left join inv_barang_satuan as bs
				on bs.ID=b.ID_Satuan
				$where order by b.Nama_Barang";
		//echo $sql;		
		$data=$this->db->query($sql);
		return $data->result();
	}
	
	function get_detail_stock($nm_barang){
		$sql="select batch, sum(stock) as stock, sum(blokstok) as blokstok,
			   expired,nm_satuan,harga_beli from inv_material_stok where nm_barang='$nm_barang'
			   and stock <>'0' group by batch order by batch";
		$data=$this->db->query($sql);
		return $data->result();
	}
	function get_detail_stocked($nm_barang,$limit='limit 1'){
		$sql="select batch, sum(stock) as stock, sum(blokstok) as blokstok,
			   expired,nm_satuan,harga_beli from inv_material_stok where id_barang='$nm_barang'
			   and stock <>'0' group by batch order by batch desc $limit";
		$data=$this->db->query($sql);
		return $data->result();
	}
	function get_total_stock($nm_barang){
		$sql="select sum(s.stock) as stock,u.satuan
				from inv_material_stok as s
				left join inv_barang as p
				on p.ID=s.id_barang
				left join inv_barang_satuan as u
				on u.ID=p.ID_Satuan
				where id_barang='$nm_barang'";
		$data=$this->db->query($sql);
		return $data->result();
	}
}
