import 'dart:io';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService {
  final SupabaseStorageClient _storage = Supabase.instance.client.storage;

  Future<String> uploadFile({
    required String filePath,
    required String bucket,
    required String path,
    String? fileName,
  }) async {
    final file = File(filePath);
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final name = fileName != null
        ? '${timestamp}_$fileName'
        : '${timestamp}_${file.path.split('/').last}';
    final response = await _storage.from(bucket).upload('$path/$name', file);
    return 'https://pqerqhikadmusqtzfmoa.supabase.co/storage/v1/object/sign/$response';
  }

  Future<String> uploadPublicProfilesFile({
    required String filePath,
    required String urlPath,
  }) async {
    final url = await uploadFile(
      bucket: 'profiles',
      filePath: filePath,
      path: urlPath,
    );

    return _storage.from('profiles').getPublicUrl(url.split('/profiles/').last);
  }

  Future<List<String>> createSignedUrls(
      {required String bucketName, required List<String> paths}) async {
    if (paths.isEmpty) return [];
    try {
      return (await _storage.from(bucketName).createSignedUrls(paths, 600))
          .map((e) => e.signedUrl!)
          .toList();
    } catch (e) {
      printError(info: 'SupabaseStorageService CreateSignedUrls Error: $e');
      rethrow;
    }
  }

  Future<String> createSignedUrl(
      {required String bucketName, required String path}) async {
    try {
      return (await _storage.from(bucketName).createSignedUrl(path, 600));
    } catch (e) {
      printError(info: 'SupabaseStorageService CreateSignedUrls Error: $e');
      rethrow;
    }
  }

  String getPublicUrl({
    required String bucketName,
    required String path,
  }) {
    return (_storage.from(bucketName).getPublicUrl(path));
  }
}
