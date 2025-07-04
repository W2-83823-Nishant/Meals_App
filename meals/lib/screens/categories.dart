import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/main.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
class CategoriesScreen extends StatefulWidget{

  const CategoriesScreen({
  super.key,
  //required 
  required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
  
 late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(
      vsync: this, //entire class
      duration: const Duration(milliseconds: 300),
     lowerBound: 0,
     upperBound: 1,
      );
    
   _animationController.forward();
  }

  @override
  void dispose(){
     _animationController.dispose();
     
     super.dispose();

  }

  void _selectCategory(BuildContext context,Category category){ //because the widget is stateless and i want a context
    // Navigator.push(context, route)
    final filteredMeals = widget.availableMeals.where((meal)=> meal.categories.contains(category.id)).toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx)=> MealsScreen(
          title: category.title, 
          meals: filteredMeals,
          ),
          ),
          );  //it is same as writing the code like this 
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return  AnimatedBuilder(animation: _animationController,
    child: GridView
      (
        padding: const EdgeInsets.all(24),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 3 / 2,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,),
      
      children:  [

       for(final category in availableCategories)
         CategoryGridItem(category: category,onSelectCategory: (){
          _selectCategory(context,category);
         },)
      ],

    ),
    //  builder: (context,child)=> Padding(
    //  padding: EdgeInsets.only(top:100 - _animationController.value *100,
    //  ),child: child,),)  ;
    
    builder: (context,child) => SlideTransition(
      position: _animationController.drive(Tween(
      begin:Offset(0,0.3),
      end: const Offset(0, 0),
    )),
    child: child,),

    );
  }

}