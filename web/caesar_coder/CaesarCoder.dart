library caesar_coder;

part 'CaesarCodec.dart';
part 'LangCaesarCodec.dart';
part 'RangeCaesarCodec.dart';

class CaesarCoder {
	List<CaesarCodec> _codecs = [];
	void setCodec(CaesarCodec codec) {
		_codecs.add(codec);
	}
	
	String encode(String inputText, int shift) {
		List<int> charCodes = inputText.codeUnits;
		List<int> outputCodes = [];
		for(int n in charCodes) {
			int temp = n;
			for(CaesarCodec codec in _codecs) {
				temp = codec.encode(temp, shift);
			}
			outputCodes.add(temp);			
		}
		return new String.fromCharCodes(outputCodes);
	}
	
	int getCycle() {
		int maxCycle = 0;
		for(CaesarCodec codec in _codecs) {
			int currentCycle = codec.getCycle();
			if(currentCycle > maxCycle) {
				maxCycle = currentCycle;
			}
		}
		return maxCycle;
	}
}