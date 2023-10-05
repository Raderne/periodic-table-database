#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ $1 ]]
then
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ELEMENT_RESULT=$($PSQL "select * from elements as e inner join properties as p using(atomic_number) inner join types as t using(type_id) where e.atomic_number=$1;")

  elif [[ $1 =~ ^[a-zA-Z]*+ ]]
  then
    ELEMENT_RESULT=$($PSQL "select * from elements as e inner join properties as p using(atomic_number) inner join types as t using(type_id) where e.name='$1' OR e.symbol='$1';")
  fi

  if [[ -z $ELEMENT_RESULT ]]
  then
    echo I could not find that element in the database.
  else
    echo "$ELEMENT_RESULT" | while IFS="|" read TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS TYPE
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
    done
  fi
else
  echo Please provide an element as an argument.
fi