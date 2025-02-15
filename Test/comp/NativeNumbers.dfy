// Skip JavaScript because JavaScript doesn't have the same native types

// RUN: %dafny /compile:3 /spillTargetCode:2 /compileTarget:cs "%s" > "%t"
// RUN: %dafny /compile:3 /spillTargetCode:2 /compileTarget:go "%s" >> "%t"
// RUN: %dafny /compile:3 /spillTargetCode:2 /compileTarget:java "%s" >> "%t"
// RUN: %diff "%s.expect" "%t"

method Main() {
  CastTests();
  Int8Test();
  Int16Test();
  BvTests();
  ZeroComparisonTests();
}

newtype {:nativeType "sbyte"} int8 = x | -0x80 <= x < 0x80
newtype {:nativeType "short"} int16 = x | -0x8000 <= x < 0x8000
newtype {:nativeType "int"} int32 = x : int | -0x8000_0000 <= x < 0x8000_0000
newtype {:nativeType "long"} int64 = x : int | -0x8000_0000 <= x < 0x8000_0000_0000_0000

newtype {:nativeType "byte"} uint8 = x : int | 0 <= x < 0x100
newtype {:nativeType "ushort"} uint16 = x : int | 0 <= x < 0x10000
newtype {:nativeType "uint"} uint32 = x : int | 0 <= x < 0x1_0000_0000
newtype {:nativeType "ulong"} uint64 = x : int | 0 <= x < 0x1_0000_0000_0000_0000

method CastTests() {
  print "Casting:\n\n";

  var i : int := 0;
  print i as int, " ",
    i as int8, " ", i as int16, " ", i as int32, " ", i as int64, " ",
    i as uint8, " ", i as uint16, " ", i as uint32, " ", i as uint64, "\n";

  var i8 : int8 := 1;
  print i8 as int, " ",
    i8 as int8, " ", i8 as int16, " ", i8 as int32, " ", i8 as int64, " ",
    i8 as uint8, " ", i8 as uint16, " ", i8 as uint32, " ", i8 as uint64, "\n";

  var i16 : int16 := 2;
  print i16 as int, " ",
    i16 as int8, " ", i16 as int16, " ", i16 as int32, " ", i16 as int64, " ",
    i16 as uint8, " ", i16 as uint16, " ", i16 as uint32, " ", i16 as uint64, "\n";

  var i32 : int32 := 3;
  print i32 as int, " ",
    i32 as int8, " ", i32 as int16, " ", i32 as int32, " ", i32 as int64, " ",
    i32 as uint8, " ", i32 as uint16, " ", i32 as uint32, " ", i32 as uint64, "\n";

  var i64 : int64 := 4;
  print i64 as int, " ",
    i64 as int8, " ", i64 as int16, " ", i64 as int32, " ", i64 as int64, " ",
    i64 as uint8, " ", i64 as uint16, " ", i64 as uint32, " ", i64 as uint64, "\n";

  var u8 : uint8 := 5;
  print u8 as int, " ",
    u8 as int8, " ", u8 as int16, " ", u8 as int32, " ", u8 as int64, " ",
    u8 as uint8, " ", u8 as uint16, " ", u8 as uint32, " ", u8 as uint64, "\n";

  var u16 : uint16 := 6;
  print u16 as int, " ",
    u16 as int8, " ", u16 as int16, " ", u16 as int32, " ", u16 as int64, " ",
    u16 as uint8, " ", u16 as uint16, " ", u16 as uint32, " ", u16 as uint64, "\n";

  var u32 : uint32 := 7;
  print u32 as int, " ",
    u32 as int8, " ", u32 as int16, " ", u32 as int32, " ", u32 as int64, " ",
    u32 as uint8, " ", u32 as uint16, " ", u32 as uint32, " ", u32 as uint64, "\n";

  var u64 : uint64 := 8;
  print u64 as int, " ",
    u64 as int8, " ", u64 as int16, " ", u64 as int32, " ", u64 as int64, " ",
    u64 as uint8, " ", u64 as uint16, " ", u64 as uint32, " ", u64 as uint64, "\n";

  u8 := 0xff;
  print u8 as int, " ",
    u8 as int16, " ", u8 as int32, " ", u8 as int64, " ",
    u8 as uint8, " ", u8 as uint16, " ", u8 as uint32, " ", u8 as uint64, "\n";

  u16 := 0xffff;
  print u16 as int, " ",
    u16 as int32, " ", u16 as int64, " ",
    u16 as uint16, " ", u16 as uint32, " ", u16 as uint64, "\n";

  u32 := 0xffff_ffff;
  print u32 as int, " ",
    u32 as int64, " ",
    u32 as uint32, " ", u32 as uint64, "\n";

  u64 := 0xffff_ffff_ffff_ffff;
  print u64 as int, " ",
    u64 as uint64, "\n";

  i := 0xff;
  print i as uint8, " ";

  i := 0xffff;
  print i as uint16, " ";

  i := 0xffff_ffff;
  print i as uint32, " ";

  i := 0xffff_ffff_ffff_ffff;
  print i as uint64, "\n";

  print "\n";
}

// test handling of byte/short arithmetic in Java
method Int8Test() {
  print "Byte arithmetic:\n\n";

  var a, b := 20, 30;
  var r0 := MInt8(a, b);
  var r1 := MInt8(b, a);
  var r2 := MInt8(-2, b);
  print a, " ", b, "\n";
  print r0, " ", r1, " ", r2, "\n";

  print "\n";
}

method MInt8(m: int8, n: int8) returns (r: int8) {
  if m < 0 || n < 0 {
    r := 18;
  } else if m < n {
    r := n - m;
  } else {
    r := m - n;
  }
}

method Int16Test() {
  print "Short arithmetic:\n\n";
  var a, b := 20, 30;
  var r0 := MInt16(a, b);
  var r1 := MInt16(b, a);
  var r2 := MInt16(-2, b);
  print a, " ", b, "\n";
  print r0, " ", r1, " ", r2, "\n";

  print "\n";
}

method MInt16(m: int16, n: int16) returns (r: int16) {
  if m < 0 || n < 0 {
    r := 18;
  } else if m < n {
    r := n - m;
  } else {
    r := m - n;
  }
}

method BvTests() {
  // These will also be bytes/shorts in Java (though they'll be wrapped in
  // UByte/UShort objects)
  print "Bitvectors:\n\n";

  var a: bv8 := 250;
  a := a + 6;
  assert a == 0;

  var b: bv7 := 126;
  b := b + 5;
  assert b == 3;

  var c: bv16 := 0xfffa;
  c := c + 10;
  assert c == 4;

  var d: bv15 := 0x7ffb;
  d := d + 6;
  assert d == 1;

  print a, " ", b, " ", c, " ", d, "\n";

  print "\n";
}

// Test zero comparisons in Java
method ZeroComparisonTests() {
  print "Comparison to zero:\n\n";

  print "int8:\n";
  ZCInt8Tests(-42);
  ZCInt8Tests(0);
  ZCInt8Tests(23);

  print "int16:\n";
  ZCInt16Tests(-42);
  ZCInt16Tests(0);
  ZCInt16Tests(23);

  print "int32:\n";
  ZCInt32Tests(-42);
  ZCInt32Tests(0);
  ZCInt32Tests(23);

  print "int64:\n";
  ZCInt64Tests(-42);
  ZCInt64Tests(0);
  ZCInt64Tests(23);

  print "uint8:\n";
  ZCUint8Tests(0);
  ZCUint8Tests(23);

  print "uint16:\n";
  ZCUint16Tests(0);
  ZCUint16Tests(23);

  print "uint32:\n";
  ZCUint32Tests(0);
  ZCUint32Tests(23);

  print "uint64:\n";
  ZCUint64Tests(0);
  ZCUint64Tests(23);

  print "\n";
}

function method YN(b : bool) : string {
  if b then "Y" else "N"
}

method ZCInt8Tests(n : int8) {
  print n, "\t",
    " <0 ",  YN(n < 0),  " <=0 ", YN(n <= 0),
    " ==0 ", YN(n == 0), " !=0 ", YN(n != 0),
    " >0 ",  YN(n > 0),  " >=0 ", YN(n >= 0),
    " 0< ",  YN(0 < n),  " 0<= ", YN(0 <= n),
    " 0== ", YN(0 == n), " 0!= ", YN(0 != n),
    " 0> ",  YN(0 > n),  " 0>= ", YN(0 >= n),
    "\n";
}

method ZCInt16Tests(n : int16) {
  print n, "\t",
    " <0 ",  YN(n < 0),  " <=0 ", YN(n <= 0),
    " ==0 ", YN(n == 0), " !=0 ", YN(n != 0),
    " >0 ",  YN(n > 0),  " >=0 ", YN(n >= 0),
    " 0< ",  YN(0 < n),  " 0<= ", YN(0 <= n),
    " 0== ", YN(0 == n), " 0!= ", YN(0 != n),
    " 0> ",  YN(0 > n),  " 0>= ", YN(0 >= n),
    "\n";
}

method ZCInt32Tests(n : int32) {
  print n, "\t",
    " <0 ",  YN(n < 0),  " <=0 ", YN(n <= 0),
    " ==0 ", YN(n == 0), " !=0 ", YN(n != 0),
    " >0 ",  YN(n > 0),  " >=0 ", YN(n >= 0),
    " 0< ",  YN(0 < n),  " 0<= ", YN(0 <= n),
    " 0== ", YN(0 == n), " 0!= ", YN(0 != n),
    " 0> ",  YN(0 > n),  " 0>= ", YN(0 >= n),
    "\n";
}

method ZCInt64Tests(n : int64) {
  print n, "\t",
    " <0 ",  YN(n < 0),  " <=0 ", YN(n <= 0),
    " ==0 ", YN(n == 0), " !=0 ", YN(n != 0),
    " >0 ",  YN(n > 0),  " >=0 ", YN(n >= 0),
    " 0< ",  YN(0 < n),  " 0<= ", YN(0 <= n),
    " 0== ", YN(0 == n), " 0!= ", YN(0 != n),
    " 0> ",  YN(0 > n),  " 0>= ", YN(0 >= n),
    "\n";
}

method ZCUint8Tests(n : uint8) {
  print n, "\t",
    " <0 ",  YN(n < 0),  " <=0 ", YN(n <= 0),
    " ==0 ", YN(n == 0), " !=0 ", YN(n != 0),
    " >0 ",  YN(n > 0),  " >=0 ", YN(n >= 0),
    " 0< ",  YN(0 < n),  " 0<= ", YN(0 <= n),
    " 0== ", YN(0 == n), " 0!= ", YN(0 != n),
    " 0> ",  YN(0 > n),  " 0>= ", YN(0 >= n),
    "\n";
}

method ZCUint16Tests(n : uint16) {
  print n, "\t",
    " <0 ",  YN(n < 0),  " <=0 ", YN(n <= 0),
    " ==0 ", YN(n == 0), " !=0 ", YN(n != 0),
    " >0 ",  YN(n > 0),  " >=0 ", YN(n >= 0),
    " 0< ",  YN(0 < n),  " 0<= ", YN(0 <= n),
    " 0== ", YN(0 == n), " 0!= ", YN(0 != n),
    " 0> ",  YN(0 > n),  " 0>= ", YN(0 >= n),
    "\n";
}

method ZCUint32Tests(n : uint32) {
  print n, "\t",
    " <0 ",  YN(n < 0),  " <=0 ", YN(n <= 0),
    " ==0 ", YN(n == 0), " !=0 ", YN(n != 0),
    " >0 ",  YN(n > 0),  " >=0 ", YN(n >= 0),
    " 0< ",  YN(0 < n),  " 0<= ", YN(0 <= n),
    " 0== ", YN(0 == n), " 0!= ", YN(0 != n),
    " 0> ",  YN(0 > n),  " 0>= ", YN(0 >= n),
    "\n";
}

method ZCUint64Tests(n : uint64) {
  print n, "\t",
    " <0 ",  YN(n < 0),  " <=0 ", YN(n <= 0),
    " ==0 ", YN(n == 0), " !=0 ", YN(n != 0),
    " >0 ",  YN(n > 0),  " >=0 ", YN(n >= 0),
    " 0< ",  YN(0 < n),  " 0<= ", YN(0 <= n),
    " 0== ", YN(0 == n), " 0!= ", YN(0 != n),
    " 0> ",  YN(0 > n),  " 0>= ", YN(0 >= n),
    "\n";
}
