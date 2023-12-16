import '../../core/core.dart';
import '../blocs.dart';

class VocabularyDetailBloc extends BaseBloc<VocabularyDetailState> {
  
  Stream<bool?> get successStream =>
      stateStream.map((event) => event.success).distinct();
  Stream<String?> get errorStream => stateStream.map((event) => event.error);

  
}