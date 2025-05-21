class BerkasModel {
  final String uid;
  final Map<String, String> berkasUrls;

  BerkasModel({
    required this.uid,
    required this.berkasUrls,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'berkasUrls': berkasUrls,
    };
  }

  factory BerkasModel.fromMap(Map<String, dynamic> map) {
    return BerkasModel(
      uid: map['uid'] ?? '',
      berkasUrls: Map<String, String>.from(map['berkasUrls'] ?? {}),
    );
  }
}
