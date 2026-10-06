import 'dart:async'; // Timer dipakai buat countdown promo
import 'package:flutter/material.dart';

void main() {
  // Jalankan aplikasi CHERRYBOMB
  runApp(const CherryBombApp());
}

// ============================================================
// KONSTANTA WARNA
// ============================================================

// Warna utama CHERRYBOMB disimpan di sini
class AppColors {
  static const Color primary = Color(0xFFE83D5B);
  static const Color dark = Color(0xFF8E2045);
  static const Color soft = Color(0xFFFFD1E1);
  static const Color bg = Color(0xFFFFF7F8);
  static const Color text = Color(0xFF3C2A30);
  static const Color muted = Color(0xFF80636B);
}

// ============================================================
// MODEL DATA
// ============================================================

// Ekstensi gambar yang dipakai di assets
const String imageExtension = 'jpg';

// Minimal belanja untuk dapat gratis ongkir
const int freeShippingMin = 75000;

// Data yang disimpan untuk tiap produk
// Nama file gambar mengikuti id produk
class Product {
  final String id;
  final String name;
  final String description;
  final String category;
  final int price;
  final String? badge;
  final double rating;
  final int sold;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.rating,
    required this.sold,
    this.badge,
  });

  // Ambil path gambar dari id produk
  String get image => 'assets/$id.$imageExtension';
}

// Data item cart: produk dan jumlahnya
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}

// Semua data produk CHERRYBOMB
const List<Product> allProducts = [
  // ---------- GUMMIES ----------
  Product(
    id: 'strawberry_gummies',
    name: 'Strawberry Gummies',
    description: 'Soft strawberry gummy candy',
    category: 'Gummies',
    price: 15000,
    rating: 4.9,
    sold: 410,
    badge: 'BEST SELLER',
  ),
  Product(
    id: 'cherry_gummies',
    name: 'Cherry Gummies',
    description: 'Chewy cherry gummies full of juicy flavor',
    category: 'Gummies',
    price: 14000,
    rating: 4.8,
    sold: 320,
  ),
  Product(
    id: 'cola_gummies',
    name: 'Cola Gummies',
    description: 'Fizzy cola-shaped gummy bottles',
    category: 'Gummies',
    price: 13000,
    rating: 4.6,
    sold: 210,
  ),
  Product(
    id: 'watermelon_gummies',
    name: 'Watermelon Gummies',
    description: 'Juicy watermelon slice gummies',
    category: 'Gummies',
    price: 14000,
    rating: 4.7,
    sold: 260,
    badge: 'NEW ✨',
  ),

  // ---------- LOLLIPOP ----------
  Product(
    id: 'cherry_lollipop',
    name: 'Cherry Lollipop',
    description: 'Sweet cherry lollipop',
    category: 'Lollipop',
    price: 12000,
    rating: 4.8,
    sold: 340,
    badge: 'FAN FAVORITE',
  ),
  Product(
    id: 'melody_lollipop',
    name: 'Melody Sanrio Lollipop',
    description: 'My Melody themed lollipop from Sanrio',
    category: 'Lollipop',
    price: 16000,
    rating: 4.9,
    sold: 380,
    badge: 'SANRIO 🎀',
  ),
  Product(
    id: 'butterfly_lollipop',
    name: 'Butterfly Lollipop',
    description: 'Pretty butterfly-shaped lollipop',
    category: 'Lollipop',
    price: 13000,
    rating: 4.7,
    sold: 230,
    badge: 'CUTE 🦋',
  ),
  Product(
    id: 'flower_lollipop',
    name: 'Flower Lollipop',
    description: 'Blooming flower-shaped lollipop',
    category: 'Lollipop',
    price: 13000,
    rating: 4.6,
    sold: 190,
  ),
  Product(
    id: 'blueleaf_lollipop',
    name: 'Blueleaf Lollipop',
    description: 'Fresh blue leaf-shaped lollipop',
    category: 'Lollipop',
    price: 12000,
    rating: 4.5,
    sold: 150,
  ),

  // ---------- MARSHMALLOW ----------
  Product(
    id: 'strawberry_marshmallow',
    name: 'Pink Strawberry Marshmallow',
    description: 'Soft pink strawberry marshmallow',
    category: 'Marshmallow',
    price: 20000,
    rating: 4.9,
    sold: 360,
    badge: 'LIMITED 💥',
  ),
  Product(
    id: 'bubblegum_marshmallow',
    name: 'Bubblegum Marshmallow',
    description: 'Fluffy bubblegum flavored marshmallow',
    category: 'Marshmallow',
    price: 18000,
    rating: 4.6,
    sold: 170,
  ),
  Product(
    id: 'fruity_marshmallow',
    name: 'Fruity Marshmallow',
    description: 'Colorful marshmallow with mixed fruity flavors',
    category: 'Marshmallow',
    price: 18000,
    rating: 4.7,
    sold: 200,
  ),

  // ---------- CHOCOLATE ----------
  Product(
    id: 'hellokitty_chocolate',
    name: 'Hello Kitty Chocolate',
    description: 'Cute Hello Kitty themed chocolate',
    category: 'Chocolate',
    price: 22000,
    rating: 4.9,
    sold: 420,
    badge: 'SANRIO 🎀',
  ),
  Product(
    id: 'kitkat_chocolate',
    name: 'KitKat Chocolate',
    description: 'Crispy wafer fingers covered in chocolate',
    category: 'Chocolate',
    price: 17000,
    rating: 4.8,
    sold: 390,
  ),
  Product(
    id: 'love_chocolate',
    name: 'Love Chocolate Box',
    description: 'Exclusive box especially for ur GF 💝',
    category: 'Chocolate',
    price: 35000,
    rating: 5.0,
    sold: 275,
    badge: 'EXCLUSIVE 💝',
  ),
  Product(
    id: 'redvelvet_chocolate',
    name: 'Red Velvet Cookie Bomb',
    description: 'Red velvet cookie bomb with a chocolate burst',
    category: 'Chocolate',
    price: 25000,
    rating: 4.8,
    sold: 310,
    badge: 'COOKIE BOMB 💣',
  ),
  Product(
    id: 'stick_chocolate',
    name: 'Chocolate Wafer Sticks',
    description: 'Pocky-style wafer sticks in pink, white & brown chocolate',
    category: 'Chocolate',
    price: 16000,
    rating: 4.7,
    sold: 300,
  ),
  Product(
    id: 'coins_chocolate',
    name: 'Coins Chocolate',
    description: 'Golden coin-shaped milk chocolate',
    category: 'Chocolate',
    price: 15000,
    rating: 4.5,
    sold: 140,
  ),
];

// Pilihan kategori untuk filter
const List<String> categories = [
  'All',
  'Gummies',
  'Lollipop',
  'Marshmallow',
  'Chocolate',
];

// Warna untuk masing-masing kategori
Color categoryColor(String category) {
  switch (category) {
    case 'Gummies':
      return const Color(0xFFFFE3C4);
    case 'Lollipop':
      return const Color(0xFFFFD9E8);
    case 'Marshmallow':
      return const Color(0xFFE4DAFF);
    case 'Chocolate':
      return const Color(0xFFEBDCD7);
    default:
      return const Color(0xFFFFE1EB);
  }
}

// Icon untuk masing-masing kategori
IconData categoryIcon(String category) {
  switch (category) {
    case 'Gummies':
      return Icons.favorite;
    case 'Lollipop':
      return Icons.icecream;
    case 'Marshmallow':
      return Icons.cloud;
    case 'Chocolate':
      return Icons.cookie;
    default:
      return Icons.cake;
  }
}

// Teks singkat untuk halaman detail kategori
String categoryBlurb(String category) {
  switch (category) {
    case 'Gummies':
      return 'Kenyal, juicy, dan bikin nagih di setiap gigitan! 🍓';
    case 'Lollipop':
      return 'Lucu banget buat dipajang, manis banget buat dijilat! 🍭';
    case 'Marshmallow':
      return 'Empuk, lembut, dan meleleh di mulut seperti awan manis ☁️';
    case 'Chocolate':
      return 'Cokelat premium yang bikin harimu jadi lebih manis 🍫';
    default:
      return 'A sweet and cute candy for your sweetest moments 🍬';
  }
}

// Cari produk berdasarkan id
Product productById(String id) =>
    allProducts.firstWhere((product) => product.id == id);

// Voucher yang tersedia dan diskonnya
const Map<String, int> vouchers = {
  'CHERRY10': 10,
  'SWEET5': 5,
};

// ============================================================
// STATE BERSAMA (ChangeNotifier)
// ============================================================

// ShopController simpan state bersama. Saat datanya berubah,
// notifyListeners() dipanggil biar widget yang listen ikut update.
class ShopController extends ChangeNotifier {
  final List<CartItem> _cart = [];
  final Set<String> _favorites = {};
  String? _voucher;

  // Data profile
  String profileName = 'Cherry Club Member';
  String profileEmail = 'cherry@example.com';
  bool vipMode = true;

  // ---------- Cart ----------
  List<CartItem> get cart => List.unmodifiable(_cart);

  // Total jumlah item untuk badge cart
  int get totalItems => _cart.fold(0, (sum, item) => sum + item.quantity);

  // Total harga sebelum diskon
  int get subtotal => _cart.fold(
      0, (sum, item) => sum + item.product.price * item.quantity);

  // Tambah produk ke cart. Kalau sudah ada, jumlahnya ditambah.
  void addToCart(Product product, {int quantity = 1}) {
    final index = _cart.indexWhere((i) => i.product.name == product.name);
    if (index >= 0) {
      _cart[index].quantity += quantity;
    } else {
      _cart.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  // Tambah jumlah item
  void increase(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  // Kurangi jumlah item. Kalau tinggal satu, item dihapus.
  void decrease(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _cart.remove(item);
    }
    notifyListeners();
  }

  // Hapus item dari cart
  void remove(CartItem item) {
    _cart.remove(item);
    notifyListeners();
  }

  // Kosongkan cart setelah checkout
  void clearCart() {
    _cart.clear();
    _voucher = null;
    notifyListeners();
  }

  // ---------- Voucher & harga ----------
  String? get voucher => _voucher;

  int get voucherPercent => _voucher == null ? 0 : vouchers[_voucher]!;

  // Cek apakah kode voucher valid
  bool applyVoucher(String code) {
    final clean = code.trim().toUpperCase();
    if (vouchers.containsKey(clean)) {
      _voucher = clean;
      notifyListeners();
      return true;
    }
    return false;
  }

  void removeVoucher() {
    _voucher = null;
    notifyListeners();
  }

  int get voucherDiscount => subtotal * voucherPercent ~/ 100;

  // VIP dapat diskon tambahan 5%
  int get vipDiscount => vipMode ? subtotal * 5 ~/ 100 : 0;

  // Pickup gratis. Delivery Rp5.000, tapi gratis untuk VIP atau belanja minimal Rp75.000.
  int shippingFee(bool delivery) =>
      !delivery ? 0 : (vipMode || subtotal >= freeShippingMin ? 0 : 5000);

  int total(bool delivery) =>
      subtotal - voucherDiscount - vipDiscount + shippingFee(delivery);

  // ---------- Favorit ----------
  bool isFavorite(Product product) => _favorites.contains(product.name);

  void toggleFavorite(Product product) {
    if (!_favorites.remove(product.name)) {
      _favorites.add(product.name);
    }
    notifyListeners();
  }

  List<Product> get favoriteProducts =>
      allProducts.where((p) => _favorites.contains(p.name)).toList();

  // ---------- Profile ----------
  void updateProfile(String name, String email) {
    profileName = name;
    profileEmail = email;
    notifyListeners();
  }

  void setVip(bool value) {
    vipMode = value;
    notifyListeners();
  }
}

// Satu controller yang dipakai semua halaman
final ShopController shop = ShopController();

// ============================================================
// HELPER
// ============================================================

// Format angka jadi rupiah, misalnya 15000 jadi Rp15.000
String rupiah(int value) {
  final digits = value.toString().replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
        (match) => '${match[1]}.',
  );
  return 'Rp$digits';
}

// Tampilkan SnackBar pakai style CHERRYBOMB
void showMessage(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.dark,
        duration: const Duration(seconds: 2),
      ),
    );
}

// Buka halaman detail produk
void openProduct(BuildContext context, Product product) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProductDetailPage(product: product),
    ),
  );
}

// ============================================================
// APP
// ============================================================

// MaterialApp jadi dasar aplikasi
class CherryBombApp extends StatelessWidget {
  const CherryBombApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Atur tema dan halaman awal aplikasi
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CHERRYBOMB',

      // Atur tema global aplikasi
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        scaffoldBackgroundColor: AppColors.bg,

        // Samakan style semua ElevatedButton
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(0, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),

        // Samakan style semua OutlinedButton
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.primary),
            minimumSize: const Size(0, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),

        // Style AppBar untuk halaman detail dan Edit Profile
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),

      // Mulai dari SplashPage, lalu lanjut ke HomePage
      home: const SplashPage(),
    );
  }
}

// ============================================================
// SPLASH SCREEN
// ============================================================

// StatefulWidget dipakai karena halaman pindah otomatis
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // Setelah 2,6 detik, pindah ke HomePage pakai efek fade
    Future.delayed(const Duration(milliseconds: 2600), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (context, animation, secondaryAnimation) =>
          const HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // FadeTransition bikin perpindahan halaman lebih halus
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold jadi kerangka halaman splash
    return Scaffold(
      // Container jadi background gradient pink
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFF8FAB), Color(0xFFE83D5B)],
          ),
        ),

        // Center menaruh logo di tengah
        child: Center(
          // TweenAnimationBuilder bikin logo muncul pakai efek scale + fade
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 1400),
            curve: Curves.elasticOut,
            builder: (context, value, child) {
              return Opacity(
                opacity: value.clamp(0.0, 1.0).toDouble(),
                child: Transform.scale(scale: value, child: child),
              );
            },

            // Column berisi logo, nama, slogan, dan loading
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Container putih ini jadi logo
                Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),

                  // Column berisi dua cherry dan sparkle
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.circle, color: AppColors.primary, size: 38),
                          SizedBox(width: 3),
                          Icon(Icons.circle, color: AppColors.primary, size: 38),
                        ],
                      ),
                      Icon(
                        Icons.auto_awesome,
                        color: Color(0xFFF2A5B5),
                        size: 24,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Nama toko
                const Text(
                  'CHERRYBOMB',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 8),

                // Slogan
                const Text(
                  'Sweet things, made sweeter! 🍒',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
                const SizedBox(height: 36),

                // Loading indicator
                const SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// HOME PAGE (NavigationBar)
// ============================================================

// StatefulWidget dipakai karena selectedIndex bisa berubah
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // State untuk simpan tab yang sedang aktif
  int selectedIndex = 0;

  // Pindah tab dari halaman lain, misalnya dari ikon cart
  void goToTab(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold jadi kerangka utama aplikasi
    return Scaffold(
      // IndexedStack nampilin halaman sesuai tab,
      // halaman lain tetap simpan state
      body: IndexedStack(
        index: selectedIndex,
        children: [
          HomeContent(onGoToTab: goToTab),
          const ShopPage(),
          const CartPage(),
          const ProfilePage(),
        ],
      ),

      // ListenableBuilder bikin badge cart ikut update
      bottomNavigationBar: ListenableBuilder(
        listenable: shop,
        builder: (context, _) {
          // NavigationBar jadi menu di bawah
          return NavigationBar(
            selectedIndex: selectedIndex,
            backgroundColor: Colors.white,
            indicatorColor: AppColors.soft,
            onDestinationSelected: goToTab,
            destinations: [
              // Menu Home
              const NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),

              // Menu Shop
              const NavigationDestination(
                icon: Icon(Icons.storefront_outlined),
                selectedIcon: Icon(Icons.storefront),
                label: 'Shop',
              ),

              // Menu Cart + jumlah item
              NavigationDestination(
                icon: Badge(
                  isLabelVisible: shop.totalItems > 0,
                  label: Text('${shop.totalItems}'),
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
                selectedIcon: Badge(
                  isLabelVisible: shop.totalItems > 0,
                  label: Text('${shop.totalItems}'),
                  child: const Icon(Icons.shopping_cart),
                ),
                label: 'Cart',
              ),

              // Menu Profile
              const NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}

// ============================================================
// WIDGET UMUM (dipakai di banyak halaman)
// ============================================================

// Widget gambar produk + fallback kalau asset tidak ada
class ProductImage extends StatelessWidget {
  final String path;
  final BoxFit fit;
  final double? width;
  final double? height;

  const ProductImage({
    super.key,
    required this.path,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    // Image.asset mengambil gambar dari assets
    return Image.asset(
      path,
      fit: fit,
      width: width,
      height: height,

      // errorBuilder jalan kalau gambar gagal dimuat
      errorBuilder: (context, error, stackTrace) {
        // Container pengganti kalau gambar error
        return Container(
          width: width,
          height: height,
          color: AppColors.soft,
          child: const Icon(Icons.icecream, color: AppColors.primary),
        );
      },
    );
  }
}

// Kolom pencarian yang dipakai di Home dan Shop
class CandySearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const CandySearchField({
    super.key,
    required this.controller,
    required this.hint,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    // TextField untuk mengetik pencarian
    return TextField(
      controller: controller,
      onChanged: onChanged,

      // InputDecoration ngatur tampilan TextField
      decoration: InputDecoration(
        hintText: hint,

        // Icon search di kiri
        prefixIcon: const Icon(Icons.search, color: AppColors.primary),

        // Tombol hapus muncul kalau ada teks
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
          onPressed: onClear,
          icon: const Icon(Icons.close),
        )
            : null,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

// Pilihan kategori dalam bentuk ChoiceChip
class CategorySelector extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelected;

  const CategorySelector({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    // SingleChildScrollView horizontal biar chip bisa digeser
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,

      // Row susun chip ke samping
      child: Row(
        children: categories.map((category) {
          final isSelected = category == selected;

          // Padding kasih jarak antar chip
          return Padding(
            padding: const EdgeInsets.only(right: 8),

            // ChoiceChip untuk memilih kategori
            child: ChoiceChip(
              label: Text(category),
              selected: isSelected,
              selectedColor: AppColors.primary,
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : AppColors.dark,
              ),
              showCheckmark: false,
              onSelected: (_) => onSelected(category),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// Tampilan saat tidak ada data
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    // Center menaruh pesan di tengah
    return Center(
      // Padding kasih jarak dari tepi layar
      child: Padding(
        padding: const EdgeInsets.all(30),

        // Column berisi icon dan teks
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon ilustrasi
            Icon(icon, size: 80, color: const Color(0xFFF2A5B5)),
            const SizedBox(height: 14),

            // Judul
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.dark,
              ),
            ),
            const SizedBox(height: 6),

            // Keterangan
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.muted),
            ),
          ],
        ),
      ),
    );
  }
}

// Kartu putih untuk beberapa bagian seperti voucher dan pengiriman
class SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const SectionCard({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    // Container jadi kartu putih pakai bayangan
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      // Column berisi judul dan isi kartu
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Judul kartu
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.dark,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

// ============================================================
// HOME CONTENT
// ============================================================

// StatefulWidget dipakai karena pencarian dan kategori bisa berubah
class HomeContent extends StatefulWidget {
  // Callback untuk pindah tab dari HomePage
  final ValueChanged<int> onGoToTab;

  const HomeContent({super.key, required this.onGoToTab});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  // Controller untuk membaca teks pencarian
  final TextEditingController searchController = TextEditingController();

  // State untuk pencarian dan kategori yang dipilih
  String searchText = '';
  String selectedCategory = 'All';

  @override
  void dispose() {
    // Controller dibersihkan saat halaman selesai dipakai
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = searchText.trim().toLowerCase();
    final searching = query.isNotEmpty;

    // Cari produk berdasarkan nama
    final results = allProducts
        .where((p) => p.name.toLowerCase().contains(query))
        .toList();

    // Ambil produk sesuai kategori yang dipilih
    final picks = allProducts
        .where((p) => selectedCategory == 'All' || p.category == selectedCategory)
        .toList();

    // Urutkan produk berdasarkan jumlah terjual
    final bestSellers = ([...allProducts]
      ..sort((a, b) => b.sold.compareTo(a.sold)))
        .take(6)
        .toList();

    // SafeArea biar isi tidak ketutup status bar
    return SafeArea(
      // SingleChildScrollView biar halaman bisa di-scroll
      child: SingleChildScrollView(
        // Padding untuk jarak isi halaman
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 30),

          // Column berisi seluruh isi Home
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: logo, nama toko, dan cart
              HomeHeader(onCartTap: () => widget.onGoToTab(2)),
              const SizedBox(height: 20),

              // Kolom pencarian
              CandySearchField(
                controller: searchController,
                hint: 'Search your favorite candy...',
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                onClear: () {
                  searchController.clear();
                  setState(() {
                    searchText = '';
                  });
                },
              ),

              // ---------- Mode pencarian ----------
              if (searching) ...[
                const SizedBox(height: 18),

                // Jumlah hasil pencarian
                Text(
                  '${results.length} result found',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.dark,
                  ),
                ),
                const SizedBox(height: 10),

                // Tampilkan hasil pencarian atau pesan kosong
                if (results.isNotEmpty)
                  Column(
                    children: results
                        .map((p) => ProductListTile(product: p))
                        .toList(),
                  )
                else
                  const EmptyState(
                    icon: Icons.search_off,
                    title: 'Candy tidak ditemukan 🍬',
                    subtitle: 'Coba kata kunci lain ya!',
                  ),
              ],

              // ---------- Mode normal ----------
              if (!searching) ...[
                const SizedBox(height: 22),

                // Banner utama
                HeroCarousel(onGoToTab: widget.onGoToTab),
                const SizedBox(height: 22),

                // Judul kategori
                const Text(
                  'Sweet Categories',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: AppColors.dark,
                  ),
                ),
                const SizedBox(height: 12),

                // CategoryTiles untuk memilih kategori
                CategoryTiles(
                  selected: selectedCategory,
                  onSelected: (category) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                ),
                const SizedBox(height: 24),

                // Judul Best Sellers
                const Text(
                  '🔥 Best Sellers',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 12),

                // Daftar produk terlaris secara horizontal
                SizedBox(
                  height: 190,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: bestSellers.length,
                    itemBuilder: (context, index) {
                      return MiniProductCard(product: bestSellers[index]);
                    },
                  ),
                ),
                const SizedBox(height: 18),

                // Judul produk + tombol See all
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedCategory == 'All'
                          ? "Today's Sweet Picks 🍬"
                          : '$selectedCategory Picks ${selectedCategory == 'Chocolate' ? '🍫' : '✨'}',
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),

                    // TextButton untuk pindah ke Shop
                    TextButton(
                      onPressed: () => widget.onGoToTab(1),
                      child: const Text('See all ›'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // GridView untuk kartu produk
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: picks.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 230,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.66,
                  ),
                  itemBuilder: (context, index) {
                    // FadeInUp kasih efek muncul pada kartu
                    return FadeInUp(
                      index: index,
                      child: ProductCard(product: picks[index]),
                    );
                  },
                ),
                const SizedBox(height: 22),

                // Banner promo + countdown
                const PromoBanner(),
                const SizedBox(height: 28),

                // Footer
                const Center(
                  child: Text(
                    '♥ · ˚✦ made with love by Ghesya (๑˃ᴗ˂)ﻭ ✨',
                    style: TextStyle(fontSize: 12, color: Color(0xFFB19AA1)),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Header Home: logo, nama toko, dan cart
class HomeHeader extends StatelessWidget {
  final VoidCallback onCartTap;

  const HomeHeader({super.key, required this.onCartTap});

  @override
  Widget build(BuildContext context) {
    // Row berisi logo, teks, dan ikon cart
    return Row(
      children: [
        // Container jadi logo CHERRYBOMB
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFFFFDCE4),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFFFC5D1)),
          ),

          // Column berisi dua cherry dan sparkle
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Row untuk dua simbol cherry
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.circle, color: AppColors.primary, size: 17),
                  SizedBox(width: 2),
                  Icon(Icons.circle, color: AppColors.primary, size: 17),
                ],
              ),

              // Icon sparkle dekorasi
              Icon(Icons.auto_awesome, color: Color(0xFFF2A5B5), size: 12),
            ],
          ),
        ),
        const SizedBox(width: 12),

        // Expanded kasih ruang untuk teks
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nama toko
              Text(
                'CHERRYBOMB',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),

              // Slogan
              Text(
                'Sweet things, made sweeter! 🍒',
                style: TextStyle(fontSize: 12, color: AppColors.muted),
              ),
            ],
          ),
        ),

        // ListenableBuilder bikin badge cart ikut update
        ListenableBuilder(
          listenable: shop,
          builder: (context, _) {
            // IconButton untuk buka tab Cart
            return IconButton(
              onPressed: onCartTap,

              // Badge menunjukkan jumlah item di cart
              icon: Badge(
                isLabelVisible: shop.totalItems > 0,
                label: Text('${shop.totalItems}'),
                backgroundColor: AppColors.primary,
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  size: 28,
                  color: Color(0xFF5E4149),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

// Banner utama pakai ilustrasi cherry
class HeroBanner extends StatelessWidget {
  final VoidCallback onShopNow;

  const HeroBanner({super.key, required this.onShopNow});

  // Buat batang cherry yang miring
  Widget _stem(double left, double angle) {
    // Positioned ngatur posisi batang
    return Positioned(
      left: left,
      top: 15,

      // Transform.rotate memiringkan batang
      child: Transform.rotate(
        angle: angle,

        // Container jadi batang cherry
        child: Container(
          width: 7,
          height: 55,
          decoration: BoxDecoration(
            color: const Color(0xFF6D9B52),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  // Buat bentuk buah cherry
  Widget _circle({
    double? left,
    double? right,
    required double top,
    required double size,
    required Color color,
  }) {
    // Positioned ngatur posisi lingkaran
    return Positioned(
      left: left,
      right: right,
      top: top,

      // Container ini dibuat bulat
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Container jadi background banner
    return Container(
      width: double.infinity,
      height: 210,
      decoration: BoxDecoration(
        color: AppColors.soft,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      // Stack menaruh teks, tombol, dan ilustrasi
      child: Stack(
        children: [
          // Teks banner
          const Positioned(
            left: 20,
            top: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sweet things,',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.dark,
                  ),
                ),
                Text(
                  'made sweeter! 🍭',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.dark,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Welcome to CHERRYBOMB',
                  style: TextStyle(fontSize: 13, color: Color(0xFF6D4552)),
                ),
              ],
            ),
          ),

          // Tombol Shop Now
          Positioned(
            left: 20,
            bottom: 22,
            child: ElevatedButton(
              onPressed: onShopNow,
              child: const Text('Shop Now'),
            ),
          ),

          // Ilustrasi cherry
          Positioned(
            right: 16,
            bottom: 16,
            child: SizedBox(
              width: 110,
              height: 110,
              child: FittedBox(
                // SizedBox jadi area gambar cherry
                child: SizedBox(
                  width: 150,
                  height: 150,

                  // Stack berisi batang, daun, buah, dan highlight
                  child: Stack(
                    children: [
                      _stem(62, -0.35),
                      _stem(78, 0.35),

                      // Daun cherry
                      const Positioned(
                        left: 70,
                        top: 5,
                        child: Icon(
                          Icons.eco,
                          size: 35,
                          color: Color(0xFF6D9B52),
                        ),
                      ),

                      // Dua buah cherry
                      _circle(
                        left: 35,
                        top: 50,
                        size: 62,
                        color: AppColors.primary,
                      ),
                      _circle(
                        right: 35,
                        top: 50,
                        size: 62,
                        color: AppColors.primary,
                      ),

                      // Highlight pada cherry
                      _circle(
                        left: 50,
                        top: 62,
                        size: 12,
                        color: const Color(0xFFFFA9BA),
                      ),
                      _circle(
                        right: 50,
                        top: 62,
                        size: 12,
                        color: const Color(0xFFFFA9BA),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Carousel banner yang bergeser otomatis
// StatefulWidget dipakai karena page bisa berubah
class HeroCarousel extends StatefulWidget {
  final ValueChanged<int> onGoToTab;

  const HeroCarousel({super.key, required this.onGoToTab});

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  // Controller untuk PageView
  final PageController controller = PageController();

  // Timer menggeser banner tiap 4 detik
  late final Timer timer;

  // State untuk simpan halaman yang sedang tampil
  int page = 0;

  static const int slideCount = 3;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!controller.hasClients) return;
      final next = (page + 1) % slideCount;
      controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    // Timer dan controller dibersihkan saat selesai
    timer.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Column berisi carousel dan dot indicator
    return Column(
      children: [
        // SizedBox kasih tinggi untuk PageView
        SizedBox(
          height: 210,

          // PageView untuk banner yang bisa digeser
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                page = index;
              });
            },
            children: [
              // Slide 1: banner utama
              HeroBanner(onShopNow: () {
                widget.onGoToTab(1);
              }),

              // Slide 2: box eksklusif
              PromoSlide(
                product: productById('love_chocolate'),
                tag: 'EXCLUSIVE BOX 💝',
                title: 'Especially for ur GF',
                subtitle: 'Surprise her with a box full of love 💌',
                colors: const [Color(0xFFFF7A9A), Color(0xFFE83D5B)],
                onTap: () =>
                    openProduct(context, productById('love_chocolate')),
              ),

              // Slide 3: Sanrio corner
              PromoSlide(
                product: productById('hellokitty_chocolate'),
                tag: 'SANRIO CORNER 🎀',
                title: 'Hello Kitty & My Melody',
                subtitle: 'Cute treats for every Sanrio lover!',
                colors: const [Color(0xFFB57BFF), Color(0xFFFF6FA5)],
                onTap: () =>
                    openProduct(context, productById('hellokitty_chocolate')),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Row untuk dot indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(slideCount, (index) {
            final active = index == page;

            // AnimatedContainer bikin dot ikut berubah
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: active ? 22 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: active ? AppColors.primary : AppColors.soft,
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }),
        ),
      ],
    );
  }
}

// Slide promo pakai gradient dan foto produk
class PromoSlide extends StatelessWidget {
  final Product product;
  final String tag;
  final String title;
  final String subtitle;
  final List<Color> colors;
  final VoidCallback onTap;

  const PromoSlide({
    super.key,
    required this.product,
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.colors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Container gradient jadi background slide
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      // Row berisi teks dan foto produk
      child: Row(
        children: [
          // Expanded biar area teks fleksibel
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container untuk label kecil
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0x33FFFFFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Judul slide
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),

                // Subjudul slide
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFFFE4EC),
                  ),
                ),
                const SizedBox(height: 12),

                // Tombol menuju detail produk
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.dark,
                    minimumSize: const Size(0, 38),
                  ),
                  child: const Text('Shop now'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Container untuk foto produk
          Container(
            width: 110,
            height: 110,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: Colors.white, width: 3),
            ),
            child: ProductImage(path: product.image),
          ),
        ],
      ),
    );
  }
}

// Animasi muncul pakai efek fade + naik
class FadeInUp extends StatelessWidget {
  final int index;
  final Widget child;

  const FadeInUp({super.key, required this.index, required this.child});

  @override
  Widget build(BuildContext context) {
    // TweenAnimationBuilder ubah nilai 0 -> 1
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 350 + (index % 6) * 80),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        // Opacity + Transform.translate bikin efek fade dan naik
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 24 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

// Kartu kategori, tekan untuk filter
class CategoryTiles extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelected;

  const CategoryTiles({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Row susun kartu kategori
    return Row(
      children: categories.where((c) => c != 'All').map((category) {
        final isSelected = category == selected;
        final count = allProducts.where((p) => p.category == category).length;

        // Expanded membagi lebar kartu
        return Expanded(
          // Padding kasih jarak antar kartu
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),

            // GestureDetector menangkap tap pada kartu
            child: GestureDetector(
              onTap: () => onSelected(isSelected ? 'All' : category),

              // AnimatedContainer bikin border berubah saat dipilih
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: categoryColor(category),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: isSelected
                      ? const [
                    BoxShadow(
                      color: Color(0x4DE83D5B),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ]
                      : null,
                ),

                // Column berisi icon, nama, dan jumlah produk
                child: Column(
                  children: [
                    // CircleAvatar jadi latar icon
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      child: Icon(
                        categoryIcon(category),
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // FittedBox mengecilkan nama kalau terlalu panjang
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        category,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    // Jumlah produk
                    Text(
                      '$count items',
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// Kartu kecil untuk daftar horizontal (Best Sellers, Related)
class MiniProductCard extends StatelessWidget {
  final Product product;

  const MiniProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // GestureDetector membuka detail saat ditekan
    return GestureDetector(
      onTap: () => openProduct(context, product),

      // Container sebagai kartu putih
      child: Container(
        width: 135,
        margin: const EdgeInsets.only(right: 12, bottom: 6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        // Column susun gambar, nama, rating, dan harga
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ClipRRect bikin gambar rounded
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ProductImage(
                path: product.image,
                width: double.infinity,
                height: 92,
              ),
            ),
            const SizedBox(height: 6),

            // Nama produk
            Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const Spacer(),

            // Row rating dan harga
            Row(
              children: [
                const Icon(Icons.star, size: 13, color: Color(0xFFFFB300)),
                const SizedBox(width: 2),
                Text(
                  product.rating.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 11),
                ),
                const Spacer(),
                Text(
                  rupiah(product.price),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// StatefulWidget karena countdown berubah setiap detik (Timer.periodic)
class PromoBanner extends StatefulWidget {
  const PromoBanner({super.key});

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  // Timer yang berjalan tiap 1 detik
  late final Timer timer;

  // State: sisa waktu promo
  Duration remaining = const Duration(hours: 5, minutes: 30);

  // Produk yang sedang promo
  final Product promoProduct = productById('redvelvet_chocolate');

  @override
  void initState() {
    super.initState();

    // Timer.periodic mengurangi sisa waktu setiap detik
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remaining.inSeconds <= 0) {
        t.cancel();
        return;
      }
      setState(() {
        remaining -= const Duration(seconds: 1);
      });
    });
  }

  @override
  void dispose() {
    // Timer wajib dibatalkan biar tidak berjalan setelah widget hilang
    timer.cancel();
    super.dispose();
  }

  // Ubah angka menjadi 2 digit, contoh 5 -> 05
  String two(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final countdown = '${two(remaining.inHours)}:'
        '${two(remaining.inMinutes % 60)}:'
        '${two(remaining.inSeconds % 60)}';

    // GestureDetector bikin seluruh banner bisa ditekan
    return GestureDetector(
      onTap: () => openProduct(context, promoProduct),

      // Container jadi background banner
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFFFE5D5),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        // Row susun gambar, teks, dan tombol
        child: Row(
          children: [
            // ClipRRect bikin gambar rounded
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: ProductImage(
                path: promoProduct.image,
                width: 90,
                height: 90,
              ),
            ),
            const SizedBox(width: 12),

            // Expanded biar area teks fleksibel
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'LIMITED CANDY DROP 💥',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    promoProduct.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A3038),
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Countdown yang berubah tiap detik
                  Row(
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                        size: 14,
                        color: AppColors.muted,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Ends in $countdown',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Icon panah sebagai petunjuk bisa ditekan
            const CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Icon(Icons.arrow_forward, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// PRODUCT CARD (Grid) & PRODUCT LIST TILE (List)
// ============================================================

// Kartu produk untuk tampilan grid di Home
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // GestureDetector membuka detail saat kartu ditekan
    return GestureDetector(
      onTap: () => openProduct(context, product),

      // Container sebagai kartu putih
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        // Column susun gambar dan info produk
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expanded biar gambar mengisi ruang yang tersisa
            Expanded(
              // Stack menumpuk gambar, label, dan tombol favorit
              child: Stack(
                children: [
                  // Positioned.fill bikin gambar memenuhi Stack
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: ProductImage(path: product.image),
                    ),
                  ),

                  // Label produk (BEST SELLER, NEW, dll)
                  if (product.badge != null)
                    Positioned(
                      left: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE4EC),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          product.badge!,
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),

                  // Tombol favorit (rebuild otomatis saat favorit berubah)
                  Positioned(
                    right: 4,
                    top: 4,
                    child: ListenableBuilder(
                      listenable: shop,
                      builder: (context, _) {
                        final fav = shop.isFavorite(product);

                        // GestureDetector untuk toggle favorit
                        return GestureDetector(
                          onTap: () => shop.toggleFavorite(product),

                          // CircleAvatar jadi latar icon hati
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.white,
                            child: Icon(
                              fav ? Icons.favorite : Icons.favorite_border,
                              size: 18,
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Nama produk
            Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 4),

            // Row harga + tombol tambah ke cart
            Row(
              children: [
                // Expanded biar harga mengisi sisa ruang
                Expanded(
                  child: Text(
                    rupiah(product.price),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),

                // IconButton menambah produk ke cart
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    shop.addToCart(product);
                    showMessage(
                      context,
                      '${product.name} masuk ke cart 🛒',
                    );
                  },
                  icon: const Icon(
                    Icons.add_shopping_cart,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Item produk berbentuk list (Shop, hasil pencarian, favorit)
class ProductListTile extends StatelessWidget {
  final Product product;

  const ProductListTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // GestureDetector membuka detail saat ditekan
    return GestureDetector(
      onTap: () => openProduct(context, product),

      // Container sebagai kartu item
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        // Row susun gambar, info, dan tombol aksi
        child: Row(
          children: [
            // ClipRRect bikin gambar rounded
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ProductImage(
                path: product.image,
                width: 72,
                height: 72,
              ),
            ),
            const SizedBox(width: 12),

            // Expanded untuk informasi produk
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama produk
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),

                  // Deskripsi singkat
                  Text(
                    product.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.muted,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Rating dan jumlah terjual
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 13,
                        color: Color(0xFFFFB300),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${product.rating.toStringAsFixed(1)} • ${product.sold} sold',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Harga
                  Text(
                    rupiah(product.price),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Kolom tombol favorit dan tambah ke cart
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ListenableBuilder biar icon hati ikut berubah
                ListenableBuilder(
                  listenable: shop,
                  builder: (context, _) {
                    // IconButton toggle favorit
                    return IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () => shop.toggleFavorite(product),
                      icon: Icon(
                        shop.isFavorite(product)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: AppColors.primary,
                      ),
                    );
                  },
                ),

                // IconButton tambah ke cart
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    shop.addToCart(product);
                    showMessage(
                      context,
                      '${product.name} masuk ke cart 🛒',
                    );
                  },
                  icon: const Icon(
                    Icons.add_shopping_cart,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// SHOP PAGE
// ============================================================

// StatefulWidget karena ada pencarian, kategori, sort, dan filter favorit
class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  // Controller input pencarian
  final TextEditingController searchController = TextEditingController();

  // State halaman Shop
  String searchText = '';
  String selectedCategory = 'All';
  String sortBy = 'Default';
  bool onlyFavorites = false;

  // Pilihan urutan produk
  static const List<String> sortOptions = [
    'Default',
    'Name A-Z',
    'Price: Low to High',
    'Price: High to Low',
    'Top Rated',
    'Best Selling',
  ];

  @override
  void dispose() {
    // Controller dibersihkan saat halaman ditutup
    searchController.dispose();
    super.dispose();
  }

  // Buat daftar produk setelah difilter dan diurutkan
  List<Product> getVisibleProducts() {
    final query = searchText.trim().toLowerCase();

    final list = allProducts.where((p) {
      final matchName = p.name.toLowerCase().contains(query);
      final matchCategory =
          selectedCategory == 'All' || p.category == selectedCategory;
      final matchFavorite = !onlyFavorites || shop.isFavorite(p);
      return matchName && matchCategory && matchFavorite;
    }).toList();

    if (sortBy == 'Name A-Z') {
      list.sort((a, b) => a.name.compareTo(b.name));
    } else if (sortBy == 'Price: Low to High') {
      list.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortBy == 'Price: High to Low') {
      list.sort((a, b) => b.price.compareTo(a.price));
    } else if (sortBy == 'Top Rated') {
      list.sort((a, b) => b.rating.compareTo(a.rating));
    } else if (sortBy == 'Best Selling') {
      list.sort((a, b) => b.sold.compareTo(a.sold));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    // ListenableBuilder biar filter favorit selalu mengikuti state terbaru
    return ListenableBuilder(
      listenable: shop,
      builder: (context, _) {
        final products = getVisibleProducts();

        // SafeArea biar konten dari status bar
        return SafeArea(
          // Column susun header, filter, dan daftar produk
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding judul halaman
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 4),

                // Row judul dan jumlah produk
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Candy Shop 🍬',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.dark,
                      ),
                    ),
                    Text(
                      '${products.length} items',
                      style: const TextStyle(color: AppColors.muted),
                    ),
                  ],
                ),
              ),

              // Padding kolom pencarian
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: CandySearchField(
                  controller: searchController,
                  hint: 'Search candy...',
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  onClear: () {
                    searchController.clear();
                    setState(() {
                      searchText = '';
                    });
                  },
                ),
              ),

              // Padding chip kategori
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CategorySelector(
                  selected: selectedCategory,
                  onSelected: (category) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                ),
              ),

              // Padding baris filter favorit dan urutan
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 0),

                // Row: FilterChip favorit + Dropdown sort
                child: Row(
                  children: [
                    // FilterChip: chip on/off untuk filter favorit
                    FilterChip(
                      label: const Text('Favorites ❤'),
                      selected: onlyFavorites,
                      selectedColor: AppColors.soft,
                      backgroundColor: Colors.white,
                      onSelected: (value) {
                        setState(() {
                          onlyFavorites = value;
                        });
                      },
                    ),
                    const Spacer(),

                    // DropdownButton memilih urutan produk
                    DropdownButton<String>(
                      value: sortBy,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.sort, color: AppColors.primary),
                      items: sortOptions.map((option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(
                            option,
                            style: const TextStyle(fontSize: 13),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            sortBy = value;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),

              // Expanded biar daftar mengisi sisa halaman
              Expanded(
                child: products.isEmpty
                // Pesan jika tidak ada produk yang cocok
                    ? const EmptyState(
                  icon: Icons.search_off,
                  title: 'Candy tidak ditemukan 🍬',
                  subtitle: 'Coba ubah kata kunci atau filter.',
                )
                // ListView.builder nampilin daftar produk
                    : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    // FadeInUp kasih animasi muncul pada item
                    return FadeInUp(
                      index: index,
                      child: ProductListTile(product: products[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ============================================================
// PRODUCT DETAIL PAGE
// ============================================================

// StatefulWidget karena jumlah (quantity) yang dipilih bisa berubah
class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  // State: jumlah produk yang akan dimasukkan ke cart
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    // Produk lain dalam kategori yang sama
    final related = allProducts
        .where((p) => p.category == product.category && p.id != product.id)
        .toList();

    // Scaffold sebagai struktur halaman detail
    return Scaffold(
      // AppBar sebagai header, pakai tombol favorit di kanan
      appBar: AppBar(
        title: const Text(
          'Product Detail',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          // ListenableBuilder biar icon hati ikut berubah
          ListenableBuilder(
            listenable: shop,
            builder: (context, _) {
              // IconButton toggle favorit
              return IconButton(
                onPressed: () => shop.toggleFavorite(product),
                icon: Icon(
                  shop.isFavorite(product)
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
              );
            },
          ),
        ],
      ),

      // SingleChildScrollView biar detail bisa di-scroll
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        // Column susun isi detail
        child: Column(
          children: [
            // Stack untuk gambar dan label kategori
            Stack(
              children: [
                // Container sebagai background gambar
                Container(
                  width: double.infinity,
                  height: 300,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: categoryColor(product.category),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),

                  // Gambar produk
                  child: ProductImage(
                    path: product.image,
                    fit: BoxFit.contain,
                  ),
                ),

                // Chip kategori di pojok kiri atas
                Positioned(
                  left: 15,
                  top: 15,
                  child: Chip(
                    backgroundColor: Colors.white,
                    label: Text('CHERRYBOMB 🍒 • ${product.category}'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),

            // Nama produk
            Text(
              product.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.dark,
              ),
            ),
            const SizedBox(height: 8),

            // Harga satuan
            Text(
              rupiah(product.price),
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 14),

            // Row rating dan jumlah terjual
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Color(0xFFFFB300), size: 20),
                const SizedBox(width: 4),
                Text(
                  product.rating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '•  ${product.sold} terjual',
                  style: const TextStyle(color: AppColors.muted),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Deskripsi produk
            Text(
              '${product.description}. ${categoryBlurb(product.category)}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, color: Color(0xFF6D4552)),
            ),

            // Catatan spesial khusus Love Chocolate Box
            if (product.id == 'love_chocolate') ...[
              const SizedBox(height: 14),

              // Container catatan pakai gradient pink
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFE4EC), Color(0xFFFFC5D8)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  '💝 Exclusive box, spesial buat kamu yang mau bikin pacar '
                      'senyum seharian. Siap dikasih langsung atau jadi surprise!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.dark,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 22),

            // Container kontrol jumlah
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),

              // Row: label, stepper jumlah, subtotal
              child: Row(
                children: [
                  const Text(
                    'Quantity',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.dark,
                    ),
                  ),
                  const Spacer(),

                  // Tombol kurangi jumlah (minimal 1)
                  IconButton(
                    onPressed: quantity > 1
                        ? () {
                      setState(() {
                        quantity--;
                      });
                    }
                        : null,
                    icon: const Icon(Icons.remove_circle_outline),
                  ),

                  // Jumlah saat ini
                  Text(
                    '$quantity',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Tombol tambah jumlah (maksimal 99)
                  IconButton(
                    onPressed: quantity < 99
                        ? () {
                      setState(() {
                        quantity++;
                      });
                    }
                        : null,
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // SizedBox biar tombol memenuhi lebar
            SizedBox(
              width: double.infinity,

              // ElevatedButton.icon tambah ke cart sesuai quantity
              child: ElevatedButton.icon(
                onPressed: () {
                  shop.addToCart(product, quantity: quantity);
                  showMessage(
                    context,
                    '$quantity x ${product.name} masuk ke cart 🛒',
                  );
                },
                icon: const Icon(Icons.shopping_cart),
                label: Text(
                  'Add to Cart • ${rupiah(product.price * quantity)}',
                ),
              ),
            ),
            const SizedBox(height: 10),

            // SizedBox biar tombol memenuhi lebar
            SizedBox(
              width: double.infinity,

              // OutlinedButton kembali ke halaman sebelumnya
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Shop'),
              ),
            ),

            // Bagian produk terkait (kategori yang sama)
            if (related.isNotEmpty) ...[
              const SizedBox(height: 26),

              // Judul produk terkait
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'More ${product.category} 💕',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.dark,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Daftar horizontal produk terkait
              SizedBox(
                height: 190,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: related.length,
                  itemBuilder: (context, index) {
                    return MiniProductCard(product: related[index]);
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CART PAGE
// ============================================================

// StatefulWidget karena ada pilihan pengiriman, pembayaran, dan voucher
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Controller input kode voucher
  final TextEditingController voucherController = TextEditingController();

  // State: true = delivery, false = pickup
  bool delivery = false;

  // State: metode pembayaran terpilih
  String payment = 'QRIS';

  static const List<String> paymentMethods = ['QRIS', 'Transfer Bank', 'COD'];

  @override
  void dispose() {
    // Controller dibersihkan saat halaman ditutup
    voucherController.dispose();
    super.dispose();
  }

  // Memeriksa kode voucher yang dimasukkan
  void applyVoucher() {
    final ok = shop.applyVoucher(voucherController.text);
    if (ok) {
      voucherController.clear();
      showMessage(context, 'Voucher berhasil dipakai 🎉');
    } else {
      showMessage(context, 'Kode voucher tidak valid 🍒');
    }
  }

  // Tampilkan dialog konfirmasi lalu memproses checkout
  Future<void> checkout() async {
    final total = shop.total(delivery);

    // showDialog nampilin AlertDialog konfirmasi pesanan
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        // AlertDialog berisi ringkasan pesanan
        return AlertDialog(
          title: const Text('Konfirmasi Pesanan 🍒'),
          content: Text(
            'Total: ${rupiah(total)}\n'
                'Pengambilan: ${delivery ? 'Delivery' : 'Pickup'}\n'
                'Pembayaran: $payment',
          ),
          actions: [
            // Tombol batal
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Batal'),
            ),

            // Tombol bayar
            ElevatedButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Bayar'),
            ),
          ],
        );
      },
    );

    // Pastikan halaman masih aktif sebelum memakai context
    if (confirm != true || !mounted) return;

    shop.clearCart();
    showMessage(context, 'Checkout berhasil! Terima kasih sudah belanja 🍒');
  }

  @override
  Widget build(BuildContext context) {
    // SafeArea biar isi halaman
    return SafeArea(
      // ListenableBuilder rebuild saat cart berubah
      child: ListenableBuilder(
        listenable: shop,
        builder: (context, _) {
          final items = shop.cart;

          // Tampilan jika cart kosong
          if (items.isEmpty) {
            return const EmptyState(
              icon: Icons.shopping_cart_outlined,
              title: 'Your cart is empty 🛒',
              subtitle: 'Add some sweet candies first!',
            );
          }

          // Column susun judul, isi cart, dan bar checkout
          return Column(
            children: [
              // Judul halaman
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'My Cart 🛒',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppColors.dark,
                    ),
                  ),
                ),
              ),

              // Expanded biar daftar bisa di-scroll
              Expanded(
                // ListView menampung item, voucher, opsi, dan ringkasan
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                  children: [
                    // Daftar item cart (geser ke kiri untuk hapus)
                    ...items.map((item) => CartItemCard(item: item)),
                    const SizedBox(height: 4),

                    // Kartu progress gratis ongkir
                    SectionCard(
                      title: 'Gratis Ongkir 🚚',

                      // Column berisi teks dan progress bar
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Teks status gratis ongkir
                          Text(
                            shop.vipMode
                                ? 'Member VIP selalu gratis ongkir ✨'
                                : shop.subtotal >= freeShippingMin
                                ? 'Yeay! Kamu dapat gratis ongkir 🎉'
                                : 'Belanja ${rupiah(freeShippingMin - shop.subtotal)} lagi untuk gratis ongkir',
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 8),

                          // LinearProgressIndicator menunjukkan progres belanja
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: shop.vipMode
                                  ? 1.0
                                  : (shop.subtotal / freeShippingMin)
                                  .clamp(0.0, 1.0)
                                  .toDouble(),
                              minHeight: 10,
                              backgroundColor: AppColors.soft,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Kartu voucher
                    SectionCard(
                      title: 'Voucher 🎟️',

                      // Column: input voucher dan voucher aktif
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row input + tombol pakai
                          Row(
                            children: [
                              // Expanded biar TextField fleksibel
                              Expanded(
                                child: TextField(
                                  controller: voucherController,
                                  textCapitalization:
                                  TextCapitalization.characters,
                                  decoration: InputDecoration(
                                    hintText: 'Coba: CHERRY10 / SWEET5',
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),

                              // Tombol pakai voucher
                              ElevatedButton(
                                onPressed: applyVoucher,
                                child: const Text('Apply'),
                              ),
                            ],
                          ),

                          // Chip voucher yang sedang aktif
                          if (shop.voucher != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Chip(
                                backgroundColor: AppColors.soft,
                                label: Text(
                                  '${shop.voucher} • -${shop.voucherPercent}%',
                                ),
                                onDeleted: shop.removeVoucher,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Kartu pilihan pengambilan
                    SectionCard(
                      title: 'Pengambilan 🚚',

                      // SegmentedButton memilih Pickup / Delivery
                      child: SizedBox(
                        width: double.infinity,
                        child: SegmentedButton<bool>(
                          segments: const [
                            ButtonSegment<bool>(
                              value: false,
                              label: Text('Pickup'),
                              icon: Icon(Icons.store),
                            ),
                            ButtonSegment<bool>(
                              value: true,
                              label: Text('Delivery'),
                              icon: Icon(Icons.delivery_dining),
                            ),
                          ],
                          selected: {delivery},
                          style: SegmentedButton.styleFrom(
                            selectedBackgroundColor: AppColors.soft,
                            selectedForegroundColor: AppColors.dark,
                          ),
                          onSelectionChanged: (selection) {
                            setState(() {
                              delivery = selection.first;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Kartu metode pembayaran
                    SectionCard(
                      title: 'Pembayaran 💳',

                      // Wrap susun chip dan turun baris bila sempit
                      child: Wrap(
                        spacing: 8,
                        children: paymentMethods.map((method) {
                          // ChoiceChip memilih metode pembayaran
                          return ChoiceChip(
                            label: Text(method),
                            selected: payment == method,
                            selectedColor: AppColors.soft,
                            onSelected: (_) {
                              setState(() {
                                payment = method;
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Kartu ringkasan harga
                    SectionCard(
                      title: 'Ringkasan 🧾',

                      // Column berisi baris-baris rincian harga
                      child: Column(
                        children: [
                          SummaryRow(
                            label: 'Subtotal',
                            value: rupiah(shop.subtotal),
                          ),
                          if (shop.voucherDiscount > 0)
                            SummaryRow(
                              label: 'Voucher ${shop.voucherPercent}%',
                              value: '-${rupiah(shop.voucherDiscount)}',
                            ),
                          if (shop.vipDiscount > 0)
                            SummaryRow(
                              label: 'VIP 5%',
                              value: '-${rupiah(shop.vipDiscount)}',
                            ),
                          SummaryRow(
                            label: 'Ongkir',
                            value: shop.shippingFee(delivery) == 0
                                ? 'Gratis'
                                : rupiah(shop.shippingFee(delivery)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Container bar checkout di bagian bawah
              Container(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),

                // Column: total dan tombol checkout
                child: Column(
                  children: [
                    // Row total harga
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          rupiah(shop.total(delivery)),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // SizedBox biar tombol penuh
                    SizedBox(
                      width: double.infinity,

                      // Tombol checkout
                      child: ElevatedButton.icon(
                        onPressed: checkout,
                        icon: const Icon(Icons.shopping_cart_checkout),
                        label: const Text('Checkout'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Satu baris rincian harga (label di kiri, nilai di kanan)
class SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const SummaryRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    // Padding jarak antar baris
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),

      // Row label dan nilai
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.muted)),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// Kartu satu item di cart, bisa digeser untuk hapus
class CartItemCard extends StatelessWidget {
  final CartItem item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // Dismissible: geser ke kiri untuk hapus item
    return Dismissible(
      key: ObjectKey(item),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => shop.remove(item),

      // Background merah yang muncul saat digeser
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.only(right: 24),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),

      // Container sebagai kartu item
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        // Row susun gambar, info, dan total per item
        child: Row(
          children: [
            // ClipRRect bikin gambar rounded
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ProductImage(
                path: item.product.image,
                width: 72,
                height: 72,
              ),
            ),
            const SizedBox(width: 12),

            // Expanded untuk nama, harga satuan, dan stepper
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama produk
                  Text(
                    item.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),

                  // Harga satuan
                  Text(
                    rupiah(item.product.price),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.muted,
                    ),
                  ),

                  // Row stepper jumlah
                  Row(
                    children: [
                      // Kurangi jumlah
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () => shop.decrease(item),
                        icon: const Icon(Icons.remove_circle_outline),
                      ),

                      // Jumlah item
                      Text(
                        '${item.quantity}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      // Tambah jumlah
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () => shop.increase(item),
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Column: tombol hapus dan total per item
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Tombol hapus item
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () => shop.remove(item),
                  icon: const Icon(
                    Icons.delete_outline,
                    color: AppColors.primary,
                  ),
                ),

                // Total harga item (harga x jumlah)
                Text(
                  rupiah(item.product.price * item.quantity),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// PROFILE PAGE
// ============================================================

// StatefulWidget karena ada Slider, Switch, dan ChoiceChip
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // State: level kemanisan (Slider)
  double sweetnessLevel = 100;

  // State: notifikasi promo (Switch)
  bool promoNotification = true;

  // State: rasa favorit (ChoiceChip)
  String favoriteFlavor = 'Gummies';

  static const List<String> flavors = [
    'Gummies',
    'Lollipop',
    'Marshmallow',
    'Chocolate',
  ];

  // Teks deskripsi sesuai nilai slider
  String sweetnessLabel(double value) {
    if (value <= 20) return 'Tipis manis 🍃';
    if (value <= 50) return 'Manis sedang 🍓';
    if (value <= 80) return 'Manis banget 🍬';
    return 'Super sweet! 🍒';
  }

  // Membuka halaman Edit Profile
  void openEditProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditProfilePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // SafeArea biar isi dari status bar
    return SafeArea(
      // SingleChildScrollView biar halaman bisa di-scroll
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 25, 20, 30),

        // ListenableBuilder biar data profile ikut berubah otomatis
        child: ListenableBuilder(
          listenable: shop,
          builder: (context, _) {
            final favorites = shop.favoriteProducts;

            // Column susun seluruh isi Profile
            return Column(
              children: [
                // Stack: foto profile + badge VIP
                Stack(
                  children: [
                    // CircleAvatar sebagai foto profile
                    const CircleAvatar(
                      radius: 55,
                      backgroundColor: AppColors.soft,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: AppColors.primary,
                      ),
                    ),

                    // Badge mahkota muncul jika VIP aktif
                    if (shop.vipMode)
                      const Positioned(
                        right: 0,
                        bottom: 0,
                        child: CircleAvatar(
                          radius: 17,
                          backgroundColor: Color(0xFFFFC107),
                          child: Icon(
                            Icons.workspace_premium,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 14),

                // Nama profile
                Text(
                  shop.profileName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.dark,
                  ),
                ),
                const SizedBox(height: 4),

                // Email profile
                Text(
                  shop.profileEmail,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.muted,
                  ),
                ),
                const SizedBox(height: 16),

                // Row statistik: item cart, favorit, status
                Row(
                  children: [
                    StatTile(
                      icon: Icons.shopping_cart,
                      value: '${shop.totalItems}',
                      label: 'In Cart',
                    ),
                    const SizedBox(width: 10),
                    StatTile(
                      icon: Icons.favorite,
                      value: '${favorites.length}',
                      label: 'Favorites',
                    ),
                    const SizedBox(width: 10),
                    StatTile(
                      icon: Icons.workspace_premium,
                      value: shop.vipMode ? 'VIP' : 'Basic',
                      label: 'Status',
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Kartu pengaturan
                SectionCard(
                  title: 'Sweet Settings',

                  // Column berisi Slider dan Switch
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row judul slider dan nilainya
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sweetness: ${sweetnessLabel(sweetnessLevel)}',
                            style: const TextStyle(fontSize: 13),
                          ),
                          Text(
                            '${sweetnessLevel.round()}%',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),

                      // Slider ubah level kemanisan
                      Slider(
                        value: sweetnessLevel,
                        min: 0,
                        max: 100,
                        divisions: 10,
                        activeColor: AppColors.primary,
                        inactiveColor: AppColors.soft,
                        onChanged: (value) {
                          setState(() {
                            sweetnessLevel = value;
                          });
                        },
                      ),
                      const Divider(),

                      // SwitchListTile untuk Cherry VIP Mode
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text(
                          'Cherry VIP Mode',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          shop.vipMode
                              ? 'Diskon 5% & gratis ongkir aktif ✨'
                              : 'VIP sweetness is off',
                        ),
                        value: shop.vipMode,
                        activeColor: AppColors.primary,
                        onChanged: shop.setVip,
                      ),

                      // SwitchListTile untuk notifikasi promo
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text(
                          'Promo Notification',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          promoNotification
                              ? 'Kamu akan dapat info promo 🔔'
                              : 'Notifikasi promo dimatikan',
                        ),
                        value: promoNotification,
                        activeColor: AppColors.primary,
                        onChanged: (value) {
                          setState(() {
                            promoNotification = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Kartu rasa favorit
                SectionCard(
                  title: 'Favorite Candy Type 🍬',

                  // Wrap susun ChoiceChip rasa
                  child: Wrap(
                    spacing: 8,
                    children: flavors.map((flavor) {
                      // ChoiceChip untuk memilih satu rasa favorit
                      return ChoiceChip(
                        label: Text(flavor),
                        selected: favoriteFlavor == flavor,
                        selectedColor: AppColors.soft,
                        onSelected: (_) {
                          setState(() {
                            favoriteFlavor = flavor;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),

                // SizedBox biar tombol penuh
                SizedBox(
                  width: double.infinity,

                  // Tombol membuka Edit Profile
                  child: ElevatedButton.icon(
                    onPressed: openEditProfile,
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit Profile'),
                  ),
                ),
                const SizedBox(height: 22),

                // Judul daftar favorit
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'My Favorite Candies ❤',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.dark,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Daftar favorit atau pesan kosong
                if (favorites.isEmpty)
                  const Text(
                    'Belum ada favorit. Tekan ❤ pada produk ya!',
                    style: TextStyle(color: AppColors.muted),
                  )
                else
                  Column(
                    children: favorites
                        .map((p) => ProductListTile(product: p))
                        .toList(),
                  ),
                const SizedBox(height: 10),

                // Teks informasi
                const Text(
                  'Your profile changes are saved instantly 🍒',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Color(0xFFB19AA1)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Kotak statistik kecil di halaman profile
class StatTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const StatTile({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    // Expanded biar tiga kotak berbagi lebar sama rata
    return Expanded(
      // Container sebagai kotak statistik
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        // Column susun icon, nilai, dan label
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.dark,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: AppColors.muted),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// EDIT PROFILE PAGE
// ============================================================

// StatefulWidget karena form dan controller memiliki state
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Kunci Form untuk menjalankan validasi
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controller nama dan email
  late final TextEditingController nameController;
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();

    // Controller diisi data profile saat ini
    nameController = TextEditingController(text: shop.profileName);
    emailController = TextEditingController(text: shop.profileEmail);
  }

  @override
  void dispose() {
    // Controller dibersihkan saat halaman ditutup
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  // Simpan perubahan setelah validasi lolos
  void saveProfile() {
    // validate() menjalankan semua validator TextFormField
    if (!formKey.currentState!.validate()) return;

    shop.updateProfile(nameController.text.trim(), emailController.text.trim());
    showMessage(context, 'Profile berhasil disimpan ✨');
    Navigator.pop(context);
  }

  // Dekorasi input yang seragam
  InputDecoration inputStyle(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: AppColors.primary),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold sebagai struktur halaman Edit Profile
    return Scaffold(
      // AppBar sebagai header halaman
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      // SingleChildScrollView biar form aman saat keyboard muncul
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        // Form membungkus input untuk validasi
        child: Form(
          key: formKey,

          // Column susun isi form
          child: Column(
            children: [
              // Avatar profile
              const CircleAvatar(
                radius: 45,
                backgroundColor: AppColors.soft,
                child: Icon(Icons.person, size: 50, color: AppColors.primary),
              ),
              const SizedBox(height: 14),

              // Judul form
              const Text(
                'Cherry Club Profile',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(height: 20),

              // TextFormField untuk nama (pakai validasi)
              TextFormField(
                controller: nameController,
                decoration: inputStyle('Name', Icons.person),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama tidak boleh kosong 🍒';
                  }
                  if (value.trim().length < 3) {
                    return 'Nama minimal 3 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // TextFormField untuk email (pakai validasi format)
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: inputStyle('Email', Icons.email),
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (text.isEmpty) {
                    return 'Email tidak boleh kosong 🍒';
                  }
                  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(text)) {
                    return 'Format email tidak valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 22),

              // SizedBox biar tombol penuh
              SizedBox(
                width: double.infinity,

                // Tombol simpan
                child: ElevatedButton.icon(
                  onPressed: saveProfile,
                  icon: const Icon(Icons.save),
                  label: const Text('Save Profile'),
                ),
              ),
              const SizedBox(height: 10),

              // SizedBox biar tombol penuh
              SizedBox(
                width: double.infinity,

                // Tombol batal
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
