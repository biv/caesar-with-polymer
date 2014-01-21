part of caesar_coder;

class RuLowercaseCaesarCodec extends RangeCaesarCodec {
	RuLowercaseCaesarCodec(): super(1072, 1103);
}

class RuUppercaseCaesarCodec extends RangeCaesarCodec {
	RuUppercaseCaesarCodec(): super(1040, 1071);
}

class EnLowercaseCaesarCodec extends RangeCaesarCodec {
	EnLowercaseCaesarCodec(): super(97, 122);
}

class EnUppercaseCaesarCodec extends RangeCaesarCodec {
	EnUppercaseCaesarCodec(): super(65, 90);
}