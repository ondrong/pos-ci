<?php

//class control model

class Control_model extends CI_Model{
	function __construct(){
		parent::__construct();
	}
	function tabel($table){
		$this->tabels=$table;	
	}
	function field($query){
		$this->fields=$query;
	}
	function userid($userid){
		$this->userid=$userid;	
	}
	
	function cek_oto($field,$idmenu){
		$cek_oto='';
		$sql="select $field from useroto where idmenu='$idmenu' and userid='".$this->userid."'";
		$rs=mysql_query($sql) or die(mysql_error());
			while($row=mysql_fetch_object($rs)){
					$cek_oto=$row->$field;
		}
		return ($cek_oto=='Y')? " checked":($this->session->userdata('idlevel')=='1')? "checked":"";
	}
	function cek_oto_x($field,$idmenu,$userid){
		$cek_oto='';
		$sql="select $field from useroto where idmenu='".str_replace('/','__',$idmenu)."' and userid='".$userid."'";
		$rs=mysql_query($sql) or die(mysql_error());
			while($row=mysql_fetch_object($rs)){
					$cek_oto=$row->$field;
		}
		return ($cek_oto=='Y')? " checked":"";
	}

	function auto_sugest($str){
			$this->db->select($this->fields.' from '.$this->tabels." where idlevel!='1' and ".$this->fields." like '".$str."%' order by ". $this->fields,true);
			return $this->db->get();
	}
	function hapus_table($tabel,$field,$isi){
		$this->db->where($field,$isi);
		$this->db->delete($tabel);	
	}
	function user_area(){
		$data=array();$area='';
		$sql=($this->session->userdata('idlevel')=='1')?
		"select * from user_area order by ID":
		"select * from user_area where userid='".$this->userid."'";
		$data=$this->db->query($sql);
		foreach($data as $r){
			$area .="'".$r->ID."'";
		}
		return $area;
	}
}	
