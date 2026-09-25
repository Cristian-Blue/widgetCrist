import 'package:contador/model/product_model.dart';
import 'package:contador/services/product_service.dart';
import 'package:flutter/material.dart';

class PetitionScreen extends StatelessWidget {
  const PetitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Peticiones')),
      body: FutureBuilder(
        future: ProductService().getProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error"));
          } else if (snapshot.hasData) {
            final List<ProductModel> pm = snapshot.data ?? [];
            return ListView.builder(
              itemCount: pm.length,
              itemBuilder: (context, i) {
                final product = pm[i];
                return ListTile(
                  title: Text(product.title),
                  subtitle: Text(product.description),
                );
              },
            );
          } else {
            return Text('No data');
          }
        },
      ),
    );
  }
}
