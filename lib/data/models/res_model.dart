import 'dart:convert';

List<Predictions> predictionsFromJson(String str) => List<Predictions>.from(
    json.decode(str).map((x) => Predictions.fromJson(x)));

class Predictions {
  Predictions({
    required this.noPathogens,
    this.pathogenNames,
    this.imageCrops,
    required this.path,
    required this.statusCode,
    required this.filename,
  });

  int noPathogens;
  List<String>? pathogenNames;
  List<String>? imageCrops;
  String path;
  int statusCode;
  String filename;

  factory Predictions.fromJson(Map<String, dynamic> json) => Predictions(
        noPathogens: json["no_pathogens"] ?? '0',
        pathogenNames: json["pathogen_names"] == null
            ? ['']
            : List<String>.from(json["pathogen_names"].map((x) => x)),
        imageCrops: json["image_crops"] == null
            ? ['']
            : List<String>.from(json["image_crops"].map((x) => x)),
        path: json["path"] ?? '',
        statusCode: json["status_code"],
        filename: json["filename"],
      );
}
