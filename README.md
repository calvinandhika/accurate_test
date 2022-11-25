## Cara penggunaan aplikasi
1. aplikasi dapat berjalan di iOS dan Android berkat dibuat menggunakan Flutter
2. di halaman homepage atau halaman awal pengguna aplikasi dapat melihat seluruh user yang terdaftar
3. pengguna aplikasi dapat melakukan pencarian dengan memasukan nama di search bar di atas lalu submit
4. bila search bar kosong maka secara otomatis akan dilakukan search all atau semua database user
5. filter dapat langsung digunakan dengan menekan chip, pengguna dapat melakukan sort ascending atau descending berdasarkan nama user
6. selain itu pengguna juga dapat melakukan filter berdasarkan kota dengan menekan chip yang tersedia
7. chip kota berasal dari data API kota yang diberikan
8. pengguna aplikasi juga dapat menekan salah satu user card untuk dapat menuju ke halaman user detail
9. di halaman tambah user, pengguna aplikasi dapat mengisi form yang tersedia dan menekan tombol submit, maka akan ada loading dialog dan muncul dialog sukses beserta data user yang baru ditambahkan
10. user yang baru ditambahkan akan automatis masuk dalam list user yang ada di homepage berkat penggunaan BlocBuilder
11. error handling juga sudah diterapkan khususnya untuk Exception Dio.

## Teknologi yang digunakan
1. State management menggunakan BLOC
2. navigasi menggunakan Getx
3. HTTP Request menggunakan Dio
4. Error handling dan menunjukan Dialog
5. Mengimplementasikan Loading state, sehingga pengguna aplikasi tetap mendapatkan feedback saat applikasi sedang dalam proses asyncronous
6. filter dan sort user
7. Sebisa mungkin memisahkan Logic dengan UI agar code tidak sulit dimengerti dan sebisa mungkin menerapkan clean code

## accurate_test project

![Simulator Screen Shot - iPhone 14 - 2022-11-26 at 04 13 45](https://user-images.githubusercontent.com/10304331/204056205-d0981e20-da92-4f37-a377-56d3b2f285d4.png)
![Simulator Screen Shot - iPhone 14 - 2022-11-26 at 04 16 33](https://user-images.githubusercontent.com/10304331/204056646-25087523-99ba-4605-8db1-48d745bbeb49.png)
![image](https://user-images.githubusercontent.com/10304331/204057048-ce18b9a2-ef78-483d-8862-27166db4138a.png)


