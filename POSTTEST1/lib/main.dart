import 'package:flutter/material.dart';

void main() {
  // Menjalankan aplikasi CHERRYBOMB
  runApp(const MyApp());
}

// Widget utama aplikasi CHERRYBOMB
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp digunakan sebagai wrapper utama aplikasi
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CHERRYBOMB',
      theme: ThemeData(
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE83D5B),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF7F8),
      ),

      // Menentukan HomePage sebagai halaman utama aplikasi
      home: const HomePage(),
    );
  }
}

// Widget halaman utama CHERRYBOMB
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold digunakan sebagai struktur dasar halaman
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F8),

      // SafeArea menjaga konten agar tidak tertutup area perangkat
      body: SafeArea(
        // SingleChildScrollView membuat halaman dapat di-scroll
        child: SingleChildScrollView(
          // Padding memberikan jarak pada isi halaman
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 25),

            // Column menyusun seluruh konten halaman secara vertikal
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row menyusun bagian header secara horizontal
                Row(
                  children: [
                    // Container digunakan sebagai logo CHERRYBOMB
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFDCE4),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: const Color(0xFFFFC5D1),
                        ),
                      ),

                      // Column menyusun dekorasi cherry secara vertikal
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Row menyusun dua cherry secara horizontal
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon menampilkan cherry pertama
                              const Icon(
                                Icons.circle,
                                color: Color(0xFFE83D5B),
                                size: 17,
                              ),

                              // SizedBox memberikan jarak antar cherry
                              const SizedBox(width: 2),

                              // Icon menampilkan cherry kedua
                              const Icon(
                                Icons.circle,
                                color: Color(0xFFE83D5B),
                                size: 17,
                              ),
                            ],
                          ),

                          // Icon menampilkan dekorasi sparkle
                          const Icon(
                            Icons.auto_awesome,
                            color: Color(0xFFF2A5B5),
                            size: 12,
                          ),
                        ],
                      ),
                    ),

                    // SizedBox memberikan jarak antara logo dan nama
                    const SizedBox(width: 12),

                    // Expanded membuat informasi toko memenuhi ruang
                    Expanded(
                      // Column menyusun nama dan slogan secara vertikal
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text menampilkan nama toko
                          const Text(
                            'CHERRYBOMB',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.1,
                              color: Color(0xFF342A2D),
                            ),
                          ),

                          // SizedBox memberikan jarak
                          const SizedBox(height: 3),

                          // Text menampilkan slogan toko
                          Text(
                            'sweet things, big happiness ♡',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Container digunakan sebagai tombol visual keranjang
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE83D5B),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x30E83D5B),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),

                      // Icon menampilkan ikon shopping bag
                      child: const Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white,
                        size: 23,
                      ),
                    ),
                  ],
                ),

                // SizedBox memberikan jarak setelah header
                const SizedBox(height: 22),

                // Container digunakan sebagai search bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: const Color(0xFFFFD7DF),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x10000000),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),

                  // Row menyusun icon dan TextField secara horizontal
                  child: Row(
                    children: [
                      // Icon menampilkan ikon pencarian
                      const Icon(
                        Icons.search_rounded,
                        color: Color(0xFFE83D5B),
                        size: 22,
                      ),

                      // SizedBox memberikan jarak
                      const SizedBox(width: 8),

                      // Expanded memberikan ruang untuk TextField
                      Expanded(
                        // TextField digunakan untuk mencari produk
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search your favorite candy...',
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 13,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),

                      // Icon menampilkan ikon filter
                      Icon(
                        Icons.tune_rounded,
                        color: Colors.grey.shade400,
                        size: 20,
                      ),
                    ],
                  ),
                ),

                // SizedBox memberikan jarak setelah search bar
                const SizedBox(height: 25),

                // Container digunakan sebagai hero banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE83D5B),
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x35E83D5B),
                        blurRadius: 15,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),

                  // Row menyusun isi banner secara horizontal
                  child: Row(
                    children: [
                      // Expanded memberikan ruang pada informasi promo
                      Expanded(
                        // Column menyusun informasi promo secara vertikal
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Container digunakan sebagai badge promo
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFEEF2),
                                borderRadius: BorderRadius.circular(20),
                              ),

                              // Text menampilkan badge promo
                              child: const Text(
                                '✨ NEW DROP',
                                style: TextStyle(
                                  color: Color(0xFFE83D5B),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            // SizedBox memberikan jarak
                            const SizedBox(height: 12),

                            // Text menampilkan judul promo
                            const Text(
                              'Sweetness\nhas arrived! 🍒',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                                height: 1.08,
                              ),
                            ),

                            // SizedBox memberikan jarak
                            const SizedBox(height: 9),

                            // Text menampilkan deskripsi promo
                            const Text(
                              'Discover your new\nfavorite candy ♡',
                              style: TextStyle(
                                color: Color(0xFFFFEEF2),
                                fontSize: 12,
                                height: 1.4,
                              ),
                            ),

                            // SizedBox memberikan jarak
                            const SizedBox(height: 15),

                            // Container digunakan sebagai kode promo
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 11,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0x25FFFFFF),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0x45FFFFFF),
                                ),
                              ),

                              // Text menampilkan kode promo
                              child: const Text(
                                'CHERRY20  •  20% OFF',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Container digunakan sebagai dekorasi permen
                      Container(
                        width: 96,
                        height: 140,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFDCE4),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: const Color(0xFFFFC6D1),
                            width: 3,
                          ),
                        ),

                        // Column menyusun dekorasi permen secara vertikal
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon menampilkan cherry utama
                            const Icon(
                              Icons.circle,
                              color: Color(0xFFE83D5B),
                              size: 58,
                            ),

                            // SizedBox memberikan jarak
                            const SizedBox(height: 4),

                            // Row menyusun dekorasi sparkle
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icon menampilkan sparkle kecil
                                const Icon(
                                  Icons.auto_awesome,
                                  color: Color(0xFFF08BA0),
                                  size: 17,
                                ),

                                // SizedBox memberikan jarak
                                const SizedBox(width: 5),

                                // Icon menampilkan sparkle kedua
                                const Icon(
                                  Icons.auto_awesome,
                                  color: Color(0xFFF08BA0),
                                  size: 12,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // SizedBox memberikan jarak setelah hero banner
                const SizedBox(height: 28),

                // Row menyusun judul kategori dan See All
                Row(
                  children: [
                    // Expanded memberikan ruang pada judul
                    const Expanded(
                      // Text menampilkan judul kategori
                      child: Text(
                        'Shop by Category',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF342A2D),
                        ),
                      ),
                    ),

                    // Text menampilkan pilihan See All
                    Text(
                      'See all  ›',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                // SizedBox memberikan jarak
                const SizedBox(height: 14),

                // Row menyusun kartu kategori secara horizontal
                Row(
                  children: [
                    // Expanded membuat kategori pertama seimbang
                    Expanded(
                      // Container digunakan sebagai kartu Lollipop
                      child: Container(
                        height: 112,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE1E8),
                          borderRadius: BorderRadius.circular(22),
                        ),

                        // Column menyusun isi kategori
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Container digunakan sebagai lingkaran ikon
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),

                              // Icon menampilkan ikon lollipop
                              child: const Icon(
                                Icons.icecream_outlined,
                                color: Color(0xFFE83D5B),
                                size: 28,
                              ),
                            ),

                            // SizedBox memberikan jarak
                            const SizedBox(height: 7),

                            // Text menampilkan nama kategori
                            const Text(
                              'Lollipop',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF342A2D),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // SizedBox memberikan jarak
                    const SizedBox(width: 10),

                    // Expanded membuat kategori kedua seimbang
                    Expanded(
                      // Container digunakan sebagai kartu Gummies
                      child: Container(
                        height: 112,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF0C9),
                          borderRadius: BorderRadius.circular(22),
                        ),

                        // Column menyusun isi kategori
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Container digunakan sebagai lingkaran ikon
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),

                              // Icon menampilkan ikon gummies
                              child: const Icon(
                                Icons.favorite_rounded,
                                color: Color(0xFFE9A900),
                                size: 28,
                              ),
                            ),

                            // SizedBox memberikan jarak
                            const SizedBox(height: 7),

                            // Text menampilkan nama kategori
                            const Text(
                              'Gummies',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF342A2D),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // SizedBox memberikan jarak
                    const SizedBox(width: 10),

                    // Expanded membuat kategori ketiga seimbang
                    Expanded(
                      // Container digunakan sebagai kartu Chocolate
                      child: Container(
                        height: 112,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0E1DC),
                          borderRadius: BorderRadius.circular(22),
                        ),

                        // Column menyusun isi kategori
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Container digunakan sebagai lingkaran ikon
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),

                              // Icon menampilkan ikon chocolate
                              child: const Icon(
                                Icons.cookie_outlined,
                                color: Color(0xFF795548),
                                size: 28,
                              ),
                            ),

                            // SizedBox memberikan jarak
                            const SizedBox(height: 7),

                            // Text menampilkan nama kategori
                            const Text(
                              'Chocolate',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF342A2D),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // SizedBox memberikan jarak menuju produk
                const SizedBox(height: 30),

                // Row menyusun judul produk dan See All
                Row(
                  children: [
                    // Expanded memberikan ruang pada judul
                    const Expanded(
                      // Text menampilkan judul produk
                      child: Text(
                        'Today\'s Sweet Picks 🍬',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF342A2D),
                        ),
                      ),
                    ),

                    // Text menampilkan See All
                    Text(
                      'See all  ›',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                // SizedBox memberikan jarak
                const SizedBox(height: 15),

                // Row menyusun dua kartu produk secara horizontal
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Expanded membuat kartu pertama seimbang
                    Expanded(
                      // Container digunakan sebagai kartu Strawberry Gummies
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: const Color(0xFFFFDCE4),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x10000000),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),

                        // Column menyusun isi produk
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Container digunakan sebagai area visual produk
                            Container(
                              width: double.infinity,
                              height: 145,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFE5EA),
                                borderRadius: BorderRadius.circular(18),
                              ),

                              // Column menyusun ilustrasi produk
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Icon menampilkan ilustrasi strawberry
                                  const Icon(
                                    Icons.favorite_rounded,
                                    color: Color(0xFFE83D5B),
                                    size: 58,
                                  ),

                                  // SizedBox memberikan jarak
                                  const SizedBox(height: 5),

                                  // Text menampilkan rasa produk
                                  const Text(
                                    'STRAWBERRY',
                                    style: TextStyle(
                                      color: Color(0xFFE83D5B),
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.1,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // SizedBox memberikan jarak
                            const SizedBox(height: 11),

                            // Container digunakan sebagai badge Best Seller
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFE1E8),
                                borderRadius: BorderRadius.circular(8),
                              ),

                              // Text menampilkan label Best Seller
                              child: const Text(
                                'BEST SELLER',
                                style: TextStyle(
                                  color: Color(0xFFE83D5B),
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            // SizedBox memberikan jarak
                            const SizedBox(height: 8),

                            // Text menampilkan nama produk
                            const Text(
                              'Strawberry Gummies',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF342A2D),
                              ),
                            ),

                            // SizedBox memberikan jarak
                            const SizedBox(height: 5),

                            // Text menampilkan harga
                            const Text(
                              'Rp15.000',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFE83D5B),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // SizedBox memberikan jarak antar produk
                    const SizedBox(width: 12),

                    // Expanded membuat kartu kedua seimbang
                    Expanded(
                      // Container digunakan sebagai kartu Cherry Lollipop
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: const Color(0xFFFFE7B0),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x10000000),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),

                        // Column menyusun isi produk
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Container digunakan sebagai area visual produk
                            Container(
                              width: double.infinity,
                              height: 145,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF0C9),
                                borderRadius: BorderRadius.circular(18),
                              ),

                              // Column menyusun ilustrasi produk
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Icon menampilkan ilustrasi lollipop
                                  const Icon(
                                    Icons.icecream_rounded,
                                    color: Color(0xFFE83D5B),
                                    size: 58,
                                  ),

                                  // SizedBox memberikan jarak
                                  const SizedBox(height: 5),

                                  // Text menampilkan rasa produk
                                  const Text(
                                    'CHERRY',
                                    style: TextStyle(
                                      color: Color(0xFFE83D5B),
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.1,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // SizedBox memberikan jarak
                            const SizedBox(height: 11),

                            // Container digunakan sebagai badge New
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF0C9),
                                borderRadius: BorderRadius.circular(8),
                              ),

                              // Text menampilkan label New
                              child: const Text(
                                'NEW ✨',
                                style: TextStyle(
                                  color: Color(0xFFB37A00),
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            // SizedBox memberikan jarak
                            const SizedBox(height: 8),

                            // Text menampilkan nama produk
                            const Text(
                              'Cherry Lollipop',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF342A2D),
                              ),
                            ),

                            // SizedBox memberikan jarak
                            const SizedBox(height: 5),

                            // Text menampilkan harga
                            const Text(
                              'Rp12.000',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFE83D5B),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // SizedBox memberikan jarak menuju limited candy
                const SizedBox(height: 25),

                // Container digunakan sebagai banner Limited Candy Drop
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE8D6),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xFFFFC7A8),
                    ),
                  ),

                  // Row menyusun informasi limited candy secara horizontal
                  child: Row(
                    children: [
                      // Container digunakan sebagai area ilustrasi permen
                      Container(
                        width: 58,
                        height: 58,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),

                        // Icon menampilkan ilustrasi permen
                        child: const Icon(
                          Icons.icecream_rounded,
                          color: Color(0xFFE83D5B),
                          size: 30,
                        ),
                      ),

                      // SizedBox memberikan jarak antara ikon dan informasi
                      const SizedBox(width: 13),

                      // Expanded memberikan ruang pada informasi produk
                      Expanded(
                        // Column menyusun informasi produk secara vertikal
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text menampilkan label limited candy
                            const Text(
                              'LIMITED CANDY DROP 💥‼️',
                              style: TextStyle(
                                color: Color(0xFFE83D5B),
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                              ),
                            ),

                            // SizedBox memberikan jarak
                            const SizedBox(height: 5),

                            // Text menampilkan nama produk
                            const Text(
                              'Pink Strawberry Marshmallow',
                              style: TextStyle(
                                color: Color(0xFF342A2D),
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // SizedBox memberikan jarak
                            const SizedBox(height: 4),

                            // Text menampilkan deskripsi produk
                            Text(
                              'Only available this week! Grab yours now',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Container digunakan sebagai dekorasi tombol
                      Container(
                        width: 34,
                        height: 34,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE83D5B),
                          shape: BoxShape.circle,
                        ),

                        // Icon menampilkan ikon panah
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                    ],
                  ),
                ),

                // SizedBox memberikan jarak sebelum navigasi
                const SizedBox(height: 25),

                // Container digunakan sebagai navigasi bawah
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: const Color(0xFFFFDFE5),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x10000000),
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),

                  // Row menyusun menu navigasi secara horizontal
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Column menyusun ikon dan label Home
                      Column(
                        children: [
                          // Icon menampilkan ikon Home
                          const Icon(
                            Icons.home_rounded,
                            color: Color(0xFFE83D5B),
                            size: 22,
                          ),

                          // SizedBox memberikan jarak
                          const SizedBox(height: 3),

                          // Text menampilkan label Home
                          const Text(
                            'Home',
                            style: TextStyle(
                              fontSize: 9,
                              color: Color(0xFFE83D5B),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      // Column menyusun ikon dan label Favorites
                      Column(
                        children: [
                          // Icon menampilkan ikon Favorites
                          Icon(
                            Icons.favorite_border_rounded,
                            color: Colors.grey.shade500,
                            size: 22,
                          ),

                          // SizedBox memberikan jarak
                          const SizedBox(height: 3),

                          // Text menampilkan label Favorites
                          Text(
                            'Favorites',
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),

                      // Column menyusun ikon dan label Orders
                      Column(
                        children: [
                          // Icon menampilkan ikon Orders
                          Icon(
                            Icons.receipt_long_outlined,
                            color: Colors.grey.shade500,
                            size: 22,
                          ),

                          // SizedBox memberikan jarak
                          const SizedBox(height: 3),

                          // Text menampilkan label Orders
                          Text(
                            'Orders',
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),

                      // Column menyusun ikon dan label Profile
                      Column(
                        children: [
                          // Icon menampilkan ikon Profile
                          Icon(
                            Icons.person_outline_rounded,
                            color: Colors.grey.shade500,
                            size: 22,
                          ),

                          // SizedBox memberikan jarak
                          const SizedBox(height: 3),

                          // Text menampilkan label Profile
                          Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // SizedBox memberikan jarak sebelum footer
                const SizedBox(height: 17),

                // Row menyusun dekorasi footer
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon menampilkan dekorasi hati
                    const Icon(
                      Icons.favorite_rounded,
                      color: Color(0xFFE83D5B),
                      size: 13,
                    ),

                    // SizedBox memberikan jarak
                    const SizedBox(width: 5),

                    // Text menampilkan tulisan footer made w lop
                    Text(
                      '₊˚⊹ ᰔ made with love by Ghesya (๑>؂•̀๑)',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 10,
                      ),
                    ),

                    // SizedBox memberikan jarak
                    const SizedBox(width: 5),

                    // Icon menampilkan dekorasi sparkle
                    const Icon(
                      Icons.auto_awesome,
                      color: Color(0xFFE83D5B),
                      size: 13,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}