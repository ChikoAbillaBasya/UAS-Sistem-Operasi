#!/bin/bash

echo "======================================================"
echo "       Selamat Datang di Aplikasi Manajemen File      "
echo "======================================================"
echo "=================== Dibuat Oleh ======================"
echo "                 Chiko Abilla Basya                   "
echo "                    2341720005                        "
echo "=================== Kelas TI-1B ======================"

# Fungsi untuk menampilkan menu
tampilkan_menu() {
    echo "===== Menu Manajemen File ====="
    echo "1. Daftar Direktori"
    echo "2. Buat Direktori Baru"
    echo "3. Salin File atau Direktori"
    echo "4. Pindahkan File atau Direktori"
    echo "5. Hapus File atau Direktori"
    echo "6. Ganti Nama File atau Direktori"
    echo "7. Tampilkan Isi File Teks"
    echo "8. Cari File Berdasarkan Nama"
    echo "9. Ubah Hak Akses File atau Direktori"
    echo "10. Kompres dan Ekstrak Arsip"
    echo "11. Baca File yang Ada di Dalam Direktori"
    echo "0. Keluar"
    echo "==============================="
}

# Fungsi untuk menampilkan isi direktori
daftar_direktori() {
    ls -l 
}

# Fungsi untuk membuat direktori baru
buat_direktori() {
    read -p "Masukkan nama direktori baru: " nama_direktori_baru
    mkdir -p "$nama_direktori_baru"
    echo "Direktori '$nama_direktori_baru' telah dibuat."
}

# Fungsi untuk menyalin file atau direktori
salin_file_atau_direktori() {
    read -p "Masukkan path file/direktori yang akan disalin: " path_sumber
    read -p "Masukkan path tujuan penyimpanan: " path_tujuan
    cp -r "$path_sumber" "$path_tujuan"
    echo "File/Direktori '$path_sumber' telah disalin ke '$path_tujuan'."
}

# Fungsi untuk memindahkan file atau direktori
pindahkan_file_atau_direktori() {
    read -p "Masukkan path file/direktori yang akan dipindahkan: " path_sumber
    read -p "Masukkan path tujuan penyimpanan: " path_tujuan
    mv "$path_sumber" "$path_tujuan"
    echo "File/Direktori '$path_sumber' telah dipindahkan ke '$path_tujuan'."
}

# Fungsi untuk menghapus file atau direktori
hapus_file_atau_direktori() {
    read -p "Masukkan nama file/direktori yang akan dihapus: " target
    rm -rf "$target"
    echo "File/Direktori '$target' telah dihapus."
}

# Fungsi untuk mengganti nama file atau direktori
ganti_nama_file_atau_direktori() {
    read -p "Masukkan nama lama file/direktori: " nama_lama
    read -p "Masukkan nama baru file/direktori: " nama_baru
    mv "$nama_lama" "$nama_baru"
    echo "File/Direktori '$nama_lama' telah diganti namanya menjadi '$nama_baru'."
}

# Fungsi untuk menampilkan isi file teks
tampilkan_isi_file_teks() {
    read -p "Masukkan nama file yang akan ditampilkan: " nama_file
    cat "$nama_file"
}

# Fungsi untuk mencari file berdasarkan nama
cari_file_berdasarkan_nama() {
    read -p "Masukkan nama file yang ingin dicari: " nama_file
    read -p "Masukkan lokasi pencarian (default: ~): " lokasi_pencarian
    lokasi_pencarian=${lokasi_pencarian:-~}
    find "$lokasi_pencarian" -name "$nama_file"
}

# Fungsi untuk mengubah hak akses file atau direktori
ubah_hak_akses() {
    read -p "Masukkan hak akses baru (mode dalam angka): " mode
    read -p "Masukkan nama file/direktori: " target
    chmod "$mode" "$target"
    echo "Hak akses '$target' telah diubah menjadi '$mode'."
}

# Fungsi untuk kompres atau ekstrak arsip
kompres_atau_ekstrak_arsip() {
    echo "1. Kompres Direktori"
    echo "2. Ekstrak Arsip"
    read -p "Pilih opsi (1-2): " opsi_arsip
    case $opsi_arsip in
        1) read -p "Masukkan nama direktori yang akan dikompres: " direktori_sumber
           read -p "Masukkan nama arsip (tanpa ekstensi): " nama_arsip
           tar -czvf "$nama_arsip.tar.gz" "$direktori_sumber"
           echo "Direktori '$direktori_sumber' telah dikompres menjadi '$nama_arsip.tar.gz'."
           ;;
        2) read -p "Masukkan nama arsip yang akan diekstrak: " file_arsip
           read -p "Masukkan direktori tujuan: " direktori_tujuan
           mkdir -p "$direktori_tujuan"
           tar -xzvf "$file_arsip" -C "$direktori_tujuan"
           echo "Arsip '$file_arsip' telah diekstrak ke '$direktori_tujuan'."
           ;;
        *) echo "Pilihan tidak valid." ;;
    esac
}

# Fungsi untuk membaca file dalam direktori
baca_file_dalam_direktori() {
    read -p "Masukkan nama direktori: " nama_direktori
    if [ -d "$nama_direktori" ]; then
        echo "File yang ada di dalam direktori $nama_direktori:"
        ls "$nama_direktori"
        read -p "Masukkan nama file yang ingin dibaca: " nama_file
        if [ -f "$nama_direktori/$nama_file" ]; then
            cat "$nama_direktori/$nama_file"
        else
            echo "File tidak ditemukan di dalam direktori $nama_direktori"
        fi
    else
        echo "Direktori $nama_direktori tidak ada"
    fi
}

# Fungsi untuk menjalankan opsi yang dipilih
jalankan_aksi() {
    case $1 in
        1) daftar_direktori ;;
        2) buat_direktori ;;
        3) salin_file_atau_direktori ;;
        4) pindahkan_file_atau_direktori ;;
        5) hapus_file_atau_direktori ;;
        6) ganti_nama_file_atau_direktori ;;
        7) tampilkan_isi_file_teks ;;
        8) cari_file_berdasarkan_nama ;;
        9) ubah_hak_akses ;;
        10) kompres_atau_ekstrak_arsip ;;
        11) baca_file_dalam_direktori ;;
        0) echo "Terima kasih, sampai jumpa!"
           exit ;;
        *) echo "Pilihan tidak valid" ;;
    esac
}

# Loop utama program
while true
do
    tampilkan_menu
    read -p "Pilih fitur (0-11): " pilihan
    echo "==============================="
    jalankan_aksi "$pilihan"
    echo "==============================="
done