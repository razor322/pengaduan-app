<?php

$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    require_once 'koneksi.php';

    $nama = $_POST['nama'];
    $no_hp = $_POST['no_hp'];
    $no_ktp = $_POST['no_ktp'];
    $uraian_laporan = $_POST['uraian_laporan'];
    $laporan = $_POST['laporan'];
    $id_user = $_POST['id_user'];

    if (isset($_FILES['foto_ktp']) && isset($_FILES['foto_laporan'])) {
        $filename_ktp = $_FILES["foto_ktp"]["name"];
        $tempname_ktp = $_FILES["foto_ktp"]["tmp_name"];
        $ext_ktp = pathinfo($filename_ktp, PATHINFO_EXTENSION);
        $filename_ktp_without_ext = pathinfo($filename_ktp, PATHINFO_FILENAME);

        $angka_acak_ktp = rand(1, 999);
        $final_folder_ktp = $filename_ktp_without_ext . '-' . $angka_acak_ktp . '.' . $ext_ktp;
        $folder_ktp = "C:\\xampp\\htdocs\\pengaduan\\file\\" . $final_folder_ktp;

        $filename_laporan = $_FILES["foto_laporan"]["name"];
        $tempname_laporan = $_FILES["foto_laporan"]["tmp_name"];
        $ext_laporan = pathinfo($filename_laporan, PATHINFO_EXTENSION);
        $filename_laporan_without_ext = pathinfo($filename_laporan, PATHINFO_FILENAME);

        $angka_acak_laporan = rand(1, 999);
        $final_folder_laporan = $filename_laporan_without_ext . '-' . $angka_acak_laporan . '.' . $ext_laporan;
        $folder_laporan = "C:\\xampp\\htdocs\\pengaduan\\file\\" . $final_folder_laporan;

        $sql = "INSERT INTO tb_korupsi (nama, no_hp, no_ktp, foto_ktp,uraian_laporan, laporan, foto_laporan, id_user) VALUES ('$nama', '$no_hp', '$no_ktp', '$final_folder_ktp','$uraian_laporan', '$laporan', '$final_folder_laporan', '$id_user')";

        if (!empty($nama) && !empty($no_hp) && !empty($no_ktp) && !empty($laporan)) {
            if (move_uploaded_file($tempname_ktp, $folder_ktp) && move_uploaded_file($tempname_laporan, $folder_laporan)) {
                if ($koneksi->query($sql) === TRUE) {
                    $response['isSuccess'] = true;
                    $response['message'] = "Berhasil menambahkan data laporan pengaduan";
                } else {
                    $response['isSuccess'] = false;
                    $response['message'] = "Gagal menambahkan data laporan pengaduan: " . $koneksi->error;
                }
            } else {
                $response['isSuccess'] = false;
                $response['message'] = "Gagal memindahkan file. Pastikan folder tujuan ada dan writable.";
            }
        } else {
            $response['isSuccess'] = false;
            $response['message'] = "Parameter tidak lengkap";
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