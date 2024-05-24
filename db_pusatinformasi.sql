-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 24 Bulan Mei 2024 pada 16.42
-- Versi server: 10.4.27-MariaDB
-- Versi PHP: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_pusatinformasi`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_jaksa`
--

CREATE TABLE `tb_jaksa` (
  `id` int(11) NOT NULL,
  `sekolah` varchar(255) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `status` varchar(11) NOT NULL DEFAULT 'pending',
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `tb_jaksa`
--

INSERT INTO `tb_jaksa` (`id`, `sekolah`, `nama`, `status`, `id_user`) VALUES
(4, 'sd 12 padang', 'jono surya', 'approve', 1),
(6, 'sma 2', 'budi', 'pending', 1),
(7, 'sma 2 ', 'rudi', 'pending', 4),
(9, 'sma 32', 'budi s', 'pending', 6);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_korupsi`
--

CREATE TABLE `tb_korupsi` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `no_hp` varchar(16) NOT NULL,
  `no_ktp` int(16) NOT NULL,
  `foto_ktp` varchar(255) NOT NULL,
  `uraian_laporan` text NOT NULL,
  `laporan` text NOT NULL,
  `foto_laporan` varchar(255) NOT NULL,
  `status` varchar(11) NOT NULL DEFAULT 'pending',
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `tb_korupsi`
--

INSERT INTO `tb_korupsi` (`id`, `nama`, `no_hp`, `no_ktp`, `foto_ktp`, `uraian_laporan`, `laporan`, `foto_laporan`, `status`, `id_user`) VALUES
(1, 'gybran', '23131', 2324241, '3-687.pdf', 'asdawadaw', 'adawdasdaw', '5-677.pdf', 'pending', 1),
(3, 'rusdi munir', '908', 90778, '17162596476970Flight E-ticket - Order ID - 1239008868 - PMENNY.pdf', 'lporam', 'asdawdawdadad', '171625964743931.pdf', 'approve', 1),
(6, 'rudi', '9877', 887, '171656044428901.pdf', 'laporam t', 'lpoarantest', '17165604447002Flight E-ticket - Order ID - 1239008868 - PMENNY.pdf', 'pending', 4),
(8, 'maseh', '989', 9090, 'Flight E-ticket - Order ID - 1239008868 - PMENNY-207.pdf', 'test', 'test', '1-380.pdf', 'pending', 4),
(9, 'hono', '13', 1233, '1-229.pdf', 'tst', 'tst', 'Flight E-ticket - Order ID - 1239008868 - PMENNY-566.pdf', 'pending', 6);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_pengaduan`
--

CREATE TABLE `tb_pengaduan` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `no_hp` varchar(16) NOT NULL,
  `no_ktp` int(16) NOT NULL,
  `foto_ktp` varchar(255) NOT NULL,
  `laporan` text NOT NULL,
  `foto_laporan` varchar(255) NOT NULL,
  `kategori` varchar(255) NOT NULL,
  `status` varchar(11) NOT NULL DEFAULT 'pending',
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `tb_pengaduan`
--

INSERT INTO `tb_pengaduan` (`id`, `nama`, `no_hp`, `no_ktp`, `foto_ktp`, `laporan`, `foto_laporan`, `kategori`, `status`, `id_user`) VALUES
(10, 'gyb', '231317', 23242417, '171625972192172.pdf', 'adawdasdaws', '171625972116471.pdf', 'pengawasan', 'reject', 1),
(13, 'gybran nauv', '231317', 23242417, '171625974134942.pdf', 'adawdasdaw7', '17162597412561Flight E-ticket - Order ID - 1239008868 - PMENNY.pdf', 'pilkada', 'approve', 1),
(20, 'gybran nau', '092888', 170466, '171625961056351.pdf', 'laporan aja', '17162596108574Flight E-ticket - Order ID - 1239008868 - PMENNY.pdf', 'pegawai', 'approve', 1),
(29, 'jono', '98989', 9999, '1-124.pdf', 'sdaadw', 'Flight E-ticket - Order ID - 1239008868 - PMENNY-258.pdf', 'pegawai', 'reject', 1),
(30, 'rawa', '99', 909, '1-281.pdf', 'sadwa', 'Flight E-ticket - Order ID - 1239008868 - PMENNY-426.pdf', 'pilkada', 'reject', 1),
(31, 'gybrannn', '23131', 2324241, '3-654.pdf', 'adawdasdaw', '5-510.pdf', 'pilkada', 'reject', 1),
(32, 'gybrannn', '23131', 2324241, '3-578.pdf', 'adawdasdaw', '5-607.pdf', 'pilkada', 'reject', 1),
(33, 'gybrannn', '23131', 2324241, '3-524.pdf', 'adawdasdaw', '5-194.pdf', 'pilkada', 'reject', 1),
(34, 'gybrannn', '23131', 2324241, '3-674.pdf', 'adawdasdaw', '5-322.pdf', 'pilkada', 'approve', 1),
(35, 'budi', '23131', 2324241, '3-94.pdf', 'adawdasdaw', '5-689.pdf', 'pengawasan', 'approve', 1),
(36, 'budi', '23131', 2324241, '3-256.pdf', 'adawdasdaw', '5-400.pdf', 'penyuluhan', 'approve', 1),
(37, 'budi', '23131', 2324241, '3-699.pdf', 'adawdasdaw', '5-554.pdf', 'pilkada', 'approve', 1),
(38, 'gybran na', '098622', 231334, '17165603479438Flight E-ticket - Order ID - 1239008868 - PMENNY.pdf', 'laporan2', '17165603473054Flight E-ticket - Order ID - 1239008868 - PMENNY.pdf', 'pegawai', 'approve', 4),
(40, 'radi', '123', 12313, 'Flight E-ticket - Order ID - 1239008868 - PMENNY-595.pdf', 'tst', '1-293.pdf', 'pegawai', 'pending', 6),
(43, 'reni s', '233', 333, '171656117245521.pdf', 'tst', '17165611725973Flight E-ticket - Order ID - 1239008868 - PMENNY.pdf', 'penyuluhan', 'approve', 6),
(44, 'hero', '23', 78, 'Flight E-ticket - Order ID - 1239008868 - PMENNY-882.pdf', 'tst', '1-361.pdf', 'pengawasan', 'approve', 6),
(47, 'ragi sh', '89877', 98976, '17165612921517Flight E-ticket - Order ID - 1239008868 - PMENNY.pdf', 'tst tst', '171656129287441.pdf', 'pilkada', 'reject', 6);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_penilaian`
--

CREATE TABLE `tb_penilaian` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `pesan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `tb_penilaian`
--

INSERT INTO `tb_penilaian` (`id`, `id_user`, `rating`, `pesan`) VALUES
(1, 1, 3, 'keran'),
(2, 1, 2, 'keran'),
(3, 2, 3, 'keran'),
(4, 6, 3, 'keren sekali');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(50) NOT NULL,
  `no_tlp` varchar(50) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `nik` varchar(16) NOT NULL,
  `is_admin` varchar(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `no_tlp`, `alamat`, `nik`, `is_admin`) VALUES
(1, 'gybran', '202cb962ac59075b964b07152d234b70', 'gybran@gmail.com', '098762', 'padang', '1765336', '0'),
(2, 'jono', '202cb962ac59075b964b07152d234b70', 'jono@gmail.com', '07755', 'jono', '087666', '1'),
(3, 'koi', '202cb962ac59075b964b07152d234b70', 'koi@gmail.com', '08754', 'koi', '07754', '0'),
(4, 'gyb', '202cb962ac59075b964b07152d234b70', 'gyb@gmail.com', '123', 'gyb', '08558', '0'),
(5, 'budi', '202cb962ac59075b964b07152d234b70', 'budi@gmail.com', '123', 'budi', '98989', '0'),
(6, 'radi', '202cb962ac59075b964b07152d234b70', 'radi@gmail.com', '123', 'radi', '9898', '0');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tb_jaksa`
--
ALTER TABLE `tb_jaksa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `tb_korupsi`
--
ALTER TABLE `tb_korupsi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `tb_pengaduan`
--
ALTER TABLE `tb_pengaduan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `tb_penilaian`
--
ALTER TABLE `tb_penilaian`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tb_jaksa`
--
ALTER TABLE `tb_jaksa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `tb_korupsi`
--
ALTER TABLE `tb_korupsi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `tb_pengaduan`
--
ALTER TABLE `tb_pengaduan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT untuk tabel `tb_penilaian`
--
ALTER TABLE `tb_penilaian`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `tb_jaksa`
--
ALTER TABLE `tb_jaksa`
  ADD CONSTRAINT `tb_jaksa_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `tb_korupsi`
--
ALTER TABLE `tb_korupsi`
  ADD CONSTRAINT `tb_korupsi_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `tb_pengaduan`
--
ALTER TABLE `tb_pengaduan`
  ADD CONSTRAINT `tb_pengaduan_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `tb_penilaian`
--
ALTER TABLE `tb_penilaian`
  ADD CONSTRAINT `tb_penilaian_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
