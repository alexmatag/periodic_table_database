#!/bin/bash

# 1. Variable de conexión (sin encabezados ni bordes, separado por |)
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# VERIFICAR si el primer argumento ($1) viene vacio
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit 0
fi

# 2. Distinguir si el argumento ($1) es un número o un texto
if [[ $1 =~ ^[0-9]+$ ]]
then
  # Si son solo dígitos, buscamos en la columna numérica (sin comillas simples)
  CONDITION="atomic_number = $1"
else
  # Si es texto, buscamos en las columnas de texto (con comillas simples '$1')
  CONDITION="symbol = '$1' OR name = '$1'"
fi

DATA_ELEMENT_RESULT=$($PSQL "SELECT atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE $CONDITION;")

# 3. Validar si la consulta regresó vacía (no encontró nada)
if [[ -z $DATA_ELEMENT_RESULT ]]
then
  echo "I could not find that element in the database."
  exit 0
fi

IFS="|" read -r ATOMIC_NUMBER SYMBOL NAME TYPE ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS <<< "$DATA_ELEMENT_RESULT"

echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."