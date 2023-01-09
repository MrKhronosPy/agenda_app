import 'package:mobx/mobx.dart';

// Include generated file
part 'home_mobx.g.dart';

// This is the class used by rest of your codebase
class Home = _Home with _$Home;

// The store-class
abstract class _Home with Store {

  @observable
  int currentPage = 0;


  @action
  updateCurrentPage(int index) {
    
    if(index != currentPage){
      currentPage = index;
    }

  }
  
}