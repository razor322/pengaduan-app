<?php
header("Access-Control-Allow-Origin: header");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
// header("Content-Type: application/json");

include 'koneksi.php';

$id = $_POST['id_user'];
$username = $_POST['username'];



$sql = "UPDATE tb_user SET username = '$username' WHERE id_user=$id";
$isSuccess = $koneksi->query($sql);

if ($isSuccess) {

    $cek = "SELECT * FROM tb_user WHERE id_user = $id";
    $result = mysqli_fetch_array(mysqli_query($koneksi, $cek));
    $res['is_success'] = true;
    $res['value'] = 1;
    $res['message'] = "Berhasil edit user";
    $res['username'] = $result['username'];
    $res['id_user'] = $result['id_user'];
} else {
    $res['is_success'] = false;
    $res['value'] = 0;
    $res['message'] = "Gagal edit user";
}

echo json_encode($res);