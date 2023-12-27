import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  final VoidCallback onTap;

  const FavoriteButton({
    required this.onTap,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isFavorite = !isFavorite;
        });
        widget.onTap.call();
      },
      child: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.grey,
      ),
    );
  }
}
