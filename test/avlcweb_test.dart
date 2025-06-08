import 'package:avlcweb/avlc_web.dart';
import 'package:avlcweb/src/avlcweb_method_channel.dart';
import 'package:avlcweb/src/avlcweb_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAvlcwebPlatform with MockPlatformInterfaceMixin implements AvlcwebPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AvlcwebPlatform initialPlatform = AvlcwebPlatform.instance;

  test('$MethodChannelAvlcweb is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAvlcweb>());
  });

  test('getPlatformVersion', () async {
    AvlcWeb avlcwebPlugin = AvlcWeb();
    avlcwebPlugin.initialize(
      email: "",
      password: "",
      onInitialize: (isInitialized, {error}) {},
    );
    MockAvlcwebPlatform fakePlatform = MockAvlcwebPlatform();
    AvlcwebPlatform.instance = fakePlatform;

    expect(await avlcwebPlugin.getPlatformVersion(), '42');
  });
}
