<?php
$zfm=new zetro_frmBuilder('asset/bin/zetro_beli.frm');
$zlb=new zetro_buildlist();
$zlb->config_file('asset/bin/zetro_beli.frm');
$path='application/views/pembelian';
$printer="<img src='".base_url()."asset/images/print.png' id='printsheet' title='Print count sheet'>";
link_css('autosuggest.css','asset/css');
link_js('material_income_return.js,auto_sugest.js,jquery_terbilang.js,jquery.sumfield.js',$path.'/js,asset/js,asset/js,asset/js');
panel_begin('Return Beli');
panel_multi('returjual','block');
if($c_pembelian__return_beli!=''){
	echo "<table id='frame' width='99%'>
		 <tr valign='top'><td width='45%'>";
		$zfm->AddBarisKosong(false);
		$zfm->Start_form(true,'frm1');
		$zfm->BuildForm('return',true,'70%');
		$zfm->BuildFormButton('Process','filter','button',2);
}else{
	no_auth();
}
panel_multi_end();
panel_end();
auto_sugest();
tab_select('prs');
terbilang();
?>
<div id='kekata' style="display:none;padding:8px; background:#003; border:5px solid #F60;width:80%; height:50px; font-size:x-large;left:9%;top: 82%;color:#FFF; position:fixed; z-index:9997">
	<!--terbilang jumlah yang harus di bayar-->
</div>
<input type="hidden" id='jmlbayar' value='' />
<input type="hidden" id='nama' value='' />
<input type="hidden" id='trans_new' value='' />