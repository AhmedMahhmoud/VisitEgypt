class PlaceReview {
  String description;
  double rate;
  String reveiwerName;
  PlaceReview({
    required this.description,
    required this.rate,
    required this.reveiwerName,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'rate': rate,
      'reveiwerName': reveiwerName,
      // 'reveiwerID': reviewerID
    };
  }

  factory PlaceReview.fromMap(Map<String, dynamic> map) {
    return PlaceReview(
      description: map['description'] ?? '',
      rate: map['rate']?.toDouble() ?? 0.0,
      reveiwerName: map['reveiwerName'] ?? '',
      // reviewerID: map['reviewerID'] ?? '',
    );
  }
}
