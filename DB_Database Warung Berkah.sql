CREATE TABLE Supplier (
	id_supplier INT PRIMARY KEY IDENTITY,
	nama_supplier VARCHAR(100),
	alamat_gudang VARCHAR(200),
	nomor_kontak VARCHAR(20)
);

CREATE TABLE Faktur (
	id_faktur INT PRIMARY KEY IDENTITY,
	id_supplier INT,
	tahun_mulai_kontrak INT,
	tanggal_pesan DATE,
	tanggal_terima DATE,

	lama_proses_hari AS DATEDIFF(DAY, tanggal_pesan, tanggal_terima),

	FOREIGN KEY (id_supplier) REFERENCES Supplier(id_supplier)
);

CREATE TABLE Barang (
	id_barang INT PRIMARY KEY IDENTITY,
	nama_barang VARCHAR(100),
	harga_beli INT,
	harga_jual INT,

	margin AS (harga_jual - harga_beli)
);

CREATE TABLE Detail_Faktur (
id_faktur INT,
id_barang INT,
PRIMARY KEY (id_faktur, id_barang),

FOREIGN KEY (id_faktur) REFERENCES Faktur(id_faktur),
FOREIGN KEY (id_barang) REFERENCES Barang(id_barang)
);

INSERT INTO Supplier (nama_supplier, alamat_gudang, nomor_kontak)
VALUES
('PT. Sumber Makmur', 'Sukabumi, Solo, Cirebon', '123'),
('PT. Snack Jaya', 'Depok, Bekasi', '456');

INSERT INTO Faktur (id_supplier, tahun_mulai_kontrak, tanggal_pesan, tanggal_terima)
VALUES
(1, 2018, '2026-01-10', '2026-01-15'),
(1, 2018, '2026-02-15', '2026-02-17'),
(2, 2020, '2026-03-01', '2026-03-02');

INSERT INTO Barang (nama_barang, harga_beli, harga_jual)
VALUES
('Beras Premium', 10000, 12000),
('Minyak Goreng', 14000, 16500),
('Sabun Mandi', 3000, 4500),
('Keripik Kentang', 8000, 11000);

INSERT INTO Detail_Faktur VALUES
(1,1),
(1,2),
(2,3),
(3,4);

SELECT id_faktur, tanggal_pesan, tanggal_terima, lama_proses_hari
FROM Faktur;

SELECT nama_barang, harga_beli, harga_jual, margin
FROM Barang;

SELECT f.id_faktur, SUM(b.margin) AS total_profit
FROM Faktur f
JOIN Detail_Faktur d ON f.id_faktur = d.id_faktur
JOIN Barang b ON d.id_barang = b.id_barang
GROUP BY f.id_faktur;

SELECT
s.nama_supplier,
s.alamat_gudang,
s.nomor_kontak,
f.tahun_mulai_kontrak,
f.tanggal_pesan,
f.tanggal_terima,
f.lama_proses_hari,
b.nama_barang,
b.harga_beli,
b.harga_jual,
b.margin
FROM Supplier s
JOIN Faktur f ON s.id_supplier = f.id_supplier
JOIN Detail_Faktur d ON f.id_faktur = d.id_faktur
JOIN Barang b ON d.id_barang = b.id_barang;
