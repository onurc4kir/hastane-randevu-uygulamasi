import 'dart:developer' as developer;

void printW(Object text) {
  developer.log('\x1B[33m$text\x1B[0m');
}

void printE(Object text) {
  developer.log('\x1B[31m$text\x1B[0m');
}

void printI(Object text) {
  developer.log('\x1B[36m$text\x1B[0m');
}

void printS(Object text) {
  developer.log('\x1B[32m$text\x1B[0m');
}
