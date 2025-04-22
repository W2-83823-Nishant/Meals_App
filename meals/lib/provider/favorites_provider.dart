import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>>{

  FavoriteMealsNotifier() : super([]); //state will contain the empty list 
  
  bool toggleMealFavoriteStatus(Meal meal){
    //not allowed to edit the old value create new value
    //stateNotifier makes available state 
   final mealIsFavorite =  state.contains(meal);

   if(mealIsFavorite){
       state = state.where((m)=> m.id != meal.id).toList();
       return false;
   }else {
    state = [...state,meal];
    return true;
   }
   // state = [];
  }

}

final favoriteMealsProvider = StateNotifierProvider<FavoriteMealsNotifier,List<Meal>>((ref){
  return FavoriteMealsNotifier();
});