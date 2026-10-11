abstract class SearchState{}
class SearchInitialState extends SearchState{}
class SearchLoadingState extends SearchState{}
class SearchSuccessState extends SearchState{}
class SearchErrorState extends SearchState{
  String error;
  SearchErrorState(this.error);
}