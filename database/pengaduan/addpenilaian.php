<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Pastikan bahwa semua parameter yang diperlukan tersedia
    if (isset($_POST['rating']) && isset($_POST['pesan'])) {
        $rating = $_POST['rating'];

        $pesan = $_POST['pesan'];
        $id_user = $_POST['id_user'];

        $sql = "INSERT INTO tb_penilaian (rating, pesan,id_user) VALUES ( '$rating', '$pesan','$id_user')";
        if ($koneksi->query($sql) === TRUE) {
            $response['isSuccess'] = true;
            $response['message'] = "Berhasil menambahkan data rating";
        } else {
            $response['isSuccess'] = false;
            $response['message'] = "Gagal menambahkan data rating: " . $koneksi->error;
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
