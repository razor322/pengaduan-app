<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// Include the database connection file
include 'koneksi.php';

$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Check if all required parameters are available
    if (isset($_POST['nama']) && isset($_POST['no_hp']) && isset($_POST['no_ktp']) && isset($_POST['id_user'])) {
        $nama = $_POST['nama'];
        $no_hp = $_POST['no_hp'];
        $no_ktp = $_POST['no_ktp'];
        $laporan = $_POST['laporan'];
        $kategori = $_POST['kategori'];
        // $status = 'pending';  // Default status
        $id = $_POST['id'];
        $id_user = $_POST['id_user'];


        // Handle uploaded KTP photo
        $foto_ktp = $_FILES['foto_ktp']['name'];
        $foto_ktp_tmp = $_FILES['foto_ktp']['tmp_name'];
        $ktp_folder = "file/";

        // Handle uploaded report photo
        $foto_laporan = $_FILES['foto_laporan']['name'];
        $foto_laporan_tmp = $_FILES['foto_laporan']['tmp_name'];
        $laporan_folder = "file/";

        // Ensure the directories exist
        if (!is_dir($ktp_folder)) {
            mkdir($ktp_folder, 0755, true);
        }
        if (!is_dir($laporan_folder)) {
            mkdir($laporan_folder, 0755, true);
        }

        // Generate unique filename for KTP photo
        $timestamp_ktp = time();
        $random_number_ktp = rand(1000, 9999);
        $foto_ktp_new = $timestamp_ktp . '' . $random_number_ktp . '' . $foto_ktp;

        // Generate unique filename for report photo
        $timestamp_laporan = time();
        $random_number_laporan = rand(1000, 9999);
        $foto_laporan_new = $timestamp_laporan . '' . $random_number_laporan . '' . $foto_laporan;

        // Move uploaded files to their respective folders
        if (move_uploaded_file($foto_ktp_tmp, $ktp_folder . $foto_ktp_new) && move_uploaded_file($foto_laporan_tmp, $laporan_folder . $foto_laporan_new)) {
            // Prepare the SQL statement
            $sql = "UPDATE tb_pengaduan SET nama='$nama', no_hp='$no_hp', no_ktp='$no_ktp', foto_ktp='$foto_ktp_new', laporan='$laporan', foto_laporan='$foto_laporan_new',kategori='$kategori',id_user='$id_user' WHERE id=$id";

            // Execute the SQL statement
            if ($koneksi->query($sql) === TRUE) {
                $response['isSuccess'] = true;
                $response['message'] = "Berhasil menambahkan data pengaduan";
            } else {
                $response['isSuccess'] = false;
                $response['message'] = "Gagal menambahkan data pengaduan: " . $koneksi->error;
            }
        } else {
            $response['isSuccess'] = false;
            $response['message'] = "Gagal mengunggah file";
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
