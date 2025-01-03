import 'dart:typed_data';
import 'package:cloudinary/cloudinary.dart';
import 'package:social/features/storage/domain/storage_repo.dart';

class CloudinaryStorageRepo implements StorageRepo {
  final cloudinary = Cloudinary.signedConfig(
    apiKey: 'APIKEY',
    apiSecret: 'APISECRET',
    cloudName: 'CLOUDNAME',
  );

  @override
  Future<String?> uploadProfileImageMobile(String path, String fileName) async {
    return _uploadFile(path, fileName, "profile_images");
  }

  @override
  Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String fileName) async {
    return _uploadFileBytes(fileBytes, fileName, "profile_images");
  }

  @override
  Future<String?> uploadPostImageMobile(String path, String fileName) async {
    return _uploadFile(path, fileName, "post_images");
  }

  @override
  Future<String?> uploadPostImageWeb(Uint8List fileBytes, String fileName) async {
    return _uploadFileBytes(fileBytes, fileName, "post_images");
  }

  Future<String?> _uploadFile(String path, String fileName, String folder) async {
    try {
      final response = await cloudinary.upload(
          file: path,
          resourceType: CloudinaryResourceType.image,
          folder: folder,
          fileName: fileName
      );
      print("secure url::::  ${response.secureUrl}");

      if (response.isSuccessful) {
        return response.secureUrl;
      } else {
        print('Cloudinary Upload Error: ${response.error}');
        return null;
      }
    } catch (e) {
      print('Cloudinary Exception: $e');
      return null;
    }
  }

  Future<String?> _uploadFileBytes(Uint8List fileBytes, String fileName, String folder) async {
    try {
      CloudinaryResponse response = await cloudinary.upload(
        fileBytes: fileBytes, // Directly pass the bytes
        folder: folder,
        resourceType: CloudinaryResourceType.image,
        fileName: fileName,
      );
      print("secure url::::  ${response.secureUrl}");

      if (response.isSuccessful) {
        return response.secureUrl;
      } else {
        print('Cloudinary Upload Error: ${response.error}');
        return null;
      }
    } catch (e) {
      print('Cloudinary Exception: $e');
      return null;
    }
  }
}