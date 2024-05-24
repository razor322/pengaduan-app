<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Pastikan bahwa semua parameter yang diperlukan tersedia
    if (isset($_POST['no_bp']) && isset($_POST['email'])) {
        $no_bp = $_POST['no_bp'];
        $nama_mahasiswa = $_POST['nama_mahasiswa'];
        $email = $_POST['email'];
        $jenis_kelamin = $_POST['jenis_kelamin'];

        $sql = "INSERT INTO tb_mahasiswa (nama_mahasiswa, no_bp, email, jenis_kelamin) VALUES ('$nama_mahasiswa','$no_bp', '$email', '$jenis_kelamin')";
        if ($koneksi->query($sql) === TRUE) {
            $response['isSuccess'] = true;
            $response['message'] = "Berhasil menambahkan data mahasiswa";
        } else {
            $response['isSuccess'] = false;
            $response['message'] = "Gagal menambahkan data mahasiswa: " . $koneksi->error;
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
?>
