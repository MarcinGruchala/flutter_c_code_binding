import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

import 'hello_bindings_generated.dart';

String getHelloMessage() => _bindings.getHelloMessage().pointerCharToString();

extension PointerCharToString on Pointer<Char> {
  String pointerCharToString() {    
    final Pointer<Utf8> utf8Pointer = cast<Utf8>();

    return utf8Pointer.toDartString();
  }
}

const String _libName = 'hello';

/// The dynamic library in which the symbols for [HelloBindings] can be found.
final DynamicLibrary _dylib = () {
  if (Platform.isMacOS || Platform.isIOS) {
    return DynamicLibrary.open('$_libName.framework/$_libName');
  }
  if (Platform.isAndroid || Platform.isLinux) {
    return DynamicLibrary.open('lib$_libName.so');
  }
  if (Platform.isWindows) {
    return DynamicLibrary.open('$_libName.dll');
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

/// The bindings to the native functions in [_dylib].
final HelloBindings _bindings = HelloBindings(_dylib);
