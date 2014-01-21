library caesar_decode_service;

import 'dart:async';
import 'dart:html';
import 'dart:convert';
import '../caesar_coder/CaesarCoder.dart';

part 'speller_service_caller.dart';

class DecodeService {	
	String _encodedText;
	Set<String> _words = new Set();
	Map<String, Set<String>> _statementVsWords;
	
	
	DecodeService(this._encodedText) {
		Set<String> assumptions = _getAssumptions(_encodedText);
		_statementVsWords = _splitStatements(assumptions);
		
	}
	
	static Set<String> _getAssumptions(String str) {
		CaesarCoder coder = new CaesarCoder();
		coder.setCodec(new RuLowercaseCaesarCodec());
		coder.setCodec(new RuUppercaseCaesarCodec());
		coder.setCodec(new EnLowercaseCaesarCodec());
		coder.setCodec(new EnUppercaseCaesarCodec());
		Set<String> assumptions = new Set();
		for(int n = 0; n < coder.getCycle(); n++) {
			assumptions.add(coder.encode(str, n));
		}
		return assumptions;
	}
	
	Map<String, Set<String>> _splitStatements(Set<String> statements) {
		Map<String, Set<String>> map = new Map.fromIterable(statements,
			key: (String item)=>item,
			value: (String item) {
				Set<String> wordSet = new Set<String>();
				RegExp regExp = new RegExp(r'[\s!?,.]');
				List<String> words = item.split(regExp);
				words.removeWhere((String word) {
					if(word.length < 2) {
						return true;
					}
					return false;
				});
				wordSet.addAll(words);
				_words.addAll(words);
				return wordSet;				
			}
		);
		return map;		
	}
	
	/*	
	Future<String> getDecodedText() {
		Future<Map<String, int>> spellerResponce = checkWords(_words);
		Future<String> future = spellerResponce.then((Map<String, int> wordVsScore) {
			String maxScoreString = "";
			int maxScore = 0;
			_statementVsWords.forEach((String statement, Set<String> statementWords) {
				int score = 0;
				statementWords.forEach((String statementWord) {
					if(wordVsScore.containsKey(statementWord)) {
						score += wordVsScore[statementWord];
					}
				});
				if(score > maxScore) {
					maxScore = score;
					maxScoreString = statement;
				}
			});
			return maxScoreString;
		});
		return future;
	}*/
	
	Future<String> getDecodedText() {
		Future<Set<String>> spellerResponce = findRightWords(_words);
		Future<String> future = spellerResponce.then((Set<String> rightWords) {
			String maxScoreString = "";
			int maxScore = 0;
			_statementVsWords.forEach((String statement, Set<String> statementWords) {
				int score = 0;
				statementWords.forEach((String statementWord) {
					if(rightWords.contains(statementWord)) {
						score += 1;
					}
				});
				if(score > maxScore) {
					maxScore = score;
					maxScoreString = statement;
				}
			});
			return maxScoreString;
		});
	return future;
	}
	
	
	
	Future<String> _test() {
		return new Future.delayed(new Duration(seconds: 2), () {
			if(this._encodedText.isEmpty) {
				throw("encodedText is Empty");
			}
			return this._encodedText+"preved";
		});
	}
}