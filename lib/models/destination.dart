class Destination {
  const Destination({
    required this.name,
    required this.resortCount,
    required this.startingPrice,
    required this.imagePath,
    this.badge,
  });

  final String name;
  final int resortCount;
  final int startingPrice;
  final String imagePath;
  final String? badge;
}
