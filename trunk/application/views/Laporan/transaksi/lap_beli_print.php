<?php
		  $a=new reportProduct();
		  $zn=new zetro_manager();
		  $nfile='asset/bin/zetro_beli.frm';
		  //$a->Header();
		  $a->setKriteria("transkip");
		  $a->setNama("LAPORAN PEMBELIAN BARANG");
		  $a->setSection("rptbeli");
		  $a->setFilter(array($tanggal,$jenisobat,$nm_vendor));
		  $a->setReferer(array('Sampai Dengan','Kategori Barang','Nama Vendor'));
		  $a->setFilename('asset/bin/zetro_beli.frm');
		  $a->AliasNbPages();
		  $a->AddPage("L","A4");
	
		  $a->SetFont('Arial','',10);
		  // set lebar tiap kolom tabel transaksi
		  // set align tiap kolom tabel transaksi
		  $a->SetWidths(array(10,25,70,18,25,30,30,70));
		  $a->SetAligns(array("C","C","L","C","R","R","R","L"));
		  $a->SetFont('Arial','B',10);
		  $a->SetFont('Arial','',9);
		  //$rec = $temp_rec->result();
		  $n=0;$harga=0;$hgb=0;$hargaj=0;$jml=0;
		  foreach($temp_rec->result_object() as $r)
		  {
			 $hgb=rdb('inv_barang','Harga_Beli','Harga_Beli',"where ID='".$r->ID_Barang."'");
			$n++;
			$a->Row(array($n, tglfromSql($r->Tanggal),
							 rdb('inv_barang','Nama_Barang','Nama_Barang',"where ID='".$r->ID_Barang."'"),
							 rdb('inv_barang_satuan','Satuan','Satuan',"where ID='".rdb('inv_barang','ID_Satuan','ID_Satuan',"where ID='".$r->ID_Barang."'")."'"),
							 number_format($r->Jml_Faktur,2), number_format($r->Harga_Beli,2), 
							 number_format(($r->Jumlah),2), 
							 rdb('inv_pemasok','Pemasok','Pemasok',"where ID='".$r->ID_Pemasok."'").' :: '.
							 "Ref.:".$r->NoUrut." - ". rdb('inv_penjualan_jenis','Jenis_Jual','Jenis_Jual',"where ID='".$r->ID_Jenis."'")));
			//sub tlot
			$jml=($jml+$r->Jml_Faktur);
			$harga =($harga+($r->Jumlah));
			$hargaj =($hargaj+($r->Harga_Beli));
		  }
		  $a->SetFont('Arial','B',10);
		  $a->SetFillColor(225,225,225);
		  $a->Cell(123,8,"TOTAL",1,0,'R',true);
		  $a->Cell(25,8,number_format($jml,2),1,0,'R',true);
		  $a->Cell(30,8,number_format($hargaj,2),1,0,'R',true);
		  $a->Cell(30,8,number_format($harga,2),1,0,'R',true);
		  $a->Cell(70,8,'',1,0,'R',true);
		  $a->Output('application/logs/'.$this->session->userdata('userid').'_rekap_simpanan.pdf','F');

//show pdf output in frame
$path='application/views/laporan';
$img=" <img src='".base_url()."asset/images/back.png' onclick='js:window.history.back();' style='cursor:pointer' title='click for select other filter data'>";
link_js('auto_sugest.js,lap_beli.js,jquery.fixedheader.js','asset/js,'.$path.'/js,asset/js');
panel_begin('Print Preview','','Back'.$img);
?>
		  <iframe src="<?=base_url();?>application/logs/<?=$this->session->userdata('userid');?>_rekap_simpanan.pdf" height="100%" width="100%" frameborder="0" allowtransparency="1"></iframe>
<?
panel_end();

?>