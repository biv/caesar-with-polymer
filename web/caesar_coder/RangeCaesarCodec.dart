part of caesar_coder;

class RangeCaesarCodec implements CaesarCodec {
	int _minCode;
	int _maxCode;
	RangeCaesarCodec(this._minCode, this._maxCode);
	
	int encode(int charCode, int shift) {
		int retval = charCode;
		if(charCode >= _minCode && charCode <= _maxCode) {
			int temp = charCode - _minCode;
			temp += shift;
			temp %= _maxCode - _minCode + 1;
			retval = temp + _minCode;
		}
		return retval;
	}
	
	int getCycle() {
		return _maxCode - _minCode + 1;
	}
}