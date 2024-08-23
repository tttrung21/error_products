import 'package:cached_network_image/cached_network_image.dart';
import 'package:error_products/Home/Model/ErrorProductItem.dart';
import 'package:error_products/Home/UI/EditDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductCard extends StatelessWidget {
  ProductCard({super.key, required this.item});

  ErrorProductItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (context) => EditDialog(item: item,),);
      },
      child: Container(
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            offset: Offset(0, 12),
            blurRadius: 24,
            spreadRadius: -4,
            color: Color.fromRGBO(145, 158, 171, 0.12),
          ),
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 2,
            color: Color.fromRGBO(145, 158, 171, 0.2),
          )
        ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: item.image ?? '',
                fit: BoxFit.cover,
                height: 100,
                // height: 180,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: CupertinoColors.white,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) {
                  return const Icon(
                    Icons.image_not_supported,
                    size: 100,
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        item.name ?? '',
                        softWrap: true,
                        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(item.errorDescription ?? '',
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(item.sku ?? '',
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(item.colorName ?? 'None',
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
