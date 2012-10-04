// JavaScript Document
/*
	file name	: member_list.js
	function	: jquery member_list.php
	location	: application/views/member
	version		: 2.0
	Author		: Zetrosoft.com
*/
$(document).ready(function(e) {
	var path=$('#path').val();
	var prs=$('#prs').val();
		$('#daftarpelanggan').removeClass('tab_button');
		$('#daftarpelanggan').addClass('tab_select');
	$('table#panel tr td:not(.flt,.plt,#kosong)').click(function(){
		var id=$(this).attr('id');
				$('#'+id).removeClass('tab_button');
				$('#'+id).addClass('tab_select');
				$('table#panel tr td:not(#'+id+',.flt,.plt)').removeClass('tab_select');
				$('table#panel tr td:not(#'+id+',#kosong,.flt,.plt)').addClass('tab_button');
				$('span#v_'+id).show();
				$('span:not(#v_'+id+')').hide();
				//$('#prs').val(id);
	})
	if($('#otor').val()==''){
		lock('#dept,#stat')
	}else{
		unlock('#dept,#stat')
	}
	unlock('#carix')
	$('#cari').css('opacity','1');
	$('span#td').html(format_number($('#totdata').val(),0));
	find_by('');
	
	//add new member
	
/*
not used in this version
	$('#dept').change(function(){
		
		ajax_start();
		$.post('filter_by',{
			'id_dept':$(this).val(),
			'ordby':$('#ordby').val().substr(1,$('#ordby').val().length),
			'stat':$('#stat').val(),'searchby':$('#carix').val()},
			function(result){
				$('#v_daftaranggota table#ListTable tbody').html('');	
				$('#v_daftaranggota table#ListTable tbody').html(result);
				$('span#td').html(format_number($('#v_daftaranggota table#ListTable tbody tr').length));
				$('#ListTable').fixedHeader({width:(screen.width-50),height:(screen.height-320)})
				ajax_stop();
				unlock('#carix');
			$('#cari').css('opacity','1');
				$('#carix').focus().select();
			})
	})
	$('#stat').change(function(){
		$('#dept').change();
	})
	$('#gon').click(function(){
		var id=$('#ordby').val().replace('undefined,','');
		$('#dept').change();
	})
*/
	$('#cari').click(function(){
		if($('#carix').val().length>0)	find_by($('#carix').val());
	})
	$('#urutan')
		.fcbkcomplete({
		cache: true,
		newel: true,
		firstselected:true,
		filter_case: false,
		filter_hide: false,
		select_all_text: "select"
		
	})
	$("#urutan").trigger("addItem",[{"title": "No Anggota", "value": "no_Agt"}]);	
	//$('#ListTable').fixedHeader({width:(screen.width-50),height:(screen.height-320)})
})
function show_member_detail(id){
	ajax_start();
	$.post('member_detail',{'no_anggota':id},
	function(result){
		$('#mm_lock').show();	
		$('#mm_detail')
			.html(result)
			.show()
		$('#mm_detail #tab tr td#datapelanggan').removeClass('tab_button');
		$('#mm_detail #tab tr td#datapelanggan').addClass('tab_select');
		ajax_stop();
	})
}

function find_by(nama){
		show_indicator('#ListTable',6);
		$.post('filter_by',{
			'id_dept'	:'',
			'ordby'		:'',
			'stat'		:'',
			'searchby'	:nama},
			function(result){
				$('#v_daftaranggota table#ListTable tbody').html('');	
				$('#v_daftaranggota table#ListTable tbody').html(result);
				$('span#td').html(format_number($('#v_daftaranggota table#ListTable tbody tr').length));
				$('#ListTable').fixedHeader({width:(screen.width-30),height:(screen.height-320)})
				//ajax_stop();
			})
}