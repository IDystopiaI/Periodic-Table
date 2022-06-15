#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"


# This function identifies if input is atomic number, symbol or name
PARSE_INPUT() {
  if [[ $1 =~ ^[0-9]{1,2}$ ]]
  then
    # echo "number: $1"
    # select statement works, need to read into VARIABLES and then create sentence

    # needs to handle element can not be found
    echo $($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements join properties using(atomic_number) join types using(type_id) WHERE atomic_number = $1 ") | while read Q_ATOMIC_NUM BAR Q_NAME BAR Q_SYMBOL BAR Q_TYPE BAR Q_MASS BAR Q_MELT_C BAR Q_BOIL_C
    do
      # dont forget to add $ to varaiable name
      if ! [[ -z $Q_NAME ]]
      then
        echo "The element with atomic number $Q_ATOMIC_NUM is $Q_NAME ($Q_SYMBOL). It's a $Q_TYPE, with a mass of $Q_MASS amu. $Q_NAME has a melting point of $Q_MELT_C celsius and a boiling point of $Q_BOIL_C celsius."
      else
        echo "I could not find that element in the database."
      fi
    done
  
  else
  # use wc function and get the character count
  # if characters are <= 2 $1 = symbol else $1 = name
    if [[ ${#1} -le 2 ]]
    then
    echo "Symbol: $1"

    else
    echo "Name: $1"
    fi
  fi
}


# needs to accept atomic number, symbol or name
if [[ -z $1 ]]
then
# does this need to be any element, symbol or number or only element's name?
  echo "Please provide an element as as argument"
  read INPUT_ELEMENT

  # place input into PARSE_INPUT function
  ELEMENT_RESPONSE=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements join properties using(atomic_number) join types using(type_id) WHERE LOWER(name) = LOWER('$INPUT_ELEMENT')")
  echo "$ELEMENT_RESPONSE"

else
echo "$($echo PARSE_INPUT $1)"

fi
#  You should create an element.sh file in your repo folder for the program I want you to make

# Your script (.sh) file should have executable permissions

# If you run ./element.sh, it should output Please provide an element as an argument and finish running.

# If you run ./element.sh 1, ./element.sh H, or ./element.sh Hydrogen, it should output The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.

# If you run ./element.sh script with another element as input, you should get the same output but with information associated with the given element.

# If the argument input to your element.sh script doesn't exist as an atomic_number, symbol, or name in the database, the output should be I could not find that element in the database.
