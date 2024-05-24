<?php

$koneksi = mysqli_connect("localhost", "root", "", "db_pusatinformasi");

if ($koneksi) {

	// echo "Database berhasil Connect";

} else {
	echo "gagal Connect";
}
