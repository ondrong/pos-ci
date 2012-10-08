<?php
		  $a=new reportProduct();
		  $zn=new zetro_manager();
		  $nfile='asset/bin/zetro_beli.frm';
		  //$a->Header();
		  $a->setKriteria("transkip");
		  $a->setNama("LAPORAN PENJUALAN MATERIAL");
		  $a->setSection("lapjuallist");
		  $a->setFilter(array($tanggal,$jenisobat,$nm_vendor));
		  $a->setReferer(array('Tanggal','Kategori','Nama Pelanggan'));
		  $a->setFilename('asset/bin/zetro_beli.frm');
		  $a->AliasNbPages();
		  $a->AddPage("L","A4");
		  $a->SetFont('Arial','',10);
		  // set lebar tiap kolom tabel transaksi
		  // set align tiap kolom tabel transaksi
		  $a->SetWidths(array(10,22,65,18,25,25,28,40,45));
		  $a->SetAligns(array("C","C","L","C","R","R","R","L","L"));
		  $a->SetFont('Arial','',9);
		  //$rec = $temp_rec->result();
		  $n=0;$harga=0;$hgb=0;$hargaj=0;
		  foreach($temp_rec->result_object() as $r)
		  {
			 $hgb=rdb('inv_barang','Harga_Beli','Harga_Beli',"where ID='".$r->ID_Barang."'");
			 $jenis=($r->ID_Jenis!='5')?rdb('inv_penjualan_jenis','Jenis_Jual','Jenis_Jual',"where ID='".$r->ID_Jenis."'"):'Return';
			$n++;
			$a->Row(array($n, tglfromSql($r->Tanggal),
							 rdb('inv_barang','Nama_Barang','Nama_Barang',"where ID='".$r->ID_Barang."'"),
							 rdb('inv_barang_satuan','Satuan','Satuan',"where ID='".rdb('inv_barang','ID_Satuan','ID_Satuan',"where ID='".$r->ID_Barang."'")."'"),
							 $r->Jumlah, number_format($hgb,2), 
							 number_format(($r->Harga),2), 
							 rdb('mst_anggota','Nama','Nama',"where ID='".$r->ID_Anggota."'"),
							 'Ref.:'.$r->Keterangan." - ".$jenis));
			//sub tlot
			$harga =($harga+(abs($r->Jumlah)*$r->Harga));
			$hargaj =($hargaj+($hgb));
		  }
		  $a->SetFont('Arial','B',10);
		  $a->SetFillColor(225,225,225);
		  $a->Cell(140,8,"TOTAL",1,0,'R',true);
		  $a->Cell(25,8,number_format($hargaj,2),1,0,'R',true);
		  $a->Cell(28,8,number_format($harga,2),1,0,'R',true);
		  $a->Cell(85,8,'',1,0,'R',true);
		  $a->Output('application/logs/'.$this->session->userdata('userid').'_laporan_jual.pdf','F');

//show pdf output in frame
$path='application/views/laporan';
$img=" <img src='".base_url()."asset/images/back.png' onclick='js:window.history.back();' style='cursor:pointer' title='click for select other filter data'>";
link_js('auto_sugest.js,lap_beli.js,jquery.fixedheader.js','asset/js,'.$path.'/js,asset/js');
panel_begin('Print Preview','','Back'.$img);
?>
		  <iframe src="<?=base_url();?>application/logs/<?=$this->session->userdata('userid');?>_laporan_jual.pdf" height="100%" width="100%" frameborder="0" allowtransparency="1"></iframe>
<?
panel_end();

?>