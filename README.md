# Penyelesaian Soal Shift Modul 1

- Ega Prabu Pamungkas (05111940000014)
- A. Zidan Abdillah Majid (05111940000070)
- Jundullah Hanif Robbani (05111940000144)

-------------------------------------------
## Soal 1
### Cara pengerjaan
1. Mendeklarasi bahwa variabel `user error_msg user_error user_info` itu akan menjadi array asosiatif dengan menggunakan `declare -A (variabel)`.
1. Membuat regex yang akan digunakan oleh program `sed`.  Untuk regexnya menggunakan `[^:]*:[^:]*:[^:]*: \([^ ]*\) \([^[#]*\) [^\(]*(\([^)]*\).*`, penjelasannya:

    - `*` untuk mencocokkan karakter sebanyak 1 atau lebih.
    - `*:` untuk mencocokkan karakter sebanyak 1 atau lebih sampai bertemu dengan karakter `:`.
    - `*(` untuk mencocokkan karakter sebanyak 1 atau lebih sampai bertemu dengan karakter `(`.
    - `.*` untuk mencocokkan sembarang karakter sebanyak 1 atau lebih.
    - `[^:]` untuk mencocokkan selama belum ketemu karakter `:`.
    - `\([^ ]*\) ` untuk mencocokkan selama belum ketemu karakter `(space)`, digabung dengan karakter `(space)` setelahnya. Terdapat `\(...\)` karena akan digunakan sebagai argumen di `sed`.
    - `\([^[#]*\) ` untuk mencocokkan selama belum ketemu karakter `[#`, digabung dengan karakter `(space)` setelahnya. Terdapat `\(...\)` karena akan digunakan sebagai argumen di `sed`.
    - `[^\(]` untuk mencocokkan selama belum ketemu karakter `(`.
    - `\([^)]*\)` untuk mencocokkan selama belum ketemu karakter `)`. Terdapat `\(...\)` karena akan digunakan sebagai argumen di `sed`.

1. Semua user yang ada di `syslog.log` dimasukkan ke variabel `user`, dengan username digunakan sebagai key agar unik. Di sini dapat memanfaatkan program `sed` untuk membuat syntax shell perubahan array `user` yang kemudian dieksekusi oleh `eval`.
1. Menghitung semua pesan error yang ada di `syslog.log`, lalu dimasukkan ke variabel `error_msg`, dengan pesan log digunakan sebagai key agar unik. Di sini dapat memanfaatkan program `sed` untuk membuat syntax shell increment `error_msg[KEY]` yang kemudian dieksekusi oleh `eval`.
1. Menghitung banyak pesan error dan info per user dengan memanfaatkan key dari array `user`. Key dari `user` didapatkan dengan `"${!user[@]}"`, lalu dilooping dan key-nya digunakan oleh grep untuk mencari pesan error dan info terkait. Untuk grep, `grep -E "ERROR.*$key" $syslog` digunakan untuk mencari error, dan `grep -E "INFO.*$key" $syslog ` digunakan untuk mencari info. Setelah dicari barisnya menggunakan grep, penghitungan baris dilakukan dengan pipeline hasil grep ke perintah `wc -l`.
1. Dilakukan looping untuk memasukkan hasil ke file `*.csv` terkait. Untuk `error_message.csv`, sebelum dimasukkan file, isi disorting terlebih dahulu dengan perintah `sort -k2 -n -t, -r`, dengan `-k2` menunjukkan sorting berdasarkan kolom ke-2 (Count), `-n` menunjukkan sorting ala angka, `-t,` menunjukkan delimiter menggunakan koma, `-r` menunjukkan sorting secara descending. Untuk `user_statistic.csv`, sebelum dimasukkan ke file, isi disorting terlebih dahulu dengan perintah `sort -k1 -t,`.
### Screenshot
| ![image](https://user-images.githubusercontent.com/40772378/112722246-e652e700-8f3a-11eb-8074-a36014c5ffdf.png) | 
|:--:| 
| *Saat mengkoding solusi* |

| ![image](https://user-images.githubusercontent.com/40772378/112722257-f965b700-8f3a-11eb-8c16-d3fb580b67a3.png) | 
|:--:| 
| *Tab browser yang penuh* |

### Kendala yang dialami
Masih belum lancar membaca, maupun membuat regex. Mungkin karena regex tidak terlihat seperti kalimat biasa, sehingga tidak enak di mata.
## Soal 2

## Soal 3
### Soal 3a
Permasalahan dalam soal ini dapat dibagi menjadi 3 bagian.
1. Mendownload gambar pada link yang disediakan dan menaruh log pada Foto.log.
2. Mengecek foto yang didownload apakah sama dengan yang telah didownload sebelumnya.
3. Penamaan foto yang terdownload "Koleksi_XX".

Permasalahan pertama, dapat diselesaikan dengan menggunakan `wget -o temp.log 'https://loremflickr.com/320/240/kitten'` dimana command `wget` digunakan untuk mendownload gambar pada link yang diberikan lalu option `-o` untuk menyimpan log download pada sebuah file. Log file dibuat `temp.log` yang akan digunakan untuk membandingkan apakah ada foto sama yang telah didownload, menggunakan **awk**. Membandingakannya dengan cara membandingkan log download yang telah dilakukan dengan log download sebelumnya. Yang membedakan log download satu dengan lainnya adalah lokasi mendownload gambarnya.

![log](https://user-images.githubusercontent.com/68368240/113421376-32979e80-93f5-11eb-8368-da0115646e73.png)
|:--:|
| *Baris Location pada Log* |


Dengan begitu dapat dibandingkan menggunakan awk dan bash script.

![compare-image](https://user-images.githubusercontent.com/68368240/113421445-535ff400-93f5-11eb-9815-905f75633801.png)
|:--:| 
| *Compare script using AWK and BASH* |

`-v` untuk mempassing variable yang akan digunakan *awk*. `~` digunakan untuk membandingkan string dimana sebelah kiri adalah ekspresi biasa dan sebelah kanan adalah string-nya, sehingga jika sama akan bernilai 1 jika tidak akan bernilai 0. Jika bernilai 1 variable `compare` akan berisi string, jika bernilai 0 maka `compare` akan kosong sehingga untuk melihat apakah sama atau tidak dengan melihat panjang string `compare` apakah lebih besar dari 1 atau tidak.

Penamaan file dapat menggunakan `%02d` untuk memberikan padding `0` di depan pada saat penamaan file.

### Soal 3b *(Masih diperbaiki)*
Permasalahan dalam soal ini dapat dibagi menjadi 3 bagian.
1. Menjalankan script tepat sekali pada jam 8 malam di tanggal 1,8,... dan tanggal 2,6,...
2. Membuat direktori dengan nama tanggal didownloadnya Koleksi tersebut.
3. Memindahkan Foto.log dan semua koleksi foto ke dalam direktori.

Pada permasalahan pertama, menit dapat dibuat `0`, jam dibuat `20`, agar dapat berjalan sekali, untuk tanggal dapat dibuat `1/7,2/4` dimana `/` menunjukkan step atau jumlah sehingga untuk 1 akan +7 terus, sedangkan untuk 2 akan +4 terus.

Pada permasalahan kedua dan ketiga, dapat dijalankan dengan menambahkan `&&` pada setiap setelah command, urutan yang dilakukan yaitu membuat direktori dengan nama menggunakan `mkdir $(date +%d%m%Y)`, menjalankan bash script `soal3a.sh`, memindahkan `Foto.log` dan koleksi foto dengan command `mv Foto.log Koleksi_* $(date +%d%m%Y)`.

*GAMBAR CRON3b*

### Soal 3c
Permasalahan dalam soal ini dapat dibagi menjadi 2 bagian.
1. Memodifikasi bash script soal3a untuk mendownload foto pada "https://loremflickr.com/320/240/bunny"
2. Meletakkan Foto.log dan koleksi foto yang didownload di folder "Kucing_(tanggal sekarang)" jika yang didownload foto kucing, "Kelinci_(tanggal sekarang)" jika yang didownload foto kelinci
3. Menyetel agar bash script mendownload bergantian antara foto kucing dan foto kelinci, jika tanggal 31 kucing > tanggal 1 kelinci > dst.

Permasalahan pertama, dapat diselesaikan dengan mudah yaitu mengubah link pada `wget` sehingga mendownload foto pada "https://loremflickr.com/320/240/".

Permasalahan kedua, dapat diselesaikan dengan terlebih dahulu mendefinisikan fungsi kucing dan kelinci sehingga dapat dipisah pembuatan direktorinya, dengan menggunakan `mkdir $(date +%d%m%Y)`, selain itu juga dicek jika direktori telah dibuat maka tidak perlu membuat direktori baru.

Permasalahan ketiga, dengan cara mengecek apakah direktori yang dibuat kemarin direktori untuk kucing atau direktori untuk kelinci. Command untuk mengambil tanggal kemarin adalah `$(date -d 'yesterday' +%d%m%Y)`. Jika nama direktori yang dibuat kemarin *Kelinci_(tanggal kemarin)* maka jalankan fungsi kucing, jika *Kucing_(tanggal kemarin)* jalankan fungsi *kelinci*, selain itu semua yang dipilih duluan adalah mendownload foto kucing maka jalankan fungsi *kucing* terlebih dahulu. `pwd` digunakan agar path yang digunakan akan sama dengan tempat `soal3c.sh` dijalankan.

![folder-bergantian](https://user-images.githubusercontent.com/68368240/113421509-7094c280-93f5-11eb-962a-3cf0a76b32e1.png)
|:--:| 
| *Script mengecek Folder kemarin* |

### Soal 3d
Permasalahan dalam soal ini hanya ada dua.
1. Meng-compress folder-folder Kucing dan Kelinci dengan password tanggal sekarang.
2. Menghapus folder-folder Kucing dan Kelinci yang telah di-compress.

Permasalahan pertama, cukup sederhana dengan menggunakan command `zip` ditambah opsi `-e` untuk menambahkan enkripsi, `-q` untuk tidak menampilkan comment prompts, -P untuk menambahkan enkripsinya. Enkripsi tanggal sekarang dapat diambil dengan `$(date +%d%m%Y)`. Lalu diikuti dengan nama zip yaitu *Koleksi.zip* dan semua direktori Kucing dan Kelinci dengan menambahkan `*` di belakangnya. 

![zip](https://user-images.githubusercontent.com/68368240/113421566-8a360a00-93f5-11eb-94b3-089b32b1ee3a.png)
|:--:| 
| *Script untuk ZIP* |

Permasalahan kedua cukup sederhana, menghapus semua direktori dengan menggunakan `rm -r` diikuti direktori yang akan dihapus, yaitu *kucing* dan *kelinci*. ` /dev/null 2>&1 ` agar input yang error maupun tidak, tidak ditampilkan di terminal. 

![menghapus-direktori](https://user-images.githubusercontent.com/68368240/113421602-99b55300-93f5-11eb-843e-ee0a7e997e3b.png)
|:--:| 
| *Menghapus direktori setelah di-zip* |

### Soal 3e
Permasalahan dalam soal ini ada dua.
1. Mengkompres semua folder Kucing dan Kelinci pada hari Senin - Jumat pukul 7 sampai 6 sore
2. Meng-ekstrak *Koleksi.zip* selain hari yang disebutkan di nomor 1 dan menghapus file 'Koleksi.zip'

Permasalahan pertama, dapat diselesaikan dengan menggunakan cron jobs dimana menit dibuat `0`, jam dibuat `7`, hari dibuat `1-5` dimana `1` adalah Senin dan `5` adalah Kamis. Cron jobs di atas jadi hanya perlu dikerjakan satu kali.

Permasalahan kedua, dapat diselesaikan dengan menggunakan cron job dimana menit dibuat `0`, jam dibuat `18`, hari dibuat `1-5` dimana `1` adalah Senin dan `5` adalah Kamis. Cron jobs di atas jadi hanya perlu dikerjakan satu kali.

![cron3e](https://user-images.githubusercontent.com/68368240/113421680-b94c7b80-93f5-11eb-8b83-9c9ed6508323.png)
|:--:| 
| *Cron job untuk 3e* |

### Kendala yang dialami
Kesulitan dalam membuat cron job, mencari yang paling sederhana. Pemindahan penggunaan dari `bash` ke `AWK` untuk *soal3a* cukup bingung bagaimana `AWK` men-filter dan menjalankan prosesnya. Sempat tidak teliti dalam penggunaan variabel, dimana kurang penambahan `$` sebelum variabel sehingga beberapa script tidak berjalan. Penulisan lapres belum terlalu lihai dalam penggunaan  `ini` atau *ini* atau yang lainnya agar MD mudah dipahami dan dibaca.