import 'package:flutter/material.dart';

void main() {
  // Menjalankan aplikasi CHERRYBOMB
  runApp(const CherryBombApp());
}

// MaterialApp digunakan sebagai dasar aplikasi
class CherryBombApp extends StatelessWidget {
  const CherryBombApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp mengatur tema dan halaman utama aplikasi
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CHERRYBOMB',

      // ThemeData digunakan untuk mengatur tema aplikasi
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',

        // ColorScheme digunakan untuk menentukan warna utama aplikasi
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE83D5B),
        ),

        // Warna background utama aplikasi
        scaffoldBackgroundColor: const Color(0xFFFFF7F8),
      ),

      // HomePage digunakan sebagai halaman pertama aplikasi
      home: const HomePage(),
    );
  }
}

// StatefulWidget digunakan karena halaman memiliki state
// seperti selectedIndex dan daftar produk dalam cart
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Menyimpan index halaman NavigationBar yang sedang dipilih
  int selectedIndex = 0;

  // Menyimpan daftar produk yang masuk ke cart
  final List<CartItem> cartItems = [];

  // Fungsi untuk menambahkan produk ke cart
  void addToCart(String name, String price, String image) {
    setState(() {
      final existingIndex = cartItems.indexWhere(
            (item) => item.name == name,
      );

      if (existingIndex >= 0) {
        cartItems[existingIndex].quantity++;
      } else {
        cartItems.add(
          CartItem(
            name: name,
            price: price,
            image: image,
            quantity: 1,
          ),
        );
      }
    });
  }

  // Fungsi untuk mengurangi jumlah produk
  void decreaseQuantity(int index) {
    setState(() {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      } else {
        cartItems.removeAt(index);
      }
    });
  }

  // Fungsi untuk menambah jumlah produk
  void increaseQuantity(int index) {
    setState(() {
      cartItems[index].quantity++;
    });
  }

  // Fungsi untuk menghapus produk dari cart
  void removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold digunakan sebagai struktur utama aplikasi
    return Scaffold(
      // IndexedStack digunakan untuk menampilkan halaman
      // berdasarkan index NavigationBar
      body: IndexedStack(
        index: selectedIndex,

        // Daftar halaman yang digunakan NavigationBar
        children: [
          // Halaman Home
          HomeContent(
            cartCount: cartItems.length,
            onAddToCart: addToCart,
          ),

          // Halaman Shop
          ShopPage(
            onAddToCart: addToCart,
          ),

          // Halaman Cart
          CartPage(
            cartItems: cartItems,
            onIncrease: increaseQuantity,
            onDecrease: decreaseQuantity,
            onRemove: removeFromCart,
            onCheckout: () {
              setState(() {
                cartItems.clear();
              });

              // SnackBar menampilkan notifikasi setelah checkout berhasil
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Checkout berhasil! Terima kasih sudah belanja 🍒',
                  ),
                ),
              );
            },
          ),

          // Halaman Profile
          const ProfilePage(),
        ],
      ),

      // NavigationBar digunakan untuk berpindah halaman
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,

        // Warna background NavigationBar
        backgroundColor: Colors.white,

        // Warna indikator menu yang sedang dipilih
        indicatorColor: const Color(0xFFFFD1E1),

        // Callback ketika menu NavigationBar ditekan
        onDestinationSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },

        // NavigationDestination digunakan sebagai menu NavigationBar
        destinations: const [
          // Menu Home
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),

          // Menu Shop
          NavigationDestination(
            icon: Icon(Icons.storefront_outlined),
            selectedIcon: Icon(Icons.storefront),
            label: 'Shop',
          ),

          // Menu Cart
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),

          // Menu Profile
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Model sederhana untuk menyimpan data produk di cart
class CartItem {
  String name;
  String price;
  String image;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
  });
}

// ============================================================
// HOME PAGE
// ============================================================

// Widget halaman Home
class HomeContent extends StatefulWidget {
  final int cartCount;
  final Function(String, String, String) onAddToCart;

  const HomeContent({
    super.key,
    required this.cartCount,
    required this.onAddToCart,
  });

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  // Controller digunakan untuk membaca input pencarian
  final TextEditingController searchController = TextEditingController();

  // Menyimpan kata pencarian
  String searchText = '';

  // Daftar produk untuk pencarian
  final List<Map<String, String>> products = [
    {
      'name': 'Strawberry Gummies',
      'price': 'Rp15.000',
      'image': 'assets/strawberry.jpg',
    },
    {
      'name': 'Cherry Lollipop',
      'price': 'Rp12.000',
      'image': 'assets/cherry.jpg',
    },
    {
      'name': 'Strawberry Marshmallow',
      'price': 'Rp20.000',
      'image': 'assets/marshmallow.jpg',
    },
    {
      'name': 'Cherry Candy',
      'price': 'Rp18.000',
      'image': 'assets/candy.jpg',
    },
  ];

  @override
  void dispose() {
    // Controller dibersihkan ketika halaman ditutup
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Memfilter produk berdasarkan teks pencarian
    final filteredProducts = products.where((product) {
      final name = product['name']!.toLowerCase();
      return name.contains(searchText.toLowerCase());
    }).toList();

    // Scaffold digunakan sebagai struktur halaman Home
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F8),

      // SafeArea menjaga isi halaman agar tidak tertutup area perangkat
      body: SafeArea(
        // SingleChildScrollView membuat halaman Home dapat di-scroll
        child: SingleChildScrollView(
          // Padding memberikan jarak isi halaman
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 30),

            // Column menyusun seluruh isi halaman secara vertikal
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row digunakan untuk bagian header
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

                      // Column digunakan untuk menyusun logo
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Row digunakan untuk dua simbol cherry
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              // Icon digunakan sebagai dekorasi cherry
                              Icon(
                                Icons.circle,
                                color: Color(0xFFE83D5B),
                                size: 17,
                              ),

                              // SizedBox memberikan jarak antar icon
                              SizedBox(width: 2),

                              // Icon digunakan sebagai dekorasi cherry
                              Icon(
                                Icons.circle,
                                color: Color(0xFFE83D5B),
                                size: 17,
                              ),
                            ],
                          ),

                          // Icon digunakan sebagai dekorasi sparkle
                          const Icon(
                            Icons.auto_awesome,
                            color: Color(0xFFF2A5B5),
                            size: 12,
                          ),
                        ],
                      ),
                    ),

                    // SizedBox memberikan jarak antara logo dan nama toko
                    const SizedBox(width: 12),

                    // Expanded membuat nama toko mengisi ruang yang tersedia
                    Expanded(
                      // Column menyusun nama dan slogan toko
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          // Text menampilkan nama toko
                          Text(
                            'CHERRYBOMB',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE83D5B),
                            ),
                          ),

                          // Text menampilkan slogan
                          Text(
                            'Sweet things, made sweeter! 🍒',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF80636B),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Stack digunakan untuk menampilkan icon cart
                    // sekaligus jumlah produk
                    Stack(
                      children: [
                        // IconButton digunakan untuk membuka halaman cart
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CartPage(
                                  cartItems: [],
                                  onIncrease: (_) {},
                                  onDecrease: (_) {},
                                  onRemove: (_) {},
                                  onCheckout: () {},
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.shopping_bag_outlined,
                            size: 28,
                            color: Color(0xFF5E4149),
                          ),
                        ),

                        // Positioned digunakan untuk menempatkan jumlah cart
                        if (widget.cartCount > 0)
                          Positioned(
                            right: 3,
                            top: 3,

                            // Container digunakan sebagai badge jumlah cart
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                color: Color(0xFFE83D5B),
                                shape: BoxShape.circle,
                              ),

                              // Text menampilkan jumlah produk
                              child: Text(
                                '${widget.cartCount}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),

                // SizedBox memberikan jarak
                const SizedBox(height: 20),

                // TextField digunakan sebagai fitur pencarian
                TextField(
                  controller: searchController,

                  // onChanged menjalankan pencarian secara langsung
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },

                  // InputDecoration mengatur tampilan TextField
                  decoration: InputDecoration(
                    hintText: 'Search your favorite candy...',

                    // PrefixIcon menampilkan icon search
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFFE83D5B),
                    ),

                    // SuffixIcon digunakan untuk menghapus pencarian
                    suffixIcon: searchText.isNotEmpty
                        ? IconButton(
                      onPressed: () {
                        searchController.clear();

                        setState(() {
                          searchText = '';
                        });
                      },
                      icon: const Icon(Icons.close),
                    )
                        : null,

                    filled: true,
                    fillColor: Colors.white,

                    // Border InputDecoration dibuat rounded
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                // Jika sedang melakukan pencarian
                if (searchText.isNotEmpty) ...[
                  const SizedBox(height: 18),

                  // Text menampilkan hasil pencarian
                  Text(
                    '${filteredProducts.length} result found',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8E2045),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Jika hasil ditemukan
                  if (filteredProducts.isNotEmpty)
                    Column(
                      children: filteredProducts.map((product) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),

                          // ProductSearchCard digunakan untuk hasil pencarian
                          child: ProductSearchCard(
                            image: product['image']!,
                            name: product['name']!,
                            price: product['price']!,
                            onAddToCart: () {
                              widget.onAddToCart(
                                product['name']!,
                                product['price']!,
                                product['image']!,
                              );
                            },
                          ),
                        );
                      }).toList(),
                    )

                  // Jika produk tidak ditemukan
                  else
                    const Padding(
                      padding: EdgeInsets.all(30),

                      // Center menempatkan pesan di tengah
                      child: Center(
                        child: Text(
                          'Candy tidak ditemukan 🍬',
                          style: TextStyle(
                            color: Color(0xFF8E2045),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],

                // Konten normal Home hanya ditampilkan
                // ketika tidak sedang mencari
                if (searchText.isEmpty) ...[
                  const SizedBox(height: 25),

                  // Stack digunakan untuk banner utama
                  Stack(
                    children: [
                      // Container digunakan sebagai background banner
                      Container(
                        width: double.infinity,
                        height: 220,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD1E1),
                          borderRadius: BorderRadius.circular(25),

                          // BoxShadow memberikan efek bayangan
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                      ),

                      // Positioned digunakan untuk menempatkan teks banner
                      const Positioned(
                        left: 20,
                        top: 28,

                        // Column menyusun teks banner
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text judul banner
                            Text(
                              'Sweet things,',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8E2045),
                              ),
                            ),

                            // Text judul kedua
                            Text(
                              'made sweeter! 🍭',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8E2045),
                              ),
                            ),

                            // SizedBox memberikan jarak
                            SizedBox(height: 10),

                            // Text deskripsi banner
                            Text(
                              'Welcome to CHERRYBOMB',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6D4552),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Positioned digunakan untuk menempatkan dekorasi cherry
                      Positioned(
                        right: 45,
                        bottom: 25,

                        // Stack digunakan untuk menyusun dua buah cherry
                        // dan tangkai cherry dalam satu posisi
                        child: SizedBox(
                          width: 150,
                          height: 150,

                          // Stack membuat bagian cherry dapat ditumpuk
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Positioned digunakan untuk membuat tangkai kiri
                              Positioned(
                                left: 62,
                                top: 15,

                                // Transform memiringkan tangkai cherry
                                child: Transform.rotate(
                                  angle: -0.35,

                                  // Container digunakan sebagai tangkai cherry
                                  child: Container(
                                    width: 7,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF6D9B52),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),

                              // Positioned digunakan untuk membuat tangkai kanan
                              Positioned(
                                left: 78,
                                top: 15,

                                // Transform memiringkan tangkai cherry
                                child: Transform.rotate(
                                  angle: 0.35,

                                  // Container digunakan sebagai tangkai cherry
                                  child: Container(
                                    width: 7,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF6D9B52),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),

                              // Positioned digunakan untuk membuat daun cherry
                              Positioned(
                                left: 70,
                                top: 5,

                                // Icon digunakan sebagai simbol daun
                                child: Icon(
                                  Icons.eco,
                                  size: 35,
                                  color: const Color(0xFF6D9B52),
                                ),
                              ),

                              // Positioned digunakan untuk membuat buah cherry kiri
                              Positioned(
                                left: 35,
                                top: 50,

                                // Container digunakan sebagai buah cherry
                                child: Container(
                                  width: 62,
                                  height: 62,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFE83D5B),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),

                              // Positioned digunakan untuk membuat buah cherry kanan
                              Positioned(
                                right: 35,
                                top: 50,

                                // Container digunakan sebagai buah cherry
                                child: Container(
                                  width: 62,
                                  height: 62,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFE83D5B),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),

                              // Positioned digunakan untuk memberikan efek highlight
                              Positioned(
                                left: 50,
                                top: 62,

                                // Container digunakan sebagai highlight cherry kiri
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFFA9BA),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),

                              // Positioned digunakan untuk memberikan efek highlight
                              Positioned(
                                right: 50,
                                top: 62,

                                // Container digunakan sebagai highlight cherry kanan
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFFA9BA),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // Row digunakan untuk judul kategori
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text menampilkan judul kategori
                      const Text(
                        'Sweet Categories',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8E2045),
                        ),
                      ),

                      // TextButton digunakan untuk membuka Shop
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopPage(
                                onAddToCart: widget.onAddToCart,
                              ),
                            ),
                          );
                        },

                        // Text menampilkan tombol See All
                        child: const Text('See all ›'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Row digunakan untuk tiga kategori
                  Row(
                    children: [
                      // Expanded membagi ruang kategori pertama
                      Expanded(
                        child: CategoryCard(
                          icon: Icons.icecream,
                          title: 'Lollipop',
                          color: const Color(0xFFFFDDE6),
                        ),
                      ),

                      const SizedBox(width: 10),

                      // Expanded membagi ruang kategori kedua
                      Expanded(
                        child: CategoryCard(
                          icon: Icons.favorite,
                          title: 'Gummies',
                          color: const Color(0xFFFFEDC4),
                        ),
                      ),

                      const SizedBox(width: 10),

                      // Expanded membagi ruang kategori ketiga
                      Expanded(
                        child: CategoryCard(
                          icon: Icons.cookie,
                          title: 'Chocolate',
                          color: const Color(0xFFEBDCD7),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Row digunakan untuk judul produk
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text menampilkan judul produk
                      const Text(
                        "Today's Sweet Picks 🍬",
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF38282D),
                        ),
                      ),

                      // TextButton membuka halaman Shop
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopPage(
                                onAddToCart: widget.onAddToCart,
                              ),
                            ),
                          );
                        },
                        child: const Text('See all ›'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Row digunakan untuk dua kartu produk
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Expanded membagi ruang kartu pertama
                      Expanded(
                        child: ProductCard(
                          image: 'assets/strawberry.jpg',
                          name: 'Strawberry Gummies',
                          price: 'Rp15.000',
                          label: 'BEST SELLER',
                          onAddToCart: widget.onAddToCart,
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Expanded membagi ruang kartu kedua
                      Expanded(
                        child: ProductCard(
                          image: 'assets/cherry.jpg',
                          name: 'Cherry Lollipop',
                          price: 'Rp12.000',
                          label: 'NEW ✨',
                          onAddToCart: widget.onAddToCart,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // Stack digunakan untuk banner limited candy
                  Stack(
                    children: [
                      // Container digunakan sebagai background banner
                      Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE5D5),
                          borderRadius: BorderRadius.circular(22),

                          // BoxShadow digunakan untuk bayangan banner
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),

                      // Positioned menempatkan asset marshmallow
                      Positioned(
                        left: 12,
                        top: 10,

                        // Image.asset menampilkan asset marshmallow
                        child: Image.asset(
                          'assets/marshmallow.jpg',
                          width: 95,
                          height: 95,
                          fit: BoxFit.contain,
                        ),
                      ),

                      // Positioned menempatkan teks limited drop
                      const Positioned(
                        left: 110,
                        top: 25,

                        // Column menyusun teks banner
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text judul promo
                            Text(
                              'LIMITED CANDY DROP 💥!!',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE83D5B),
                              ),
                            ),

                            SizedBox(height: 7),

                            // Text nama produk promo
                            Text(
                              'Pink Strawberry Marshmallow',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4A3038),
                              ),
                            ),

                            SizedBox(height: 4),

                            // Text informasi promo
                            Text(
                              'Only available this week!',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF80636B),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Positioned menempatkan tombol promo
                      Positioned(
                        right: 15,
                        top: 39,

                        // IconButton digunakan sebagai tombol promo
                        child: IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: const Color(0xFFE83D5B),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailPage(
                                  image: 'assets/marshmallow.jpg',
                                  name: 'Pink Strawberry Marshmallow',
                                  price: 'Rp20.000',
                                  onAddToCart: widget.onAddToCart,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Center digunakan untuk menempatkan footer
                  const Center(
                    child: Text(
                      '♥ · ˚✦ made with love by Ghesya (๑˃ᴗ˂)ﻭ ✨',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFB19AA1),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// CATEGORY CARD
// ============================================================

// Widget kartu kategori
class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const CategoryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    // Container digunakan sebagai kartu kategori
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),

      // Column menyusun icon dan teks
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // CircleAvatar digunakan sebagai background icon
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white,

            // Icon digunakan untuk simbol kategori
            child: Icon(
              icon,
              color: const Color(0xFFE83D5B),
            ),
          ),

          const SizedBox(height: 8),

          // Text menampilkan nama kategori
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PRODUCT CARD
// ============================================================

// Widget kartu produk
class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String label;
  final Function(String, String, String) onAddToCart;

  const ProductCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.label,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    // Container digunakan sebagai kartu produk
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        // BoxShadow digunakan untuk memberikan bayangan
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      // Column menyusun gambar dan informasi produk
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stack digunakan untuk menumpuk gambar dan favorite
          Stack(
            children: [
              // ClipRRect membuat sudut gambar menjadi rounded
              ClipRRect(
                borderRadius: BorderRadius.circular(15),

                // Image.asset menampilkan gambar produk
                child: Image.asset(
                  image,
                  height: 145,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              // Positioned digunakan untuk tombol favorite
              const Positioned(
                top: 5,
                right: 5,

                // Icon digunakan sebagai simbol favorite
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.favorite_border,
                    size: 20,
                    color: Color(0xFFE83D5B),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Container digunakan sebagai label produk
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE4EC),
              borderRadius: BorderRadius.circular(8),
            ),

            // Text menampilkan label produk
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE83D5B),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Text menampilkan nama produk
          Text(
            name,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3C2A30),
            ),
          ),

          const SizedBox(height: 5),

          // Text menampilkan harga produk
          Text(
            price,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE83D5B),
            ),
          ),

          const SizedBox(height: 10),

          // SizedBox membuat tombol memenuhi lebar kartu
          SizedBox(
            width: double.infinity,

            // ElevatedButton digunakan untuk melihat detail
            child: ElevatedButton(
              onPressed: () {
                // Navigator.push digunakan untuk membuka halaman detail
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(
                      image: image,
                      name: name,
                      price: price,
                      onAddToCart: onAddToCart,
                    ),
                  ),
                );
              },

              // Text digunakan pada tombol
              child: const Text('View Product'),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SEARCH RESULT CARD
// ============================================================

// Widget untuk hasil pencarian
class ProductSearchCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final VoidCallback onAddToCart;

  const ProductSearchCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    // Container digunakan sebagai kartu hasil pencarian
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        // BoxShadow memberikan efek bayangan
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      // Row menyusun gambar dan informasi produk
      child: Row(
        children: [
          // ClipRRect membuat gambar rounded
          ClipRRect(
            borderRadius: BorderRadius.circular(12),

            // Image.asset menampilkan gambar hasil pencarian
            child: Image.asset(
              image,
              width: 75,
              height: 75,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          // Expanded membuat informasi mengisi ruang
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text menampilkan nama
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                // Text menampilkan harga
                Text(
                  price,
                  style: const TextStyle(
                    color: Color(0xFFE83D5B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // IconButton digunakan untuk menambahkan produk ke cart
          IconButton(
            onPressed: onAddToCart,
            icon: const Icon(
              Icons.add_shopping_cart,
              color: Color(0xFFE83D5B),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SHOP PAGE
// ============================================================

// Halaman Shop
class ShopPage extends StatefulWidget {
  final Function(String, String, String) onAddToCart;

  const ShopPage({
    super.key,
    required this.onAddToCart,
  });

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  // Controller digunakan untuk TextField pencarian
  final TextEditingController searchController = TextEditingController();

  // Menyimpan kata pencarian
  String searchText = '';

  // Daftar produk CHERRYBOMB
  final List<Map<String, String>> products = [
    {
      'name': 'Strawberry Gummies',
      'description': 'Soft strawberry gummy candy',
      'price': 'Rp15.000',
      'image': 'assets/strawberry.jpg',
    },
    {
      'name': 'Cherry Lollipop',
      'description': 'Sweet cherry lollipop',
      'price': 'Rp12.000',
      'image': 'assets/cherry.jpg',
    },
    {
      'name': 'Pink Strawberry Marshmallow',
      'description': 'Soft pink strawberry marshmallow',
      'price': 'Rp20.000',
      'image': 'assets/marshmallow.jpg',
    },
    {
      'name': 'Cherry Candy',
      'description': 'Cute cherry flavored candy',
      'price': 'Rp18.000',
      'image': 'assets/candy.jpg',
    },
  ];

  @override
  void dispose() {
    // Controller dibersihkan saat halaman ditutup
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filter produk berdasarkan kata pencarian
    final filteredProducts = products.where((product) {
      return product['name']!
          .toLowerCase()
          .contains(searchText.toLowerCase());
    }).toList();

    // Scaffold digunakan sebagai struktur halaman Shop
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F8),

      // SafeArea menjaga konten halaman
      body: SafeArea(
        // Column menyusun search dan daftar produk
        child: Column(
          children: [
            // Padding memberikan jarak pada search
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),

              // TextField digunakan untuk mencari produk
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },

                // InputDecoration mengatur tampilan search
                decoration: InputDecoration(
                  hintText: 'Search candy...',
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFFE83D5B),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // Expanded membuat daftar mengisi sisa halaman
            Expanded(
              // ListView digunakan untuk menampilkan daftar produk
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: filteredProducts.length,

                // itemBuilder membuat setiap item produk
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];

                  // ProductListTile menampilkan produk
                  return ProductListTile(
                    image: product['image']!,
                    name: product['name']!,
                    description: product['description']!,
                    price: product['price']!,
                    onAddToCart: widget.onAddToCart,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// PRODUCT LIST TILE
// ============================================================

// Widget untuk item produk di Shop
class ProductListTile extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  final String price;
  final Function(String, String, String) onAddToCart;

  const ProductListTile({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    // Container digunakan sebagai card produk
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        // BoxShadow digunakan untuk memberikan bayangan
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      // ListTile menyusun informasi produk
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),

        // ClipRRect digunakan untuk membuat gambar rounded
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),

          // Image.asset menampilkan asset produk
          child: Image.asset(
            image,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),

        // Text menampilkan nama produk
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        // Text menampilkan deskripsi
        subtitle: Text(description),

        // Text menampilkan harga
        trailing: Text(
          price,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFE83D5B),
          ),
        ),

        // onTap digunakan untuk membuka detail produk
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(
                image: image,
                name: name,
                price: price,
                onAddToCart: onAddToCart,
              ),
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// PRODUCT DETAIL PAGE
// ============================================================

// Halaman detail produk
class ProductDetailPage extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final Function(String, String, String) onAddToCart;

  const ProductDetailPage({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    // Scaffold digunakan sebagai struktur halaman detail
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F8),

      // AppBar digunakan sebagai header halaman
      appBar: AppBar(
        title: const Text(
          'Product Detail',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFE83D5B),
        foregroundColor: Colors.white,

        // IconButton digunakan untuk kembali
        leading: IconButton(
          onPressed: () {
            // Navigator.pop digunakan untuk kembali ke halaman sebelumnya
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),

      // SingleChildScrollView membuat detail dapat di-scroll
      body: SingleChildScrollView(
        // Padding memberikan jarak konten
        child: Padding(
          padding: const EdgeInsets.all(20),

          // Column menyusun detail produk
          child: Column(
            children: [
              // Stack digunakan untuk gambar dan label
              Stack(
                children: [
                  // Container sebagai background gambar
                  Container(
                    width: double.infinity,
                    height: 330,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE1EB),
                      borderRadius: BorderRadius.circular(25),

                      // BoxShadow memberikan bayangan
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                  ),

                  // Positioned menempatkan gambar di tengah
                  Positioned(
                    left: 15,
                    right: 15,
                    top: 20,
                    bottom: 20,

                    // Image.asset menampilkan gambar produk
                    child: Image.asset(
                      image,
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Positioned menempatkan label
                  const Positioned(
                    left: 15,
                    top: 15,

                    // Chip digunakan sebagai label toko
                    child: Chip(
                      label: Text('CHERRYBOMB 🍒'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // Text menampilkan nama produk
              Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8E2045),
                ),
              ),

              const SizedBox(height: 10),

              // Text menampilkan harga
              Text(
                price,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE83D5B),
                ),
              ),

              const SizedBox(height: 15),

              // Text menampilkan deskripsi
              const Text(
                'A sweet and cute candy made for your sweetest moments. '
                    'Perfect for candy lovers! 🍬🍒',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF6D4552),
                ),
              ),

              const SizedBox(height: 25),

              // SizedBox membuat tombol memenuhi lebar
              SizedBox(
                width: double.infinity,

                // ElevatedButton.icon digunakan sebagai tombol cart
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Menambahkan produk ke cart
                    onAddToCart(
                      name,
                      price,
                      image,
                    );

                    // SnackBar menampilkan notifikasi produk berhasil masuk cart
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '$name berhasil ditambahkan ke cart 🛒',
                        ),
                      ),
                    );
                  },

                  // Icon menunjukkan cart
                  icon: const Icon(Icons.shopping_cart),

                  // Text menunjukkan aksi tombol
                  label: const Text('Add to Cart'),
                ),
              ),

              const SizedBox(height: 10),

              // SizedBox membuat tombol memenuhi lebar
              SizedBox(
                width: double.infinity,

                // OutlinedButton digunakan untuk kembali
                child: OutlinedButton(
                  onPressed: () {
                    // Navigator.pop mengembalikan halaman sebelumnya
                    Navigator.pop(context);
                  },

                  // Text menampilkan tulisan tombol
                  child: const Text('Back to Shop'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// CART PAGE
// ============================================================

// Halaman Cart
class CartPage extends StatelessWidget {
  final List<CartItem> cartItems;
  final Function(int) onIncrease;
  final Function(int) onDecrease;
  final Function(int) onRemove;
  final VoidCallback onCheckout;

  const CartPage({
    super.key,
    required this.cartItems,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
    required this.onCheckout,
  });

  // Fungsi mengubah string harga menjadi angka
  int parsePrice(String price) {
    return int.parse(
      price.replaceAll('Rp', '').replaceAll('.', ''),
    );
  }

  // Fungsi menghitung total belanja
  int getTotal() {
    int total = 0;

    for (final item in cartItems) {
      total += parsePrice(item.price) * item.quantity;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold digunakan sebagai struktur halaman Cart
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F8),

      // SafeArea menjaga isi halaman
      body: SafeArea(
        child: cartItems.isEmpty
            ? Center(
          // Column menyusun pesan cart kosong
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon menunjukkan cart kosong
              const Icon(
                Icons.shopping_cart_outlined,
                size: 85,
                color: Color(0xFFF2A5B5),
              ),

              const SizedBox(height: 15),

              // Text menunjukkan status cart
              const Text(
                'Your cart is empty 🛒',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8E2045),
                ),
              ),

              const SizedBox(height: 8),

              // Text memberikan keterangan
              const Text(
                'Add some sweet candies first!',
              ),
            ],
          ),
        )
            : Column(
          children: [
            // Padding memberikan jarak judul cart
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),

              // Align mengatur posisi judul
              child: Align(
                alignment: Alignment.centerLeft,

                // Text menampilkan judul cart
                child: Text(
                  'My Cart 🛒',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8E2045),
                  ),
                ),
              ),
            ),

            // Expanded membuat daftar mengisi ruang
            Expanded(
              // ListView.builder menampilkan item cart
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: cartItems.length,

                // itemBuilder membuat kartu setiap produk
                itemBuilder: (context, index) {
                  final item = cartItems[index];

                  // CartItemCard menampilkan produk di cart
                  return CartItemCard(
                    item: item,
                    onIncrease: () {
                      onIncrease(index);
                    },
                    onDecrease: () {
                      onDecrease(index);
                    },
                    onRemove: () {
                      onRemove(index);
                    },
                  );
                },
              ),
            ),

            // Container digunakan sebagai bagian checkout
            Container(
              padding: const EdgeInsets.fromLTRB(
                20,
                15,
                20,
                20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,

                // BoxShadow digunakan untuk bayangan checkout
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),

              // Column menyusun total dan tombol checkout
              child: Column(
                children: [
                  // Row menyusun subtotal
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      // Text subtotal
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Text total harga
                      Text(
                        'Rp${getTotal().toString().replaceAllMapped(
                          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
                              (match) => '${match[1]}.',
                        )}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE83D5B),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // SizedBox membuat tombol checkout penuh
                  SizedBox(
                    width: double.infinity,

                    // ElevatedButton digunakan untuk checkout
                    child: ElevatedButton.icon(
                      onPressed: onCheckout,

                      // Icon checkout
                      icon: const Icon(
                        Icons.shopping_cart_checkout,
                      ),

                      // Text checkout
                      label: const Text(
                        'Checkout',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CART ITEM CARD
// ============================================================

// Widget kartu item cart
class CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    // Container digunakan sebagai card item cart
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        // BoxShadow memberikan bayangan
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      // Row menyusun gambar dan informasi
      child: Row(
        children: [
          // ClipRRect membuat gambar rounded
          ClipRRect(
            borderRadius: BorderRadius.circular(12),

            // Image.asset menampilkan gambar produk
            child: Image.asset(
              item.image,
              width: 75,
              height: 75,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          // Expanded membuat informasi produk fleksibel
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text menampilkan nama produk
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 5),

                // Text menampilkan harga
                Text(
                  item.price,
                  style: const TextStyle(
                    color: Color(0xFFE83D5B),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                // Row menyusun tombol quantity
                Row(
                  children: [
                    // IconButton untuk mengurangi quantity
                    IconButton(
                      onPressed: onDecrease,
                      icon: const Icon(
                        Icons.remove_circle_outline,
                      ),
                    ),

                    // Text menampilkan quantity
                    Text(
                      '${item.quantity}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // IconButton untuk menambah quantity
                    IconButton(
                      onPressed: onIncrease,
                      icon: const Icon(
                        Icons.add_circle_outline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // IconButton untuk menghapus item
          IconButton(
            onPressed: onRemove,
            icon: const Icon(
              Icons.delete_outline,
              color: Color(0xFFE83D5B),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PROFILE PAGE
// ============================================================

// Halaman Profile
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Center menempatkan isi profile di tengah
    return Center(
      // Column menyusun profile secara vertikal
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // CircleAvatar digunakan sebagai foto profile
          const CircleAvatar(
            radius: 55,
            backgroundColor: Color(0xFFFFD1E1),

            // Icon digunakan sebagai foto profile
            child: Icon(
              Icons.person,
              size: 60,
              color: Color(0xFFE83D5B),
            ),
          ),

          const SizedBox(height: 15),

          // Text menampilkan nama member
          const Text(
            'Cherry Club Member',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8E2045),
            ),
          ),

          const SizedBox(height: 8),

          // Text menampilkan informasi member
          const Text(
            'Sweetness level: 100% 🍒',
          ),

          const SizedBox(height: 20),

          // ElevatedButton membuka halaman edit profile
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfilePage(),
                ),
              );
            },

            // Icon digunakan sebagai icon edit
            icon: const Icon(Icons.edit),

            // Text digunakan sebagai label tombol
            label: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// EDIT PROFILE PAGE
// ============================================================

// Halaman Edit Profile
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold digunakan sebagai struktur halaman
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F8),

      // AppBar digunakan sebagai header halaman
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: const Color(0xFFE83D5B),
        foregroundColor: Colors.white,

        // IconButton digunakan untuk kembali
        leading: IconButton(
          onPressed: () {
            // Navigator.pop kembali ke profile
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),

      // Padding memberikan jarak konten
      body: Padding(
        padding: const EdgeInsets.all(20),

        // Column menyusun form profile
        child: Column(
          children: [
            // Text sebagai judul form
            const Text(
              'Cherry Club Profile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8E2045),
              ),
            ),

            const SizedBox(height: 20),

            // TextField digunakan untuk input nama
            const TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),

                // PrefixIcon menampilkan icon user
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 15),

            // TextField digunakan untuk input email
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),

                // PrefixIcon menampilkan icon email
                prefixIcon: Icon(Icons.email),
              ),
            ),

            const SizedBox(height: 20),

            // SizedBox membuat tombol memenuhi lebar
            SizedBox(
              width: double.infinity,

              // ElevatedButton digunakan untuk menyimpan profile
              child: ElevatedButton(
                onPressed: () {
                  // SnackBar menampilkan notifikasi profile berhasil disimpan
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Profile berhasil disimpan ✨',
                      ),
                    ),
                  );
                },

                // Text sebagai label tombol
                child: const Text('Save Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}