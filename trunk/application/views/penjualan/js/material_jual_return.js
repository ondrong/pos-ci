// JavaScript Document
$(document).ready(function(e) {
	$('table#frame2 tr th:nth-child(7)').hide();
	$('table#frame2 tr td:nth-child(7)').hide();
	//if($('#trans_new').val()==''){
		_generate_nomor('GI','#frm1 input#no_transaksi');
		//_generate_faktur('#frm1 input#faktur_transaksi');
	//}
	lock('#no_transaksi');
	$('input:not(:button,#no_doc,#nm_barang)').attr('disabled','disabled');
	$('#no_doc').focus().select();
	//tglNow('#tgl_transaksi');
	// Pengaturan tab panel yang aktif
	var prs=$('#prs').val();
	$('table#panel tr td.flt').hide()
    $('#returnjual').removeClass('tab_button');
	$('#returnjual').addClass('tab_select');
	
	$('#no_doc')
		.focusout(function(){
			var str=$(this).val();
			$.post('get_transaksi',{'no_transaksi':str},
				function(result){
					var datax=$.parseJSON(result);
					$('#tgl_transaksi').val(datax.tgl_transaksi);
					$('#faktur_transaksi').val(datax.faktur_transaksi);
					$('#nm_nasabah').val(datax.nm_nasabah);
					$('#nm_barang').val('');
						$('#jml_transaksi').val('');
						$('#nm_satuan').val('')
						$('#harga_beli').val('')
						$('#total_harga').val('')
				})
					
		})
		.keypress(function(e){
			if(e.which==13){
				//$(this).focusout();
				$('#nm_barang').focus().select();
			}
		})
	$('#nm_barang')
		.focus(function(){
				pos_div(this);
				auto_suggest2('get_material',$('#no_doc').val(),$(this).attr('id')+'-frm1');
		})
	$('#saved-filter').click(function(){
		image_click('','','GIR');
	})
})

	function on_clicked(id,fld,frm){
		var nt=$('#no_doc').val();
			 $.post('get_detail_transaksi',{'no_transaksi':nt,'nm_barang':id},
					function(result){
						//alert(result);
						var hsl=$.parseJSON(result);
						$('#jml_transaksi').val(hsl.jml_transaksi);
						$('#nm_satuan').val(hsl.nm_satuan)
						$('#harga_beli').val(hsl.harga_beli)
						$('#total_harga').val(hsl.ket_transaksi)
						var tgl=hsl.expired.split('-')
						$('#expired').val(tgl[2]+'/'+tgl[1]+'/'+tgl[0])
					})
	}
	//membuat nomor transaksi otomatis berdasarkan jenis transaksi
	function _generate_nomor(tipe,field){
		$.post('nomor_transaksi',{'tipe':tipe},
		function(result){
			$(field).val(result);
			$('#trans_new').val('add');
		})
	}
	//membuat nomor faktur otomatis khusus untuk penjualan
	function _generate_faktur(field){
		$.post('nomor_faktur',{'tipe':'rnd'},
		function(result){
			$(field).val(result);
		})
	}
	
	function image_click(id,cl,jtran){
	unlock('input');
			var path=$('#path').val();
			var id_trans	=$('#no_doc').val();
			var tgl_trans	=$('#tgl_transaksi').val();
			var faktur		=$('#faktur_transaksi').val();
			var vendor_name	=$('#nm_nasabah').val();
			var cara_bayar	=$('#cara_bayar').val();
			var nm_barang 	=$('#nm_barang').val();
			var nm_satuan 	=$('#nm_satuan').val();
			var jml_trans 	=$('#jml_transaksi').val();
			var harga_beli	=$('#harga_beli').val();
			var ket_trans	=$('#harga_total').val();
			var expired		=$('#expired').val();
			$.post(path+'pembelian/simpan_transaksi',
				{
				'no_transaksi'		:id_trans,
				'tgl_transaksi'		:tgl_trans,
				'faktur_transaksi'	:faktur,
				'nm_produsen'		:vendor_name,
				'cara_bayar'		:'Cash',
				'nm_barang'			:nm_barang,
				'nm_satuan'			:nm_satuan,
				'jml_transaksi'		:jml_trans,
				'harga_beli'		:harga_beli,
				'ket_transaksi'		:ket_trans,
				'expired'			:expired,
				'jtran'				:jtran
				},
				function(result){
					document.location.href=path+'penjualan/return_jual'
				})
	}