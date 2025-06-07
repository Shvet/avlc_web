import 'package:avlcweb/src/avlcweb_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class AvlcwebPlatform extends PlatformInterface {
  /// Constructs a AvlcwebPlatform.
  AvlcwebPlatform() : super(token: _token);

  static final Object _token = Object();

  static AvlcwebPlatform _instance = MethodChannelAvlcweb();

  /// The default instance of [AvlcwebPlatform] to use.
  ///
  /// Defaults to [MethodChannelAvlcweb].
  static AvlcwebPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AvlcwebPlatform] when
  /// they register themselves.
  static set instance(AvlcwebPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
