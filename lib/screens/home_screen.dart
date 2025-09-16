import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/language_provider.dart';
import '../l10n/app_localizations.dart';
import '../models/photo_item.dart';
import '../widgets/photo_card.dart';
import 'cart_screen.dart';
import 'photo_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<PhotoItem> photos = [
    PhotoItem(
      id: '1',
      title: 'Sunset Beach',
      price: 29.99,
      imageUrl: 'https://picsum.photos/400/600?random=1',
      photographer: 'John Doe',
      category: 'Nature',
    ),
    PhotoItem(
      id: '2',
      title: 'Mountain Peak',
      price: 39.99,
      imageUrl: 'https://picsum.photos/400/600?random=2',
      photographer: 'Jane Smith',
      category: 'Nature',
    ),
    PhotoItem(
      id: '3',
      title: 'City Lights',
      price: 24.99,
      imageUrl: 'https://picsum.photos/400/600?random=3',
      photographer: 'Mike Johnson',
      category: 'Urban',
    ),
    PhotoItem(
      id: '4',
      title: 'Forest Path',
      price: 34.99,
      imageUrl: 'https://picsum.photos/400/600?random=4',
      photographer: 'Sarah Wilson',
      category: 'Nature',
    ),
    PhotoItem(
      id: '5',
      title: 'Abstract Art',
      price: 49.99,
      imageUrl: 'https://picsum.photos/400/600?random=5',
      photographer: 'Alex Brown',
      category: 'Abstract',
    ),
    PhotoItem(
      id: '6',
      title: 'Wildlife Safari',
      price: 44.99,
      imageUrl: 'https://picsum.photos/400/600?random=6',
      photographer: 'Emma Davis',
      category: 'Wildlife',
    ),
  ];

  String selectedCategory = 'All';
  List<PhotoItem> cartItems = [];

  List<PhotoItem> get filteredPhotos {
    if (selectedCategory == 'All') {
      return photos;
    }
    return photos.where((photo) => photo.category == selectedCategory).toList();
  }

  void addToCart(PhotoItem photo) {
    setState(() {
      cartItems.add(photo);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.translate('added_to_cart')),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('photo_store')),
        backgroundColor: const Color.fromARGB(255, 180, 188, 71),
        actions: [
          // Language Switcher
          DropdownButton<String>(
            value: languageProvider.currentLocale.languageCode,
            dropdownColor: const Color.fromARGB(255, 180, 188, 71),
            icon: Icon(Icons.language, color: Colors.white),
            underline: Container(),
            items: [
              DropdownMenuItem(
                value: 'en',
                child: Text('EN', style: TextStyle(color: Colors.white)),
              ),
              DropdownMenuItem(
                value: 'fr',
                child: Text('FR', style: TextStyle(color: Colors.white)),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                languageProvider.changeLanguage(value);
              }
            },
          ),
          
          // Cart Icon
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(cartItems: cartItems),
                    ),
                  );
                },
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cartItems.length}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          
          // Logout
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              authProvider.signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                'All',
                'Nature',
                'Urban',
                'Abstract',
                'Wildlife',
              ].map((category) {
                return Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(loc.translate(category.toLowerCase())),
                    selected: selectedCategory == category,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    selectedColor: const Color.fromARGB(255, 200, 206, 126),
                  ),
                );
              }).toList(),
            ),
          ),
          
          // Photo Grid
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemCount: filteredPhotos.length,
              itemBuilder: (context, index) {
                final photo = filteredPhotos[index];
                return PhotoCard(
                  photo: photo,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhotoDetailScreen(
                          photo: photo,
                          onAddToCart: () => addToCart(photo),
                        ),
                      ),
                    );
                  },
                  onAddToCart: () => addToCart(photo),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}