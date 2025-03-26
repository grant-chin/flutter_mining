import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class CommonUtil {
  static Future<dynamic> _saveImage(String imageUrl) async {
    var response = await NetUtil().request(imageUrl, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response), quality: 60);
    return result;
  }
}

class NetUtil {
  request(String imageUrl, {required Options options}) {}
}
