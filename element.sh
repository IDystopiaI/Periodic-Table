#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"



# This function identifies if input is atomic number, symbol or name
PARSE_INPUT() {
  if [[ $1 =~ ^[0-9]{1,2}$ ]]
  then
    # Look-up element by atomic number
    echo $($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1 ") | while read Q_ATOMIC_NUM BAR Q_NAME BAR Q_SYMBOL BAR Q_TYPE BAR Q_MASS BAR Q_MELT_C BAR Q_BOIL_C
    do
      if ! [[ -z $Q_NAME ]]
      then
        echo "The element with atomic number $Q_ATOMIC_NUM is $Q_NAME ($Q_SYMBOL). It's a $Q_TYPE, with a mass of $Q_MASS amu. $Q_NAME has a melting point of $Q_MELT_C celsius and a boiling point of $Q_BOIL_C celsius."
      else
        echo "I could not find that element in the database."
      fi
    done
  
  else
    # Determines if argument is symbol or name 
    if [[ ${#1} -le 2 ]]
    then
      # Look-up by symbol
      echo $($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol = '$1' ") | while read Q_ATOMIC_NUM BAR Q_NAME BAR Q_SYMBOL BAR Q_TYPE BAR Q_MASS BAR Q_MELT_C BAR Q_BOIL_C
    do
      if ! [[ -z $Q_NAME ]]
      then
        echo "The element with atomic number $Q_ATOMIC_NUM is $Q_NAME ($Q_SYMBOL). It's a $Q_TYPE, with a mass of $Q_MASS amu. $Q_NAME has a melting point of $Q_MELT_C celsius and a boiling point of $Q_BOIL_C celsius."
      else
        echo "I could not find that element in the database."
      fi
    done

    else
      # Look-up by name
      echo $($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name = '$1'") | while read Q_ATOMIC_NUM BAR Q_NAME BAR Q_SYMBOL BAR Q_TYPE BAR Q_MASS BAR Q_MELT_C BAR Q_BOIL_C
    do
      if ! [[ -z $Q_NAME ]]
      then
        echo "The element with atomic number $Q_ATOMIC_NUM is $Q_NAME ($Q_SYMBOL). It's a $Q_TYPE, with a mass of $Q_MASS amu. $Q_NAME has a melting point of $Q_MELT_C celsius and a boiling point of $Q_BOIL_C celsius."
      else
        echo "I could not find that element in the database."
      fi
    done
    fi
  fi
}


# needs to accept atomic number, symbol or name?
# can't get this test to pass
if [[ -z $1 ]]
then
# does this need to be any element, symbol or number or only element's name?
  echo "Please provide an element as an argument."
  # read INPUT_ELEMENT
  # PARSE_INPUT $INPUT_ELEMENT


else
  echo "$($echo PARSE_INPUT $1)"
fi

