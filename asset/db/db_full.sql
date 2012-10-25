-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.5.25a - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL version:             7.0.0.4140
-- Date/time:                    2012-10-25 17:11:38
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;

-- Dumping database structure for setujudb
DROP DATABASE IF EXISTS `setujudb`;
CREATE DATABASE IF NOT EXISTS `setujudb` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `setujudb`;


-- Dumping structure for table setujudb.bayar_transaksi
DROP TABLE IF EXISTS `bayar_transaksi`;
CREATE TABLE IF NOT EXISTS `bayar_transaksi` (
  `no_transaksi` varchar(50) NOT NULL DEFAULT '',
  `total_belanja` double DEFAULT '0',
  `ppn` double DEFAULT '0',
  `total_bayar` double DEFAULT '0',
  `dibayar` double DEFAULT '0',
  `kembalian` double DEFAULT '0',
  `created_by` varchar(125) DEFAULT NULL,
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `terbilang` text,
  PRIMARY KEY (`no_transaksi`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='table data pembayaran pejualan';

-- Dumping data for table setujudb.bayar_transaksi: 0 rows
/*!40000 ALTER TABLE `bayar_transaksi` DISABLE KEYS */;
/*!40000 ALTER TABLE `bayar_transaksi` ENABLE KEYS */;


-- Dumping structure for table setujudb.buku_besar
DROP TABLE IF EXISTS `buku_besar`;
CREATE TABLE IF NOT EXISTS `buku_besar` (
  `ID` int(11) DEFAULT NULL,
  `Tanggal` datetime DEFAULT NULL,
  `NoJurnal` varchar(10) DEFAULT NULL,
  `Keterangan` varchar(50) DEFAULT NULL,
  `Debet` double DEFAULT NULL,
  `Kredit` double DEFAULT NULL,
  `Saldo` double DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.buku_besar: 0 rows
/*!40000 ALTER TABLE `buku_besar` DISABLE KEYS */;
/*!40000 ALTER TABLE `buku_besar` ENABLE KEYS */;


-- Dumping structure for table setujudb.cost_center
DROP TABLE IF EXISTS `cost_center`;
CREATE TABLE IF NOT EXISTS `cost_center` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `nama_cc` varchar(150) NOT NULL DEFAULT '',
  PRIMARY KEY (`nama_cc`),
  KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.cost_center: ~7 rows (approximately)
/*!40000 ALTER TABLE `cost_center` DISABLE KEYS */;
REPLACE INTO `cost_center` (`ID`, `nama_cc`) VALUES
	(1, 'Penjualan Tunai'),
	(2, 'Penjualan Kredit'),
	(3, 'Return Penjualan'),
	(4, 'Pembelian Tunai'),
	(5, 'Pembelian Kredit'),
	(6, 'Pembayaran Hutang'),
	(7, 'Pembayaran Piutang');
/*!40000 ALTER TABLE `cost_center` ENABLE KEYS */;


-- Dumping structure for table setujudb.detail_transaksi
DROP TABLE IF EXISTS `detail_transaksi`;
CREATE TABLE IF NOT EXISTS `detail_transaksi` (
  `id_transaksi` int(11) NOT NULL AUTO_INCREMENT,
  `no_transaksi` varchar(50) DEFAULT NULL,
  `tgl_transaksi` date DEFAULT NULL,
  `faktur_transaksi` varchar(100) DEFAULT NULL,
  `jenis_transaksi` varchar(50) DEFAULT NULL,
  `akun_transaksi` varchar(100) DEFAULT NULL,
  `cara_bayar` varchar(50) DEFAULT NULL,
  `nm_produsen` varchar(225) DEFAULT NULL,
  `nm_barang` varchar(225) DEFAULT NULL,
  `nm_satuan` varchar(225) DEFAULT NULL,
  `jml_transaksi` double(10,2) DEFAULT '0.00',
  `expired` date DEFAULT NULL,
  `harga_beli` double DEFAULT '0',
  `ket_transaksi` text,
  `created_by` varchar(50) DEFAULT NULL,
  `doc_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_transaksi`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='table transaksi keluar masuk obat';

-- Dumping data for table setujudb.detail_transaksi: 0 rows
/*!40000 ALTER TABLE `detail_transaksi` DISABLE KEYS */;
/*!40000 ALTER TABLE `detail_transaksi` ENABLE KEYS */;


-- Dumping structure for table setujudb.inv_barang
DROP TABLE IF EXISTS `inv_barang`;
CREATE TABLE IF NOT EXISTS `inv_barang` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Kode` varchar(15) DEFAULT NULL,
  `ID_Kategori` int(11) DEFAULT NULL,
  `ID_Jenis` tinyint(4) DEFAULT NULL,
  `ID_Pemasok` int(11) DEFAULT NULL,
  `Nama_Barang` varchar(30) NOT NULL DEFAULT '',
  `Harga_Beli` float DEFAULT NULL,
  `Harga_Jual` float DEFAULT NULL,
  `ID_Satuan` int(11) DEFAULT NULL,
  `Status` varchar(11) DEFAULT NULL,
  `minstok` double DEFAULT '0',
  PRIMARY KEY (`Nama_Barang`),
  KEY `ID` (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.inv_barang: 7 rows
/*!40000 ALTER TABLE `inv_barang` DISABLE KEYS */;
REPLACE INTO `inv_barang` (`ID`, `Kode`, `ID_Kategori`, `ID_Jenis`, `ID_Pemasok`, `Nama_Barang`, `Harga_Beli`, `Harga_Jual`, `ID_Satuan`, `Status`, `minstok`) VALUES
	(11, 'BB3MM', 8, 2, NULL, 'BESI PLAT 3MM', 22500, 30000, 2, 'Continue', 10),
	(16, 'AA100', 10, 6, NULL, 'ANKUR BETON', 15000, 20000, 8, 'Continue', 5),
	(17, 'BBT10MM', 8, 1, NULL, 'BESI BETON 10 MM', 35000, 40000, 4, 'Continue', 5),
	(6, 'BBT6M', 8, 1, NULL, 'BESI BETON 6MM', 30000, 35000, 4, 'Continue', 10),
	(15, 'BBT3M', 8, 1, NULL, 'BESI BETON 3MM', 25000, 30000, 4, 'Continue', 15),
	(13, 'BBP1.5MM', 8, 2, NULL, 'BESI PLAT 1.5 MM', 150000, 200000, 2, 'Continue', 12),
	(14, 'BBT8M', 8, 1, NULL, 'BESI BETON 8MM', 50000, 150000, 4, 'Continue', 10);
/*!40000 ALTER TABLE `inv_barang` ENABLE KEYS */;


-- Dumping structure for table setujudb.inv_barang_jenis
DROP TABLE IF EXISTS `inv_barang_jenis`;
CREATE TABLE IF NOT EXISTS `inv_barang_jenis` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `JenisBarang` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`JenisBarang`),
  KEY `ID` (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.inv_barang_jenis: 5 rows
/*!40000 ALTER TABLE `inv_barang_jenis` DISABLE KEYS */;
REPLACE INTO `inv_barang_jenis` (`ID`, `JenisBarang`) VALUES
	(1, 'BESI BETON'),
	(2, 'PLAT'),
	(5, 'BESI ULIR'),
	(6, 'ANGKUR'),
	(7, 'TALANG');
/*!40000 ALTER TABLE `inv_barang_jenis` ENABLE KEYS */;


-- Dumping structure for table setujudb.inv_barang_kategori
DROP TABLE IF EXISTS `inv_barang_kategori`;
CREATE TABLE IF NOT EXISTS `inv_barang_kategori` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Kategori` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`Kategori`),
  KEY `ID` (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.inv_barang_kategori: 6 rows
/*!40000 ALTER TABLE `inv_barang_kategori` DISABLE KEYS */;
REPLACE INTO `inv_barang_kategori` (`ID`, `Kategori`) VALUES
	(9, 'KAYU'),
	(8, 'BESI'),
	(7, 'BAJA'),
	(10, 'AKSESORIS'),
	(13, 'BAUT'),
	(14, 'PLASTIK');
/*!40000 ALTER TABLE `inv_barang_kategori` ENABLE KEYS */;


-- Dumping structure for table setujudb.inv_barang_satuan
DROP TABLE IF EXISTS `inv_barang_satuan`;
CREATE TABLE IF NOT EXISTS `inv_barang_satuan` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Satuan` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`Satuan`),
  KEY `ID` (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.inv_barang_satuan: 18 rows
/*!40000 ALTER TABLE `inv_barang_satuan` DISABLE KEYS */;
REPLACE INTO `inv_barang_satuan` (`ID`, `Satuan`) VALUES
	(2, 'LEMBAR'),
	(3, 'KG'),
	(4, 'BATANG'),
	(8, 'PCS'),
	(6, 'METER'),
	(7, 'DUS'),
	(13, 'BOX'),
	(10, 'LITER'),
	(11, 'KALENG'),
	(12, 'DRUM'),
	(14, 'IKAT'),
	(15, 'SAK'),
	(16, 'COLT'),
	(17, 'TRUK'),
	(23, 'KUBIK'),
	(24, 'ROLL'),
	(25, 'BUAH'),
	(26, 'SLOP');
/*!40000 ALTER TABLE `inv_barang_satuan` ENABLE KEYS */;


-- Dumping structure for table setujudb.inv_blacklist
DROP TABLE IF EXISTS `inv_blacklist`;
CREATE TABLE IF NOT EXISTS `inv_blacklist` (
  `ID` int(11) DEFAULT NULL,
  `ID_Agt` int(11) NOT NULL DEFAULT '0',
  `Keterangan` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID_Agt`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.inv_blacklist: 0 rows
/*!40000 ALTER TABLE `inv_blacklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_blacklist` ENABLE KEYS */;


-- Dumping structure for table setujudb.inv_golongan
DROP TABLE IF EXISTS `inv_golongan`;
CREATE TABLE IF NOT EXISTS `inv_golongan` (
  `nm_golongan` varchar(225) NOT NULL DEFAULT '',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`nm_golongan`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='tabel golongan obat';

-- Dumping data for table setujudb.inv_golongan: 0 rows
/*!40000 ALTER TABLE `inv_golongan` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_golongan` ENABLE KEYS */;


-- Dumping structure for table setujudb.inv_konversi
DROP TABLE IF EXISTS `inv_konversi`;
CREATE TABLE IF NOT EXISTS `inv_konversi` (
  `id_barang` varchar(50) NOT NULL DEFAULT '',
  `nm_barang` varchar(225) NOT NULL DEFAULT '',
  `nm_satuan` varchar(50) DEFAULT NULL,
  `sat_beli` varchar(50) NOT NULL DEFAULT '',
  `isi_konversi` double DEFAULT '0',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`sat_beli`,`id_barang`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.inv_konversi: 8 rows
/*!40000 ALTER TABLE `inv_konversi` DISABLE KEYS */;
REPLACE INTO `inv_konversi` (`id_barang`, `nm_barang`, `nm_satuan`, `sat_beli`, `isi_konversi`, `doc_date`, `created_by`) VALUES
	('16', 'ANKUR BETON', '8', '3', 0.25, '2012-10-17 13:40:14', NULL),
	('11', 'BESI PLAT 3MM', '2', '2', 1, '2012-10-06 13:50:35', NULL),
	('14', 'BESI BETON 8MM', '4', '4', 1, '2012-10-06 13:53:07', NULL),
	('16', 'ANKUR BETON', '8', '8', 1, '2012-10-17 13:38:24', NULL),
	('17', 'BESI BETON 10 MM', '4', '4', 1, '2012-10-24 14:48:45', NULL),
	('6', 'BESI BETON 6MM', '4', '4', 1, '2012-10-06 11:48:10', NULL),
	('15', 'BESI BETON 3MM', '4', '4', 1, '2012-10-08 23:06:54', NULL),
	('13', 'BESI PLAT 1.5 MM', '2', '2', 1, '2012-10-06 13:52:48', NULL);
/*!40000 ALTER TABLE `inv_konversi` ENABLE KEYS */;


-- Dumping structure for table setujudb.inv_material_count
DROP TABLE IF EXISTS `inv_material_count`;
CREATE TABLE IF NOT EXISTS `inv_material_count` (
  `nm_barang` varchar(125) NOT NULL DEFAULT '',
  `nm_satuan` varchar(50) DEFAULT NULL,
  `count1` double DEFAULT '0',
  `count2` double DEFAULT '0',
  `datecount` date DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`nm_barang`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.inv_material_count: 0 rows
/*!40000 ALTER TABLE `inv_material_count` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_material_count` ENABLE KEYS */;


-- Dumping structure for table setujudb.inv_material_stok
DROP TABLE IF EXISTS `inv_material_stok`;
CREATE TABLE IF NOT EXISTS `inv_material_stok` (
  `id_barang` int(50) NOT NULL DEFAULT '0',
  `nm_barang` varchar(125) NOT NULL DEFAULT '',
  `batch` varchar(125) NOT NULL DEFAULT '',
  `expired` date DEFAULT NULL,
  `stock` double DEFAULT '0',
  `blokstok` double DEFAULT '0',
  `nm_satuan` varchar(50) DEFAULT NULL,
  `harga_beli` int(10) unsigned DEFAULT '0',
  `created_by` varchar(50) DEFAULT NULL,
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`batch`,`id_barang`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='data stock material';

-- Dumping data for table setujudb.inv_material_stok: 3 rows
/*!40000 ALTER TABLE `inv_material_stok` DISABLE KEYS */;
REPLACE INTO `inv_material_stok` (`id_barang`, `nm_barang`, `batch`, `expired`, `stock`, `blokstok`, `nm_satuan`, `harga_beli`, `created_by`, `doc_date`) VALUES
	(4, 'BESI BETON 10MM', '12297-8', NULL, 50, 0, '4', 35000, 'superuser', '2012-10-24 14:39:58'),
	(15, 'BESI BETON 3MM', '12297-2', NULL, 20, 0, '4', 25000, NULL, '2012-10-25 15:27:12'),
	(14, 'BESI BETON 8MM', '12297-8', NULL, 29, 0, '4', 35000, NULL, '2012-10-25 15:27:12');
/*!40000 ALTER TABLE `inv_material_stok` ENABLE KEYS */;


-- Dumping structure for table setujudb.inv_pemasok
DROP TABLE IF EXISTS `inv_pemasok`;
CREATE TABLE IF NOT EXISTS `inv_pemasok` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Pemasok` varchar(30) DEFAULT NULL,
  `Alamat` varchar(50) DEFAULT NULL,
  `Kota` varchar(20) DEFAULT NULL,
  `Propinsi` varchar(20) DEFAULT NULL,
  `Telepon` varchar(30) DEFAULT NULL,
  `Faksimili` varchar(15) DEFAULT NULL,
  `Status` varchar(9) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.inv_pemasok: 0 rows
/*!40000 ALTER TABLE `inv_pemasok` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_pemasok` ENABLE KEYS */;


-- Dumping structure for table setujudb.inv_pembayaran
DROP TABLE IF EXISTS `inv_pembayaran`;
CREATE TABLE IF NOT EXISTS `inv_pembayaran` (
  `no_transaksi` varchar(50) NOT NULL DEFAULT '0',
  `total_belanja` double DEFAULT '0',
  `ppn` double DEFAULT '0',
  `total_bayar` double DEFAULT '0',
  `jml_dibayar` double DEFAULT '0',
  `kembalian` double DEFAULT '0',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(100) DEFAULT NULL,
  `ID_Jenis` int(10) DEFAULT NULL,
  PRIMARY KEY (`no_transaksi`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.inv_pembayaran: 14 rows
/*!40000 ALTER TABLE `inv_pembayaran` DISABLE KEYS */;
REPLACE INTO `inv_pembayaran` (`no_transaksi`, `total_belanja`, `ppn`, `total_bayar`, `jml_dibayar`, `kembalian`, `doc_date`, `created_by`, `ID_Jenis`) VALUES
	('4000000017', 900000, 0, 900000, 900000, 0, '2012-10-24 23:16:34', 'superuser', 1),
	('4000000016', 1320000, 0, 1320000, 1320000, 0, '2012-10-24 23:16:32', 'superuser', 2),
	('4000000000', 150000, 0, 150000, 150000, 0, '2012-10-24 23:15:20', 'superuser', 1),
	('4000000001', 900000, 0, 900000, 900000, 0, '2012-10-24 23:15:23', 'superuser', 2),
	('4000000003', 150000, 0, 150000, 150000, 0, '2012-10-24 23:15:31', 'superuser', 2),
	('4000000004', 600000, 0, 600000, 600000, 0, '2012-10-24 23:15:55', 'superuser', 3),
	('4000000005', 30000, 0, 30000, 5000, 25000, '2012-10-24 23:15:59', 'superuser', 4),
	('4000000009', 30000, 0, 30000, 0, 0, '2012-10-24 23:16:36', 'superuser', 5),
	('4000000010', 150000, 0, 150000, 0, 0, '2012-10-24 23:16:37', 'superuser', 5),
	('4000000011', 150000, 0, 150000, 0, 0, '2012-10-24 23:16:39', 'superuser', 5),
	('4000000013', 30000, 0, 30000, 0, 0, '2012-10-24 23:16:40', 'superuser', 5),
	('4000000014', 120000, 0, 120000, 0, 0, '2012-10-24 23:16:42', 'superuser', 5),
	('4000000015', 30000, 0, 30000, 30000, 0, '2012-10-24 23:16:31', 'superuser', 1),
	('4000000018', 40000, 0, 40000, 50000, 10000, '2012-10-25 11:13:55', 'superuser', 1),
	('4000000019', 600000, 0, 600000, 600000, 0, '2012-10-25 14:09:30', 'superuser', 1),
	('4000000020', 150000, 0, 150000, 150000, 0, '2012-10-25 14:15:58', 'superuser', 1),
	('4000000021', 30000, 0, 30000, 30000, 0, '2012-10-25 14:22:33', 'superuser', 1),
	('4000000022', 30000, 0, 30000, 30000, 0, '2012-10-25 14:24:35', 'superuser', 1),
	('4000000023', 30000, 0, 30000, 30000, 0, '2012-10-25 14:25:35', 'superuser', 2),
	('4000000024', 150000, 0, 150000, 150000, 0, '2012-10-25 14:26:21', 'superuser', 3),
	('4000000025', 30000, 0, 30000, 0, 30000, '2012-10-25 14:26:57', 'superuser', 4),
	('4000000026', 120000, 0, 120000, 0, 0, '2012-10-25 14:27:25', 'superuser', 5),
	('4000000027', 1800000, 0, 1800000, 1800000, 0, '2012-10-25 15:27:12', 'superuser', 2);
/*!40000 ALTER TABLE `inv_pembayaran` ENABLE KEYS */;


-- Dumping structure for table setujudb.inv_pembelian
DROP TABLE IF EXISTS `inv_pembelian`;
CREATE TABLE IF NOT EXISTS `inv_pembelian` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Jenis` tinyint(4) DEFAULT NULL,
  `Tanggal` date DEFAULT NULL,
  `Bulan` tinyint(4) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `ID_Pemasok` int(11) DEFAULT NULL,
  `NoUrut` varchar(50) DEFAULT NULL,
  `Nomor` varchar(15) DEFAULT NULL,
  `Deskripsi` varchar(30) DEFAULT NULL,
  `ID_Bayar` int(11) DEFAULT NULL,
  `ID_Post` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.inv_pembelian: 2 rows
/*!40000 ALTER TABLE `inv_pembelian` DISABLE KEYS */;
REPLACE INTO `inv_pembelian` (`ID`, `ID_Jenis`, `Tanggal`, `Bulan`, `Tahun`, `ID_Pemasok`, `NoUrut`, `Nomor`, `Deskripsi`, `ID_Bayar`, `ID_Post`) VALUES
	(1, 1, '2012-10-24', 10, 2012, 4, '5000000000', 'BT-0000-12', 'BAJA BESI. PT', 1750000, NULL),
	(2, 1, '2012-10-24', 10, 2012, 4, '5000000001', '3344565', 'BAJA BESI. PT', 3525000, NULL);
/*!40000 ALTER TABLE `inv_pembelian` ENABLE KEYS */;


-- Dumping structure for table setujudb.inv_pembelian_detail
DROP TABLE IF EXISTS `inv_pembelian_detail`;
CREATE TABLE IF NOT EXISTS `inv_pembelian_detail` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Tanggal` date DEFAULT NULL,
  `Bulan` tinyint(4) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `ID_Beli` int(11) DEFAULT NULL,
  `ID_Barang` int(11) DEFAULT NULL,
  `Jml_Faktur` smallint(6) DEFAULT NULL,
  `Jumlah` int(11) DEFAULT NULL,
  `Harga_Beli` float DEFAULT NULL,
  `Keterangan` varchar(50) DEFAULT NULL,
  `ID_Satuan` int(11) DEFAULT NULL,
  `Batch` varchar(50) DEFAULT NULL,
  KEY `ID` (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.inv_pembelian_detail: 3 rows
/*!40000 ALTER TABLE `inv_pembelian_detail` DISABLE KEYS */;
REPLACE INTO `inv_pembelian_detail` (`ID`, `Tanggal`, `Bulan`, `Tahun`, `ID_Beli`, `ID_Barang`, `Jml_Faktur`, `Jumlah`, `Harga_Beli`, `Keterangan`, `ID_Satuan`, `Batch`) VALUES
	(4, '2012-10-24', 10, 2012, 2, 15, 50, 50, 25000, '1250000', 4, '12297-2'),
	(5, '2012-10-24', 10, 2012, 2, 14, 65, 65, 35000, '2275000', 4, '12297-8'),
	(3, '2012-10-24', 10, 2012, 1, 4, 50, 50, 35000, '1750000', 4, '12297-8');
/*!40000 ALTER TABLE `inv_pembelian_detail` ENABLE KEYS */;


-- Dumping structure for table setujudb.inv_pembelian_jenis
DROP TABLE IF EXISTS `inv_pembelian_jenis`;
CREATE TABLE IF NOT EXISTS `inv_pembelian_jenis` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Jenis_Beli` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`Jenis_Beli`),
  KEY `ID` (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.inv_pembelian_jenis: 3 rows
/*!40000 ALTER TABLE `inv_pembelian_jenis` DISABLE KEYS */;
REPLACE INTO `inv_pembelian_jenis` (`ID`, `Jenis_Beli`) VALUES
	(1, 'Tunai'),
	(2, 'Giro'),
	(3, 'Cheque');
/*!40000 ALTER TABLE `inv_pembelian_jenis` ENABLE KEYS */;


-- Dumping structure for table setujudb.inv_pembelian_rekap
DROP TABLE IF EXISTS `inv_pembelian_rekap`;
CREATE TABLE IF NOT EXISTS `inv_pembelian_rekap` (
  `ID` int(11) DEFAULT NULL,
  `Tanggal` datetime DEFAULT NULL,
  `Bulan` tinyint(4) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `ID_Beli` int(11) DEFAULT NULL,
  `ID_Barang` int(11) DEFAULT NULL,
  `Jml_Faktur` smallint(6) DEFAULT NULL,
  `Jumlah` int(11) DEFAULT NULL,
  `Harga_Beli` float DEFAULT NULL,
  `Keterangan` varchar(50) DEFAULT NULL,
  `ID_Satuan` int(11) DEFAULT NULL,
  `batch` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Dumping data for table setujudb.inv_pembelian_rekap: 11 rows
/*!40000 ALTER TABLE `inv_pembelian_rekap` DISABLE KEYS */;
REPLACE INTO `inv_pembelian_rekap` (`ID`, `Tanggal`, `Bulan`, `Tahun`, `ID_Beli`, `ID_Barang`, `Jml_Faktur`, `Jumlah`, `Harga_Beli`, `Keterangan`, `ID_Satuan`, `batch`) VALUES
	(3, '2012-10-19 00:00:00', 10, 2012, 2, 4, 100, 100, 35000, '3500000', 4, '12290-5'),
	(4, '2012-10-19 00:00:00', 10, 2012, 3, 11, 10, 10, 545000, '5450000', 2, '12293-6'),
	(5, '2012-10-19 00:00:00', 10, 2012, 3, 13, 5, 5, 350000, '1750000', 2, '12293-2'),
	(6, '2012-10-19 00:00:00', 10, 2012, 3, 4, 100, 100, 32500, '3250000', 4, '12293-7'),
	(7, '2012-10-19 00:00:00', 10, 2012, 3, 6, 50, 50, 30000, '1500000', 4, '12293-4'),
	(8, '2012-10-19 00:00:00', 10, 2012, 3, 15, 100, 100, 20000, '2000000', 4, '12293-8'),
	(9, '2012-09-22 00:00:00', 9, 2012, 4, 14, 50, 50, 33250, '1662500', 4, '12295-5'),
	(10, '2011-10-22 00:00:00', 10, 2011, 5, 15, 10, 10, 30000, '300000', 4, '12295-9'),
	(4, '2012-10-24 00:00:00', 10, 2012, 2, 15, 50, 50, 25000, '1250000', 4, '12297-2'),
	(5, '2012-10-24 00:00:00', 10, 2012, 2, 14, 65, 65, 35000, '2275000', 4, '12297-8'),
	(3, '2012-10-24 00:00:00', 10, 2012, 1, 4, 50, 50, 35000, '1750000', 4, '12297-8');
/*!40000 ALTER TABLE `inv_pembelian_rekap` ENABLE KEYS */;


-- Dumping structure for table setujudb.inv_pembelian_status
DROP TABLE IF EXISTS `inv_pembelian_status`;
CREATE TABLE IF NOT EXISTS `inv_pembelian_status` (
  `ID` int(11) DEFAULT NULL,
  `Status` varchar(12) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.inv_pembelian_status: 0 rows
/*!40000 ALTER TABLE `inv_pembelian_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_pembelian_status` ENABLE KEYS */;


-- Dumping structure for table setujudb.inv_penjualan
DROP TABLE IF EXISTS `inv_penjualan`;
CREATE TABLE IF NOT EXISTS `inv_penjualan` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Jenis` tinyint(4) DEFAULT NULL,
  `Tanggal` date DEFAULT NULL,
  `Bulan` tinyint(4) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `NoUrut` varchar(50) NOT NULL DEFAULT '',
  `Nomor` varchar(50) DEFAULT NULL,
  `ID_Anggota` int(11) DEFAULT '0',
  `Deskripsi` varchar(30) DEFAULT NULL,
  `Cicilan` tinyint(4) DEFAULT NULL,
  `Total` double DEFAULT NULL,
  `Tgl_Cicilan` date DEFAULT NULL,
  `ID_Post` varchar(100) DEFAULT NULL,
  `ID_Close` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.inv_penjualan: 19 rows
/*!40000 ALTER TABLE `inv_penjualan` DISABLE KEYS */;
REPLACE INTO `inv_penjualan` (`ID`, `ID_Jenis`, `Tanggal`, `Bulan`, `Tahun`, `NoUrut`, `Nomor`, `ID_Anggota`, `Deskripsi`, `Cicilan`, `Total`, `Tgl_Cicilan`, `ID_Post`, `ID_Close`) VALUES
	(1, 1, '2012-10-24', 10, 2012, '4000000000', '00000-2012', 2, '', 0, 150000, '0000-00-00', '0', NULL),
	(2, 2, '2012-10-24', 10, 2012, '4000000001', '00001-2012', 3, 'BANK BCA', 1, 900000, '2012-10-26', '334455', NULL),
	(3, 5, '2012-10-24', 10, 2012, '4000000002', 'RK-00002-2012', 3, '', 1, 750000, '0000-00-00', '0', NULL),
	(4, 2, '2012-10-24', 10, 2012, '4000000003', '00003-2012', 2, 'BANK BTN', 1, 150000, '2012-10-24', '333', NULL),
	(5, 3, '2012-10-24', 10, 2012, '4000000004', '00004-2012', 1, 'BANK BTN', 1, 600000, '2012-10-25', '223344', NULL),
	(6, 4, '2012-10-24', 10, 2012, '4000000005', '00005-2012', 3, '', 1, 30000, '2012-10-26', '0', NULL),
	(7, 5, '2012-10-24', 10, 2012, '4000000006', 'RK-00006-2012', 0, '', 1, 150000, '0000-00-00', '0', NULL),
	(8, 5, '2012-10-24', 10, 2012, '4000000007', 'RK-00007-2012', 0, '', 1, 750000, '0000-00-00', '0', NULL),
	(9, 5, '2012-10-24', 10, 2012, '4000000008', 'RK-00008-2012', 0, '', 1, 30000, '0000-00-00', '0', NULL),
	(10, 5, '2012-10-24', 10, 2012, '4000000009', 'RK-00009-2012', 0, '', 1, 30000, '0000-00-00', '0', NULL),
	(11, 5, '2012-10-24', 10, 2012, '4000000010', 'RK-00010-2012', 0, '', 1, 150000, '0000-00-00', '0', NULL),
	(12, 5, '2012-10-24', 10, 2012, '4000000011', 'RK-00011-2012', 0, '', 1, 150000, '0000-00-00', '0', NULL),
	(13, 5, '2012-10-24', 10, 2012, '4000000012', 'RK-00012-2012', 0, '', 1, 60000, '0000-00-00', '0', NULL),
	(14, 5, '2012-10-24', 10, 2012, '4000000013', 'RK-00013-2012', 0, '', 1, 30000, '0000-00-00', '0', NULL),
	(15, 5, '2012-10-24', 10, 2012, '4000000014', 'RK-00014-2012', 0, '', 1, 120000, '0000-00-00', '0', NULL),
	(16, 1, '2012-10-24', 10, 2012, '4000000015', '00015-2012', 0, '', 0, 30000, '0000-00-00', '0', NULL),
	(17, 2, '2012-10-24', 10, 2012, '4000000016', '00016-2012', 2, 'BANK BTN', 1, 1320000, '2012-10-31', '33456', NULL),
	(18, 1, '2012-10-24', 10, 2012, '4000000017', '00017-2012', 0, '', 0, 900000, '0000-00-00', '0', NULL),
	(19, 1, '2012-10-25', 10, 2012, '4000000018', '00018-2012', 3, '', 0, 40000, '0000-00-00', '0', NULL),
	(20, 1, '2012-10-25', 10, 2012, '4000000019', '00019-2012', 3, '', 0, 600000, '0000-00-00', '0', NULL),
	(21, 1, '2012-10-25', 10, 2012, '4000000020', '00020-2012', 3, '', 0, 150000, '0000-00-00', '0', NULL),
	(22, 1, '2012-10-25', 10, 2012, '4000000021', '00021-2012', 3, '', 0, 30000, '0000-00-00', '0', NULL),
	(23, 1, '2012-10-25', 10, 2012, '4000000022', '00022-2012', 0, '', 0, 30000, '0000-00-00', '0', NULL),
	(24, 2, '2012-10-25', 10, 2012, '4000000023', '00023-2012', 2, 'BANK BCA', 1, 30000, '2012-10-25', '334455', NULL),
	(25, 3, '2012-10-25', 10, 2012, '4000000024', '00024-2012', 1, 'BANK BCA', 1, 150000, '2012-10-31', '445566', NULL),
	(26, 4, '2012-10-25', 10, 2012, '4000000025', '00025-2012', 3, '', 1, 30000, '2012-10-31', '0', NULL),
	(27, 5, '2012-10-25', 10, 2012, '4000000026', 'RK-00026-2012', 2, '', 1, 120000, '0000-00-00', '0', NULL),
	(28, 2, '2012-10-25', 10, 2012, '4000000027', '00027-2012', 1, 'BANK BCA', 1, 1800000, '2012-10-30', '345678', NULL);
/*!40000 ALTER TABLE `inv_penjualan` ENABLE KEYS */;


-- Dumping structure for table setujudb.inv_penjualan_bayar
DROP TABLE IF EXISTS `inv_penjualan_bayar`;
CREATE TABLE IF NOT EXISTS `inv_penjualan_bayar` (
  `ID` int(11) DEFAULT NULL,
  `ID_Jual` int(11) DEFAULT NULL,
  `ID_Master` tinyint(4) DEFAULT NULL,
  `Tanggal` varchar(50) DEFAULT NULL,
  `Bayar` float DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.inv_penjualan_bayar: 0 rows
/*!40000 ALTER TABLE `inv_penjualan_bayar` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_penjualan_bayar` ENABLE KEYS */;


-- Dumping structure for table setujudb.inv_penjualan_detail
DROP TABLE IF EXISTS `inv_penjualan_detail`;
CREATE TABLE IF NOT EXISTS `inv_penjualan_detail` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Jenis` tinyint(4) DEFAULT NULL,
  `Tanggal` date DEFAULT NULL,
  `Bulan` tinyint(4) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `ID_Jual` int(11) DEFAULT NULL,
  `ID_Barang` int(11) DEFAULT NULL,
  `Jumlah` smallint(6) DEFAULT NULL,
  `Harga` float DEFAULT NULL,
  `ID_Post` varchar(50) DEFAULT NULL,
  `Keterangan` varchar(50) DEFAULT NULL,
  `ID_Satuan` varchar(50) DEFAULT NULL,
  `Batch` varchar(50) DEFAULT NULL,
  KEY `ID` (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.inv_penjualan_detail: 19 rows
/*!40000 ALTER TABLE `inv_penjualan_detail` DISABLE KEYS */;
REPLACE INTO `inv_penjualan_detail` (`ID`, `ID_Jenis`, `Tanggal`, `Bulan`, `Tahun`, `ID_Jual`, `ID_Barang`, `Jumlah`, `Harga`, `ID_Post`, `Keterangan`, `ID_Satuan`, `Batch`) VALUES
	(1, 1, '2012-10-24', 1, NULL, 1, 15, 5, 30000, '0', '4000000000', '4', '12297-2'),
	(2, 2, '2012-10-24', 1, NULL, 2, 15, 5, 30000, '0', '4000000001', '4', '12297-2'),
	(3, 2, '2012-10-24', 2, NULL, 2, 14, 5, 150000, '0', '4000000001', '4', '12297-8'),
	(4, 2, '2012-10-24', 1, NULL, 4, 14, 1, 150000, '0', '4000000003', '4', '12297-8'),
	(5, 3, '2012-10-24', 1, NULL, 5, 14, 4, 150000, '0', '4000000004', '4', '12297-8'),
	(6, 4, '2012-10-24', 1, NULL, 6, 15, 1, 30000, '0', '4000000005', '4', '12297-2'),
	(7, 5, '2012-10-24', 2, NULL, 10, 15, 1, 30000, '', '4000000009', '4', '12297-2'),
	(8, 5, '2012-10-24', 1, NULL, 10, 15, 1, 30000, NULL, '4000000009', '4', '12297-2'),
	(9, 5, '2012-10-24', 2, NULL, 11, 14, 1, 150000, '', '4000000010', '4', '12297-8'),
	(10, 5, '2012-10-24', 2, NULL, 12, 14, 1, 150000, '', '4000000011', '4', '12297-8'),
	(11, 5, '2012-10-24', 2, NULL, 13, 15, 2, 30000, '', '4000000012', '4', '12297-2'),
	(12, 5, '2012-10-24', 2, NULL, 14, 15, 1, 30000, '', '4000000013', '4', '12297-2'),
	(13, 5, '2012-10-24', 2, NULL, 15, 15, 4, 30000, '', '4000000014', '4', '12297-2'),
	(14, 1, '2012-10-24', 1, NULL, 16, 15, 1, 30000, '0', '4000000015', '4', '12297-2'),
	(15, 2, '2012-10-24', 1, NULL, 17, 15, 9, 30000, '0', '4000000016', '4', '12297-2'),
	(16, 2, '2012-10-24', 2, NULL, 17, 14, 7, 150000, '0', '4000000016', '4', '12297-8'),
	(17, 1, '2012-10-24', 1, NULL, 18, 15, 5, 30000, '0', '4000000017', '4', '12297-2'),
	(18, 1, '2012-10-24', 2, NULL, 18, 14, 5, 150000, '0', '4000000017', '4', '12297-8'),
	(19, 1, '2012-10-25', 1, NULL, 19, 14, 1, 40000, '0', '4000000018', '4', '12297-8'),
	(20, 1, '2012-10-25', 1, NULL, 20, 14, 4, 150000, '0', '4000000019', '4', '12297-8'),
	(21, 1, '2012-10-25', 1, NULL, 21, 15, 5, 30000, '0', '4000000020', '4', '12297-2'),
	(22, 1, '2012-10-25', 1, NULL, 22, 15, 1, 30000, '0', '4000000021', '4', '12297-2'),
	(23, 1, '2012-10-25', 1, NULL, 23, 15, 1, 30000, '0', '4000000022', '4', '12297-2'),
	(24, 2, '2012-10-25', 1, NULL, 24, 15, 1, 30000, '0', '4000000023', '4', '12297-2'),
	(25, 3, '2012-10-25', 1, NULL, 25, 14, 1, 150000, '0', '4000000024', '4', '12297-8'),
	(26, 4, '2012-10-25', 1, NULL, 26, 15, 1, 30000, '0', '4000000025', '4', '12297-2'),
	(27, 5, '2012-10-25', 2, NULL, 27, 15, 4, 30000, '', '4000000026', '4', '12297-2'),
	(28, 2, '2012-10-25', 1, NULL, 28, 15, 1, 30000, '0', '4000000027', '4', '12297-2'),
	(29, 2, '2012-10-25', 2, NULL, 28, 14, 1, 150000, '0', '4000000027', '4', '12297-8'),
	(30, 2, '2012-10-25', 3, NULL, 28, 14, 1, 150000, '0', '4000000027', '4', '12297-8'),
	(31, 2, '2012-10-25', 4, NULL, 28, 15, 1, 30000, '0', '4000000027', '4', '12297-2'),
	(32, 2, '2012-10-25', 5, NULL, 28, 14, 1, 150000, '0', '4000000027', '4', '12297-8'),
	(33, 2, '2012-10-25', 6, NULL, 28, 15, 1, 30000, '0', '4000000027', '4', '12297-2'),
	(34, 2, '2012-10-25', 7, NULL, 28, 14, 1, 150000, '0', '4000000027', '4', '12297-8'),
	(35, 2, '2012-10-25', 8, NULL, 28, 15, 1, 30000, '0', '4000000027', '4', '12297-2'),
	(36, 2, '2012-10-25', 9, NULL, 28, 14, 1, 150000, '0', '4000000027', '4', '12297-8'),
	(37, 2, '2012-10-25', 10, NULL, 28, 15, 1, 30000, '0', '4000000027', '4', '12297-2'),
	(38, 2, '2012-10-25', 11, NULL, 28, 14, 1, 150000, '0', '4000000027', '4', '12297-8'),
	(39, 2, '2012-10-25', 12, NULL, 28, 15, 1, 30000, '0', '4000000027', '4', '12297-2'),
	(40, 2, '2012-10-25', 13, NULL, 28, 14, 1, 150000, '0', '4000000027', '4', '12297-8'),
	(41, 2, '2012-10-25', 14, NULL, 28, 15, 1, 30000, '0', '4000000027', '4', '12297-2'),
	(42, 2, '2012-10-25', 15, NULL, 28, 14, 1, 150000, '0', '4000000027', '4', '12297-8'),
	(43, 2, '2012-10-25', 16, NULL, 28, 15, 1, 30000, '0', '4000000027', '4', '12297-2'),
	(44, 2, '2012-10-25', 17, NULL, 28, 14, 1, 150000, '0', '4000000027', '4', '12297-8'),
	(45, 2, '2012-10-25', 18, NULL, 28, 15, 1, 30000, '0', '4000000027', '4', '12297-2'),
	(46, 2, '2012-10-25', 19, NULL, 28, 14, 1, 150000, '0', '4000000027', '4', '12297-8'),
	(47, 2, '2012-10-25', 20, NULL, 28, 15, 1, 30000, '0', '4000000027', '4', '12297-2');
/*!40000 ALTER TABLE `inv_penjualan_detail` ENABLE KEYS */;


-- Dumping structure for table setujudb.inv_penjualan_jenis
DROP TABLE IF EXISTS `inv_penjualan_jenis`;
CREATE TABLE IF NOT EXISTS `inv_penjualan_jenis` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Jenis_Jual` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.inv_penjualan_jenis: 5 rows
/*!40000 ALTER TABLE `inv_penjualan_jenis` DISABLE KEYS */;
REPLACE INTO `inv_penjualan_jenis` (`ID`, `Jenis_Jual`) VALUES
	(1, 'Tunai'),
	(2, 'Giro'),
	(3, 'Cheque'),
	(4, 'Kredit'),
	(5, 'Return');
/*!40000 ALTER TABLE `inv_penjualan_jenis` ENABLE KEYS */;


-- Dumping structure for table setujudb.inv_penjualan_rekap
DROP TABLE IF EXISTS `inv_penjualan_rekap`;
CREATE TABLE IF NOT EXISTS `inv_penjualan_rekap` (
  `ID` int(11) DEFAULT NULL,
  `ID_Jenis` tinyint(4) DEFAULT NULL,
  `Tanggal` datetime DEFAULT NULL,
  `Bulan` tinyint(4) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `ID_Jual` int(11) DEFAULT NULL,
  `ID_Barang` int(11) DEFAULT NULL,
  `Jumlah` smallint(6) DEFAULT NULL,
  `Harga` double DEFAULT NULL,
  `ID_Post` tinyint(4) DEFAULT NULL,
  `Keterangan` varchar(50) DEFAULT NULL,
  `no_transaksi` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Dumping data for table setujudb.inv_penjualan_rekap: 48 rows
/*!40000 ALTER TABLE `inv_penjualan_rekap` DISABLE KEYS */;
REPLACE INTO `inv_penjualan_rekap` (`ID`, `ID_Jenis`, `Tanggal`, `Bulan`, `Tahun`, `ID_Jual`, `ID_Barang`, `Jumlah`, `Harga`, `ID_Post`, `Keterangan`, `no_transaksi`) VALUES
	(4, 2, '2012-10-17 00:00:00', 10, 2012, 7, 4, 1, 35000, NULL, '0', '4000000018'),
	(5, 3, '2012-10-17 00:00:00', 10, 2012, 8, 4, 4, 35000, NULL, '1', '4000000019'),
	(6, 4, '2012-10-17 00:00:00', 10, 2012, 8, 15, 1, 30000, NULL, '1', '4000000019'),
	(7, 5, '2012-10-17 00:00:00', 10, 2012, 9, 4, 1, 35000, NULL, '0', '4000000020'),
	(5, 3, '2012-10-24 00:00:00', 10, 2012, 5, 14, 4, 150000, NULL, '0', '4000000004'),
	(11, 5, '2012-10-20 00:00:00', 10, 2012, 37, 4, 2, 35000, NULL, '0', '4000000044'),
	(10, 5, '2012-10-17 00:00:00', 10, 2012, 10, 4, 1, 35000, NULL, '1', '4000000021'),
	(11, 5, '2012-10-18 00:00:00', 10, 2012, 11, 4, 2, 35000, NULL, '0', '4000000022'),
	(12, 5, '2012-10-18 00:00:00', 10, 2012, 13, 4, 1, 35000, NULL, '0', '4000000024'),
	(4, 2, '2012-10-24 00:00:00', 10, 2012, 4, 14, 1, 150000, NULL, '1', '4000000003'),
	(3, 2, '2012-10-24 00:00:00', 10, 2012, 2, 14, 5, 150000, NULL, '1', '4000000001'),
	(2, 2, '2012-10-24 00:00:00', 10, 2012, 2, 15, 5, 30000, NULL, '1', '4000000001'),
	(1, 1, '2012-10-24 00:00:00', 10, 2012, 1, 15, 5, 30000, NULL, '0', '4000000000'),
	(27, 5, '2012-10-23 00:00:00', 10, 2012, 50, 13, 4, 200000, NULL, '1', '4000000051'),
	(26, 4, '2012-10-22 00:00:00', 10, 2012, 49, 6, 1, 35000, NULL, '0', '4000000050'),
	(25, 3, '2012-10-19 00:00:00', 10, 2012, 26, 13, 1, 200000, NULL, '0', '4000000036'),
	(26, 4, '2012-10-19 00:00:00', 10, 2012, 26, 6, 1, 35000, NULL, '0', '4000000036'),
	(30, 2, '2012-10-19 00:00:00', 10, 2012, 29, 4, 1, 35000, NULL, '0', '4000000038'),
	(29, 2, '2012-10-19 00:00:00', 10, 2012, 29, 4, 1, 35000, NULL, '0', '4000000038'),
	(31, 2, '2012-10-19 00:00:00', 10, 2012, 29, 15, 1, 30000, NULL, '0', '4000000038'),
	(1, 1, '2012-10-20 00:00:00', 10, 2012, 34, 4, 5, 35000, NULL, '0', '4000000042'),
	(46, 2, '2012-10-20 00:00:00', 10, 2012, 34, 13, 1, 200000, NULL, '0', '4000000042'),
	(45, 2, '2012-10-20 00:00:00', 10, 2012, 34, 6, 1, 35000, NULL, '0', '4000000042'),
	(44, 2, '2012-10-20 00:00:00', 10, 2012, 34, 4, 1, 35000, NULL, '0', '4000000042'),
	(43, 2, '2012-10-20 00:00:00', 10, 2012, 34, 4, 1, 35000, NULL, '0', '4000000042'),
	(2, 2, '2012-10-20 00:00:00', 10, 2012, 34, 6, 5, 35000, NULL, '0', '4000000042'),
	(3, 2, '2012-10-20 00:00:00', 10, 2012, 34, 13, 5, 200000, NULL, '0', '4000000042'),
	(4, 2, '2012-10-20 00:00:00', 10, 2012, 35, 4, 1, 35000, NULL, '1', '4000000043'),
	(5, 3, '2012-10-20 00:00:00', 10, 2012, 35, 4, 4, 35000, NULL, '1', '4000000043'),
	(6, 4, '2012-10-20 00:00:00', 10, 2012, 35, 6, 1, 35000, NULL, '1', '4000000043'),
	(7, 5, '2012-10-20 00:00:00', 10, 2012, 35, 13, 1, 200000, NULL, '1', '4000000043'),
	(12, 5, '2012-10-20 00:00:00', 10, 2012, 38, 4, 1, 35000, NULL, '0', '4000000045'),
	(10, 5, '2012-10-20 00:00:00', 10, 2012, 37, 4, 1, 35000, NULL, '0', '4000000044'),
	(25, 3, '2012-10-20 00:00:00', 10, 2012, 48, 4, 1, 35000, NULL, '1', '4000000049'),
	(6, 4, '2012-10-24 00:00:00', 10, 2012, 6, 15, 1, 30000, NULL, '4', '4000000005'),
	(7, 5, '2012-10-24 00:00:00', 10, 2012, 10, 15, 1, 30000, NULL, '0', '4000000009'),
	(8, 5, '2012-10-24 00:00:00', 10, 2012, 10, 15, 1, 30000, NULL, '0', '4000000009'),
	(9, 5, '2012-10-24 00:00:00', 10, 2012, 11, 14, 1, 150000, NULL, '0', '4000000010'),
	(10, 5, '2012-10-24 00:00:00', 10, 2012, 12, 14, 1, 150000, NULL, '0', '4000000011'),
	(11, 5, '2012-10-24 00:00:00', 10, 2012, 13, 15, 2, 30000, NULL, '0', '4000000012'),
	(12, 5, '2012-10-24 00:00:00', 10, 2012, 14, 15, 1, 30000, NULL, '0', '4000000013'),
	(13, 5, '2012-10-24 00:00:00', 10, 2012, 15, 15, 4, 30000, NULL, '0', '4000000014'),
	(14, 1, '2012-10-24 00:00:00', 10, 2012, 16, 15, 1, 30000, NULL, '1', '4000000015'),
	(15, 2, '2012-10-24 00:00:00', 10, 2012, 17, 15, 9, 30000, NULL, '0', '4000000016'),
	(16, 2, '2012-10-24 00:00:00', 10, 2012, 17, 14, 7, 150000, NULL, '0', '4000000016'),
	(17, 1, '2012-10-24 00:00:00', 10, 2012, 18, 15, 5, 30000, NULL, '1', '4000000017'),
	(18, 1, '2012-10-24 00:00:00', 10, 2012, 18, 14, 5, 150000, NULL, '1', '4000000017'),
	(19, 1, '2012-10-25 00:00:00', 10, 2012, 19, 14, 1, 40000, NULL, '0', '4000000018'),
	(20, 1, '2012-10-25 00:00:00', 10, 2012, 20, 14, 4, 150000, NULL, '1', '4000000019'),
	(21, 1, '2012-10-25 00:00:00', 10, 2012, 21, 15, 5, 30000, NULL, '0', '4000000020'),
	(22, 1, '2012-10-25 00:00:00', 10, 2012, 22, 15, 1, 30000, NULL, '1', '4000000021'),
	(23, 1, '2012-10-25 00:00:00', 10, 2012, 23, 15, 1, 30000, NULL, '0', '4000000022'),
	(24, 2, '2012-10-25 00:00:00', 10, 2012, 24, 15, 1, 30000, NULL, '2', '4000000023'),
	(25, 3, '2012-10-25 00:00:00', 10, 2012, 25, 14, 1, 150000, NULL, '0', '4000000024'),
	(26, 4, '2012-10-25 00:00:00', 10, 2012, 26, 15, 1, 30000, NULL, '1', '4000000025'),
	(27, 5, '2012-10-25 00:00:00', 10, 2012, 27, 15, 4, 30000, NULL, '0', '4000000026'),
	(28, 2, '2012-10-25 00:00:00', 10, 2012, 28, 15, 1, 30000, NULL, '1', '4000000027'),
	(29, 2, '2012-10-25 00:00:00', 10, 2012, 28, 14, 1, 150000, NULL, '1', '4000000027'),
	(30, 2, '2012-10-25 00:00:00', 10, 2012, 28, 14, 1, 150000, NULL, '1', '4000000027'),
	(31, 2, '2012-10-25 00:00:00', 10, 2012, 28, 15, 1, 30000, NULL, '1', '4000000027'),
	(32, 2, '2012-10-25 00:00:00', 10, 2012, 28, 14, 1, 150000, NULL, '1', '4000000027'),
	(33, 2, '2012-10-25 00:00:00', 10, 2012, 28, 15, 1, 30000, NULL, '1', '4000000027'),
	(34, 2, '2012-10-25 00:00:00', 10, 2012, 28, 14, 1, 150000, NULL, '1', '4000000027'),
	(35, 2, '2012-10-25 00:00:00', 10, 2012, 28, 15, 1, 30000, NULL, '1', '4000000027'),
	(36, 2, '2012-10-25 00:00:00', 10, 2012, 28, 14, 1, 150000, NULL, '1', '4000000027'),
	(37, 2, '2012-10-25 00:00:00', 10, 2012, 28, 15, 1, 30000, NULL, '1', '4000000027'),
	(38, 2, '2012-10-25 00:00:00', 10, 2012, 28, 14, 1, 150000, NULL, '1', '4000000027'),
	(39, 2, '2012-10-25 00:00:00', 10, 2012, 28, 15, 1, 30000, NULL, '1', '4000000027'),
	(40, 2, '2012-10-25 00:00:00', 10, 2012, 28, 14, 1, 150000, NULL, '1', '4000000027'),
	(41, 2, '2012-10-25 00:00:00', 10, 2012, 28, 15, 1, 30000, NULL, '1', '4000000027'),
	(42, 2, '2012-10-25 00:00:00', 10, 2012, 28, 14, 1, 150000, NULL, '1', '4000000027'),
	(43, 2, '2012-10-25 00:00:00', 10, 2012, 28, 15, 1, 30000, NULL, '1', '4000000027'),
	(44, 2, '2012-10-25 00:00:00', 10, 2012, 28, 14, 1, 150000, NULL, '1', '4000000027'),
	(45, 2, '2012-10-25 00:00:00', 10, 2012, 28, 15, 1, 30000, NULL, '1', '4000000027'),
	(46, 2, '2012-10-25 00:00:00', 10, 2012, 28, 14, 1, 150000, NULL, '1', '4000000027'),
	(47, 2, '2012-10-25 00:00:00', 10, 2012, 28, 15, 1, 30000, NULL, '2', '4000000027');
/*!40000 ALTER TABLE `inv_penjualan_rekap` ENABLE KEYS */;


-- Dumping structure for table setujudb.inv_penjualan_status
DROP TABLE IF EXISTS `inv_penjualan_status`;
CREATE TABLE IF NOT EXISTS `inv_penjualan_status` (
  `ID` int(11) DEFAULT NULL,
  `Status_Jual` varchar(6) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.inv_penjualan_status: 0 rows
/*!40000 ALTER TABLE `inv_penjualan_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_penjualan_status` ENABLE KEYS */;


-- Dumping structure for table setujudb.inv_posting_date
DROP TABLE IF EXISTS `inv_posting_date`;
CREATE TABLE IF NOT EXISTS `inv_posting_date` (
  `ID` int(11) DEFAULT NULL,
  `PostingDate` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.inv_posting_date: 0 rows
/*!40000 ALTER TABLE `inv_posting_date` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_posting_date` ENABLE KEYS */;


-- Dumping structure for table setujudb.inv_posting_status
DROP TABLE IF EXISTS `inv_posting_status`;
CREATE TABLE IF NOT EXISTS `inv_posting_status` (
  `ID` int(11) DEFAULT NULL,
  `PostStatus` varchar(8) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.inv_posting_status: 0 rows
/*!40000 ALTER TABLE `inv_posting_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_posting_status` ENABLE KEYS */;


-- Dumping structure for table setujudb.inv_tagihan
DROP TABLE IF EXISTS `inv_tagihan`;
CREATE TABLE IF NOT EXISTS `inv_tagihan` (
  `ID` int(11) DEFAULT NULL,
  `ID_Jual` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.inv_tagihan: 0 rows
/*!40000 ALTER TABLE `inv_tagihan` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_tagihan` ENABLE KEYS */;


-- Dumping structure for table setujudb.jenis_simpanan
DROP TABLE IF EXISTS `jenis_simpanan`;
CREATE TABLE IF NOT EXISTS `jenis_simpanan` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Jenis` varchar(12) NOT NULL DEFAULT '',
  `ID_Klasifikasi` int(11) DEFAULT NULL,
  `ID_SubKlas` int(11) DEFAULT NULL,
  `ID_Laporan` int(11) DEFAULT NULL,
  `ID_LapDetail` int(11) DEFAULT NULL,
  `ID_Calc` int(11) DEFAULT NULL,
  `ID_Unit` int(11) DEFAULT NULL,
  PRIMARY KEY (`Jenis`),
  KEY `ID` (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.jenis_simpanan: 7 rows
/*!40000 ALTER TABLE `jenis_simpanan` DISABLE KEYS */;
REPLACE INTO `jenis_simpanan` (`ID`, `Jenis`, `ID_Klasifikasi`, `ID_SubKlas`, `ID_Laporan`, `ID_LapDetail`, `ID_Calc`, `ID_Unit`) VALUES
	(1, 'Tunai', 4, 17, 2, 30, 2, 1),
	(2, 'Giro', 4, 18, 2, 31, 2, 1),
	(3, 'Cheque', 4, 19, 2, 32, 2, 1),
	(4, 'Kredit', 4, 4, 2, 10, 2, 1),
	(5, 'Return', 4, 28, 2, 9, 1, 1),
	(6, 'Persediaan', 1, 5, 1, 1, 1, 1),
	(7, 'Operasional', 6, 24, 1, 1, 1, 1);
/*!40000 ALTER TABLE `jenis_simpanan` ENABLE KEYS */;


-- Dumping structure for table setujudb.jurnal
DROP TABLE IF EXISTS `jurnal`;
CREATE TABLE IF NOT EXISTS `jurnal` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Unit` int(11) DEFAULT NULL,
  `ID_Tipe` int(11) DEFAULT NULL,
  `ID_Dept` int(11) DEFAULT NULL,
  `Tanggal` date DEFAULT NULL,
  `ID_Bulan` smallint(6) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `NoUrut` int(11) DEFAULT NULL,
  `Nomor` varchar(10) DEFAULT NULL,
  `Keterangan` varchar(60) DEFAULT NULL,
  `ID_Mark` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.jurnal: 0 rows
/*!40000 ALTER TABLE `jurnal` DISABLE KEYS */;
/*!40000 ALTER TABLE `jurnal` ENABLE KEYS */;


-- Dumping structure for table setujudb.kas
DROP TABLE IF EXISTS `kas`;
CREATE TABLE IF NOT EXISTS `kas` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `Kode` varchar(50) DEFAULT NULL,
  `Nama_Kas` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.kas: ~5 rows (approximately)
/*!40000 ALTER TABLE `kas` DISABLE KEYS */;
REPLACE INTO `kas` (`ID`, `Kode`, `Nama_Kas`) VALUES
	(1, 'A', 'Penerimaan Kas'),
	(2, 'B', 'Pengeluaran Kas'),
	(3, 'C', 'Saldo Kas [ A - B ]'),
	(4, 'D', 'Kas Awal'),
	(5, 'E', 'Total Kas Di Tangan');
/*!40000 ALTER TABLE `kas` ENABLE KEYS */;


-- Dumping structure for table setujudb.kas_sub
DROP TABLE IF EXISTS `kas_sub`;
CREATE TABLE IF NOT EXISTS `kas_sub` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `ID_KAS` int(10) DEFAULT NULL,
  `Nama_SubKas` varchar(150) DEFAULT NULL,
  `ID_Calc` int(10) DEFAULT '0',
  `ID_CC` int(10) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.kas_sub: ~6 rows (approximately)
/*!40000 ALTER TABLE `kas_sub` DISABLE KEYS */;
REPLACE INTO `kas_sub` (`ID`, `ID_KAS`, `Nama_SubKas`, `ID_Calc`, `ID_CC`) VALUES
	(1, 1, 'Transaksi Penjualan', 1, 1),
	(2, 1, 'Pembayaran Piutang', 1, 7),
	(3, 2, 'Transaksi Pembelian', 2, 4),
	(4, 2, 'Pembayaran Hutang', 2, 6),
	(5, 2, 'Biaya Operasional', 2, 5),
	(6, 4, 'Saldo Awal', 0, 0);
/*!40000 ALTER TABLE `kas_sub` ENABLE KEYS */;


-- Dumping structure for table setujudb.keaktifan
DROP TABLE IF EXISTS `keaktifan`;
CREATE TABLE IF NOT EXISTS `keaktifan` (
  `ID` int(11) DEFAULT NULL,
  `Keaktifan` varchar(10) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.keaktifan: 3 rows
/*!40000 ALTER TABLE `keaktifan` DISABLE KEYS */;
REPLACE INTO `keaktifan` (`ID`, `Keaktifan`) VALUES
	(1, 'Aktif'),
	(2, 'Non Aktif'),
	(3, 'Keluar');
/*!40000 ALTER TABLE `keaktifan` ENABLE KEYS */;


-- Dumping structure for table setujudb.klasifikasi
DROP TABLE IF EXISTS `klasifikasi`;
CREATE TABLE IF NOT EXISTS `klasifikasi` (
  `ID` int(11) DEFAULT NULL,
  `Kode` varchar(2) DEFAULT NULL,
  `Klasifikasi` varchar(40) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.klasifikasi: 9 rows
/*!40000 ALTER TABLE `klasifikasi` DISABLE KEYS */;
REPLACE INTO `klasifikasi` (`ID`, `Kode`, `Klasifikasi`) VALUES
	(1, '1', 'Harta'),
	(2, '2', 'Kewajiban'),
	(3, '3', 'Kekayaan Bersih'),
	(4, '4', 'Pendapatan'),
	(5, '5', 'Biaya atas Pendapatan'),
	(6, '6', 'Pengeluaran Operasional'),
	(7, '7', 'Pengeluaran Non Operasional'),
	(8, '8', 'Pendapatan Luar Usaha'),
	(9, '9', 'Pengeluaran Luar Usaha');
/*!40000 ALTER TABLE `klasifikasi` ENABLE KEYS */;


-- Dumping structure for table setujudb.laba_rugi
DROP TABLE IF EXISTS `laba_rugi`;
CREATE TABLE IF NOT EXISTS `laba_rugi` (
  `ID` int(11) DEFAULT NULL,
  `Jenis` varchar(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.laba_rugi: 3 rows
/*!40000 ALTER TABLE `laba_rugi` DISABLE KEYS */;
REPLACE INTO `laba_rugi` (`ID`, `Jenis`) VALUES
	(1, 'Pendapatan Usaha'),
	(2, 'Pendapatan Lain'),
	(3, 'Beban Langsung');
/*!40000 ALTER TABLE `laba_rugi` ENABLE KEYS */;


-- Dumping structure for table setujudb.laporan
DROP TABLE IF EXISTS `laporan`;
CREATE TABLE IF NOT EXISTS `laporan` (
  `ID` int(11) DEFAULT NULL,
  `JenisLaporan` varchar(15) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.laporan: 2 rows
/*!40000 ALTER TABLE `laporan` DISABLE KEYS */;
REPLACE INTO `laporan` (`ID`, `JenisLaporan`) VALUES
	(1, 'Laba - Rugi'),
	(2, 'Cash Flow');
/*!40000 ALTER TABLE `laporan` ENABLE KEYS */;


-- Dumping structure for table setujudb.lap_head
DROP TABLE IF EXISTS `lap_head`;
CREATE TABLE IF NOT EXISTS `lap_head` (
  `ID` int(11) DEFAULT NULL,
  `Header1` varchar(11) DEFAULT NULL,
  `Header2` varchar(11) DEFAULT NULL,
  `Number1` double DEFAULT NULL,
  `Number2` double DEFAULT NULL,
  `Number3` double DEFAULT NULL,
  `Number4` double DEFAULT NULL,
  `Number5` double DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.lap_head: 2 rows
/*!40000 ALTER TABLE `lap_head` DISABLE KEYS */;
REPLACE INTO `lap_head` (`ID`, `Header1`, `Header2`, `Number1`, `Number2`, `Number3`, `Number4`, `Number5`) VALUES
	(1, 'A K T I V A', 'Aktiva', 0, 0, 0, 0, 0),
	(2, 'P A S I V A', 'Pasiva', 0, 0, 0, 0, 0);
/*!40000 ALTER TABLE `lap_head` ENABLE KEYS */;


-- Dumping structure for table setujudb.lap_jenis
DROP TABLE IF EXISTS `lap_jenis`;
CREATE TABLE IF NOT EXISTS `lap_jenis` (
  `ID` int(11) DEFAULT NULL,
  `ID_Head` int(11) DEFAULT NULL,
  `ID_KBR` smallint(6) DEFAULT NULL,
  `ID_USP` smallint(6) DEFAULT NULL,
  `ID_Calc` smallint(6) DEFAULT NULL,
  `Jenis` varchar(30) DEFAULT NULL,
  `Jenis1` varchar(30) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.lap_jenis: 11 rows
/*!40000 ALTER TABLE `lap_jenis` DISABLE KEYS */;
REPLACE INTO `lap_jenis` (`ID`, `ID_Head`, `ID_KBR`, `ID_USP`, `ID_Calc`, `Jenis`, `Jenis1`) VALUES
	(1, 1, 1, 1, 1, 'AKTIVA LANCAR', 'Aktiva Lancar'),
	(2, 1, 1, 0, 1, 'INVESTASI PADA USP', 'Investasi Pada USP'),
	(3, 1, 1, 1, 1, 'AKTIVA TETAP', 'Aktiva Tetap'),
	(4, 1, 1, 0, 1, 'AKTIVA LAIN-LAIN', 'Aktiva Lain-Lain'),
	(5, 2, 1, 1, 2, 'KEWAJIBAN LANCAR', 'Kewajiban Lancar'),
	(6, 2, 1, 1, 2, 'KEWAJIBAN JANGKA PANJANG', 'Kewajiban Jangka Panjang'),
	(7, 2, 1, 1, 2, 'KEKAYAAN BERSIH', 'Kekayaan Bersih'),
	(8, 0, 1, 1, 2, 'PENDAPATAN / PENJUALAN', 'Pendapatan / Penjualan'),
	(9, 0, 1, 1, 1, 'HARGA POKOK', 'Harga Pokok'),
	(10, 0, 1, 1, 1, 'BEBAN USAHA', 'Beban Usaha'),
	(11, 0, 1, 1, 2, 'PENDAPATAN / BEBAN LUAR USAHA', 'Pendapatan / Beban Luar Usaha');
/*!40000 ALTER TABLE `lap_jenis` ENABLE KEYS */;


-- Dumping structure for table setujudb.lap_neraca_detail
DROP TABLE IF EXISTS `lap_neraca_detail`;
CREATE TABLE IF NOT EXISTS `lap_neraca_detail` (
  `ID` int(11) DEFAULT NULL,
  `ID_Head` int(11) DEFAULT NULL,
  `ID_KBR` tinyint(4) DEFAULT NULL,
  `ID_USP` tinyint(4) DEFAULT NULL,
  `Detail` varchar(50) DEFAULT NULL,
  `Number1` double DEFAULT NULL,
  `Number2` double DEFAULT NULL,
  `Number3` double DEFAULT NULL,
  `Number4` double DEFAULT NULL,
  `Number5` double DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.lap_neraca_detail: 0 rows
/*!40000 ALTER TABLE `lap_neraca_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `lap_neraca_detail` ENABLE KEYS */;


-- Dumping structure for table setujudb.lap_neraca_head
DROP TABLE IF EXISTS `lap_neraca_head`;
CREATE TABLE IF NOT EXISTS `lap_neraca_head` (
  `ID` int(11) DEFAULT NULL,
  `ID_Ledger` int(11) DEFAULT NULL,
  `ID_Head` int(11) DEFAULT NULL,
  `Head` varchar(30) DEFAULT NULL,
  `Number1` double DEFAULT NULL,
  `Number2` double DEFAULT NULL,
  `Number3` double DEFAULT NULL,
  `Number4` double DEFAULT NULL,
  `Number5` double DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.lap_neraca_head: 0 rows
/*!40000 ALTER TABLE `lap_neraca_head` DISABLE KEYS */;
/*!40000 ALTER TABLE `lap_neraca_head` ENABLE KEYS */;


-- Dumping structure for table setujudb.lap_neraca_ledger
DROP TABLE IF EXISTS `lap_neraca_ledger`;
CREATE TABLE IF NOT EXISTS `lap_neraca_ledger` (
  `ID` int(11) DEFAULT NULL,
  `ID_Ledger` int(11) DEFAULT NULL,
  `Ledger1` varchar(20) DEFAULT NULL,
  `Ledger2` varchar(20) DEFAULT NULL,
  `Number1` double DEFAULT NULL,
  `Number2` double DEFAULT NULL,
  `Number3` double DEFAULT NULL,
  `Number4` double DEFAULT NULL,
  `Number5` double DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.lap_neraca_ledger: 0 rows
/*!40000 ALTER TABLE `lap_neraca_ledger` DISABLE KEYS */;
/*!40000 ALTER TABLE `lap_neraca_ledger` ENABLE KEYS */;


-- Dumping structure for table setujudb.lap_shu_detail
DROP TABLE IF EXISTS `lap_shu_detail`;
CREATE TABLE IF NOT EXISTS `lap_shu_detail` (
  `ID` int(11) DEFAULT NULL,
  `ID_Head` int(11) DEFAULT NULL,
  `ID_KBR` tinyint(4) DEFAULT NULL,
  `ID_USP` tinyint(4) DEFAULT NULL,
  `Detail` varchar(50) DEFAULT NULL,
  `Number1` double DEFAULT NULL,
  `Number2` double DEFAULT NULL,
  `Number3` double DEFAULT NULL,
  `Number4` double DEFAULT NULL,
  `Number5` double DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.lap_shu_detail: 0 rows
/*!40000 ALTER TABLE `lap_shu_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `lap_shu_detail` ENABLE KEYS */;


-- Dumping structure for table setujudb.lap_shu_head
DROP TABLE IF EXISTS `lap_shu_head`;
CREATE TABLE IF NOT EXISTS `lap_shu_head` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Head` int(11) DEFAULT NULL,
  `Head` varchar(50) DEFAULT NULL,
  `Number1` double DEFAULT NULL,
  `Number2` double DEFAULT NULL,
  `Number3` double DEFAULT NULL,
  `Number4` double DEFAULT NULL,
  `Number5` double DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.lap_shu_head: 0 rows
/*!40000 ALTER TABLE `lap_shu_head` DISABLE KEYS */;
/*!40000 ALTER TABLE `lap_shu_head` ENABLE KEYS */;


-- Dumping structure for table setujudb.lap_subjenis
DROP TABLE IF EXISTS `lap_subjenis`;
CREATE TABLE IF NOT EXISTS `lap_subjenis` (
  `ID` int(11) DEFAULT NULL,
  `NoUrut` int(11) DEFAULT NULL,
  `ID_Lap` int(11) DEFAULT NULL,
  `ID_Jenis` int(11) DEFAULT NULL,
  `ID_Calc` int(11) DEFAULT NULL,
  `ID_KBR` smallint(6) DEFAULT NULL,
  `ID_USP` smallint(6) DEFAULT NULL,
  `ID_Post` smallint(6) DEFAULT NULL,
  `SubJenis` varchar(40) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.lap_subjenis: 83 rows
/*!40000 ALTER TABLE `lap_subjenis` DISABLE KEYS */;
REPLACE INTO `lap_subjenis` (`ID`, `NoUrut`, `ID_Lap`, `ID_Jenis`, `ID_Calc`, `ID_KBR`, `ID_USP`, `ID_Post`, `SubJenis`) VALUES
	(1, 1, 2, 1, 1, 1, 1, 0, 'Kas'),
	(2, 2, 2, 1, 1, 1, 0, 0, 'Bank'),
	(3, 3, 2, 1, 1, 0, 1, 0, 'Bank BPR Kop. Jabar'),
	(6, 4, 2, 1, 1, 1, 0, 0, 'Deposito'),
	(7, 5, 2, 1, 1, 1, 0, 0, 'Piutang pada USP'),
	(8, 6, 2, 1, 1, 0, 1, 0, 'Piutang pada KBR'),
	(9, 7, 2, 1, 1, 0, 1, 0, 'Pinjaman yang diberikan'),
	(10, 8, 2, 1, 1, 1, 0, 0, 'Piutang Barang'),
	(11, 9, 2, 1, 1, 1, 0, 0, 'Piutang Catering'),
	(12, 10, 2, 1, 1, 1, 0, 0, 'Piutang Cleaning Service'),
	(13, 11, 2, 1, 1, 1, 0, 0, 'Piutang Hidangan Rapat'),
	(14, 12, 2, 1, 1, 1, 0, 0, 'Piutang Jasa Tenaga Kerja'),
	(15, 13, 2, 1, 1, 1, 0, 0, 'Piutang Jasa Service Komputer'),
	(16, 14, 2, 1, 1, 1, 0, 0, 'Piutang Babatan & Cabutan Rumput'),
	(17, 15, 2, 1, 1, 1, 0, 0, 'Piutang Lain-lain'),
	(18, 16, 2, 2, 1, 1, 0, 0, 'Investasi Pada USP'),
	(19, 17, 2, 3, 1, 1, 1, 0, 'Aktiva Tetap Perabot dan Peralatan'),
	(20, 18, 2, 3, 1, 1, 0, 0, 'Angkutan Kendaraan Bermotor'),
	(21, 19, 2, 4, 1, 1, 0, 0, 'Simpanan Pada Badan Usaha Non Koperasi'),
	(22, 20, 2, 5, 2, 1, 0, 0, 'Hutang Usaha'),
	(23, 21, 2, 5, 2, 1, 1, 0, 'Hutang Lain-lain'),
	(24, 22, 2, 5, 2, 1, 0, 0, 'Hutang Pada USP'),
	(25, 23, 2, 5, 2, 0, 1, 0, 'Hutang Pada KBR'),
	(26, 24, 2, 5, 2, 1, 0, 0, 'Hutang Pajak'),
	(27, 25, 2, 5, 2, 0, 1, 0, 'Hutang Pada BPR '),
	(28, 26, 2, 5, 2, 0, 1, 0, 'Hutang Pada Daperta'),
	(29, 27, 2, 6, 2, 1, 0, 0, 'Bantuan Pembinaan PUKK'),
	(30, 28, 2, 7, 2, 1, 0, 0, 'Simpanan Pokok'),
	(31, 29, 2, 7, 2, 1, 0, 0, 'Simpanan Wajib'),
	(32, 30, 2, 7, 2, 1, 0, 0, 'Simpanan Khusus'),
	(34, 31, 2, 7, 2, 1, 0, 0, 'Cadangan'),
	(35, 32, 2, 7, 2, 1, 1, 2, 'SHU Tahun Lalu'),
	(36, 33, 2, 7, 2, 1, 1, 1, 'SHU Tahun Berjalan'),
	(37, 34, 1, 8, 2, 1, 0, 0, 'Penjualan Barang'),
	(38, 35, 1, 8, 2, 0, 1, 0, 'Jasa Pinjaman'),
	(39, 36, 1, 8, 2, 1, 0, 0, 'Jasa Catering'),
	(40, 37, 1, 8, 2, 1, 0, 0, 'Jasa Cleaning Service'),
	(41, 38, 1, 8, 2, 1, 0, 0, 'Jasa Hidangan Rapat'),
	(42, 39, 1, 8, 2, 1, 0, 0, 'Jasa Tenaga Kerja'),
	(43, 40, 1, 8, 2, 1, 0, 0, 'Jasa Service Komputer'),
	(44, 41, 1, 8, 2, 1, 0, 0, 'Jasa Babatan & Cabutan Rumput'),
	(45, 42, 1, 9, 1, 1, 0, 0, 'Beban Pokok Barang'),
	(46, 43, 1, 9, 1, 0, 1, 0, 'Beban Pinjaman'),
	(47, 44, 1, 9, 1, 1, 0, 0, 'Beban Catering'),
	(48, 45, 1, 9, 1, 1, 0, 0, 'Beban Cleaning Service'),
	(49, 46, 1, 9, 1, 1, 0, 0, 'Beban Hidangan Rapat'),
	(50, 47, 1, 9, 1, 1, 0, 0, 'Beban Tenaga Kerja'),
	(51, 48, 1, 9, 1, 1, 0, 0, 'Beban Service Komputer'),
	(52, 49, 1, 9, 1, 1, 0, 0, 'Beban Babatan & Cabutan Rumput'),
	(53, 50, 1, 10, 1, 1, 1, 0, 'Beban Pegawai'),
	(54, 51, 1, 10, 1, 1, 1, 0, 'Beban Rapat Anggota Tahunan'),
	(55, 52, 1, 10, 1, 1, 1, 0, 'Beban Kantor dan Rumah Tangga'),
	(56, 53, 1, 10, 1, 1, 1, 0, 'Beban Pelayanan Anggota'),
	(57, 54, 1, 10, 1, 1, 1, 0, 'Beban Piutang Tak Tertagih'),
	(58, 55, 1, 10, 1, 1, 1, 0, 'Beban Penyusutan'),
	(59, 56, 1, 10, 1, 1, 1, 0, 'Beban Administrasi dan Umum'),
	(60, 57, 1, 11, 2, 1, 1, 0, 'Pendapatan Luar Usaha'),
	(61, 58, 1, 11, 1, 1, 1, 0, 'Beban Luar Usaha'),
	(62, 60, 2, 1, 2, 1, 1, 0, 'Penyisihan Piutang'),
	(63, 61, 2, 1, 1, 1, 0, 0, 'Pajak Dibayar Dimuka'),
	(64, 72, 2, 1, 1, 1, 1, 0, 'Pembayaran Dimuka'),
	(65, 62, 2, 3, 1, 1, 1, 0, 'Akumulasi Penyusutan'),
	(66, 63, 2, 5, 2, 1, 1, 0, 'Beban Yang Masih Harus Dibayar'),
	(67, 64, 2, 5, 2, 1, 0, 0, 'Dana SHU'),
	(68, 65, 2, 7, 2, 1, 0, 0, 'Historical Balancing'),
	(71, 66, 2, 7, 2, 0, 1, 0, 'Modal Disetor'),
	(73, 67, 2, 5, 2, 1, 1, 0, 'Pendapatan Yang Diterima Dimuka'),
	(74, 68, 1, 8, 2, 1, 0, 0, 'Jasa Usaha Lainnya'),
	(75, 69, 1, 9, 1, 1, 0, 0, 'Beban Usaha Lainnya'),
	(76, 73, 2, 1, 1, 1, 0, 0, 'Persediaan'),
	(77, 71, 2, 6, 2, 1, 0, 0, 'Hutang Bank Jabar'),
	(83, 74, 2, 1, 1, 0, 1, 0, 'BNI 46 (USP)'),
	(84, 75, 2, 1, 1, 0, 1, 0, 'Ayat Silang Kas - Bank (USP)'),
	(85, 84, 2, 6, 2, 0, 0, 0, 'Kewajiban Jangka Panjang (USP)'),
	(86, 76, 2, 6, 2, 1, 0, 0, 'Hutang PT. Adira Finance'),
	(88, 80, 2, 6, 2, 0, 1, 0, 'Hutang Pada BNI \'46'),
	(89, 79, 2, 1, 1, 0, 1, 0, 'BRI Syariah Kedoya (USP)'),
	(90, 81, 2, 6, 2, 0, 1, 0, 'Hutang Pada BRI Syariah (USP)'),
	(92, 78, 2, 6, 2, 1, 0, 0, 'Kewajiban Jangka Panjang'),
	(93, 83, 2, 1, 1, 0, 1, 0, 'BJB Syariah Cab.Pwk (USP)'),
	(94, 82, 2, 6, 2, 0, 1, 0, 'Hutang Pada BJB Syariah Cab.Pwk (USP)'),
	(95, 85, 2, 1, 1, 1, 0, 0, 'Garansi Bank'),
	(96, 86, 2, 1, 1, 0, 1, 0, 'Garansi Bank (USP)');
/*!40000 ALTER TABLE `lap_subjenis` ENABLE KEYS */;


-- Dumping structure for table setujudb.mst_anggota
DROP TABLE IF EXISTS `mst_anggota`;
CREATE TABLE IF NOT EXISTS `mst_anggota` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Jenis` tinyint(4) NOT NULL DEFAULT '0',
  `NoUrut` int(11) NOT NULL DEFAULT '0',
  `ID_Aktif` int(11) DEFAULT NULL,
  `ID_Dept` int(11) DEFAULT NULL,
  `No_Perkiraan` varchar(4) DEFAULT NULL,
  `NIP` varchar(10) DEFAULT NULL,
  `No_Agt` varchar(10) NOT NULL DEFAULT '',
  `Nama` varchar(40) DEFAULT NULL,
  `ID_Check` smallint(6) DEFAULT NULL,
  `ID_Kelamin` int(11) DEFAULT NULL,
  `TanggalMasuk` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `TanggalKeluar` date DEFAULT NULL,
  `PhotoLink` varchar(255) DEFAULT NULL,
  `Catatan` mediumtext,
  `Alamat` varchar(50) DEFAULT NULL,
  `Kota` varchar(20) DEFAULT NULL,
  `Propinsi` varchar(20) DEFAULT NULL,
  `Telepon` varchar(50) DEFAULT NULL,
  `Faksimili` varchar(50) DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`NoUrut`,`ID_Jenis`),
  KEY `ID` (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COMMENT='table anggota koperasi';

-- Dumping data for table setujudb.mst_anggota: 5 rows
/*!40000 ALTER TABLE `mst_anggota` DISABLE KEYS */;
REPLACE INTO `mst_anggota` (`ID`, `ID_Jenis`, `NoUrut`, `ID_Aktif`, `ID_Dept`, `No_Perkiraan`, `NIP`, `No_Agt`, `Nama`, `ID_Check`, `ID_Kelamin`, `TanggalMasuk`, `TanggalKeluar`, `PhotoLink`, `Catatan`, `Alamat`, `Kota`, `Propinsi`, `Telepon`, `Faksimili`, `Status`) VALUES
	(1, 1, 1, 0, 1, NULL, NULL, '0001', 'JUNED', NULL, 1, '2012-10-18 12:08:34', '2012-10-18', NULL, 'PT.CATUR NUNGGAL', 'Jl. Bajai Bajuri', 'Purwakarta', 'Jawa Barat', '0264-351', '0264', '1000000'),
	(2, 1, 2, 0, 1, NULL, NULL, '0002', 'BAMBANG SUDJATMIKO', NULL, NULL, '2012-10-18 10:12:51', '2012-10-18', NULL, 'PT. BANGUN SENTOSA', 'Jl. Imam Bonjol 15', 'Purwakarta', 'Jawa Barat', '0264-22222', '0264-33344', '25000000'),
	(3, 1, 3, 0, 1, NULL, NULL, '0003', 'BUDIMAN', NULL, NULL, '2012-10-18 10:12:19', NULL, NULL, 'PT.AZET', 'Jl. Dipatiukur 63', 'Bandung', 'Jawa Barat', '022', '', '50000000'),
	(5, 2, 1, NULL, NULL, NULL, NULL, '0005', 'PT. KARYA LOGAM', NULL, NULL, '2012-10-19 23:02:16', NULL, NULL, NULL, 'Jl. Prapanca 5', '', '', '', '', '0'),
	(4, 2, 2, NULL, NULL, NULL, NULL, '0004', 'BAJA BESI. PT', NULL, NULL, '2012-10-19 23:02:20', NULL, NULL, NULL, 'Jl. Kyai Mojo 25', 'Tegal', '', '', '', '0');
/*!40000 ALTER TABLE `mst_anggota` ENABLE KEYS */;


-- Dumping structure for table setujudb.mst_anggota_copy
DROP TABLE IF EXISTS `mst_anggota_copy`;
CREATE TABLE IF NOT EXISTS `mst_anggota_copy` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Jenis` tinyint(4) DEFAULT NULL,
  `NoUrut` int(11) DEFAULT NULL,
  `ID_Aktif` int(11) DEFAULT NULL,
  `ID_Dept` int(11) DEFAULT NULL,
  `No_Perkiraan` varchar(4) DEFAULT NULL,
  `NIP` varchar(10) DEFAULT NULL,
  `No_Agt` varchar(10) DEFAULT NULL,
  `Nama` varchar(40) DEFAULT NULL,
  `ID_Check` smallint(6) DEFAULT NULL,
  `ID_Kelamin` int(11) DEFAULT NULL,
  `TanggalMasuk` datetime DEFAULT NULL,
  `TanggalKeluar` datetime DEFAULT NULL,
  `PhotoLink` varchar(255) DEFAULT NULL,
  `Catatan` mediumtext,
  `Alamat` varchar(50) DEFAULT NULL,
  `Kota` varchar(20) DEFAULT NULL,
  `Propinsi` varchar(20) DEFAULT NULL,
  `Telepon` varchar(50) DEFAULT NULL,
  `Faksimili` varchar(50) DEFAULT NULL,
  `Status` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='table anggota koperasi';

-- Dumping data for table setujudb.mst_anggota_copy: 0 rows
/*!40000 ALTER TABLE `mst_anggota_copy` DISABLE KEYS */;
/*!40000 ALTER TABLE `mst_anggota_copy` ENABLE KEYS */;


-- Dumping structure for table setujudb.mst_bank
DROP TABLE IF EXISTS `mst_bank`;
CREATE TABLE IF NOT EXISTS `mst_bank` (
  `NamaBank` varchar(150) NOT NULL DEFAULT '',
  `NoRek` varchar(150) NOT NULL DEFAULT '',
  `Nama` varchar(150) DEFAULT NULL,
  `Saldo` double DEFAULT '0',
  PRIMARY KEY (`NamaBank`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.mst_bank: ~3 rows (approximately)
/*!40000 ALTER TABLE `mst_bank` DISABLE KEYS */;
REPLACE INTO `mst_bank` (`NamaBank`, `NoRek`, `Nama`, `Saldo`) VALUES
	('', '0', 'JUNED', 65000),
	('BANK BCA', '12345679', 'BAMBANG SUDJATMIKO', 150000),
	('BANK BTN', '22334455', 'BAMBANG SUDJATMIKO', 825000);
/*!40000 ALTER TABLE `mst_bank` ENABLE KEYS */;


-- Dumping structure for table setujudb.mst_bulan
DROP TABLE IF EXISTS `mst_bulan`;
CREATE TABLE IF NOT EXISTS `mst_bulan` (
  `ID` int(11) NOT NULL DEFAULT '0',
  `Bulan` varchar(9) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.mst_bulan: 0 rows
/*!40000 ALTER TABLE `mst_bulan` DISABLE KEYS */;
/*!40000 ALTER TABLE `mst_bulan` ENABLE KEYS */;


-- Dumping structure for table setujudb.mst_departemen
DROP TABLE IF EXISTS `mst_departemen`;
CREATE TABLE IF NOT EXISTS `mst_departemen` (
  `ID` int(11) DEFAULT NULL,
  `Kode` varchar(2) DEFAULT NULL,
  `Departemen` varchar(40) DEFAULT NULL,
  `Title` varchar(10) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.mst_departemen: 0 rows
/*!40000 ALTER TABLE `mst_departemen` DISABLE KEYS */;
/*!40000 ALTER TABLE `mst_departemen` ENABLE KEYS */;


-- Dumping structure for table setujudb.mst_kas
DROP TABLE IF EXISTS `mst_kas`;
CREATE TABLE IF NOT EXISTS `mst_kas` (
  `id_kas` varchar(100) NOT NULL DEFAULT '',
  `nm_kas` varchar(225) DEFAULT '',
  `sa_kas` double DEFAULT '0',
  `sl_kas` double DEFAULT '0',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_kas`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.mst_kas: 1 rows
/*!40000 ALTER TABLE `mst_kas` DISABLE KEYS */;
REPLACE INTO `mst_kas` (`id_kas`, `nm_kas`, `sa_kas`, `sl_kas`, `doc_date`, `created_by`) VALUES
	('KAS TOKO', 'KAS HARIAN TOKO', 0, 0, '2012-10-04 12:13:50', 'superuser');
/*!40000 ALTER TABLE `mst_kas` ENABLE KEYS */;


-- Dumping structure for table setujudb.mst_kas_harian
DROP TABLE IF EXISTS `mst_kas_harian`;
CREATE TABLE IF NOT EXISTS `mst_kas_harian` (
  `no_trans` varchar(50) NOT NULL DEFAULT '0000-00-00',
  `tgl_kas` date NOT NULL DEFAULT '0000-00-00',
  `id_kas` varchar(50) NOT NULL DEFAULT '',
  `nm_kas` varchar(150) DEFAULT NULL,
  `sa_kas` double DEFAULT '0',
  `created_by` varchar(225) DEFAULT NULL,
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tgl_kas`,`id_kas`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.mst_kas_harian: 2 rows
/*!40000 ALTER TABLE `mst_kas_harian` DISABLE KEYS */;
REPLACE INTO `mst_kas_harian` (`no_trans`, `tgl_kas`, `id_kas`, `nm_kas`, `sa_kas`, `created_by`, `doc_date`) VALUES
	('2000000000', '2012-10-24', 'KAS TOKO', 'KAS HARIAN TOKO', 500000, 'superuser', '2012-10-24 14:29:31'),
	('2000000005', '2012-10-25', 'KAS TOKO', 'KAS HARIAN TOKO', 500000, 'superuser', '2012-10-25 13:16:21');
/*!40000 ALTER TABLE `mst_kas_harian` ENABLE KEYS */;


-- Dumping structure for table setujudb.mst_kas_trans
DROP TABLE IF EXISTS `mst_kas_trans`;
CREATE TABLE IF NOT EXISTS `mst_kas_trans` (
  `id_trans` int(10) NOT NULL DEFAULT '0',
  `id_kas` varchar(10) DEFAULT NULL,
  `tgl_trans` date DEFAULT NULL,
  `uraian_trans` text,
  `jumlah` double DEFAULT '0',
  `saldo_kas` double DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_trans`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='transaksi kas harian';

-- Dumping data for table setujudb.mst_kas_trans: ~6 rows (approximately)
/*!40000 ALTER TABLE `mst_kas_trans` DISABLE KEYS */;
REPLACE INTO `mst_kas_trans` (`id_trans`, `id_kas`, `tgl_trans`, `uraian_trans`, `jumlah`, `saldo_kas`, `created_by`, `doc_date`) VALUES
	(2000000000, 'KAS TOKO', '2012-10-24', 'Saldo Awal hari ini', 0, 500000, NULL, '2012-10-24 14:29:31'),
	(2000000001, 'KAS TOKO', '2012-10-24', 'Sumbangan', 5000, 495000, 'superuser', '2012-10-24 14:30:25'),
	(2000000002, 'KAS TOKO', '2012-10-24', 'Beli Snack', 25000, 470000, 'superuser', '2012-10-24 14:31:33'),
	(2000000003, 'KAS TOKO', '2012-10-24', 'Santunan', 10000, 450000, 'superuser', '2012-10-24 16:10:46'),
	(2000000004, 'KAS TOKO', '2012-10-24', 'Sumbangan Masjid', 25000, 435000, 'superuser', '2012-10-24 16:12:08'),
	(2000000005, 'KAS TOKO', '2012-10-25', 'Saldo Awal hari ini', 0, 500000, NULL, '2012-10-25 13:16:21'),
	(2000000006, 'KAS TOKO', '2012-10-25', 'Hilang', 450000, 50000, 'superuser', '2012-10-25 15:44:57');
/*!40000 ALTER TABLE `mst_kas_trans` ENABLE KEYS */;


-- Dumping structure for table setujudb.mst_kota
DROP TABLE IF EXISTS `mst_kota`;
CREATE TABLE IF NOT EXISTS `mst_kota` (
  `kota_anggota` varchar(150) NOT NULL DEFAULT '',
  `created_by` varchar(150) NOT NULL DEFAULT '',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`kota_anggota`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.mst_kota: 5 rows
/*!40000 ALTER TABLE `mst_kota` DISABLE KEYS */;
REPLACE INTO `mst_kota` (`kota_anggota`, `created_by`, `doc_date`) VALUES
	('Purwakarta', '', '2012-10-04 10:58:41'),
	('Kota', '', '2012-10-17 15:04:06'),
	('Bandung', '', '2012-10-18 10:12:19'),
	('Tegal', '', '2012-10-19 22:57:47'),
	('', '', '2012-10-19 22:53:00');
/*!40000 ALTER TABLE `mst_kota` ENABLE KEYS */;


-- Dumping structure for table setujudb.mst_pelanggan
DROP TABLE IF EXISTS `mst_pelanggan`;
CREATE TABLE IF NOT EXISTS `mst_pelanggan` (
  `nm_pelanggan` varchar(125) NOT NULL DEFAULT '',
  `alm_pelanggan` text,
  `telp_pelanggan` varchar(50) DEFAULT NULL,
  `hutang_pelanggan` double DEFAULT '0',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`nm_pelanggan`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.mst_pelanggan: 0 rows
/*!40000 ALTER TABLE `mst_pelanggan` DISABLE KEYS */;
/*!40000 ALTER TABLE `mst_pelanggan` ENABLE KEYS */;


-- Dumping structure for table setujudb.mst_produsen
DROP TABLE IF EXISTS `mst_produsen`;
CREATE TABLE IF NOT EXISTS `mst_produsen` (
  `nm_produsen` varchar(125) NOT NULL DEFAULT '',
  ` alm_produsen` text,
  ` telp_produsen` varchar(50) DEFAULT NULL,
  ` hutang_produsen` double DEFAULT '0',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`nm_produsen`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.mst_produsen: 0 rows
/*!40000 ALTER TABLE `mst_produsen` DISABLE KEYS */;
/*!40000 ALTER TABLE `mst_produsen` ENABLE KEYS */;


-- Dumping structure for table setujudb.mst_propinsi
DROP TABLE IF EXISTS `mst_propinsi`;
CREATE TABLE IF NOT EXISTS `mst_propinsi` (
  `prop_anggota` varchar(100) NOT NULL DEFAULT '',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`prop_anggota`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='data propinsi';

-- Dumping data for table setujudb.mst_propinsi: 4 rows
/*!40000 ALTER TABLE `mst_propinsi` DISABLE KEYS */;
REPLACE INTO `mst_propinsi` (`prop_anggota`, `doc_date`) VALUES
	('Jawa Barat', '2012-10-18 10:12:19'),
	('Propinsi', '2012-10-17 15:04:06'),
	('Jawa Tengah', '2012-10-19 22:52:36'),
	('', '2012-10-19 22:57:47');
/*!40000 ALTER TABLE `mst_propinsi` ENABLE KEYS */;


-- Dumping structure for table setujudb.mst_status
DROP TABLE IF EXISTS `mst_status`;
CREATE TABLE IF NOT EXISTS `mst_status` (
  `nm_status` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`nm_status`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.mst_status: 0 rows
/*!40000 ALTER TABLE `mst_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `mst_status` ENABLE KEYS */;


-- Dumping structure for table setujudb.nomor_transaksi
DROP TABLE IF EXISTS `nomor_transaksi`;
CREATE TABLE IF NOT EXISTS `nomor_transaksi` (
  `nomor` varchar(50) NOT NULL DEFAULT '',
  `jenis_transaksi` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`nomor`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.nomor_transaksi: 27 rows
/*!40000 ALTER TABLE `nomor_transaksi` DISABLE KEYS */;
REPLACE INTO `nomor_transaksi` (`nomor`, `jenis_transaksi`, `created_by`, `doc_date`) VALUES
	('2000000000', 'D', NULL, '2012-10-24 14:29:31'),
	('2000000001', 'D', NULL, '2012-10-24 14:30:25'),
	('2000000002', 'D', NULL, '2012-10-24 14:31:33'),
	('5000000000', 'GR', NULL, '2012-10-24 14:39:58'),
	('5000000001', 'GR', NULL, '2012-10-24 14:47:41'),
	('4000000000', 'GI', NULL, '2012-10-24 14:49:22'),
	('4000000001', 'GI', NULL, '2012-10-24 14:51:03'),
	('4000000002', 'GI', NULL, '2012-10-24 14:53:55'),
	('4000000003', 'GI', NULL, '2012-10-24 14:58:38'),
	('4000000004', 'GI', NULL, '2012-10-24 15:01:35'),
	('4000000005', 'GI', NULL, '2012-10-24 15:02:05'),
	('4000000006', 'GI', NULL, '2012-10-24 15:11:01'),
	('4000000007', 'GI', NULL, '2012-10-24 15:15:20'),
	('4000000008', 'GI', NULL, '2012-10-24 15:23:09'),
	('4000000009', 'GI', NULL, '2012-10-24 15:33:26'),
	('4000000010', 'GI', NULL, '2012-10-24 15:47:38'),
	('4000000011', 'GI', NULL, '2012-10-24 15:48:22'),
	('4000000012', 'GI', NULL, '2012-10-24 15:50:46'),
	('4000000013', 'GI', NULL, '2012-10-24 15:52:45'),
	('4000000014', 'GI', NULL, '2012-10-24 15:54:35'),
	('4000000015', 'GI', NULL, '2012-10-24 15:55:04'),
	('2000000003', 'D', NULL, '2012-10-24 16:10:46'),
	('2000000004', 'D', NULL, '2012-10-24 16:12:08'),
	('4000000016', 'GI', NULL, '2012-10-24 23:07:42'),
	('4000000017', 'GI', NULL, '2012-10-24 23:09:40'),
	('4000000018', 'GI', NULL, '2012-10-25 11:12:46'),
	('2000000005', 'D', NULL, '2012-10-25 13:16:21'),
	('4000000019', 'GI', NULL, '2012-10-25 14:09:10'),
	('4000000020', 'GI', NULL, '2012-10-25 14:15:44'),
	('4000000021', 'GI', NULL, '2012-10-25 14:22:03'),
	('4000000022', 'GI', NULL, '2012-10-25 14:24:22'),
	('4000000023', 'GI', NULL, '2012-10-25 14:25:12'),
	('4000000024', 'GI', NULL, '2012-10-25 14:25:59'),
	('4000000025', 'GI', NULL, '2012-10-25 14:26:41'),
	('4000000026', 'GI', NULL, '2012-10-25 14:27:15'),
	('4000000027', 'GI', NULL, '2012-10-25 15:25:04'),
	('2000000006', 'D', NULL, '2012-10-25 15:44:57');
/*!40000 ALTER TABLE `nomor_transaksi` ENABLE KEYS */;


-- Dumping structure for table setujudb.perkiraan
DROP TABLE IF EXISTS `perkiraan`;
CREATE TABLE IF NOT EXISTS `perkiraan` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Klas` int(11) DEFAULT NULL,
  `ID_SubKlas` int(11) DEFAULT NULL,
  `ID_Dept` int(11) DEFAULT NULL,
  `ID_Unit` int(11) DEFAULT NULL,
  `ID_Laporan` int(11) DEFAULT NULL,
  `ID_LapDetail` int(11) DEFAULT NULL,
  `ID_Agt` int(11) NOT NULL DEFAULT '0',
  `ID_Calc` int(11) DEFAULT NULL,
  `ID_Simpanan` int(11) NOT NULL DEFAULT '0',
  `NoUrut` int(11) DEFAULT NULL,
  `Kode` varchar(4) DEFAULT NULL,
  `Perkiraan` varchar(50) DEFAULT NULL,
  `SaldoAwal` double DEFAULT NULL,
  PRIMARY KEY (`ID_Agt`,`ID_Simpanan`),
  KEY `ID` (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.perkiraan: 23 rows
/*!40000 ALTER TABLE `perkiraan` DISABLE KEYS */;
REPLACE INTO `perkiraan` (`ID`, `ID_Klas`, `ID_SubKlas`, `ID_Dept`, `ID_Unit`, `ID_Laporan`, `ID_LapDetail`, `ID_Agt`, `ID_Calc`, `ID_Simpanan`, `NoUrut`, `Kode`, `Perkiraan`, `SaldoAwal`) VALUES
	(1, 3, 17, 1, 1, 2, 30, 3, 1, 1, 0, NULL, NULL, 0),
	(2, 3, 18, 1, 1, 2, 31, 3, 1, 2, 0, NULL, NULL, 0),
	(3, 3, 19, 1, 1, 2, 32, 3, 1, 3, 0, NULL, NULL, 0),
	(4, 1, 4, 1, 1, 2, 10, 3, 1, 4, 0, NULL, NULL, 0),
	(5, 1, 28, 1, 2, 2, 9, 3, 1, 5, 0, NULL, NULL, 0),
	(11, 3, 18, 1, 1, 2, 31, 1, 1, 2, NULL, NULL, NULL, NULL),
	(12, 3, 18, 1, 1, 2, 31, 2, 2, 2, NULL, NULL, NULL, NULL),
	(13, 1, 4, 1, 1, 2, 10, 2, 2, 4, NULL, NULL, NULL, NULL),
	(14, 3, 19, 1, 1, 2, 32, 2, 2, 3, NULL, NULL, NULL, NULL),
	(15, 1, 4, 1, 1, 2, 10, 1, 2, 4, NULL, NULL, NULL, NULL),
	(16, 3, 19, 1, 1, 2, 32, 1, 2, 3, NULL, NULL, NULL, NULL),
	(17, 3, 17, NULL, 1, 2, 30, 1, 2, 1, 0, NULL, NULL, 0),
	(18, 3, 17, NULL, 1, 2, 30, 2, 2, 1, 0, NULL, NULL, 0),
	(19, 3, 17, NULL, 1, 2, 30, 4, 2, 1, 0, NULL, NULL, 0),
	(20, 3, 18, NULL, 1, 2, 31, 4, 2, 2, 0, NULL, NULL, 0),
	(21, 3, 19, NULL, 1, 2, 32, 4, 2, 3, 0, NULL, NULL, 0),
	(22, 1, 4, NULL, 1, 2, 10, 4, 2, 4, 0, NULL, NULL, 0),
	(23, 1, 28, NULL, 1, 2, 9, 4, 1, 5, 0, NULL, NULL, 0),
	(24, 4, 28, 1, 1, 2, 9, 2, 1, 5, NULL, NULL, NULL, NULL),
	(25, 6, 24, 1, 1, 2, 1, 0, 1, 7, NULL, NULL, 'Operasional Harial', NULL),
	(26, 1, 5, 0, 1, 1, 1, 4, 1, 6, NULL, NULL, NULL, NULL),
	(27, 4, 28, 0, 1, 1, 9, 0, 2, 5, NULL, NULL, 'Return Penjualan', NULL),
	(28, 1, 4, 0, 1, 2, 10, 0, 2, 1, NULL, NULL, 'Penjualan Tunai', NULL);
/*!40000 ALTER TABLE `perkiraan` ENABLE KEYS */;


-- Dumping structure for table setujudb.pinjaman
DROP TABLE IF EXISTS `pinjaman`;
CREATE TABLE IF NOT EXISTS `pinjaman` (
  `ID` varchar(50) NOT NULL DEFAULT '',
  `ID_Unit` int(10) NOT NULL DEFAULT '0',
  `Tanggal` datetime DEFAULT NULL,
  `ID_Agt` int(10) DEFAULT NULL,
  `ID_Bulan` int(10) DEFAULT NULL,
  `Tahun` int(10) DEFAULT NULL,
  `jml_pinjaman` double DEFAULT '0',
  `cicilan` double DEFAULT '0',
  `cicilan_end` double DEFAULT '0',
  `lama_cicilan` double DEFAULT '1',
  `cara_bayar` varchar(50) DEFAULT NULL,
  `keterangan` text,
  `mulai_bayar` date DEFAULT NULL,
  `stat_pinjaman` int(11) DEFAULT '0',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='table daftar pinjaman anggota';

-- Dumping data for table setujudb.pinjaman: 0 rows
/*!40000 ALTER TABLE `pinjaman` DISABLE KEYS */;
REPLACE INTO `pinjaman` (`ID`, `ID_Unit`, `Tanggal`, `ID_Agt`, `ID_Bulan`, `Tahun`, `jml_pinjaman`, `cicilan`, `cicilan_end`, `lama_cicilan`, `cara_bayar`, `keterangan`, `mulai_bayar`, `stat_pinjaman`, `doc_date`, `created_by`) VALUES
	('4000000024', 1, '2012-10-25 00:00:00', 1, NULL, 2012, 150000, 0, 0, 2, '3', 'Cheque No: 445566-BANK BCA[ 31/10/2012 ]', '2012-10-31', 0, '2012-10-25 14:27:51', NULL),
	('4000000023', 1, '2012-10-25 00:00:00', 2, NULL, 2012, 30000, 0, 0, 1, '2', 'Giro No: 334455-BANK BCA[ 25/10/2012 ]', '2012-10-25', 1, '2012-10-25 14:40:58', NULL),
	('4000000025', 1, '2012-10-25 00:00:00', 3, NULL, 2012, 30000, 0, 0, 1, '4', 'Kredit No: 0-[ 31/10/2012 ]', '2012-10-31', 1, '2012-10-25 14:28:04', NULL),
	('4000000027', 1, '2012-10-25 00:00:00', 1, NULL, 2012, 1800000, 0, 0, 1, '2', 'Giro No: 345678-BANK BCA[ 30/10/2012 ]', '2012-10-30', 0, '2012-10-25 15:27:12', NULL);
/*!40000 ALTER TABLE `pinjaman` ENABLE KEYS */;


-- Dumping structure for table setujudb.pinjaman_bayar
DROP TABLE IF EXISTS `pinjaman_bayar`;
CREATE TABLE IF NOT EXISTS `pinjaman_bayar` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `ID_Pinjaman` varchar(50) NOT NULL DEFAULT '0',
  `ID_Agt` int(10) NOT NULL DEFAULT '0',
  `Tanggal` date NOT NULL DEFAULT '0000-00-00',
  `Tahun` int(10) NOT NULL DEFAULT '0',
  `Debet` double NOT NULL DEFAULT '0',
  `Kredit` double NOT NULL DEFAULT '0',
  `saldo` double DEFAULT '0',
  `keterangan` text,
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID_Pinjaman`,`Tahun`,`Debet`,`Kredit`),
  KEY `ID` (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 COMMENT='table transaksi pembayaran pinjaman';

-- Dumping data for table setujudb.pinjaman_bayar: 0 rows
/*!40000 ALTER TABLE `pinjaman_bayar` DISABLE KEYS */;
REPLACE INTO `pinjaman_bayar` (`ID`, `ID_Pinjaman`, `ID_Agt`, `Tanggal`, `Tahun`, `Debet`, `Kredit`, `saldo`, `keterangan`, `doc_date`, `created_by`) VALUES
	(8, '4000000024', 1, '2012-10-25', 2012, 150000, 0, 150000, 'Cheque No: 445566-BANK BCA[ 31/10/2012 ]', '2012-10-25 14:27:51', NULL),
	(12, '4000000023', 2, '2012-10-25', 2012, 30000, 0, 30000, 'Giro No: 334455-BANK BCA[ 25/10/2012 ]', '2012-10-25 14:40:58', NULL),
	(10, '4000000025', 3, '2012-10-25', 2012, 30000, 0, 30000, 'Kredit No: 0-[ 31/10/2012 ]', '2012-10-25 14:28:04', NULL),
	(7, '4000000024', 1, '2012-10-25', 2012, 0, 50000, 100000, 'Pembayaran Ke 1', '2012-10-25 14:27:51', 'superuser'),
	(9, '4000000025', 3, '2012-10-25', 2012, 0, 30000, 0, 'Pembayaran Ke 1', '2012-10-25 14:28:04', 'superuser'),
	(11, '4000000023', 2, '2012-10-25', 2012, 0, 30000, 0, 'Pembayaran Ke 1', '2012-10-25 14:40:58', 'superuser'),
	(13, '4000000027', 1, '2012-10-25', 2012, 1800000, 0, 1800000, 'Giro No: 345678-BANK BCA[ 30/10/2012 ]', '2012-10-25 15:27:12', NULL);
/*!40000 ALTER TABLE `pinjaman_bayar` ENABLE KEYS */;


-- Dumping structure for table setujudb.pinjaman_limit
DROP TABLE IF EXISTS `pinjaman_limit`;
CREATE TABLE IF NOT EXISTS `pinjaman_limit` (
  `ID_Agt` int(10) NOT NULL DEFAULT '0',
  `Tahun` int(10) NOT NULL DEFAULT '0',
  `max_limit` double DEFAULT '0',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID_Agt`,`Tahun`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='table daftar limit maximal anggota dapat meminjam, 0 adalah no limit';

-- Dumping data for table setujudb.pinjaman_limit: 3 rows
/*!40000 ALTER TABLE `pinjaman_limit` DISABLE KEYS */;
REPLACE INTO `pinjaman_limit` (`ID_Agt`, `Tahun`, `max_limit`, `doc_date`, `created_by`) VALUES
	(1, 2012, 1000000, '2012-10-18 12:08:34', NULL),
	(5, 2012, 0, '2012-10-19 23:02:16', NULL),
	(4, 2012, 0, '2012-10-19 23:02:20', NULL);
/*!40000 ALTER TABLE `pinjaman_limit` ENABLE KEYS */;


-- Dumping structure for table setujudb.setup_simpanan
DROP TABLE IF EXISTS `setup_simpanan`;
CREATE TABLE IF NOT EXISTS `setup_simpanan` (
  `id_simpanan` int(10) NOT NULL DEFAULT '0',
  `nm_simpanan` varchar(50) DEFAULT NULL,
  `min_simpanan` double DEFAULT '0',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_simpanan`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='table pengaturan simpanan anggota';

-- Dumping data for table setujudb.setup_simpanan: 0 rows
/*!40000 ALTER TABLE `setup_simpanan` DISABLE KEYS */;
/*!40000 ALTER TABLE `setup_simpanan` ENABLE KEYS */;


-- Dumping structure for table setujudb.set_simpanan_log
DROP TABLE IF EXISTS `set_simpanan_log`;
CREATE TABLE IF NOT EXISTS `set_simpanan_log` (
  `id_simpanan` int(10) NOT NULL DEFAULT '0',
  `nm_simpanan` varchar(50) DEFAULT NULL,
  `min_simpanan` double DEFAULT '0',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED COMMENT='table pengaturan simpanan anggota';

-- Dumping data for table setujudb.set_simpanan_log: 0 rows
/*!40000 ALTER TABLE `set_simpanan_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `set_simpanan_log` ENABLE KEYS */;


-- Dumping structure for table setujudb.status
DROP TABLE IF EXISTS `status`;
CREATE TABLE IF NOT EXISTS `status` (
  `ID` int(11) DEFAULT NULL,
  `Status1` varchar(10) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.status: 2 rows
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
REPLACE INTO `status` (`ID`, `Status1`) VALUES
	(1, 'Tunai'),
	(2, 'Kredit');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;


-- Dumping structure for table setujudb.sub_klasifikasi
DROP TABLE IF EXISTS `sub_klasifikasi`;
CREATE TABLE IF NOT EXISTS `sub_klasifikasi` (
  `ID` int(11) DEFAULT NULL,
  `ID_Klasifikasi` int(11) DEFAULT NULL,
  `ID_Neraca` int(11) DEFAULT NULL,
  `Kode` varchar(2) DEFAULT NULL,
  `SubKlasifikasi` varchar(40) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.sub_klasifikasi: 28 rows
/*!40000 ALTER TABLE `sub_klasifikasi` DISABLE KEYS */;
REPLACE INTO `sub_klasifikasi` (`ID`, `ID_Klasifikasi`, `ID_Neraca`, `Kode`, `SubKlasifikasi`) VALUES
	(1, 1, 1, '00', 'Kas'),
	(2, 1, 2, '10', 'Bank'),
	(3, 1, 3, '11', 'Deposito'),
	(4, 1, 7, '20', 'Piutang Barang'),
	(5, 1, 15, '30', 'Persediaan'),
	(6, 1, NULL, '40', 'Uang Muka Kerja'),
	(7, 1, NULL, '50', 'Investasi pada USP'),
	(8, 1, NULL, '60', 'Aktiva Tetap'),
	(9, 1, NULL, '70', 'Piutang Usaha'),
	(10, 1, NULL, '80', 'Simp. Pd. BU non Kop.'),
	(11, 2, NULL, '10', 'Kewajiban Lancar'),
	(12, 2, NULL, '20', 'Pendapatan yang diterima di muka'),
	(13, 2, NULL, '30', 'Kewajiban Jangka Panjang'),
	(15, 3, NULL, '20', 'Cadangan'),
	(16, 3, NULL, '30', 'Sisa Hasil Usaha'),
	(17, 3, NULL, '10', 'Tunai'),
	(18, 3, NULL, '11', 'Giro'),
	(19, 3, NULL, '12', 'Cheque'),
	(20, 4, NULL, '10', 'Pendapatan Usaha'),
	(22, 5, NULL, '10', 'Beban Langsung'),
	(23, 5, NULL, '20', 'Beban Lain'),
	(24, 6, NULL, '10', 'Beban Usaha'),
	(25, 6, NULL, '10', 'Beban Non Usaha'),
	(26, 8, NULL, '10', 'Pendapatan Luar Usaha'),
	(27, 9, NULL, '10', 'Pengeluaran Luar Usaha'),
	(28, 1, 0, '21', 'Pinjaman Yang Diberikan'),
	(29, 1, 0, '90', 'Pajak Dibayar Dimuka'),
	(30, 3, 0, '40', 'Modal Disetor');
/*!40000 ALTER TABLE `sub_klasifikasi` ENABLE KEYS */;


-- Dumping structure for procedure setujudb.s_total_pinjaman
DROP PROCEDURE IF EXISTS `s_total_pinjaman`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `s_total_pinjaman`(IN `ID_Pi` INT)
BEGIN
	select p.pinjaman as t_pinjaman from pinjaman as p where ID=ID_Pi;
END//
DELIMITER ;


-- Dumping structure for procedure setujudb.s_total_pinjaman_bayar
DROP PROCEDURE IF EXISTS `s_total_pinjaman_bayar`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `s_total_pinjaman_bayar`(IN `ID_Pinjaman` INT)
BEGIN
	select sum(kredit) as t_setoran from pinjaman_bayar where ID_Pinjaman=ID_Pinjaman;
END//
DELIMITER ;


-- Dumping structure for table setujudb.tipe_jurnal
DROP TABLE IF EXISTS `tipe_jurnal`;
CREATE TABLE IF NOT EXISTS `tipe_jurnal` (
  `ID` int(11) DEFAULT NULL,
  `Jenis` varchar(30) DEFAULT NULL,
  `Kode` varchar(2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.tipe_jurnal: 3 rows
/*!40000 ALTER TABLE `tipe_jurnal` DISABLE KEYS */;
REPLACE INTO `tipe_jurnal` (`ID`, `Jenis`, `Kode`) VALUES
	(1, 'Jurnal Umum', 'GJ'),
	(2, 'Jurnal SHU', 'SJ'),
	(3, 'Jurnal Umum', 'GJ');
/*!40000 ALTER TABLE `tipe_jurnal` ENABLE KEYS */;


-- Dumping structure for table setujudb.tipe_transaksi
DROP TABLE IF EXISTS `tipe_transaksi`;
CREATE TABLE IF NOT EXISTS `tipe_transaksi` (
  `ID` int(11) DEFAULT NULL,
  `Tipe` varchar(6) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.tipe_transaksi: 2 rows
/*!40000 ALTER TABLE `tipe_transaksi` DISABLE KEYS */;
REPLACE INTO `tipe_transaksi` (`ID`, `Tipe`) VALUES
	(1, 'Debet'),
	(2, 'Kredit');
/*!40000 ALTER TABLE `tipe_transaksi` ENABLE KEYS */;


-- Dumping structure for table setujudb.tmp_kasir_transaksi_rekap
DROP TABLE IF EXISTS `tmp_kasir_transaksi_rekap`;
CREATE TABLE IF NOT EXISTS `tmp_kasir_transaksi_rekap` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Jurnal` int(11) DEFAULT NULL,
  `ID_Perkiraan` int(11) DEFAULT NULL,
  `ID_Dept_T` int(11) DEFAULT NULL,
  `Debet` double DEFAULT NULL,
  `Kredit` double DEFAULT NULL,
  `Keterangan` varchar(100) DEFAULT NULL,
  `ID_P` int(11) DEFAULT NULL,
  `ID_Klas` int(11) DEFAULT NULL,
  `ID_SubKlas` int(11) DEFAULT NULL,
  `ID_Dept` int(11) DEFAULT NULL,
  `ID_Unit` int(11) DEFAULT NULL,
  `ID_Laporan` int(11) DEFAULT NULL,
  `ID_LapDetail` int(11) DEFAULT NULL,
  `ID_Agt` int(11) DEFAULT NULL,
  `ID_Calc` int(11) DEFAULT NULL,
  `ID_Simpanan` int(11) DEFAULT NULL,
  `NoUrut_P` int(11) DEFAULT NULL,
  `Kode` varchar(4) DEFAULT NULL,
  `Perkiraan` varchar(50) DEFAULT NULL,
  `SaldoAwal` double DEFAULT NULL,
  `ID_J` int(11) DEFAULT NULL,
  `ID_Unit_J` int(11) DEFAULT NULL,
  `ID_Tipe` int(11) DEFAULT NULL,
  `ID_Dept_J` int(11) DEFAULT NULL,
  `Tanggal` date DEFAULT NULL,
  `ID_Bulan` smallint(6) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `NoUrut` int(11) DEFAULT NULL,
  `Nomor` varchar(10) DEFAULT NULL,
  `Keterangan_J` varchar(60) DEFAULT NULL,
  `ID_Mark` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.tmp_kasir_transaksi_rekap: 0 rows
/*!40000 ALTER TABLE `tmp_kasir_transaksi_rekap` DISABLE KEYS */;
/*!40000 ALTER TABLE `tmp_kasir_transaksi_rekap` ENABLE KEYS */;


-- Dumping structure for table setujudb.tmp_superuser_neraca_balance
DROP TABLE IF EXISTS `tmp_superuser_neraca_balance`;
CREATE TABLE IF NOT EXISTS `tmp_superuser_neraca_balance` (
  `unit` int(10) NOT NULL DEFAULT '0',
  `periode` date NOT NULL DEFAULT '0000-00-00',
  `Aktiva` double DEFAULT '0',
  `Aktiva2` double DEFAULT '0',
  `Pasiva` double DEFAULT '0',
  `Pasiva2` double DEFAULT '0',
  PRIMARY KEY (`periode`,`unit`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.tmp_superuser_neraca_balance: 0 rows
/*!40000 ALTER TABLE `tmp_superuser_neraca_balance` DISABLE KEYS */;
/*!40000 ALTER TABLE `tmp_superuser_neraca_balance` ENABLE KEYS */;


-- Dumping structure for table setujudb.tmp_superuser_total_shu
DROP TABLE IF EXISTS `tmp_superuser_total_shu`;
CREATE TABLE IF NOT EXISTS `tmp_superuser_total_shu` (
  `tglAwal` date DEFAULT NULL,
  `tglAkhir` date DEFAULT NULL,
  `saldo` double DEFAULT '0',
  `saldo2` double DEFAULT '0',
  `unit` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`unit`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.tmp_superuser_total_shu: 0 rows
/*!40000 ALTER TABLE `tmp_superuser_total_shu` DISABLE KEYS */;
/*!40000 ALTER TABLE `tmp_superuser_total_shu` ENABLE KEYS */;


-- Dumping structure for table setujudb.tmp_superuser_transaksi_rekap
DROP TABLE IF EXISTS `tmp_superuser_transaksi_rekap`;
CREATE TABLE IF NOT EXISTS `tmp_superuser_transaksi_rekap` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Jurnal` int(11) DEFAULT NULL,
  `ID_Perkiraan` int(11) DEFAULT NULL,
  `ID_Dept_T` int(11) DEFAULT NULL,
  `Debet` double DEFAULT NULL,
  `Kredit` double DEFAULT NULL,
  `Keterangan` varchar(100) DEFAULT NULL,
  `ID_P` int(11) DEFAULT NULL,
  `ID_Klas` int(11) DEFAULT NULL,
  `ID_SubKlas` int(11) DEFAULT NULL,
  `ID_Dept` int(11) DEFAULT NULL,
  `ID_Unit` int(11) DEFAULT NULL,
  `ID_Laporan` int(11) DEFAULT NULL,
  `ID_LapDetail` int(11) DEFAULT NULL,
  `ID_Agt` int(11) DEFAULT NULL,
  `ID_Calc` int(11) DEFAULT NULL,
  `ID_Simpanan` int(11) DEFAULT NULL,
  `NoUrut_P` int(11) DEFAULT NULL,
  `Kode` varchar(4) DEFAULT NULL,
  `Perkiraan` varchar(50) DEFAULT NULL,
  `SaldoAwal` double DEFAULT NULL,
  `ID_J` int(11) DEFAULT NULL,
  `ID_Unit_J` int(11) DEFAULT NULL,
  `ID_Tipe` int(11) DEFAULT NULL,
  `ID_Dept_J` int(11) DEFAULT NULL,
  `Tanggal` date DEFAULT NULL,
  `ID_Bulan` smallint(6) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `NoUrut` int(11) DEFAULT NULL,
  `Nomor` varchar(10) DEFAULT NULL,
  `Keterangan_J` varchar(60) DEFAULT NULL,
  `ID_Mark` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.tmp_superuser_transaksi_rekap: 0 rows
/*!40000 ALTER TABLE `tmp_superuser_transaksi_rekap` DISABLE KEYS */;
/*!40000 ALTER TABLE `tmp_superuser_transaksi_rekap` ENABLE KEYS */;


-- Dumping structure for table setujudb.tmp__transaksi_rekap
DROP TABLE IF EXISTS `tmp__transaksi_rekap`;
CREATE TABLE IF NOT EXISTS `tmp__transaksi_rekap` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Jurnal` int(11) DEFAULT NULL,
  `ID_Perkiraan` int(11) DEFAULT NULL,
  `ID_Dept_T` int(11) DEFAULT NULL,
  `Debet` double DEFAULT NULL,
  `Kredit` double DEFAULT NULL,
  `Keterangan` varchar(100) DEFAULT NULL,
  `ID_P` int(11) DEFAULT NULL,
  `ID_Klas` int(11) DEFAULT NULL,
  `ID_SubKlas` int(11) DEFAULT NULL,
  `ID_Dept` int(11) DEFAULT NULL,
  `ID_Unit` int(11) DEFAULT NULL,
  `ID_Laporan` int(11) DEFAULT NULL,
  `ID_LapDetail` int(11) DEFAULT NULL,
  `ID_Agt` int(11) DEFAULT NULL,
  `ID_Calc` int(11) DEFAULT NULL,
  `ID_Simpanan` int(11) DEFAULT NULL,
  `NoUrut_P` int(11) DEFAULT NULL,
  `Kode` varchar(4) DEFAULT NULL,
  `Perkiraan` varchar(50) DEFAULT NULL,
  `SaldoAwal` double DEFAULT NULL,
  `ID_J` int(11) DEFAULT NULL,
  `ID_Unit_J` int(11) DEFAULT NULL,
  `ID_Tipe` int(11) DEFAULT NULL,
  `ID_Dept_J` int(11) DEFAULT NULL,
  `Tanggal` date DEFAULT NULL,
  `ID_Bulan` smallint(6) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `NoUrut` int(11) DEFAULT NULL,
  `Nomor` varchar(10) DEFAULT NULL,
  `Keterangan_J` varchar(60) DEFAULT NULL,
  `ID_Mark` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.tmp__transaksi_rekap: 0 rows
/*!40000 ALTER TABLE `tmp__transaksi_rekap` DISABLE KEYS */;
/*!40000 ALTER TABLE `tmp__transaksi_rekap` ENABLE KEYS */;


-- Dumping structure for table setujudb.transaksi
DROP TABLE IF EXISTS `transaksi`;
CREATE TABLE IF NOT EXISTS `transaksi` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Jurnal` int(11) DEFAULT NULL,
  `ID_Perkiraan` int(11) DEFAULT NULL,
  `ID_Dept` int(11) DEFAULT NULL,
  `Debet` double DEFAULT NULL,
  `Kredit` double DEFAULT NULL,
  `Keterangan` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.transaksi: 0 rows
/*!40000 ALTER TABLE `transaksi` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaksi` ENABLE KEYS */;


-- Dumping structure for table setujudb.transaksi_del
DROP TABLE IF EXISTS `transaksi_del`;
CREATE TABLE IF NOT EXISTS `transaksi_del` (
  `ID` int(11) DEFAULT NULL,
  `ID_Jurnal` int(11) DEFAULT NULL,
  `ID_Perkiraan` int(11) DEFAULT NULL,
  `ID_Dept` int(11) DEFAULT NULL,
  `Debet` double DEFAULT NULL,
  `Kredit` double DEFAULT NULL,
  `Keterangan` varchar(100) DEFAULT NULL,
  `ID_Unit` int(11) DEFAULT NULL,
  `ID_Tipe` int(11) DEFAULT NULL,
  `Tanggal` datetime DEFAULT NULL,
  `ID_Bulan` smallint(6) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `NoUrut` int(11) DEFAULT NULL,
  `Nomor` varchar(10) DEFAULT NULL,
  `Ket` varchar(60) DEFAULT NULL,
  `ID_Mark` tinyint(4) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Dumping data for table setujudb.transaksi_del: 0 rows
/*!40000 ALTER TABLE `transaksi_del` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaksi_del` ENABLE KEYS */;


-- Dumping structure for table setujudb.transaksi_log
DROP TABLE IF EXISTS `transaksi_log`;
CREATE TABLE IF NOT EXISTS `transaksi_log` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `ID_Trans` varchar(50) DEFAULT NULL,
  `Keterangan` text,
  `old_val` varchar(50) DEFAULT NULL,
  `new_val` varchar(50) DEFAULT NULL,
  `tanggal` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=latin1 COMMENT='log transaksi user';

-- Dumping data for table setujudb.transaksi_log: 29 rows
/*!40000 ALTER TABLE `transaksi_log` DISABLE KEYS */;
REPLACE INTO `transaksi_log` (`ID`, `ID_Trans`, `Keterangan`, `old_val`, `new_val`, `tanggal`, `created_by`) VALUES
	(1, '12', 'Delete Pembayaran Giro no. Faktur: 00025-2012', '35000', '0', '2012-10-18 12:36:45', '22658052389863424'),
	(2, '12', 'Delete Pembayaran Giro no. Faktur: 00025-2012', '35000', '0', '2012-10-18 12:37:44', '22658052389863425'),
	(3, '12', 'Delete Pembayaran Giro no. Faktur: 00025-2012', '35000', '0', '2012-10-18 12:44:37', '22658052389863426'),
	(4, '12', 'Delete Pembayaran Giro no. Faktur: 00025-2012', '35000', '0', '2012-10-18 12:45:46', '22658052389863427'),
	(5, '12', 'Delete Pembayaran Giro no. Faktur: 00025-2012', '35000', '0', '2012-10-18 12:46:24', '22658052389863428'),
	(6, '12', 'Delete Pembayaran Giro no. Faktur: 00025-2012', '35000', '0', '2012-10-18 12:47:39', '22658052389863429'),
	(7, '12', 'Delete Pembayaran Giro no. Faktur: 00025-2012', '35000', '0', '2012-10-18 12:50:49', '22658052389863430'),
	(8, '12', 'Delete Pembayaran Giro no. Faktur: 00025-2012', '35000', '0', '2012-10-18 12:52:48', '22658052389863431'),
	(9, '13', 'Delete Pembayaran Cheque no. Faktur: 00026-2012', '35000', '0', '2012-10-18 14:14:55', '22658052389863432'),
	(10, '12', 'Delete Pembayaran Giro no. Faktur: 00025-2012', '35000', '0', '2012-10-18 14:16:20', '22658052389863433'),
	(11, '13', 'Delete Pembayaran Cheque no. Faktur: 00027-2012', '35000', '0', '2012-10-18 14:16:23', '22658052389863434'),
	(12, '12', 'Delete Pembayaran Giro no. Faktur: 00027-2012', '35000', '0', '2012-10-18 14:17:18', '22658052389863435'),
	(13, '14', 'Delete Pembayaran Ke 4', '0', '10000', '2012-10-18 23:16:02', '22658869742272512'),
	(14, '14', 'Delete Pembayaran Ke 4', '0', '10000', '2012-10-19 00:33:06', '22658869742272513'),
	(15, '11', 'Delete Pembayaran Giro no. Faktur: 00029-2012', '35000', '0', '2012-10-19 21:56:31', '22660267166924800'),
	(16, '2', 'Delete Pembayaran Giro no. Faktur: 00032-2012', '35000', '0', '2012-10-19 22:02:55', '22660267166924801'),
	(17, '2', 'Delete Pembayaran Giro no. Faktur: 00032-2012', '35000', '0', '2012-10-19 22:03:59', '22660267166924802'),
	(18, '2', 'Delete Pembayaran Giro no. Faktur: 00032-2012', '35000', '0', '2012-10-19 22:05:42', '22660267166924803'),
	(19, '11', 'Delete Pembayaran Giro no. Faktur: 00031-2012', '35000', '0', '2012-10-19 22:16:32', '22660267166924804'),
	(20, '11', 'Delete Pembayaran Giro no. Faktur: 00034-2012', '35000', '0', '2012-10-19 22:50:03', '22660267166924805'),
	(21, '2', 'Delete Pembayaran Giro no. Faktur: 00032-2012', '35000', '0', '2012-10-20 11:01:49', '22660267166924806'),
	(22, '12', 'Delete Pembayaran Giro no. Faktur: 00027-2012', '35000', '0', '2012-10-20 11:08:21', '22660267166924807'),
	(23, '13', 'Delete Pembayaran Cheque no. Faktur: 00027-2012', '35000', '0', '2012-10-20 11:08:42', '22660267166924808'),
	(24, '13', 'Delete Pembayaran Kredit no. Faktur: 00044-2012', '35000', '0', '2012-10-20 11:08:53', '22660267166924809'),
	(25, '26', 'Delete Pembelian  no. Faktur: BT-0000-12', '35000', '0', '2012-10-24 14:46:43', '22667049440378880'),
	(26, '18', 'Update Pembayaran Tunai no. Faktur: 00000-2012', '150000', '0', '2012-10-24 14:50:52', 'superuser'),
	(27, '25', 'Update Sumbangan Masjid', '25000', '0', '2012-10-24 16:13:20', 'superuser'),
	(28, '25', 'Update Beli Snack', '0', '25000', '2012-10-24 16:13:21', 'superuser'),
	(29, '25', 'Update Beli Snack', '0', '25000', '2012-10-24 16:18:35', 'superuser'),
	(30, '28', 'Delete Penjualan Tunai no. Faktur: 00015-2012', '0', '30000', '2012-10-25 14:24:35', '22667049440378881'),
	(31, '4', 'Delete Penjualan Kredit no. Faktur: 00005-2012', '0', '30000', '2012-10-25 14:26:56', '22667049440378882'),
	(32, '4', 'Delete Penjualan Kredit no. Faktur: 00025-2012', '0', '30000', '2012-10-25 14:28:04', '22667049440378883'),
	(33, '16', 'Update Pembayaran Ke 1', '0', '50000', '2012-10-25 14:35:37', 'superuser'),
	(34, '12', 'Delete Penjualan Giro no. Faktur: 00023-2012', '0', '30000', '2012-10-25 14:40:58', '22667049440378884'),
	(35, '4', 'Update Pembayaran Ke 1', '0', '30000', '2012-10-25 14:41:21', 'superuser');
/*!40000 ALTER TABLE `transaksi_log` ENABLE KEYS */;


-- Dumping structure for table setujudb.transaksi_new
DROP TABLE IF EXISTS `transaksi_new`;
CREATE TABLE IF NOT EXISTS `transaksi_new` (
  `ID` int(11) DEFAULT NULL,
  `ID_Jurnal` int(11) DEFAULT NULL,
  `ID_Perkiraan` int(11) DEFAULT NULL,
  `ID_Dept` int(11) DEFAULT NULL,
  `Debet` double DEFAULT NULL,
  `Kredit` double DEFAULT NULL,
  `Keterangan` varchar(100) DEFAULT NULL,
  `ID_Unit` int(11) DEFAULT NULL,
  `ID_Tipe` int(11) DEFAULT NULL,
  `Tanggal` datetime DEFAULT NULL,
  `ID_Bulan` smallint(6) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `NoUrut` int(11) DEFAULT NULL,
  `Nomor` varchar(10) DEFAULT NULL,
  `Ket` varchar(60) DEFAULT NULL,
  `ID_Mark` tinyint(4) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.transaksi_new: 0 rows
/*!40000 ALTER TABLE `transaksi_new` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaksi_new` ENABLE KEYS */;


-- Dumping structure for table setujudb.transaksi_rekap
DROP TABLE IF EXISTS `transaksi_rekap`;
CREATE TABLE IF NOT EXISTS `transaksi_rekap` (
  `ID` int(11) NOT NULL,
  `ID_Jurnal` int(11) DEFAULT NULL,
  `ID_Perkiraan` int(11) DEFAULT NULL,
  `ID_Dept_T` int(11) DEFAULT NULL,
  `Debet` double DEFAULT NULL,
  `Kredit` double DEFAULT NULL,
  `Keterangan` varchar(100) DEFAULT NULL,
  `ID_P` int(11) DEFAULT NULL,
  `ID_Klas` int(11) DEFAULT NULL,
  `ID_SubKlas` int(11) DEFAULT NULL,
  `ID_Dept` int(11) DEFAULT NULL,
  `ID_Unit` int(11) DEFAULT NULL,
  `ID_Laporan` int(11) DEFAULT NULL,
  `ID_LapDetail` int(11) DEFAULT NULL,
  `ID_Agt` int(11) DEFAULT NULL,
  `ID_Calc` int(11) DEFAULT NULL,
  `ID_Simpanan` int(11) DEFAULT NULL,
  `NoUrut_P` int(11) DEFAULT NULL,
  `Kode` varchar(4) DEFAULT NULL,
  `Perkiraan` varchar(50) DEFAULT NULL,
  `SaldoAwal` double DEFAULT NULL,
  `ID_J` int(11) DEFAULT NULL,
  `ID_Unit_J` int(11) DEFAULT NULL,
  `ID_Tipe` int(11) DEFAULT NULL,
  `ID_Dept_J` int(11) DEFAULT NULL,
  `Tanggal` date DEFAULT NULL,
  `ID_Bulan` smallint(6) DEFAULT NULL,
  `Tahun` smallint(6) DEFAULT NULL,
  `NoUrut` int(11) DEFAULT NULL,
  `Nomor` varchar(10) DEFAULT NULL,
  `Keterangan_J` varchar(60) DEFAULT NULL,
  `ID_Mark` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.transaksi_rekap: 0 rows
/*!40000 ALTER TABLE `transaksi_rekap` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaksi_rekap` ENABLE KEYS */;


-- Dumping structure for table setujudb.transaksi_temp
DROP TABLE IF EXISTS `transaksi_temp`;
CREATE TABLE IF NOT EXISTS `transaksi_temp` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `ID_Unit` int(10) DEFAULT NULL,
  `ID_Dept` int(10) DEFAULT NULL,
  `ID_Klas` int(10) DEFAULT NULL,
  `ID_SubKlas` int(10) DEFAULT NULL,
  `ID_CC` int(10) DEFAULT NULL,
  `ID_Perkiraan` int(10) NOT NULL DEFAULT '0',
  `Debet` double NOT NULL DEFAULT '0',
  `Kredit` double NOT NULL DEFAULT '0',
  `Keterangan` text,
  `ID_Bulan` varchar(50) NOT NULL DEFAULT '',
  `Tahun` varchar(50) NOT NULL DEFAULT '',
  `Tanggal` date DEFAULT '0000-00-00',
  `created_by` varchar(50) NOT NULL,
  `ID_Stat` int(10) DEFAULT '0',
  PRIMARY KEY (`ID_Perkiraan`,`Debet`,`Kredit`,`ID_Bulan`,`Tahun`),
  UNIQUE KEY `ID` (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=latin1 COMMENT='pencatatan transaksi sebelum posting ke jurnal';

-- Dumping data for table setujudb.transaksi_temp: 20 rows
/*!40000 ALTER TABLE `transaksi_temp` DISABLE KEYS */;
REPLACE INTO `transaksi_temp` (`ID`, `ID_Unit`, `ID_Dept`, `ID_Klas`, `ID_SubKlas`, `ID_CC`, `ID_Perkiraan`, `Debet`, `Kredit`, `Keterangan`, `ID_Bulan`, `Tahun`, `Tanggal`, `created_by`, `ID_Stat`) VALUES
	(1, 1, 1, 6, 24, 5, 25, 0, 0, 'Beli Snack', '10', '2012', '2012-10-24', 'superuser', 0),
	(3, 1, 0, 1, 5, 4, 26, 25000, 0, 'Pembelian  no. Faktur: 3344565', '10', '2012', '2012-10-24', 'superuser', 0),
	(4, 1, 0, 1, 5, 4, 26, 35000, 0, 'Pembelian  no. Faktur: 3344565', '10', '2012', '2012-10-24', 'superuser', 0),
	(5, 1, 1, 4, 17, 1, 18, 0, 150000, 'Pembayaran Tunai no. Faktur: 00000-2012', '10', '2012', '2012-10-24', 'superuser', 0),
	(6, 1, 1, 4, 18, 1, 2, 900000, 0, 'Pembayaran Giro no. Faktur: 00001-2012', '10', '2012', '2012-10-24', 'superuser', 0),
	(7, 1, 1, 4, 28, 1, 5, 0, 750000, 'Penjualan Return no. Faktur: RK-00002-2012', '10', '2012', '2012-10-24', 'superuser', 0),
	(8, 1, 1, 4, 18, 1, 12, 0, 150000, 'Penjualan Giro no. Faktur: 00003-2012', '10', '2012', '2012-10-24', 'superuser', 0),
	(9, 1, 1, 4, 19, 1, 16, 0, 600000, 'Penjualan Cheque no. Faktur: 00004-2012', '10', '2012', '2012-10-24', 'superuser', 0),
	(31, 1, 1, 4, 4, 7, 4, 0, 30000, 'Pembayaran Ke 1', '10', '2012', '2012-10-25', 'superuser', 0),
	(11, 1, 0, 4, 28, 1, 27, 0, 30000, 'Penjualan Return no. Faktur: RK-00009-2012', '10', '2012', '2012-10-24', 'superuser', 0),
	(12, 1, 0, 4, 28, 1, 27, 0, 150000, 'Penjualan Return no. Faktur: RK-00010-2012', '10', '2012', '2012-10-24', 'superuser', 0),
	(13, 1, 0, 4, 28, 1, 27, 150000, 0, 'Penjualan Return no. Faktur: RK-00011-2012', '10', '2012', '2012-10-24', 'superuser', 0),
	(14, 1, 0, 4, 28, 1, 27, 60000, 0, '', '10', '2012', '2012-10-24', 'superuser', 0),
	(15, 1, 0, 4, 28, 1, 27, 30000, 0, '', '10', '2012', '2012-10-24', 'superuser', 0),
	(16, 1, 0, 4, 28, 1, 27, 120000, 0, 'Pembayaran Retur Barang tanggal 24/10/2012', '10', '2012', '2012-10-24', 'superuser', 0),
	(25, 1, 0, 4, 17, 1, 28, 0, 30000, 'Penjualan Tunai no. Faktur: 00022-2012', '10', '2012', '2012-10-25', 'superuser', 0),
	(18, 1, 1, 6, 24, 5, 25, 25000, 0, 'Sumbangan Masjid', '10', '2012', '2012-10-24', 'superuser', 0),
	(19, 1, 0, 4, 18, 1, 12, 0, 1320000, 'Penjualan Giro no. Faktur: 00016-2012', '10', '2012', '2012-10-24', 'superuser', 0),
	(20, 1, 0, 4, 17, 1, 28, 0, 900000, 'Penjualan Tunai no. Faktur: 00017-2012', '10', '2012', '2012-10-24', 'superuser', 0),
	(21, 1, 0, 4, 17, 1, 1, 0, 40000, 'Penjualan Tunai no. Faktur: 00018-2012', '10', '2012', '2012-10-25', 'superuser', 0),
	(22, 1, 0, 4, 17, 1, 1, 0, 600000, 'Penjualan Tunai no. Faktur: 00019-2012', '10', '2012', '2012-10-25', 'superuser', 0),
	(23, 1, 0, 4, 17, 1, 1, 0, 150000, 'Penjualan Tunai no. Faktur: 00020-2012', '10', '2012', '2012-10-25', 'superuser', 0),
	(24, 1, 0, 4, 17, 1, 1, 0, 30000, 'Penjualan Tunai no. Faktur: 00021-2012', '10', '2012', '2012-10-25', 'superuser', 0),
	(32, 1, 1, 4, 18, 7, 12, 0, 30000, 'Pembayaran Ke 1 a/n BAMBANG SUDJATMIKO', '10', '2012', '2012-10-25', 'superuser', 0),
	(27, 1, 0, 4, 19, 1, 16, 0, 150000, 'Penjualan Cheque no. Faktur: 00024-2012', '10', '2012', '2012-10-25', 'superuser', 0),
	(29, 1, 0, 4, 28, 1, 24, 120000, 0, 'Pembayaran Retur Barang tanggal 25/10/2012', '10', '2012', '2012-10-25', 'superuser', 0),
	(30, 1, 1, 4, 19, 7, 16, 0, 50000, 'Pembayaran Ke 1', '10', '2012', '2012-10-25', 'superuser', 0),
	(33, 1, 0, 4, 18, 1, 11, 0, 1800000, 'Penjualan Giro no. Faktur: 00027-2012', '10', '2012', '2012-10-25', 'superuser', 0),
	(34, 1, 1, 6, 24, 5, 25, 450000, 0, 'Hilang', '10', '2012', '2012-10-25', 'superuser', 0);
/*!40000 ALTER TABLE `transaksi_temp` ENABLE KEYS */;


-- Dumping structure for table setujudb.unit_jurnal
DROP TABLE IF EXISTS `unit_jurnal`;
CREATE TABLE IF NOT EXISTS `unit_jurnal` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Kode` varchar(2) DEFAULT NULL,
  `Unit` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`Unit`),
  KEY `ID` (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.unit_jurnal: 1 rows
/*!40000 ALTER TABLE `unit_jurnal` DISABLE KEYS */;
REPLACE INTO `unit_jurnal` (`ID`, `Kode`, `Unit`) VALUES
	(1, '1', 'SETUJU');
/*!40000 ALTER TABLE `unit_jurnal` ENABLE KEYS */;


-- Dumping structure for table setujudb.useroto
DROP TABLE IF EXISTS `useroto`;
CREATE TABLE IF NOT EXISTS `useroto` (
  `userid` varchar(50) NOT NULL DEFAULT '',
  `idmenu` varchar(50) NOT NULL DEFAULT '',
  `c` enum('Y','N') DEFAULT 'N',
  `e` enum('Y','N') DEFAULT 'N',
  `v` enum('Y','N') DEFAULT 'N',
  `p` enum('Y','N') DEFAULT 'N',
  `d` enum('Y','N') DEFAULT 'N',
  PRIMARY KEY (`idmenu`,`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.useroto: 19 rows
/*!40000 ALTER TABLE `useroto` DISABLE KEYS */;
REPLACE INTO `useroto` (`userid`, `idmenu`, `c`, `e`, `v`, `p`, `d`) VALUES
	('', 'master__vendor_n', 'Y', 'Y', 'N', 'N', 'N'),
	('', 'master__vendor_l', 'N', 'Y', 'N', 'N', 'N'),
	('2', 'stock__index', 'N', 'N', 'Y', 'Y', 'N'),
	('2', 'liststock', 'N', 'N', 'Y', 'Y', 'N'),
	('2', 'countsheet', 'N', 'N', 'Y', 'Y', 'N'),
	('2', 'stocklimit', 'N', 'N', 'Y', 'Y', 'N'),
	('', 'daftarpembelian', 'N', 'N', 'Y', 'N', 'N'),
	('2', 'daftarpembelian', 'N', 'N', 'Y', 'Y', 'N'),
	('2', 'detailpembelian', 'N', 'N', 'Y', 'Y', 'N'),
	('2', 'adduser', 'Y', 'Y', 'N', 'N', 'N'),
	('2', 'listuser', 'N', 'Y', 'Y', 'N', 'N'),
	('2', 'authorisation', 'Y', 'N', 'Y', 'N', 'N'),
	('2', 'rekappenjualan', 'N', 'N', 'Y', 'Y', 'N'),
	('2', 'penjualanperpelanggan', 'N', 'N', 'Y', 'Y', 'N'),
	('2', 'detailpenjualan', 'N', 'N', 'Y', 'Y', 'N'),
	('2', 'topbarangterjual', 'N', 'N', 'Y', 'Y', 'N'),
	('2', 'grafikpenjualan', 'N', 'N', 'Y', 'Y', 'N'),
	('2', 'pembelianpervendor', 'N', 'N', 'Y', 'Y', 'N'),
	('2', 'grafikpembelian', 'N', 'N', 'Y', 'Y', 'N');
/*!40000 ALTER TABLE `useroto` ENABLE KEYS */;


-- Dumping structure for table setujudb.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `userid` varchar(50) NOT NULL DEFAULT '',
  `username` varchar(200) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `idlevel` varchar(50) DEFAULT NULL,
  `active` enum('Y','N') DEFAULT 'Y',
  `createdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.users: 2 rows
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
REPLACE INTO `users` (`userid`, `username`, `password`, `idlevel`, `active`, `createdate`) VALUES
	('superuser', 'superuser', '8b5e22ec5b6020776fc7f5ec4897ac52', '1', 'Y', '2012-10-01 11:05:01'),
	('Admin', 'Setuju', 'e0e58e22350c06fd9465f29741c96b4a', '2', 'Y', '2012-10-01 15:08:42');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;


-- Dumping structure for table setujudb.user_level
DROP TABLE IF EXISTS `user_level`;
CREATE TABLE IF NOT EXISTS `user_level` (
  `idlevel` int(50) NOT NULL AUTO_INCREMENT,
  `nmlevel` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`idlevel`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.user_level: 3 rows
/*!40000 ALTER TABLE `user_level` DISABLE KEYS */;
REPLACE INTO `user_level` (`idlevel`, `nmlevel`) VALUES
	(1, 'Super User'),
	(2, 'Administrator'),
	(3, 'Kasir');
/*!40000 ALTER TABLE `user_level` ENABLE KEYS */;


-- Dumping structure for table setujudb.v_dept_trans
DROP TABLE IF EXISTS `v_dept_trans`;
CREATE TABLE IF NOT EXISTS `v_dept_trans` (
  `ID_Dept` int(10) NOT NULL DEFAULT '0',
  `ID_Klas` int(10) DEFAULT NULL,
  `ID_SubKlas` int(10) DEFAULT NULL,
  `ID_Perkiraan` int(10) NOT NULL DEFAULT '0',
  `ID_Bulan` int(10) NOT NULL DEFAULT '0',
  `ID_Tahun` int(10) NOT NULL DEFAULT '0',
  `SaldoAwal` double DEFAULT '0',
  `Kredit` double DEFAULT '0',
  `Debet` double DEFAULT '0',
  PRIMARY KEY (`ID_Perkiraan`,`ID_Dept`,`ID_Bulan`,`ID_Tahun`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='summary transaksi by simpanan by departemen';

-- Dumping data for table setujudb.v_dept_trans: 0 rows
/*!40000 ALTER TABLE `v_dept_trans` DISABLE KEYS */;
/*!40000 ALTER TABLE `v_dept_trans` ENABLE KEYS */;


-- Dumping structure for table setujudb.v_neraca
DROP TABLE IF EXISTS `v_neraca`;
CREATE TABLE IF NOT EXISTS `v_neraca` (
  `ID_Head` int(10) DEFAULT NULL,
  `ID_Jenis` int(10) DEFAULT NULL,
  `ID_SubJenis` int(10) NOT NULL DEFAULT '0',
  `SubJenis` varchar(200) DEFAULT NULL,
  `ID_Calc` int(10) DEFAULT NULL,
  `ID_KBR` int(10) DEFAULT NULL,
  `ID_USP` int(10) DEFAULT NULL,
  `Debet` double DEFAULT '0',
  `Kredit` double DEFAULT '0',
  `SaldoAwal` double DEFAULT '0',
  `SaldoAkhir` double DEFAULT '0',
  PRIMARY KEY (`ID_SubJenis`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='membentuk laporan neraca';

-- Dumping data for table setujudb.v_neraca: 0 rows
/*!40000 ALTER TABLE `v_neraca` DISABLE KEYS */;
/*!40000 ALTER TABLE `v_neraca` ENABLE KEYS */;


-- Dumping structure for table setujudb.v_neraca_lajur
DROP TABLE IF EXISTS `v_neraca_lajur`;
CREATE TABLE IF NOT EXISTS `v_neraca_lajur` (
  `ID_Dept` varchar(250) NOT NULL DEFAULT '',
  `SaldoAwal` double DEFAULT '0',
  `Simp_Pokok` double DEFAULT '0',
  `Simp_Wajib` double DEFAULT '0',
  `Simp_Khusus` double DEFAULT '0',
  `Barang` double DEFAULT '0',
  `Pinjaman` double DEFAULT '0',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Dept`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.v_neraca_lajur: 0 rows
/*!40000 ALTER TABLE `v_neraca_lajur` DISABLE KEYS */;
/*!40000 ALTER TABLE `v_neraca_lajur` ENABLE KEYS */;


-- Dumping structure for table setujudb.v_superuser_neraca_lajur
DROP TABLE IF EXISTS `v_superuser_neraca_lajur`;
CREATE TABLE IF NOT EXISTS `v_superuser_neraca_lajur` (
  `ID_Dept` varchar(250) NOT NULL DEFAULT '',
  `SaldoAwal` double DEFAULT '0',
  `Simp_Pokok` double DEFAULT '0',
  `Simp_Wajib` double DEFAULT '0',
  `Simp_Khusus` double DEFAULT '0',
  `Barang` double DEFAULT '0',
  `Pinjaman` double DEFAULT '0',
  `doc_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Dept`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table setujudb.v_superuser_neraca_lajur: 0 rows
/*!40000 ALTER TABLE `v_superuser_neraca_lajur` DISABLE KEYS */;
/*!40000 ALTER TABLE `v_superuser_neraca_lajur` ENABLE KEYS */;


-- Dumping structure for trigger setujudb.mst_kas_t_del
DROP TRIGGER IF EXISTS `mst_kas_t_del`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `mst_kas_t_del` AFTER DELETE ON `mst_kas_harian` FOR EACH ROW BEGIN
	delete from mst_kas_trans where id_trans=old.no_trans;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.mst_kas_t_new
DROP TRIGGER IF EXISTS `mst_kas_t_new`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `mst_kas_t_new` AFTER INSERT ON `mst_kas_harian` FOR EACH ROW BEGIN
	insert into mst_kas_trans (id_trans,id_kas,tgl_trans,uraian_trans,saldo_kas)
	values(New.no_trans,new.id_kas,new.tgl_kas,'Saldo Awal hari ini',new.sa_kas);
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.pembelian_del
DROP TRIGGER IF EXISTS `pembelian_del`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `pembelian_del` AFTER DELETE ON `inv_pembelian_detail` FOR EACH ROW BEGIN
	delete from inv_pembelian_rekap where ID=OLD.ID;
	update inv_pembelian set ID_Bayar=(ID_Bayar-(OLD.Jumlah*OLD.Harga_Beli)) where
	ID=OLD.ID_Beli;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.pembelian_new
DROP TRIGGER IF EXISTS `pembelian_new`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `pembelian_new` AFTER INSERT ON `inv_pembelian_detail` FOR EACH ROW BEGIN
	insert into inv_pembelian_rekap select * from inv_pembelian_detail where ID=New.ID;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.pembelian_upd
DROP TRIGGER IF EXISTS `pembelian_upd`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `pembelian_upd` AFTER UPDATE ON `inv_pembelian_detail` FOR EACH ROW BEGIN
	update inv_pembelian_rekap set jml_faktur=new.jml_faktur,jumlah=new.jumlah,
	harga_beli=round(new.jumlah/new.jml_faktur,-1)
	where id=Old.ID;
	
	/*otomatis update field ID_Bayar)
	update inv_pembelian set ID_Bayar=(ID_Bayar-OLD.Jumlah) where ID=NEW.ID_Beli;
	*/
	update inv_pembelian set ID_Bayar=(ID_Bayar+NEW.Jumlah) where ID=NEW.ID_Beli;

END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.pembelian_upd_bfr
DROP TRIGGER IF EXISTS `pembelian_upd_bfr`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `pembelian_upd_bfr` BEFORE UPDATE ON `inv_pembelian_detail` FOR EACH ROW BEGIN
 UPDATE inv_pembelian set ID_Bayar=(ID_Bayar-OLD.Jumlah)
 WHERE ID=OLD.ID_Beli;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.penjualan_del
DROP TRIGGER IF EXISTS `penjualan_del`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `penjualan_del` AFTER DELETE ON `inv_penjualan_detail` FOR EACH ROW BEGIN
	delete from inv_penjualan_rekap where ID=OLD.ID;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.penjualan_del_header
DROP TRIGGER IF EXISTS `penjualan_del_header`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `penjualan_del_header` AFTER DELETE ON `inv_penjualan` FOR EACH ROW BEGIN
	delete from inv_penjualan_detail where ID_Jual=OLD.ID;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.penjualan_new
DROP TRIGGER IF EXISTS `penjualan_new`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `penjualan_new` AFTER INSERT ON `inv_penjualan_detail` FOR EACH ROW BEGIN
	insert into inv_penjualan_rekap
	(ID,ID_Jenis,Tanggal,Bulan,Tahun,ID_Jual,ID_Barang,Jumlah,Harga,Keterangan,no_transaksi)
	values(  
	(select ID from inv_penjualan_detail where ID=NEW.ID),
	(select ID_Jenis from inv_penjualan_detail where ID=NEW.ID),
	(select Tanggal from inv_penjualan where ID=NEW.ID_Jual),
	(select Bulan from inv_penjualan where ID=NEW.ID_Jual),
	(select Tahun from inv_penjualan where ID=NEW.ID_Jual),
	(select ID_Jual from inv_penjualan_detail where ID=NEW.ID),
	(select ID_Barang from inv_penjualan_detail where ID=NEW.ID),
	(select Jumlah from inv_penjualan_detail where ID=NEW.ID),
	(select Harga from inv_penjualan_detail where ID=NEW.ID),
	(select ID_Jenis from inv_penjualan where ID=NEW.ID_Jual)&
	(select Nomor from inv_penjualan where ID=NEW.ID_Jual),
	(select NoUrut from inv_penjualan where ID=NEW.ID_Jual)
	);

END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.penjualan_upd
DROP TRIGGER IF EXISTS `penjualan_upd`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `penjualan_upd` AFTER UPDATE ON `inv_penjualan_detail` FOR EACH ROW BEGIN
update inv_penjualan_rekap set jumlah=new.jumlah,ID_Jenis=NEW.ID_Jenis
where id=NEW.ID;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.penjualan_upd_header
DROP TRIGGER IF EXISTS `penjualan_upd_header`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `penjualan_upd_header` AFTER UPDATE ON `inv_penjualan` FOR EACH ROW BEGIN
	update inv_penjualan_detail set ID_Jenis=NEW.ID_Jenis
	where ID_Jual=NEW.ID;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.transaksi_tmp_del
DROP TRIGGER IF EXISTS `transaksi_tmp_del`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `transaksi_tmp_del` AFTER DELETE ON `transaksi_temp` FOR EACH ROW BEGIN
/* data yang di delete akan di simpan secara otomatis ke table transaksi log*/
	INSERT INTO transaksi_log 
	(ID_Trans,Keterangan,old_val,new_val,created_by)
	VALUES
	(OLD.ID_Perkiraan,concat('Delete ', OLD.Keterangan),OLD.Debet,OLD.Kredit,(SELECT UUID_SHORT()));

END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.transaksi_tmp_upd
DROP TRIGGER IF EXISTS `transaksi_tmp_upd`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `transaksi_tmp_upd` AFTER UPDATE ON `transaksi_temp` FOR EACH ROW BEGIN
/* data yang di update akan di simpan secara otomatis ke table transaksi log*/
	INSERT INTO transaksi_log 
	(ID_Trans,Keterangan,old_val,new_val,created_by)
	VALUES
	(NEW.ID_Perkiraan,concat('Update ', OLD.Keterangan),OLD.Debet,OLD.Kredit,NEW.Created_by);

END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.t_alamat_new
DROP TRIGGER IF EXISTS `t_alamat_new`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_alamat_new` AFTER INSERT ON `mst_anggota` FOR EACH ROW BEGIN
	replace into mst_kota(kota_anggota) values(New.Kota);
	replace into mst_propinsi(prop_anggota) values(NEW.Propinsi);
	/*buat akun perkiraan
	 akun Simp.Pokok
	*/
	insert into perkiraan
		(ID_Klas,ID_SubKlas,ID_Dept,ID_Unit,ID_Laporan,ID_LapDetail,
		 ID_Agt,ID_Calc,ID_Simpanan,NoUrut,SaldoAwal)
		values(
		(select ID_Klasifikasi from jenis_simpanan where ID='1'),
		(select ID_SubKlas from jenis_simpanan where ID='1'),
		NEW.ID_Dept,
		(select ID_Unit from jenis_simpanan where ID='1'),
		(select ID_Laporan from jenis_simpanan where ID='1'),
		(select ID_LapDetail from jenis_simpanan where ID='1'),
		NEW.ID,
		(select ID_Calc from jenis_simpanan where ID='1'),
		'1','0','0') ;
  /*Simp.Wajib  */
	insert into perkiraan
		(ID_Klas,ID_SubKlas,ID_Dept,ID_Unit,ID_Laporan,ID_LapDetail,
		 ID_Agt,ID_Calc,ID_Simpanan,NoUrut,SaldoAwal)
		values(
		(select ID_Klasifikasi from jenis_simpanan where ID='2'),
		(select ID_SubKlas from jenis_simpanan where ID='2'),
		NEW.ID_Dept,
		(select ID_Unit from jenis_simpanan where ID='2'),
		(select ID_Laporan from jenis_simpanan where ID='2'),
		(select ID_LapDetail from jenis_simpanan where ID='2'),
		NEW.ID,
		(select ID_Calc from jenis_simpanan where ID='2'),
		'2','0','0') ;
  /*Simp.Khusus  */
	insert into perkiraan
		(ID_Klas,ID_SubKlas,ID_Dept,ID_Unit,ID_Laporan,ID_LapDetail,
		 ID_Agt,ID_Calc,ID_Simpanan,NoUrut,SaldoAwal)
		values(
		(select ID_Klasifikasi from jenis_simpanan where ID='3'),
		(select ID_SubKlas from jenis_simpanan where ID='3'),
		NEW.ID_Dept,
		(select ID_Unit from jenis_simpanan where ID='3'),
		(select ID_Laporan from jenis_simpanan where ID='3'),
		(select ID_LapDetail from jenis_simpanan where ID='3'),
		NEW.ID,
		(select ID_Calc from jenis_simpanan where ID='3'),
		'3','0','0') ;
 
  /*Pinjaman,Barang  */
	insert into perkiraan
		(ID_Klas,ID_SubKlas,ID_Dept,ID_Unit,ID_Laporan,ID_LapDetail,
		 ID_Agt,ID_Calc,ID_Simpanan,NoUrut,SaldoAwal)
		values(
		(select ID_Klasifikasi from jenis_simpanan where ID='4'),
		(select ID_SubKlas from jenis_simpanan where ID='4'),
		NEW.ID_Dept,
		(select ID_Unit from jenis_simpanan where ID='4'),
		(select ID_Laporan from jenis_simpanan where ID='4'),
		(select ID_LapDetail from jenis_simpanan where ID='4'),
		NEW.ID,
		(select ID_Calc from jenis_simpanan where ID='4'),
		'4','0','0') ;
 
  /*Barang  */
	insert into perkiraan
		(ID_Klas,ID_SubKlas,ID_Dept,ID_Unit,ID_Laporan,ID_LapDetail,
		 ID_Agt,ID_Calc,ID_Simpanan,NoUrut,SaldoAwal)
		values(
		(select ID_Klasifikasi from jenis_simpanan where ID='5'),
		(select ID_SubKlas from jenis_simpanan where ID='5'),
		NEW.ID_Dept,
		(select ID_Unit from jenis_simpanan where ID='5'),
		(select ID_Laporan from jenis_simpanan where ID='5'),
		(select ID_LapDetail from jenis_simpanan where ID='5'),
		NEW.ID,
		(select ID_Calc from jenis_simpanan where ID='5'),
		'5','0','0') ;

	/*limit pinjaman*/
	replace into pinjaman_limit (ID_Agt,Tahun,max_limit) values(NEW.ID,year(NEW.TanggalMasuk),New.Status);
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.t_alamat_upd
DROP TRIGGER IF EXISTS `t_alamat_upd`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_alamat_upd` AFTER UPDATE ON `mst_anggota` FOR EACH ROW BEGIN
	update mst_kota set kota_anggota=New.Kota where kota_anggota=OLD.Kota;
	update mst_propinsi set prop_anggota=NEW.Propinsi where prop_anggota=OLD.Propinsi;
	replace into pinjaman_limit (ID_Agt,Tahun,max_limit) values(NEW.ID,year(NEW.TanggalMasuk),New.Status);

END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.t_barang_del
DROP TRIGGER IF EXISTS `t_barang_del`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_barang_del` AFTER DELETE ON `inv_barang` FOR EACH ROW BEGIN
	delete from inv_konversi where id_barang=old.ID;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.t_barang_new
DROP TRIGGER IF EXISTS `t_barang_new`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_barang_new` AFTER INSERT ON `inv_barang` FOR EACH ROW BEGIN
 insert into inv_konversi (id_barang,nm_barang,nm_satuan,sat_beli,isi_konversi) 
 values(NEW.ID,NEW.Nama_Barang,NEW.ID_Satuan,NEW.ID_Satuan,'1');
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.t_barang_upd
DROP TRIGGER IF EXISTS `t_barang_upd`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_barang_upd` AFTER UPDATE ON `inv_barang` FOR EACH ROW BEGIN
	update inv_konversi set nm_barang=New.Nama_Barang,nm_satuan=New.ID_Satuan,
	sat_beli=New.ID_Satuan
	where ID_Barang=OLD.ID and
	sat_beli=OLD.ID_Satuan;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.t_pinjaman_del
DROP TRIGGER IF EXISTS `t_pinjaman_del`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_pinjaman_del` AFTER DELETE ON `pinjaman` FOR EACH ROW BEGIN
	delete from pinjaman_bayar where ID_pinjaman=OLD.ID;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.t_pinjaman_new
DROP TRIGGER IF EXISTS `t_pinjaman_new`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_pinjaman_new` AFTER INSERT ON `pinjaman` FOR EACH ROW BEGIN
insert into pinjaman_bayar (
  ID_pinjaman,ID_Agt,Tanggal,Tahun,Debet,saldo,keterangan) (
	select ID,ID_Agt,Tanggal,Tahun,jml_pinjaman,jml_pinjaman,keterangan
	from pinjaman where ID=NEW.ID);
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.t_pinjaman_upd
DROP TRIGGER IF EXISTS `t_pinjaman_upd`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_pinjaman_upd` AFTER UPDATE ON `pinjaman` FOR EACH ROW BEGIN
	replace into pinjaman_bayar (
  	ID_pinjaman,ID_Agt,Tanggal,Tahun,Debet,saldo,keterangan) (
	select ID,ID_Agt,Tanggal,Tahun,jml_pinjaman,jml_pinjaman,keterangan
	from pinjaman where ID=OLD.ID);

END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.t_setup_simpanan_log
DROP TRIGGER IF EXISTS `t_setup_simpanan_log`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_setup_simpanan_log` AFTER UPDATE ON `setup_simpanan` FOR EACH ROW BEGIN
insert into set_simpanan_log  select * from setup_simpanan where id_simpanan=OLD.id_simpanan;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.t_SimpSumDept_new
DROP TRIGGER IF EXISTS `t_SimpSumDept_new`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_SimpSumDept_new` AFTER INSERT ON `transaksi_new` FOR EACH ROW begin
	/*update table v_dept_trans (rekap transaksi per departemen)*/
end//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.t_transaksi_del
DROP TRIGGER IF EXISTS `t_transaksi_del`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_transaksi_del` AFTER DELETE ON `transaksi` FOR EACH ROW begin
/* 
jika data pada tabel transaksi di hapus otomatis data pada tabel transaksi new 
akan terhapus juga dan data yang di delete akan di simpan secara otomatis ke table transaksi log
dan jika no_perkiraan sesuai dengan di table temp stat akan kembali ke 0*/
delete from transaksi_new where ID=OLD.ID;
insert into transaksi_log (ID_trans,Keterangan,old_val,new_val) values(OLD.ID_Jurnal,concat('Delete ',OLD.Keterangan),OLD.Debet,OLD.Kredit);
update transaksi_temp set ID_stat='0' where ID_Perkiraan=OLD.ID_Perkiraan;
end//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.t_transaksi_new
DROP TRIGGER IF EXISTS `t_transaksi_new`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_transaksi_new` AFTER INSERT ON `transaksi` FOR EACH ROW begin
/* jika ada data baru di tabel transaksi akan tersimpan juga di table traksaksi new
Tabel transaksi new digunakan untuk mempermudah dan mempersingkat loading data*/

INSERT into transaksi_new 
	(ID,ID_Jurnal,ID_Perkiraan,ID_Dept,Debet,Kredit,Keterangan,
	 ID_Unit,ID_Tipe,Tanggal,ID_Bulan,Tahun,NoUrut,Nomor,Ket,ID_Mark)
	values
	(New.ID,New.ID_Jurnal,New.ID_Perkiraan,New.ID_Dept,
	New.Debet,New.Kredit,New.Keterangan,
	(select ID_Unit from jurnal where ID=new.ID_Jurnal),
	(select ID_Tipe from jurnal where ID=new.ID_Jurnal),
	(select Tanggal from jurnal where ID=new.ID_Jurnal),
	(select ID_Bulan from jurnal where ID=new.ID_Jurnal),
	(select Tahun from jurnal where ID=new.ID_Jurnal),
	(select NoUrut from jurnal where ID=new.ID_Jurnal),
	(select Nomor from jurnal where ID=new.ID_Jurnal),
	(select Keterangan from jurnal where ID=new.ID_Jurnal),
	(select ID_Mark from jurnal where ID=new.ID_Jurnal)
	);
	
end//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.t_transaksi_new_del
DROP TRIGGER IF EXISTS `t_transaksi_new_del`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_transaksi_new_del` AFTER DELETE ON `transaksi_new` FOR EACH ROW BEGIN
/* data yang di delete akan di simpan secara otomatis ke table transaksi_del
untuk keperluan restore jika diperlukan
*/
insert into transaksi_del select * from transaksi_new where ID=OLD.ID;
END//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;


-- Dumping structure for trigger setujudb.t_transaksi_upd
DROP TRIGGER IF EXISTS `t_transaksi_upd`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `t_transaksi_upd` AFTER UPDATE ON `transaksi` FOR EACH ROW begin
/* 
	Jika table transaksi mengalami update akan otomatis data yang sama di table
	transaksi_new juga akan otomatis ter update
*/
replace into transaksi_new 
	(ID,ID_Jurnal,ID_Perkiraan,ID_Dept,Debet,Kredit,Keterangan,
	 ID_Unit,ID_Tipe,Tanggal,ID_Bulan,Tahun,NoUrut,Nomor,Ket,ID_Mark)
	values
	(New.ID,New.ID_Jurnal,New.ID_Perkiraan,New.ID_Dept,
	New.Debet,New.Kredit,New.Keterangan,
	(select ID_Unit from jurnal where ID=new.ID_Jurnal),
	(select ID_Tipe from jurnal where ID=new.ID_Jurnal),
	(select Tanggal from jurnal where ID=new.ID_Jurnal),
	(select ID_Bulan from jurnal where ID=new.ID_Jurnal),
	(select Tahun from jurnal where ID=new.ID_Jurnal),
	(select NoUrut from jurnal where ID=new.ID_Jurnal),
	(select Nomor from jurnal where ID=new.ID_Jurnal),
	(select Keterangan from jurnal where ID=new.ID_Jurnal),
	(select ID_Mark from jurnal where ID=new.ID_Jurnal)
	);
insert into transaksi_log (ID_trans,Keterangan,old_val,new_val) values(OLD.ID_Jurnal,'Hapus',OLD.Debet,OLD.Kredit);	
end//
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;
/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
