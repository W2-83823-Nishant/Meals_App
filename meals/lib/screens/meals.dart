import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget{
  const MealsScreen({super.key,
  this.title,
  required this.meals,
  });
  
  final String? title;
  final List<Meal> meals;

  //extra approach 1

  void selectMeal(BuildContext context,Meal meal){
   Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> MealDetailsScreen(
    meal: meal,
    //Extra 1 approach 1
    ),),);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );

  if(meals.isNotEmpty){
    content = ListView.builder(
      itemCount: meals.length,
  //     itemBuilder: (ctx,index) => MealItem(meal: meals[index], onSelectMeal: (meal){
  //           selectMeal(context, meal);
  //     },
  //     ),
  //    // itemBuilder: (ctx,index)=> MealItem(meal: meals[index],)
  //     );
  // }
  itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          onSelectMeal: (meal) {  // Pass the function with both parameters
            selectMeal(context, meal);
          },
        ),
      );
    }

 if(title == null){
  return content;
 }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      // body: ListView.builder(
      //   itemCount: meals.length,
      //   itemBuilder: (ctx,index)=> Text(
      //   meals[index].title,
      // ), ),
      body: content,
    );
  }


  
}