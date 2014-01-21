part of caesar_decode_service;

Future<Map<String, int>> checkWords(Set<String> words) {
	final String url = "http://speller.yandex.net/services/spellservice.json/checkText";
	final String textParam = words.join("+");
	Map<String, String> params = {"text": textParam};
	Future<HttpRequest> future = HttpRequest.postFormData(url, params);
	return future.then((HttpRequest request) {
		String jsonString = request.response as String;
		List<Map> results = JSON.decode(jsonString);		
		Map<String, int> wordVsScore = new Map.fromIterable(results,
			key: (Map item) {
				return item["word"] as String;
			},
			value: (Map item) {
				if((item["s"] as List).length > 0) {
					return 1;
				} else {
					return 0;
				}
			}
		);
		return wordVsScore;
	});
}

Future<Set<String>> findRightWords(Set<String> words) {
	final String url = "http://speller.yandex.net/services/spellservice.json/checkText";
	final String textParam = words.join("+");
	Map<String, String> params = {"text": textParam};
	Future<HttpRequest> future = HttpRequest.postFormData(url, params);
	return future.then((HttpRequest request) {
		String jsonString = request.response as String;
		List<Map> results = JSON.decode(jsonString);
		for(Map result in results) {
			String word = result["word"] as String;
			words.remove(word);
		}
		return words;
	});
}