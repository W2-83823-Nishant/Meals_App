import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/provider/favorites_provider.dart';
import 'package:meals/provider/meals_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/provider/filters_provider.dart';

const kinitialFilters = {
Filter.glutenFree :false,
Filter.lactoseFree : false,
Filter.vegeterian :false,
Filter.vegan:false,

};

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});
  @override
  ConsumerState<TabScreen> createState(){
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabScreen> {

int _selectedPageIndex =0;







void _selectPage(int index){
  setState(() {
    _selectedPageIndex = index;
  });
}


// void _setScreen(String identifier) async {
//   Navigator.of(context).pop();
// if(identifier == 'filters'){
//   // Navigator.of(context).pop();
//     // Navigator.push(context, 
//     // MaterialPageRoute(
//     //   builder: (ctx)=> const FiltersScreen()
//     //   ),
//     //   );
//   final result =   await Navigator.of(context).push<Map<Filter,bool>>(
//       MaterialPageRoute(
//         builder: (ctx)=> const FiltersScreen(),
//     )
//     );
    

//     // setState(() {
//     //   _selectedFilters = result;
//     // });


// }
// }
void _setScreen(String identifier) async {
  Navigator.of(context).pop();

  if (identifier == 'filters') {
     await Navigator.of(context).push<Map<Filter, bool>>(
      MaterialPageRoute(
        builder: (ctx) =>  const FiltersScreen(),
      ),
    );

    
    
    // if (result == null) {
    //  // print("No result returned from FilterScreen");
    // } else {
    //  // print("Received result: $result");
    //   // Optional: You can also do something with the result here
    //   // For example, update the state with new filters
    // }

   // debugPrint("Received Result: $result");
  }
}



@override
  Widget build(BuildContext context) {
     final availableMeals =  ref.watch(filteredMealsProvider);



     Widget activePage =  CategoriesScreen(
     availableMeals: availableMeals,
     );
     var activePageTitle = 'Categories';
      
     if(_selectedPageIndex == 1){
        final favoriteMeals = ref.watch(favoriteMealsProvider);
        print("favoriteMeals ${favoriteMeals}");
        activePage =  MealsScreen( 
        meals: favoriteMeals, 
      );
        activePageTitle ='Your Favorites';
     } 
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),

      drawer:  MainDrawer(onSelectScreen: _setScreen,),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
      onTap: _selectPage,
      currentIndex: _selectedPageIndex
     ,items: const [
        BottomNavigationBarItem(icon: Icon(Icons.set_meal),label: 'Categories'  ),
        BottomNavigationBarItem(icon: Icon(Icons.star),label: 'Favorites'),
      ],),
    );
  }

}