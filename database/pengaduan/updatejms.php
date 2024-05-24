<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Pastikan bahwa semua parameter yang diperlukan tersedia
    if (isset($_POST['nama']) && isset($_POST['sekolah'])) {
        $nama = $_POST['nama'];
        $sekolah = $_POST['sekolah'];
        $id_user = $_POST['id_user'];
        $id = $_POST['id'];

        $sql = "UPDATE tb_jaksa SET nama='$nama', sekolah='$sekolah', id_user='$id_user' WHERE id=$id";
        if ($koneksi->query($sql) === TRUE) {
            $response['isSuccess'] = true;
            $response['message'] = "Berhasil menambahkan Data Jaksa Masuk sekolah";
        } else {
            $response['isSuccess'] = false;
            $response['message'] = "Gagal menambahkan Data Jaksa Masuk sekolah: " . $koneksi->error;
        }
    } else {
        $response['isSuccess'] = false;
        $response['message'] = "Parameter tidak lengkap";
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Metode yang diperbolehkan hanya POST";
}

echo json_encode($response);
