#!/bin/bash

# Function to display menu
display_menu() {
    echo "===== Manajemen File Menu ====="
    echo "1. List Direktori"
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

# Function to execute selected menu option
execute_option() {
    case $1 in
        1) ls -l ;;
        2) read -p "Masukkan nama direktori baru: " new_dir_name
           mkdir "$new_dir_name" ;;
        3) read -p "Masukkan path file/direktori yang akan disalin: " source_path
           read -p "Masukkan path tujuan penyimpanan: " destination_path
           cp -r "$source_path" "$destination_path" ;;
        4) read -p "Masukkan path file/direktori yang akan dipindahkan: " source_path
           read -p "Masukkan path tujuan penyimpanan: " destination_path
           mv "$source_path" "$destination_path" ;;
        5) read -p "Masukkan nama file/direktori yang akan dihapus: " target
           rm -rf "$target" ;;
        6) read -p "Masukkan nama lama file/direktori: " old_name
           read -p "Masukkan nama baru file/direktori: " new_name
           mv "$old_name" "$new_name" ;;
        7) read -p "Masukkan nama file yang akan ditampilkan: " target_file
           cat "$target_file" ;;
        8) read -p "Masukkan nama file yang ingin dicari: " file_name
           read -p "Masukkan lokasi pencarian (default: ~): " search_location
           search_location=${search_location:-~}
           find "$search_location" -name "$file_name" ;;
        9) read -p "Masukkan hak akses baru (mode dalam angka): " mode
           read -p "Masukkan nama file/direktori: " target
           chmod "$mode" "$target" ;;
        10) read -p "Masukkan nama direktori yang akan dikompres: " source_dir
            read -p "Masukkan nama arsip (tanpa ekstensi): " archive_name
            tar -czvf "$archive_name.tar.gz" "$source_dir"
            echo "Arsip telah dibuat: $archive_name.tar.gz"
            ;;
        11) read -p "Masukkan nama direktori: " dir_name
            if [ -d "$dir_name" ]; then
                echo "File yang ada di dalam direktori $dir_name:"
                ls "$dir_name"
                read -p "Masukkan nama file yang ingin dibaca: " file_name
                if [ -f "$dir_name/$file_name" ]; then
                    cat "$dir_name/$file_name"
                else
                    echo "File tidak ditemukan di dalam direktori $dir_name"
                fi
            else
                echo "Direktori $dir_name tidak ada"
            fi
            ;;
        0) echo "Terima kasih, sampai jumpa!"
           exit ;;
        *) echo "Pilihan tidak valid" ;;
    esac
}

# Main program
while true
do
    display_menu
    read -p "Pilih fitur (0-11): " choice
    echo "==============================="
    execute_option "$choice"
    echo "==============================="
done