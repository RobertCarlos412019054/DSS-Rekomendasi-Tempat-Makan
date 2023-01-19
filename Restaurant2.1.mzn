include "globals.mzn"; 
include "rest_data.dzn"; 

int: num_items;
array[1..num_items, 1..7] of int: items;
array[1..num_items] of string: names;

int: num_limits;
array[1..num_limits] of int: limits;

%float: rates;

% decision variables
array[1..num_items] of var 1..8: x;
var int: total = sum([x[i]*items[i,7] | i in 1..num_items]);

% solve minimize total;
solve maximize total;
% solve satisfy;

constraint
   % sodium < 3000mg, fat < 150g, calories < 3000
   forall(j in 1..num_limits) (
     sum([x[i]*items[i,j] | i in 1..num_items]) < limits[j]
   )

   % keep the serving of ketchup and lettuce the same.  
   % /\ x[FriedChicken] = x[Cola]

   % keep the servings of pickles and tomatoes the same.
   % /\ x[Burger] = x[FrenchFries]

   % /\ total = 280 % maximal solution


;


output [
  "Jmlh Mkn    : ", show(total), " Porsi\n",
  "KFC         : ", show(sum([x[i]*items[i,1] | i in 1..num_items])), " Rupiah\n",
  "Rate KFC          : 4.7 ", "\n",
  "McDonald's  : ", show(sum([x[i]*items[i,2] | i in 1..num_items])), " Rupiah\n",
  "Rate McDonald's   : 4.8 ", "\n",
  "A&W         : ", show(sum([x[i]*items[i,3] | i in 1..num_items])), " Rupiah\n",
  "Rate A&W          : 4.8",  "\n",
  "Burger King : ", show(sum([x[i]*items[i,4] | i in 1..num_items])), " Rupiah\n",
  "Rate Burger King  : 4.7 ",  "\n",
  "CFC         : ", show(sum([x[i]*items[i,5] | i in 1..num_items])), " Rupiah\n",
  "Rate CFC          : 4.6 ", "\n",
  "Wendy's     : ", show(sum([x[i]*items[i,6] | i in 1..num_items])), " Rupiah\n",
  "Rate Wendy's     : 4.6 ", "\n",
  %"Rate        : ", show(rates),
  "x           : ", show(x), "\n",
]
++
[
  show(names[i]) ++ ": " ++ show(x[i]) ++ " (" ++ show_int(3,x[i]*items[i,7]) ++ " Porsi)\n"
  | i in 1..num_items
]
;



% 0,1,2,3,4,5,6,7
% data
%
num_limits = 6;
%Limit Maksimal Harga yang sudah ditentukan
%         KFC    MCD    A&W    BK     CFC    W
limits = [350000,350000,350000,350000,350000,350000];

num_items = 8;



%rates = 
%[
% KFC     MCD      A&W       BurgerKing     CFC     Wendys
%4.7,      4.8,     4.8,      4.7,           4.6,    4.6,
%];


int: FriedChicken;
int: Burger;
int: FrenchFries;
int: Soup;
int: IceCream;
int: Sundae;
int: Float;
int: Cola;

names = ["Fried Chicken  ", 
         "Burger         ", 
         "French Fries   ", 
         "Soup           ",
         "Ice Cream      ",
         "Sundae         ", 
         "Float          ", 
         "Cola           "];