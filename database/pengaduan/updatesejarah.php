<?php

header("Access-Control-Allow-Origin: *");
include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $response = array();

    $id = $_POST['id'];
    $nama = $_POST['nama'];
    $tgl_lahir = $_POST['tgl_lahir'];
    $asal = $_POST['asal'];
    $jenis_kelamin = $_POST['jenis_kelamin'];
    $deskripsi = $_POST['deskripsi'];

    // Periksa apakah gambar baru telah diunggah
    if ($_FILES["gambar"]["error"] == UPLOAD_ERR_OK) {
        // Mengunggah gambar baru
        $filename = $_FILES["gambar"]["name"];
        $tempname = $_FILES["gambar"]["tmp_name"];
        $ext = pathinfo($filename, PATHINFO_EXTENSION);
        $filename_without_ext = pathinfo($filename, PATHINFO_FILENAME);

        $angka_acak = rand(1, 999);
        $final_folder = $filename_without_ext . '-' . $angka_acak . '.' . $ext;
        $folder = "C:\\xampp\\htdocs\\uts_mobile2\\image\\" . $final_folder;
        move_uploaded_file($tempname, $folder);

        // Memperbarui entri gambar di basis data dengan nama file yang baru
        $sql = "UPDATE tb_sejarawan SET nama = '$nama', gambar = '$final_folder', tgl_lahir = '$tgl_lahir', asal = '$asal', jenis_kelamin = '$jenis_kelamin', deskripsi = '$deskripsi' WHERE id = $id";
    } else {
        // Jika tidak ada gambar yang diunggah, gunakan query tanpa memperbarui gambar
        $sql = "UPDATE tb_sejarawan SET nama = '$nama', tgl_lahir = '$tgl_lahir', asal = '$asal', jenis_kelamin = '$jenis_kelamin', deskripsi = '$deskripsi' WHERE id = $id";
    }

    // Jalankan query SQL untuk memperbarui data dalam database
    $isSuccess = $koneksi->query($sql);

    if ($isSuccess) {
        $cek = "SELECT * FROM tb_sejarawan WHERE id = $id";
        $result = mysqli_fetch_array(mysqli_query($koneksi, $cek));
        $response['is_success'] = true;
        $response['value'] = 1;
        $response['message'] = "Sejarawan Berhasil di Edit";
        $response['nama'] = $result['nama'];
        $response['tgl_lahir'] = $result['tgl_lahir'];
        $response['asal'] = $result['asal'];
        $response['jenis_kelamin'] = $result['jenis_kelamin'];
        $response['deskripsi'] = $result['deskripsi'];
    } else {
        $response['is_success'] = false;
        $response['value'] = 0;
        $response['message'] = "Gagal Edit Sejarawan";
    }

    echo json_encode($response);
}