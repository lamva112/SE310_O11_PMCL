import 'dart:convert';

import 'package:get_it/get_it.dart';

import '../../core/core.dart';
import '../data.dart';

class SearchRemoteService implements ISearchRemoteService {
  late final INetworkUtility _networkUtility;

  SearchRemoteService()
      : _networkUtility = GetIt.I.get<INetworkUtility>(
            instanceName: NetworkConstant.authorizationDomain);

  var data = {
    "vocabulary": [
      {
        "id": "64147d927edf0126d1f6ef93",
        "type": "noun",
        "word": "sunset",
        "hint": "We sat on the beach watching a spectacular sunset",
        "phonetics": "ˈsʌn.set",
        "pronouce":
            "https://firebasestorage.googleapis.com/v0/b/dictionaryasp.appspot.com/o/vocabulary%2Fsunset.mp3?alt=media&token=9dfbf6f0-ec7f-494f-ac46-6dc95573e2de",
        "image":
            "https://firebasestorage.googleapis.com/v0/b/dictionaryasp.appspot.com/o/vocabulary%2Fsunset.png?alt=media&token=773dd843-c4e4-4164-b272-3da6b8b562c4",
        "meaning":
            "the time in the evening when you last see the sun in the sky"
      },
      {
        "id": "6414801dc76d7a7491073c22",
        "type": "verb",
        "word": "sleep",
        "hint": "I must get some sleep - I'm exhausted",
        "phonetics": "sliːp",
        "pronouce":
            "https://firebasestorage.googleapis.com/v0/b/dictionaryasp.appspot.com/o/vocabulary%2Fsleep.mp3?alt=media&token=2b42f9e9-5d8a-42b1-846f-0d52234c7e1a",
        "image":
            "https://firebasestorage.googleapis.com/v0/b/dictionaryasp.appspot.com/o/vocabulary%2Fsleep.png?alt=media&token=9baffae1-75f9-462c-b509-02201329ef39",
        "meaning":
            "the resting state in which the body is not active and the mind is unconscious"
      },
      {
        "id": "645212c87029627e8fd9dc7833",
        "type": "noun",
        "word": "dinner",
        "hint": "We are going to a dinner this evening in town",
        "phonetics": "ˈdɪn.ɚ",
        "pronouce":
            "https://firebasestorage.googleapis.com/v0/b/dictionaryasp.appspot.com/o/vocabulary%2Fdinner.mp3?alt=media&token=93cc837e-11e3-4b8f-a83e-fd22f32b8e9a",
        "image":
            "https://firebasestorage.googleapis.com/v0/b/dictionaryasp.appspot.com/o/vocabulary%2Fdinner.png?alt=media&token=293498c4-2b4b-46a2-9851-2de644c7f0d1",
        "meaning":
            "the main meal of the day, whether eaten in the evening or in the middle part of the day"
      },
      {
        "id": "645219497029627e8fd9dc7a00",
        "type": "noun",
        "word": "shower",
        "hint": "There was one bathroom with a shower stall in the corner",
        "phonetics": "ˈʃaʊ.ɚ",
        "pronouce":
            "https://firebasestorage.googleapis.com/v0/b/dictionaryasp.appspot.com/o/vocabulary%2Fshower.mp3?alt=media&token=dd8cd140-3d50-4c50-85ba-4916f84ffed1",
        "image":
            "https://firebasestorage.googleapis.com/v0/b/dictionaryasp.appspot.com/o/vocabulary%2Fshower.png?alt=media&token=39351e73-54be-40ac-adc0-4a4d93be80ae",
        "meaning":
            "a device that releases drops of water through a lot of very small holes and that you stand under to wash your whole body"
      },
      {
        "id": "64522c247029627e8fd9dc7b5",
        "type": "noun",
        "word": "breakfast",
        "hint": "I have toast and marmalade for breakfast",
        "phonetics": "brek.fəst",
        "pronouce":
            "https://firebasestorage.googleapis.com/v0/b/dictionaryasp.appspot.com/o/vocabulary%2Fbreakfast.mp3?alt=media&token=efa9d748-497b-46c1-9f0b-055830bdc7bb",
        "image":
            "https://firebasestorage.googleapis.com/v0/b/dictionaryasp.appspot.com/o/vocabulary%2Fbreakfast.png?alt=media&token=f9ea101d-afc9-4fc8-956b-aa99e5dbea56",
        "meaning": "a meal eaten in the morning as the first meal of the day"
      },
      {
        "id": "645235b57029627e8fd9dc7c7",
        "type": "verb",
        "word": "brush",
        "hint": "When did he last brush his teeth, she wondered",
        "phonetics": "brʌʃ",
        "pronouce":
            "https://firebasestorage.googleapis.com/v0/b/dictionaryasp.appspot.com/o/vocabulary%2Fbrush.mp3?alt=media&token=3b063d0d-a509-411a-afdc-3e15d441c0ee",
        "image":
            "https://firebasestorage.googleapis.com/v0/b/dictionaryasp.appspot.com/o/vocabulary%2Fbrush.png?alt=media&token=e666fb94-c44d-4405-b161-a11335b202b8",
        "meaning": "to clean something or make something smooth with a brush"
      },
      {
        "id": "6452368f7029627e8fd9dc7d88",
        "type": "noun",
        "word": "lunch",
        "hint": "a meal that is eaten in the middle of the day",
        "phonetics": "lʌntʃ",
        "pronouce":
            "https://firebasestorage.googleapis.com/v0/b/dictionaryasp.appspot.com/o/vocabulary%2Flunch.mp3?alt=media&token=ed927537-553c-4729-9a96-b814dfbfba5f",
        "image":
            "https://firebasestorage.googleapis.com/v0/b/dictionaryasp.appspot.com/o/vocabulary%2Flunch.png?alt=media&token=f9df67a2-b160-41fd-8a49-81cff71f3c09",
        "meaning": "a meal that is eaten in the middle of the day"
      }
    ]
  };

  @override
  Future<VocabularyResponse?> getSearchResponse({String? value}) async {
    //final response = await _networkUtility.request('v1/api/dummy_end_point', Method.GET);
    List<Vocabulary> vocabularies = [];
    try {
      final response = await _networkUtility.request(
          'http://localhost:51112/api/Vocabulary', Method.GET);

      print("responne ${response}");

      if (response.statusCode == 200) {
        print("no nhu nay ne ${response.data}");
        //data = json.decode(response.data) as Map<String, dynamic>;
        vocabularies = (json.decode(response.data) as List)
            .map((data) => Vocabulary.fromJson(data))
            .toList();

        print(vocabularies.length);
      } else {
        print(response.statusCode);
        print("thử lại đi nha");
      }
    } catch (error) {
      // An error occurred, handle the exception
      print('Error: $error');
    }

    VocabularyResponse updatedResponse = VocabularyResponse();

    return updatedResponse.copyWith(vocabulary: vocabularies);
  }
}
