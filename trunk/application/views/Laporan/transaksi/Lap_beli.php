<?php
$zfm=new zetro_frmBuilder('asset/bin/zetro_beli.frm');
$zlb=new zetro_buildlist();
$zlb->config_file('asset/bin/zetro_beli.frm');
$path='application/views/laporan/transaksi';
calender();
link_css('jquery.coolautosuggest.css','asset/css');
link_js('jquery.coolautosuggest.js','asset/js');
link_js('auto_sugest.js,lap_beli.js,jquery.fixedheader.js','asset/js,'.$path.'/js,asset/js');
panel_begin('Laporan Pembelian');
panel_multi('laporanpembelian','block',false);
if($all_laporanpembelian!=''){
$fld="<input type='hidden' id='jtran' name='jtran' value=''>";
$fld.="<input type='hidden' id='section' name='section' value='lapbelilist'>";
$fld.="<input type='hidden' id='lap' name='lap' value='beli'>";
$fld.="<input type='hidden' id='optional' name='optional' value=''>";
$fld.="<input type='hidden' id='ID_Pemasok' name='ID_Pemasok' value=''>";
	$zfm->Addinput($fld);
	$zfm->AddBarisKosong(true);
	$zfm->Start_form(true,'frm1');
	$zfm->BuildForm('lapbeli',true,'60%');
	$zfm->BuildFormButton('Process','filter','button',2);
	echo "<hr>";
		$zlb->section('lapbelilist');
		$zlb->aksi(false);
		$zlb->Header('100%');
	echo "</tbody></table>";
}else{
	no_auth();
}
panel_multi_end();
auto_sugest();
panel_end();
?>
<script language="javascript">
$(document).ready(function(e) {
    $('#printsheet').click(function(){
		$('#frm1').attr('action','print_laporan_beli');
		document.frm1.submit();
		//document.location.href='http://localhost/apotek/index.php/report/countsheet';
	})
});
</script>