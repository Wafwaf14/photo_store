import 'package:flutter/material.dart';
import '../models/photo_item.dart';
import '../l10n/app_localizations.dart';

class PhotoDetailScreen extends StatelessWidget {
  final PhotoItem photo;
  final VoidCallback onAddToCart;

  const PhotoDetailScreen({
    Key? key,
    required this.photo,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(photo.title),
        backgroundColor: const Color.fromARGB(255, 180, 188, 71),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photo Hero Animation
            Hero(
              tag: 'photo_${photo.id}',
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Image.network(
                  photo.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          photo.title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '\$${photo.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color:  const Color.fromARGB(255, 180, 188, 71),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  
                  // Photographer
                  Row(
                    children: [
                      Icon(Icons.camera_alt, size: 20, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        '${loc.translate("photographer")}: ${photo.photographer}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  
                  // Category
                  Chip(
                    label: Text(loc.translate(photo.category.toLowerCase())),
                    backgroundColor: const Color.fromARGB(255, 195, 201, 117),
                  ),
                  SizedBox(height: 24),
                  
                  // Description
                  Text(
                    loc.translate('description'),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    loc.translate('photo_description'),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 24),
                  
                  // Features
                  Text(
                    loc.translate('features'),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  _buildFeatureItem(Icons.high_quality, loc.translate('high_quality')),
                  _buildFeatureItem(Icons.download, loc.translate('instant_download')),
                  _buildFeatureItem(Icons.print, loc.translate('print_ready')),
                  _buildFeatureItem(Icons.verified_user, loc.translate('licensed')),
                  
                  SizedBox(height: 32),
                  
                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: onAddToCart,
                      icon: Icon(Icons.shopping_cart, color: Colors.white),
                      label: Text(
                        loc.translate('add_to_cart'),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:const Color.fromARGB(255, 180, 188, 50),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
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

  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color:const Color.fromARGB(255, 180, 188, 50),
),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}