<?php
$zfm=new zetro_frmBuilder('asset/bin/zetro_beli.frm');
$zlb=new zetro_buildlist();
$zlb->config_file('asset/bin/zetro_beli.frm');
$path='application/views/penjualan';
link_css('jquery.coolautosuggest.css','asset/css');
link_js('jquery.coolautosuggest.js','asset/js');
link_js('material_jual_return.js,jquery_terbilang.js',$path.'/js,asset/js');
panel_begin('Return Jual');
panel_multi('returjual','block');
if($c_penjualan__return_jual!=''){

		$zfm->AddBarisKosong(true);
		$zfm->Start_form(true,'frm1');
		$zfm->BuildForm('return',true,'70%');
		$zfm->BuildFormButton('Process','retur','button',2);
}else{
	no_auth();
}
panel_multi_end();
panel_end();
terbilang();
?>
<div id='kekata' style="display:none;padding:8px; background:#003; border:5px solid #F60;width:80%; height:50px; font-size:x-large;left:9%;top: 82%;color:#FFF; position:fixed; z-index:9997">
	<!--terbilang jumlah yang harus di bayar-->
</div>
<input type="hidden" id='ID_Pelanggan' value='' />
<input type="hidden" id='ID_Barang' value='' />
<input type="hidden" id='batch' value='' />
<input type="hidden" id='no_trankas' value='' />