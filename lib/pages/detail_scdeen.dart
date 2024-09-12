import 'package:flutter/material.dart';
import 'package:news_app/utils/appbar.dart';

class NewsDetailScreen extends StatelessWidget {
  final String? title, description, url;

  const NewsDetailScreen({super.key, required this.title, required this.description, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section
              url!= null
                 ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset:const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          url!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image, size: 100);
                          },
                        ),
                      ),
                    )
                  :const SizedBox.shrink(),
              const SizedBox(height: 20),

              // Title section
              Text(
                title?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),

              // Description section
              Text(
                description?? '',
                style:  TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 20),

              
              Divider(
                color: Colors.grey[300],
                thickness: 1,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}