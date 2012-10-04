;Master data build Form
;Inventory build form and list
;Generate auto from zetro_buildform and zetro_buildlist class

[pelanggan]
1|Nama Pelanggan,input,text n,nm_pelanggan,w70 upper,,20%
2|Alamat,input,text n,alm_pelanggan,w90 upper,,25%
3|No. Telp,input,text n,telp_pelanggan,w50,,10%
4|Hutang,input,text d,hutang_pelanggan,w35 angka,0,10%

[produsen]
1|ID Vendor,input,text n,id_produsen,w50 upper,,10%
2|Nama Vendor,input,text n,nm_produsen,w70 upper,,20%
3|Alamat,input,text n,alm_produsen,w70,,25%
4|Contact Person,input,text n,cp_produsen,w90,,25%
5|No. Telp,input,text n,telp_produsen,w50,,10%
6|Hutang,input,text d,hutang_produsen,w35 angka,0,10%

[Kas]
1|ID Kas,input,text n,id_kas,w35 upper,,10%
2|Nama Kas,input,text n,nm_kas,w70 upper,,20%
3|Saldo Awal,input,text d,sa_kas,w35 angka,0,10%
4|Saldo,input,text d,sl_kas,w35 angka,0,10%

[kasharian]
1|Tanggal,input,text t,tgl_kas,w35,,10%
2|ID Kas,input,text n,id_kas,w35 upper,,10%
3|Nama Kas,input,text n,nm_kas,w70 upper,,20%
4|Saldo Awal,input,text d,sa_kas,w35 angka,0,10%

[kaskeluar]
1|ID Trans,input,text n,no_transaksi,w50,,10%
2|Tanggal,input,text t,tgl_transaksi,w35,,10%
3|ID Kas,input,text n,akun_transaksi,w50 upper,,10%
4|Uraian,textarea,text n,ket_transaksi,t90,,25%
5|Jumlah pengeluaran,input,text d,harga_beli,w35 angka,,10%

[lapkas]
1|Tanggal,input,text t,tgl_transaksi,w35,,10%,,,22
2|Uraian,,,uraian,,,,,,78
3|Kredit,,,kredit,,,,,,30
4|Debit,,,debit,,,,,,30

[formfaktur]
1|ID. Transaksi,input,text n,no_transaksi,w70 upper,,10%


[faktur]
1|Nama Barang,,,nm_barang,,,,,,75
2|Qty,,,jml_transaksi,,,,,,30
3|Unit,,,nm_satuan,,,,,,12
4|Harga,,,harga_beli,,,,,,30
5|Jumlah,,,harga_beli,,,,,,30

[neraca]
1|Head,,,Header2,,,30%
2|Jenis,,,Jenis1,,,60%

[shu]
1|Jenis,,,,,,60%
2|Kalkulasi,,,,,,20%

[subneraca]
1|Sub Jenis,,,,,,40%
2|Kalkulasi,,,,,,10%
3|KBR,,,,,,10%
4|USP,,,,,,10%

