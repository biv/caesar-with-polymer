import "package:polymer/polymer.dart";
import 'dart:html';
import 'dart:async';
import 'caesar_decode_service/decode_service.dart';

@CustomTag("caesar-decoder")
class Decoder extends PolymerElement {	
	Decoder.created(): super.created();
	
	@observable String inputText = "";
	@observable String outputText = "";
	
	void decode(Event e, var detail, Node target) {
		outputText = "Please wait...";
		if(inputText.isEmpty) {
			outputText = "nothing to decode";
			return;
		}		
		DecodeService decodeService = new DecodeService(inputText);
		Future<String> future = decodeService.getDecodedText();
		future.then((String value){
			outputText = value;
		}, onError:(e){
			outputText = "ERROR";
		});
		
	}
	
}