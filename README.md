# Penyelesaian Soal Shift Modul 1

- Ega Prabu Pamungkas (05111940000014)
- A. Zidan Abdillah Majid (05111940000070)
- Jundullah Hanif Robbani (05111940000144)

-------------------------------------------
## Soal 1

## Soal 2

## Soal 3
### Soal 3a
Permasalahan dalam soal ini dapat dibagi menjadi 3 bagian.
1. Mendownload gambar pada link yang disediakan dan menaruh log pada Foto.log.
2. Mengecek foto yang didownload apakah sama dengan yang telah didownload sebelumnya.
3. Penamaan foto yang terdownload "Koleksi_XX".

Permasalahan pertama, dapat diselesaikan dengan menggunakan "wget -a Foto.log 'https://loremflickr.com/320/240/kitten'" dimana command 'wget' digunakan untuk mendownload gambar pada link yang diberikan lalu option -a akan meletakkan log pada file Foto.log, jika tidak ada file maka akan membuat baru, jika sudah ada akan menambahkan log-nya pada akhir baris Foto.log.

Permasalahan kedua, dapat diselesaikan dengan mengecek jika nomor kurang dari 10 maka penamaanya "Koleksi_0$nomor", sedangkan jika lebih dari sama dengan 10 "Koleksi_$nomor" (meskipun permasalahan ini dapat diseslesaikan dengan mengganti penamaanya sendiri dengan "Koleksi_$nomor")

Permasalahan ketiga, diselesaikan dengan mengecek md5sum file yang telah terdownload sebelum file tersebut diubah penamaannya menjadi "Koleksi_XX"

### Soal 3b
Permasalahan dalam soal ini dapat dibagi menjadi 3 bagian.
1. Menjalankan script tepat sekali pada jam 8 malam di tanggal 1,8,... dan tanggal 2,6,...
2. Membuat direktori dengan nama tanggal didownloadnya Koleksi tersebut.
3. Memindahkan Foto.log dan semua koleksi foto ke dalam direktori.

Pada permasalahan pertama, untuk membuat bash script berjalan dengan iterasi +7 dimulai dari 1, dapat dibuat pada bagian tanggal 1-31/7, begitu juga dengan iterasi +4 dimulai dari 2 yaitu dibuat 2-31/4 pada cron jobs. Sel.ain itu pada bagain jam dibuat 20, serta menit dibuat 0 agar tepat berjalan satu kali tepat pada jam 8 malam.

Pada permasalahan kedua dan ketiga, dapat dijalankan dengan menambahkan && pada setiap setelah command, urutan yang dilakukan yaitu membuat direktori dengan nama menggunakan "mkdir $(date +%d%m%Y)", menjalankan bash script soal3a, memindahkan Foto.log dan koleksi foto dengan command "mv Foto.log Koleksi_* $(date +%d%m%Y)".

### Soal 3c
Permasalahan dalam soal ini dapat dibagi menjadi 2 bagian.
1. Memodifikasi bash script soal3a untuk mendownload foto pada "https://loremflickr.com/320/240/bunny"
2. Meletakkan Foto.log dan koleksi foto yang didownload di folder "Kucing_(tanggal sekarang)" jika yang didownload foto kucing, "Kelinci_(tanggal sekarang)" jika yang didownload foto kelinci
3. Menyetel agar bash script mendownload bergantian antara foto kucing dan foto kelinci, jika tanggal 31 kucing > tanggal 1 kelinci > dst.

Permasalahan pertama, dapat diselesaikan dengan mudah yaitu mengubah link pada 'wget' sehingga mendownload foto pada "https://loremflickr.com/320/240/".

Permasalahan kedua, dapat diselesaikan dengan terlebih dahulu mendefinisikan fungsi kucing dan kelinci sehingga dapat dipisah pembuatan direktorinya, dengan menggunakan 'mkdir $(date +%d%m%Y)', selain itu juga dicek jika direktori telah dibuat maka tidak perlu membuat direktori baru.

Permasalahan ketiga, dengan cara mengecek apakah direktori yang dibuat kemarin direktori untuk kucing atau direktori untuk kelinci. Command untuk mengambil tanggal kemarin adalah "$(date -d 'yesterday' +%d%m%Y)". Jika nama direktori yang dibuat kemarin "Kelinci_(tanggal kemarin)" maka jalankan fungsi kucing, jika "Kucing_(tanggal kemarin)" jalankan fungsi kelinci, selain itu semua yang aku pilih duluan adalah mendownload foto kucing maka jalankan fungsi kucing terlebih dahulu.

### Soal 3d
Permasalahan dalam soal ini hanya ada dua.
1. Meng-compress folder-folder Kucing dan Kelinci dengan password tanggal sekarang.
2. Menghapus folder-folder Kucing dan Kelinci yang telah di-compress.

Permasalahan pertama, cukup sederhana dengan menggunakan command 'zip' ditambah opsi -e untuk menambahkan enkripsi, -q untuk tidak menampilkan comment prompts, -P untuk menambahkan enkripsinya. Enkripsi tanggal sekarang dapat diambil dengan "$(date +%d%m%Y)". Lalu diikuti dengan nama zip yaitu 'Koleksi.zip' dan semua direktori Kucing dan Kelinci dengan menambahkan * di belakangnya. 

Permasalahan kedua cukup sederhana, menghapus semua direktori dengan menggunakan 'rm -r' diikuti direktori yang akan dihapus, yaitu kucing dan kelinci.

### Soal 3e
Permasalahan dalam soal ini ada dua.
1. Mengkompres semua folder Kucing dan Kelinci pada hari Senin - Jumat pukul 7 sampai 6 sore
2. Meng-ekstrak 'Koleksi.zip' selain hari yang disebutkan di nomor 1 dan menghapus file 'Koleksi.zip'

Permasalahan pertama, dapat diselesaikan dengan menggunakan cron jobs dimana jam dibuat 7-17, serta hari dalam satu minggu dibuat 1-5, serta yang lain dibuat all ("\*") lalu menjalankan bash script dari soal3d, bernama 'soal3d.sh'

Permasalahan kedua, diselesaikan dengan membuat 2 cron job dimana yang satu memiliki konfigurasi * 0-6,18-23 * * 1-5 dimana aturan itu membuat setiap menit pada jam 0 sampai jam 6 juga pada jam 18 sampai jam 23 pada hari Senin sampai Jumat untuk menjalankan command 'find '/home/prabu/soal3/Koleksi.zip' -exec /usr/bin/unzip -P $(date +%d%m%Y) {} \; -delete' dimana command tersebut mencari file Koleksi.zip dan menjalankan 'unzip' dengan memasukkan password berupa tanggal sekarang dan setelah itu menghapus file 'Koleksi.zip tersebut'. Cron job juga dibuat untuk hari Sabtu dan Minggu sehingga menjadi '* * * * 6-7'.