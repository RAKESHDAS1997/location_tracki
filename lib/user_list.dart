class Catagory {
  final int id;
  final String name;
  // Add other fields that match the API response

  Catagory({
    required this.id,
    required this.name,
    // Initialize other fields
  });

  factory Catagory.fromJson(Map<String, dynamic> json) {
    return Catagory(
      id: json['id'],
      name: json['name'],
      // Map other fields from the API response
    );
  }
}
