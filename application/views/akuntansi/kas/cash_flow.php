<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
$zfm=new zetro_frmBuilder('asset/bin/zetro_inv.frm');
$zlb=new zetro_buildlist();
$zlb->config_file('asset/bin/zetro_inv.frm');
$path='application/views/akuntansi/kas';
calender();
link_css('jquery.coolautosuggest.css','asset/css');
link_js('jquery.coolautosuggest.js,jquery_terbilang.js','asset/js,asset/js');
link_js('jquery.fixedheader.js,cash_flow.js','asset/js,'.$path.'/js');
panel_begin('Cash Flow');
panel_multi('alirankas','block',false);
addText(array('Periode','s/d',''),
		array("<input type='text' id='dari_tgl' name='dari_tgl' value=''/>",
			  "<input type='text' id='dari_tgl' name='dari_tgl' value=''/>",
			  "<input type='button' id='okelah' value='OK'/>"),true,'frm1');

panel_multi_end();
panel_end();
terbilang();
