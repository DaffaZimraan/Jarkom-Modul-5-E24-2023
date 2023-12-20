# Jarkom-Modul-5-E24-2023
## Anggota Kelompok
1. Daffa Zimraan Hasan (5025221223)
2. Wardatul Amalia Safitri (5025211006)

## Topologi
![topologimodul5](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/topologimodul5.jpg) </br>

## VLSM
Berikut ini pembagian subnet berdasarkan topologi tersebut: </br>
![topologifixmodul5](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/topologifixmodul5.jpg) </br>
Berdasarkan pembagian subnet kami mendapatkan rute sebagai berikut: </br>
![rute](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/rute.png)
Berikut pembagian ip menggunakan tree dengan metode vlsm: </br>
![treemodul5](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/treemodul5.jpg) </br>
Berdasarkan tree, kami mendapatkan pembagian ip sebagai berikut: </br>
![ip](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/ip.png)
## Soal 1
### Pertanyaan
>Agar topologi yang kalian buat dapat mengakses keluar, kalian diminta untuk mengkonfigurasi Aura menggunakan iptables, tetapi tidak ingin menggunakan MASQUERADE.

### Penyelesaian
Agar topologi dapat mengakses keluar menggunakan iptables, maka script yang digunakan adalah sebagai berikut
```
iptables -t nat -A POSTROUTING -s 192.218.0.0/20 -o eth0 -j SNAT --to-source $(hostname -I | awk '{print $1}')
```
iptables yang digunakan adalah NAT Table, kemudian chain yang digunakan adalah `POSTROUTING` dan sourcenya adalah NID topologi, yaitu `192.218.0.0`.
![no1.1](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no1.1.png)
![no1.2](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no1.2.png)
![no1.3](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no1.3.png)
![no1.4](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no1.4.png)

## Soal 2
### Pertanyaan
>Kalian diminta untuk melakukan drop semua TCP dan UDP kecuali port 8080 pada TCP.

### Penyelesaian
Pada client, tambahkan rule berikut
```
iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
iptables -A INPUT -p tcp -j DROP
iptables -A INPUT -p udp -j DROP
```
Untuk menyaring semua paket yang masuk sesuai ketentuan soal, maka chain yang diguanakan adalah `INPUT`. Terdapat 3 rule yang diterpakan dalam soal ini. Rule pertama digunakan untuk menerima paket TCP yang memasuki port 8080. Rule kedua digunakan untuk drop semua paket TCP yang tidak memenuhi rule pertama. Rule ketiga digunakan untuk drop semua paket UDP.
![no2.1](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no2.1.png)
![no2.2](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no2.2.png)

## Soal 3
### Pertanyaan
>Kepala Suku North Area meminta kalian untuk membatasi DHCP dan DNS Server hanya dapat dilakukan ping oleh maksimal 3 device secara bersamaan, selebihnya akan di drop.

### Penyelesaian
Pada node DHCP Server (Revolte) dan DNS Server (Richter) tambahkan rule berikut
```
iptables -A INPUT -p icmp -m connlimit --connlimit-above 3 --connlimit-mask 0 -j DROP
```
dalam rule ini menggunakan chain `INPUT` dan protokol `icmp` untuk menyaring ping yang masuk ke node Revolte dan Richter. Kemudian ditambahkan `connlimit` sebagai batasan device yang dapat melakukan ping ke revolte di wkatu bersamaan. Jika lebih dari 3, maka akan di-drop
![no3.1](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no3.1.png)
![no3.2](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no3.2.png)
![no3.3](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no3.3.png)
![no3.4](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no3.4.png)

## Soal 4
### Pertanyaan
>Lakukan pembatasan sehingga koneksi SSH pada Web Server hanya dapat dilakukan oleh masyarakat yang berada pada GrobeForest.

### Penyelesaian
Pada web server Sein dan Stark tambahkan rule sebagai berikut
```
iptables -A INPUT -p tcp --dport 22 -s 192.218.4.0/22 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j DROP
```
Rule ini menggunakan chain `INPUT` dan hanya diterapkan pada protokol `tcp` untuk SSH web server. port yang dimasukkan ke dalam rule adalah port 22. Yang diterima hanyalah input dari subnet GrobeForest, yaitu 192.218.4.0/22. Selain subnet ini, maka paket akan di-drop.
![no4.1](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no4.1.png)
![no4.2](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no4.2.png) </br>
![no4.3](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no4.3.png)
![no4.4](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no4.4.png)

## Soal 5
### Pertanyaan
>Selain itu, akses menuju WebServer hanya diperbolehkan saat jam kerja yaitu Senin-Jumat pada pukul 08.00-16.00.

### Penyelesaian
Pada web server Sein dan Stark tambahkan rule berikut
```
iptables -A INPUT -p tcp --dport 22 -m time --weekdays Mon,Tue,Wed,Thu,Fri --timestart 08:00 --timestop 16:00 -s 192.218.4.0/22 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j DROP
```
Rule pertama menyatakan bahwa akses menuju webserver hanya diperbolehkan pada hari Senin, Selasa, Rabu, Kamis, dan Jumat mulai dari pukul 08.00 hingga 16.00. Sedangkan rule kedua menyatakan paket yang dikirim di luar waktu tersebut akan didrop
![no5.1](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no5.1.png)
![no5.2](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no5.2.png)

## Soal 6
### Pertanyaan
>Lalu, karena ternyata terdapat beberapa waktu di mana network administrator dari WebServer tidak bisa stand by, sehingga perlu ditambahkan rule bahwa akses pada hari Senin - Kamis pada jam 12.00 - 13.00 dilarang (istirahat maksi cuy) dan akses di hari Jumat pada jam 11.00 - 13.00 juga dilarang (maklum, Jumatan rek).

### Penyelesaian
Terdapat tambahan rule pada web server Sein dan Stark. Tambahan rule tadi diletakkan di atas rule no 5 karena akan menjadi rule yang lebih dulu dicek
```
iptables -A INPUT -p tcp --dport 22 -m time --weekdays Mon,Tue,Wed,Thu --timestart 12:00 --timestop 13:00 -j DROP
iptables -A INPUT -p tcp --dport 22 -m time --weekdays Fri --timestart 11:00 --timestop 13:00 -j DROP
iptables -A INPUT -p tcp --dport 22 -m time --weekdays Mon,Tue,Wed,Thu,Fri --timestart 08:00 --timestop 16:00 -s 192.218.4.0/22 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j DROP
```
Rule yang baru ditambahkan ini akan melakukan drop paket yang masuk pada hari Senin, Selasa, Rabu, Kamis pada pukul 12.00 - 13.00. Serta drop paket yang masuk pada hari jumat pukul 11.00 - 13.00. Selain itu, akan mengikuti rule seperti nomor 5
![no6.1](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no6.1.png)
![no6.2](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no6.2.png)

## Soal 7
### Pertanyaan
>Karena terdapat 2 WebServer, kalian diminta agar setiap client yang mengakses Sein dengan Port 80 akan didistribusikan secara bergantian pada Sein dan Stark secara berurutan dan request dari client yang mengakses Stark dengan port 443 akan didistribusikan secara bergantian pada Sein dan Stark secara berurutan.

### Penyelesaian
Pada router Frieren dan Heiter, tambahkan rule sebagai berikut
```
iptables -A PREROUTING -t nat -p tcp --dport 80 -d 192.218.4.2 -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 192.218.4.2
iptables -A PREROUTING -t nat -p tcp --dport 80 -d 192.218.4.2 -j DNAT --to-destination 192.218.0.14
iptables -A PREROUTING -t nat -p tcp --dport 443 -d 192.218.0.14 -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 192.218.0.14
iptables -A PREROUTING -t nat -p tcp --dport 443 -d 192.218.0.14 -j DNAT --to-destination 192.218.4.2
```
Rule ini akan mengarahkan semua akses tcp dengan port 80 dan port 443 ke web server Sein dan Stark. Routing akan dilakukan secara bergantian antara Sein dan Stark
![no7.1](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no7.1.png)
![no7.2](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no7.2.png)
![no7.3](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no7.3.png)
![no7.4](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no7.4.png)
![no7.5](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no7.5.png)
![no7.6](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no7.6.png)


## Soal 8
### Pertanyaan
>Karena berbeda koalisi politik, maka subnet dengan masyarakat yang berada pada Revolte dilarang keras mengakses WebServer hingga masa pencoblosan pemilu kepala suku 2024 berakhir. Masa pemilu (hingga pemungutan dan penghitungan suara selesai) kepala suku bersamaan dengan masa pemilu Presiden dan Wakil Presiden Indonesia 2024.

### Penyelesaian
Pada node Sein dan Stark tambahkan rule berikut
```
iptables -A INPUT -p tcp --dport 80 -m time --datestart "2024-02-14T00:00" --datestop "2024-06-26T23:59" -s 192.218.0.0/30 -j DROP
```
Rule ini akan membuat paket dengan protokol tcp dan port 80 yang dikirim ke web server dalam kurun waktu tersebut di-drop
![no8.1](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no8.1.png)
![no8.2](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no8.2.png)

## Soal 9
### Pertanyaan
>Sadar akan adanya potensial saling serang antar kubu politik, maka WebServer harus dapat secara otomatis memblokir  alamat IP yang melakukan scanning port dalam jumlah banyak (maksimal 20 scan port) di dalam selang waktu 10 menit. 
(clue: test dengan nmap)

### Penyelesaian
Tambahkan rule berikut di node Sein dan Stark
```
iptables -N tab_scan
iptables -A INPUT -m recent --name tab_scan --update --seconds 600 --hitcount 20 -j DROP
iptables -A FORWARD -m recent --name tab_scan --update --seconds 600 --hitcount 20 -j DROP
iptables -A INPUT -m recent --name tab_scan --set -j ACCEPT
iptables -A FORWARD -m recent --name tab_scan --set -j ACCEPT
```
Rule-rule di atas akan melakukan scanning terhadap paket yang masuk ke web server. `--seconds 600` akan melakukan perhitungan interval waktu. Dalam kasus ini, wkatu yang digunakan adalah 600 detik (10 menit). Kemudian `--hitcount 20` akan memberi batasan maksimum berapa paket yang masuk dalam interval tersebut. Dalam kasus ini, nilai maksimum permintaan adalah 20 kali.
![no9](https://github.com/DaffaZimraan/Jarkom-Modul-5-E24-2023/blob/main/image/no9.png)

## Soal 10
### Pertanyaan
>Karena kepala suku ingin tau paket apa saja yang di-drop, maka di setiap node server dan router ditambahkan logging paket yang di-drop dengan standard syslog level. 

### Penyelesaian



