// JavaScript Document
$(document).ready(function(e) {
	var prs=$('#prs').val();
	$('table#panel tr td.flt').hide()
    $('#printfakturpenjualan').removeClass('tab_button');
	$('#printfakturpenjualan').addClass('tab_select');
	last_notran();
	$('input:text').focus().select();
	$('table#panel tr td').click(function(){
		var id=$(this).attr('id');
			if(id!=''){
				$('#'+id).removeClass('tab_button');
				$('#'+id).addClass('tab_select');
				$('table#panel tr td:not(#'+id+',.flt)').removeClass('tab_select');
				$('table#panel tr td:not(#'+id+',#kosong,.flt)').addClass('tab_button');
				$('span#v_'+id).show();
				$('span:not(#v_'+id+')').hide();
			}
	});
	$('#saved-faktur').click(function(){
		$('#frm1').attr('action','print_faktur');
		document,frm1.submit();
	})
	tglNow('#dari_tgl');
	$('#dari_tgl')
		.focus().select()
		.dynDateTime()
		.focusout(function(){
			last_notran();
		})
		
	$('#sampai_tgl')
		.focusout(function(){
			last_notran();
		})
		.dynDateTime();
	$('#id_anggota').focusout(function(){
		last_notran();
	})
})

function last_notran(){
	$.post('last_no_transaksi',{
		'dari_tgl'	:$('#dari_tgl').val(),
		'sampai_tgl':$('#sampai_tgl').val(),
		'id_anggota':$('#id_anggota').val()},
		function(result){
			$('#no_transaksi').html(result);
		})
}