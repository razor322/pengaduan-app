<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Pastikan bahwa semua parameter yang diperlukan tersedia
    // $gambar = $_POST['gambar'];

    $nama = $_POST['nama'];
    $tgl_lahir = $_POST['tgl_lahir'];
    $asal = $_POST['asal'];
    $jenis_kelamin = $_POST['jenis_kelamin'];
    $deskripsi = $_POST['deskripsi'];

    if (isset($_POST['nama']) != null) {

        $filename = $_FILES["gambar"]["name"];
        $tempname = $_FILES["gambar"]["tmp_name"];
        $ext = pathinfo($filename, PATHINFO_EXTENSION);
        $filename_without_ext = pathinfo($filename, PATHINFO_FILENAME);

        $angka_acak = rand(1, 999);
        $final_folder = $filename_without_ext . '-' . $angka_acak . '.' . $ext;
        $folder = "C:\\xampp\\htdocs\\uts_mobile2\\image\\" . $final_folder;
        $sql = "INSERT INTO tb_sejarawan (nama, gambar,tgl_lahir, asal, jenis_kelamin, deskripsi) VALUES ('$nama','$final_folder','$tgl_lahir','$asal', '$jenis_kelamin', '$deskripsi')";

        // Checking if the required parameters are present
        if (!empty($nama) && !empty($tgl_lahir) && !empty($asal) && !empty($jenis_kelamin) && !empty($deskripsi)) {
            if (move_uploaded_file($tempname, $folder)) {
                if ($koneksi->query($sql) === TRUE) {
                    $response['isSuccess'] = true;
                    $response['message'] = "Berhasil menambahkan data sejarawan";
                } else {
                    $response['isSuccess'] = false;
                    $response['message'] = "Gagal menambahkan data sejarawan: " . $koneksi->error;
                }
            } else {
                $response['isSuccess'] = false;
                $response['message'] = "Gagal memindahkan file. Pastikan folder tujuan ada dan writable.";
            }
        } else {
            $response['isSuccess'] = false;
            $response['message'] = "Parameter tidak lengkap";
        }

        // if ($koneksi->query($sql) === TRUE) {
        //     $response['isSuccess'] = true;
        //     $response['message'] = "Berhasil menambahkan data sejarawan";
        // } else {
        //     $response['isSuccess'] = false;
        //     $response['message'] = "Gagal menambahkan data sejarawan: " . $koneksi->error;
        // }
    } else {
        $response['isSuccess'] = false;
        $response['message'] = "Parameter tidak lengkap";
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Metode yang diperbolehkan hanya POST";
}

echo json_encode($response);