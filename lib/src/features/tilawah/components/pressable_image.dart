import 'package:flutter/material.dart';

class PressableImage extends StatelessWidget {
  final String imageAssetPath;
  final Function(double x, double y) onTap;

  const PressableImage(
      {super.key, required this.imageAssetPath, required this.onTap});

  // Function to transform coordinates based on the new MaxX
  List<double> transformCoordinates(double oldX, double oldY, double oldMaxX,
      double oldMaxY, double newMaxX) {
    double scaleX = newMaxX / oldMaxX;
    double newX = oldX * scaleX;
    double newY = oldY * scaleX;

    return [newX, newY];
  }

  double getCalculatedImageHeightByRatio(
      double width, double height, double newWidth) {
    double aspectRatio = width / height;
    double newHeight = newWidth / aspectRatio;

    return newHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTapDown: (details) {
          Image image = Image.asset(imageAssetPath);
          image.image.resolve(ImageConfiguration.empty).addListener(
            ImageStreamListener((ImageInfo info, bool _) {
              double imageWidth = info.image.width.toDouble();
              double imageHeight = info.image.height.toDouble();
              double screenWidth = MediaQuery.of(context).size.width;

              double x = (details.localPosition.dx / imageWidth) * imageWidth;
              double y = (details.localPosition.dy / imageHeight) * imageHeight;

              double resizedImageHeight = getCalculatedImageHeightByRatio(
                  imageWidth, imageHeight, screenWidth);

              List<double> transformed = transformCoordinates(
                  x, y, screenWidth, resizedImageHeight, 1024);
              // why 1120?
              // because on database refer to 1120 width image

              onTap(transformed.elementAt(0), transformed.elementAt(1));
            }),
          );
        },
        child: Image.asset(
          imageAssetPath,
          width: MediaQuery.of(context)
              .size
              .width, // Lebar gambar mengikuti lebar layar
          fit: BoxFit.fill, // Mengisi gambar ke dalam kontainer
        ),
      ),
    );
  }
}
