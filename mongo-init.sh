#!/bin/bash

echo "########### Creating collections ###########"

mongo -- "$MONGO_INITDB_DATABASE" <<EOF
    // Erstelle die Collections
    db = new Mongo().getDB("diamat-db");
    db.createCollection('begriffe', { capped: false });
    db.createCollection('gruppen', { capped: false });
    db.createCollection('nutzer', { capped: false });
    db.createCollection('hilfen', { capped: false });
    db.createCollection('quellen', { capped: false });
EOF

echo "########### Importing data into collections ###########"

# Importiere alle Dateien in die Collections
declare -a data_template_files=("begriffe" "gruppen" "nutzer" "hilfen" "quellen")

for i in "${data_template_files[@]}" 
do   
   mongoimport --jsonArray --db diamat-db --collection $i --file /tmp/data/$i.json
done