    <?php

    header("Access-Control-Allow-Origin: header");
    header("Access-Control-Allow-Origin: *");
    include 'koneksi.php';

    if ($_SERVER['REQUEST_METHOD'] == "POST") {

        $response = array();
        $username = $_POST['username'];
        $password = md5($_POST['password']);
        $email = $_POST['email'];
        $no_tlp = $_POST['no_tlp'];
        $alamat = $_POST['alamat'];
        $nik = $_POST['nik'];




        $cek = "SELECT * FROM users WHERE username = '$username' OR email = '$email'";
        $result = mysqli_query($koneksi, $cek);

        if (mysqli_num_rows($result) > 0) {
            $response['value'] = 2;
            $response['message'] = "Username atau email telah digunakan";
            echo json_encode($response);
        } else {
            $insert = "INSERT INTO users (username, password,email,no_tlp,alamat, nik ) 
                   VALUES ('$username', '$password', '$email', '$no_tlp', '$alamat', '$nik')";

            if (mysqli_query($koneksi, $insert)) {
                $response['value'] = 1;
                $response['username'] = $username;
                $response['email'] = $email;
                $response['alamat'] = $alamat;
                $response['no_tlp'] = $no_tlp;
                $response['nik'] = $nik;


                $response['message'] = "Registrasi Berhasil";
                echo json_encode($response);
            } else {
                $response['value'] = 0;
                $response['message'] = "Gagal Registrasi";
                echo json_encode($response);
            }
        }
    }

    ?>