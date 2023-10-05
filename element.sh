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
    echo "$ELEMENT_RESULT"
  fi
else
  echo Please provide an element as an argument.
fi