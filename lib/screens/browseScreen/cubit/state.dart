abstract class BrowseState{}
class BrowseInitialState extends BrowseState{}
class BrowseLoadingState extends BrowseState{}
class BrowseSuccessState extends BrowseState{}
class BrowseChangeGenreState extends BrowseState{}
class BrowseErrorState extends BrowseState{
  String error;
  BrowseErrorState(this.error);
}