import "package:polymer/polymer.dart";
import "caesar_coder/CaesarCoder.dart";

@CustomTag("caesar-encoder")
class Encoder extends PolymerElement {
	CaesarCoder _coder = new CaesarCoder();
	Encoder.created(): super.created() {
		_coder.setCodec(new RuLowercaseCaesarCodec());
		_coder.setCodec(new RuUppercaseCaesarCodec());
		_coder.setCodec(new EnLowercaseCaesarCodec());
		_coder.setCodec(new EnUppercaseCaesarCodec());
		
		onPropertyChange(this, #inputText, () {
			updateOutput();
		});
		onPropertyChange(this, #shift, () {
			updateOutput();
		});
	}
	
	@observable String inputText = "";
	@observable String shift = "0";
	@observable String outputText = "";
	
	void updateOutput() {
		int shiftValue = int.parse(shift);
		outputText = _coder.encode(inputText, shiftValue);
	}
	
}