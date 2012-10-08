// JavaScript Document
$(document).ready(function(e) {
	var path=$('#path').val();
		_generate_nomor('GI','#frm1 input#NoUrut');
		_generate_nomor('D','#no_trankas');
	//}
	rdOnly('#NoUrut,#Tanggal',true);
	tglNow('#Tanggal')
	// Pengaturan tab panel yang aktif
	var prs=$('#prs').val();
	$('table#panel tr td.flt').hide()
    $('#returnjual').removeClass('tab_button');
	$('#returnjual').addClass('tab_select');
	
	//get nama pelanggan
	$('#Nama')
		.coolautosuggest({
				url		:path+'member/get_anggota?limit=15&str=',
				width	:350,
				showDescription	:true,
				onSelected		:function(result){
					//tombol bayar kredit aktif
					unlock('#kredit')
					$('#ID_Pelanggan').val(result.ID);
				}
		})
	//get daftar barang
	$('#Nama_Barang')
		.coolautosuggest({
			url			:path+'inventory/data_material?fld=Nama_Barang&limit=8&str=',
			width		:350,
			showDescription:true,
			onSelected	:function(result){
				$('#ID_Barang').val(result.id_barang)
				$('#ID_Satuan').val(result.nm_satuan)
				//dapatkan harga waktu beli ** lihat di struk pembelian
				$('#jumlah')
					.val('1')
					.focus().select()	
						$.post(path+'stock/get_bacth',{
							'id_barang':result.id_barang},
							function(res){
							var bt=$.parseJSON(res)
							$('#batch').val(bt.batch);
							})
			}
		})
	$('#harga_beli')
		.keyup(function(){
			kekata(this);
		})
		.focusout(function(){
			kekata_hide();
		})
		.keypress(function(e){
			if(e.which==13){
				kekata_hide();
				$(':button').focus()
			}
		})
		$(':reset').click(function(){
			_generate_nomor('GI','#NoUrut');
			_generate_nomor('D','#no_trankas');
		})
		$('#saved-retur').click(function(){
			_simpan_return();
			_simpan_detail();
		})
})
	//membuat nomor transaksi otomatis berdasarkan jenis transaksi
	function _generate_nomor(tipe,field){
		$.post('nomor_transaksi',{'tipe':tipe},
		function(result){
			$(field).val(result);
			$('#trans_new').val('add');
			tglNow('#Tanggal')
		})
	}
	//membuat nomor faktur otomatis khusus untuk penjualan
	function _generate_faktur(field){
		$.post('nomor_faktur',{'tipe':'rnd'},
		function(result){
			$(field).val(result);
		})
	}
	//simpan return
	
	function _simpan_return(){
		$.post('set_header_trans',{
			'no_trans'	:$('#NoUrut').val(),
			'tanggal'	:$('#Tanggal').val(),
			'faktur'	:'',
			'member'	:$('#ID_Pelanggan').val(),
			'cbayar'	:'5',
			'total'		:(0-parseInt($('#harga_beli').val()))
		},function(result){
			
		})
	}
	function _simpan_detail(id){
		$.post('set_detail_trans',{
			'no_trans'		:$('#NoUrut').val(),
			'tanggal'		:$('#Tanggal').val(),
			'cbayar'		:'5',			
			'nm_barang' 	:$('#Nama_Barang').val(),
			'nm_satuan' 	:$('#ID_Satuan').val(),
			'jml_trans' 	:(0-parseInt($('#Jumlah').val())),
			'harga_jual'	:(0-parseInt($('#harga_beli').val())),
			'ket_trans'		:'Return dari'+$('#Nama').val(),
			'expired'		:'',
			'no_id'			:'1',
			'batch'			:$('#batch').val()
		},function(result){
			
			
			$.post('return_stock',{
			'no_transaksi'	:$('#NoUrut').val(),
			'tanggal'		:$('#Tanggal').val()
			},function(data){
				transaksi_kas();
			})
		})
	}
	function transaksi_kas(){
		var path=$('#path').val();
				$.post(path+'master/simpan_kas_keluar',{
					'tgl_transaksi'	:$('#Tanggal').val(),
					'no_transaksi'	:$('#no_trankas').val(),
					'ket_transaksi'	:'Pembayaran Return '+$('#Jumlah').val()+' '+$('#ID_Satuan').val()+' '+$('#Nama_Barang').val(),
					'harga_beli'	:$('#harga_beli').val(),
					'akun_transaksi':'KAS TOKO',
					'jtran'			:$('#trans_new').val(),
					'tipe'			:$('#trans_new').val(),
					'tanggal'		:$('#Tanggal').val()
				},function(result){
				$(':reset').click();

				})
	}
	
	
	
	
