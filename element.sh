#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

GET_ELEMENT() {
  if [[ -z $1 ]]
  then
    echo "Please provide an element as an argument."
  else
    if [[ ! $1 =~ ^[0-9]+$ ]]
    then
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1' OR name ='$1'")
      if [[ -z $ATOMIC_NUMBER ]]
      then
        echo "I could not find that element in the database."
      else
        GET_RESULT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $ATOMIC_NUMBER")
        echo "$GET_RESULT" | while IFS="|" read ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELTING BOILING
        do
          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
        done
      fi
    else
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
      if [[ -z $ATOMIC_NUMBER ]]
      then
        echo "I could not find that element in the database."
      else
        GET_RESULT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $ATOMIC_NUMBER")
        echo "$GET_RESULT" | while IFS="|" read ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELTING BOILING
        do
          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
        done
      fi
    fi
  fi
}

GET_ELEMENT $1