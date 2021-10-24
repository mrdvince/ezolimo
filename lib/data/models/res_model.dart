import 'dart:convert';

Predictions predictionsFromJson(String str) =>
    Predictions.fromJson(json.decode(str));

String predictionsToJson(Predictions data) => json.encode(data.toJson());

class Predictions {
  Predictions({
    required this.noPathogens,
    required this.pathogenNames,
    required this.imageCrops,
    required this.path,
    required this.statusCode,
    required this.filename,
    required this.sendHeaderOnly,
    required this.mediaType,
    required this.background,
    required this.rawHeaders,
    required this.headers,
    required this.statResult,
  });

  int noPathogens;
  List<String> pathogenNames;
  List<String> imageCrops;
  String path;
  int statusCode;
  String filename;
  bool sendHeaderOnly;
  String mediaType;
  dynamic background;
  List<List<String>> rawHeaders;
  Headers headers;
  dynamic statResult;

  factory Predictions.fromJson(Map<String, dynamic> json) => Predictions(
        noPathogens: json["no_pathogens"],
        pathogenNames: List<String>.from(json["pathogen_names"].map((x) => x)),
        imageCrops: List<String>.from(json["image_crops"].map((x) => x)),
        path: json["path"],
        statusCode: json["status_code"],
        filename: json["filename"],
        sendHeaderOnly: json["send_header_only"],
        mediaType: json["media_type"],
        background: json["background"],
        rawHeaders: List<List<String>>.from(
            json["raw_headers"].map((x) => List<String>.from(x.map((x) => x)))),
        headers: Headers.fromJson(json["_headers"]),
        statResult: json["stat_result"],
      );

  Map<String, dynamic> toJson() => {
        "no_pathogens": noPathogens,
        "pathogen_names": List<dynamic>.from(pathogenNames.map((x) => x)),
        "image_crops": List<dynamic>.from(imageCrops.map((x) => x)),
        "path": path,
        "status_code": statusCode,
        "filename": filename,
        "send_header_only": sendHeaderOnly,
        "media_type": mediaType,
        "background": background,
        "raw_headers": List<dynamic>.from(
            rawHeaders.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "_headers": headers.toJson(),
        "stat_result": statResult,
      };
}

class Headers {
  Headers({
    required this.contentType,
    required this.contentDisposition,
  });

  String contentType;
  String contentDisposition;

  factory Headers.fromJson(Map<String, dynamic> json) => Headers(
        contentType: json["content-type"],
        contentDisposition: json["content-disposition"],
      );

  Map<String, dynamic> toJson() => {
        "content-type": contentType,
        "content-disposition": contentDisposition,
      };
}
