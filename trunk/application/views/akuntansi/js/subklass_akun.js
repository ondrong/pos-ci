// JavaScript Document
$(document).ready(function(e) {
    $('#subklasifikasi').removeClass('tab_button');
    $('#subklasifikasi').addClass('tab_select');
	$('table#panel tr td').click(function(){
		var id=$(this).attr('id');
				$('#'+id).removeClass('tab_button');
				$('#'+id).addClass('tab_select');
				$('table#panel tr td:not(#'+id+',.flt,.plt)').removeClass('tab_select');
				$('table#panel tr td:not(#'+id+',#kosong,.flt,.plt)').addClass('tab_button');
				$('span#v_'+id).show();
				$('span:not(#v_'+id+')').hide();
				$('#prs').val(id);
	})
	_show_data(''); //generate data klasifikasi
	
	$('#saved-subklasifikasi').click(function(){
		var ID_Klas	=$('#ID_Klasifikasi').val();
		var Kode	=$('#Kode').val();
		var Klas	=$('#SubKlasifikasi').val();
		var ID		=$('#ID_A').val();
		$.post('set_subklass_akun',{
			'ID_Klas'	:ID_Klas,
			'Kode'		:Kode,
			'SubKlas'	:Klas,
			'ID'		:ID
		},function(result){
			var wh ="where ID_Klasifikasi='"+ID_Klas+"'";
			_show_data(wh);
		})
	})
	$('#ID_Klasifikasi').change(function(){
		var wh ="where ID_Klasifikasi='"+$(this).val()+"'";
		$.post('get_subklass_akun',{'wh':wh},
			function(result){
				$('table#ListTable tbody').html(result);
				//$('#ID_Klasifikasi').val($(this).val()).select();
				$('#Kode').val('');$('#SubKlasifikasi').val('')
				$('table#ListTable').fixedHeader({width:(screen.width-150),height:(screen.height-400)})
			})
	})
});
function _get_ID(){
	$.post('get_subklas_ID',{'ID':"order by ID desc limit 1"},
		function(result){
			var rst=$.parseJSON(result)
			var newID=rst.ID;
			$('#ID_A').val(parseFloat(newID)+1);
		})
}

function _show_data(wh){
	_get_ID();
	$.post('get_subklass_akun',{'wh':wh},
		function(result){
			$('table#ListTable tbody').html(result);
			$('#ID_Klasifikasi').val('').select();
			$('#Kode').val('');$('#SubKlasifikasi').val('')
			$('table#ListTable').fixedHeader({width:(screen.width-150),height:(screen.height-400)})
		})
}

function img_onClick(id,tipe){
	switch(tipe){
		case 'edit':
			$.post('get_subklas_ID',{'ID':"where ID='"+id+"'"},
			 function(result){
				var rst=$.parseJSON(result) 
				$('#ID_A').val(rst.ID);
				$('#Kode').val(rst.Kode);
				$('#SubKlasifikasi').val(rst.SubKlasifikasi);
				$('#ID_Klasifikasi').val(rst.ID_Klasifikasi).select();
			 })
		break;
		case 'del':
		$.post('check_status_SubKlas',{'ID':id},
		function(result){
			if($.trim(result)=='dipakai'){
				alert('Data akun ini tidak bisa di hapus\nSudah dipakai untuk relasi di Data Perkiraan');
			}else if($.trim(result)=='hapus'){
				if(confirm('Yakin Data Klasifikasi ini akan dihapus???')){
					$.post('hapus_akun',{'ID':id,'sumber':'Sub_Klasifikasi'},
					function(result){
						var wh ="where ID_Klasifikasi='"+$('#ID_Klasifikasi').val()+"'";
						_show_data(wh)
					})
				}
			}
		})
		break;	
	}
}