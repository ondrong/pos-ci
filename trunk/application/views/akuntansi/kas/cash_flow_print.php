<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

		  $a=new reportProduct();
		  $TglLong=LongTgl($dari);
		  $a->setKriteria("neraca");
		  $a->setNama("LAPORAN ALIRAN KAS");
		  $a->setSection("");
		  $a->setFilter(array($TglLong));
		  $a->setReferer(array('Per'));
		  $a->setFilename('asset/bin/zetro_akun.frm');
		  $a->AliasNbPages();
		  //$a->AddPage("P","A4");
		  $a->AddPage('P','A4');
		  $a->SetFont('Arial','',10);
		  $a->SetWidths(array(100,30,30));// set lebar tiap kolom tabel transaksi
		  $a->SetAligns(array("L","R","R"));// set align tiap kolom tabel transaksi
		  $a->SetFont('Arial','B',10);
		  $data=array();$n=0;
		  
		  foreach($temp_rec as $r){
			$n++;
			$a->Row(array($r->Kode.'.'.$r->Nama_Kas),false); 
			$data=$this->report_model->lap_sub_cash($r->ID);
			$a->SetFont('Arial','',10);
				foreach($data as $row){
					$a->Row(array(sepasi(5).$row->Nama_SubKas,'100.000.000,00'),false);	
				}
			$a->SetFont('Arial','B',10);
			$a->Row(array(sepasi(15).'Total '. ucwords($r->Nama_Kas)),false); 
		  }
		  
		  $a->Output('application/logs/'.$this->session->userdata('userid').'_cash_flow.pdf','F');

//show pdf output in frame
$path='application/views/_laporan';
$img=" <img src='".base_url()."asset/images/back.png' onclick='js:window.history.back();' style='cursor:pointer' title='click for select other filter data'>";
link_js('auto_sugest.js,lap_beli.js,jquery.fixedheader.js','asset/js,'.$path.'/js,asset/js');
panel_begin('Print Preview','','Back'.$img);
?>
		  <iframe src="<?=base_url();?>application/logs/<?=$this->session->userdata('userid');?>_cash_flow.pdf" height="100%" width="100%" frameborder="0" allowtransparency="1"></iframe>
<?
panel_end();

?>