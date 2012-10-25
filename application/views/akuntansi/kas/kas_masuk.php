<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
$zfm=new zetro_frmBuilder('asset/bin/zetro_inv.frm');
$zlb=new zetro_buildlist();
$zlb->config_file('asset/bin/zetro_inv.frm');
$path='application/views/akuntansi/kas';
calender();
link_css('jquery.coolautosuggest.css','asset/css');
link_js('jquery.coolautosuggest.js,jquery_terbilang.js','asset/js,asset/js');
link_js('jquery.fixedheader.js,kas_masuk.js','asset/js,'.$path.'/js');
panel_begin('Penerimaan Harian');
panel_multi('laporankasmasuk','block',false);
if($all_laporankasmasuk!=''){
addText(array('Periode','s/d','Jenis Pembelian','',''),
		array("<input type='text' id='dari_tgl' name='dari_tgl' value=''/>",
			  "<input type='text' id='sampai_tgl' name='sampai_tgl' value=''/>",
			  "<select id='id_jenis' name='id_jenis'></select>",
			  "<input type='button' id='okedech' value='OK'/>",
			  "<input type='checkbox' id='pajak' name='pajak' value='ok' style='display:none'>"),true,'frm1');
}else{
	no_auth();	
}
panel_multi_end();
panel_end();
terbilang();
?>

<script language="javascript">
	$(document).ready(function(e) {
        $('#id_jenis').html("<option value=''>Semua</option><? dropdown('inv_penjualan_jenis','ID','Jenis_Jual','order by id');?>");
    });

</script>