#!/bin/bash

echo "########### Creating collections ###########"

mongo -- "$MONGO_INITDB_DATABASE" <<EOF
    let MONGO_INITDB_ROOT_USERNAME = '$MONGO_INITDB_ROOT_USERNAME';
    let MONGO_INITDB_ROOT_PASSWORD = '$MONGO_INITDB_ROOT_PASSWORD';
    let MONGO_USERNAME = '$MONGO_USERNAME';
    let MONGO_PASSWORD = '$MONGO_PASSWORD';
      
    // Erstelle den Nutzer
    dbAdmin = db.getSiblingDB("admin");
    dbAdmin.createUser({
      user: MONGO_USERNAME,
      pwd: MONGO_PASSWORD,
      roles: [{ role: "userAdminAnyDatabase", db: "admin" }],
      mechanisms: ["SCRAM-SHA-1"],
    });

    // Authentifiziere mit dem erstellen Nutzer
    dbAdmin.auth({
      user: MONGO_USERNAME,
      pwd: MONGO_PASSWORD,
      mechanisms: ["SCRAM-SHA-1"],
      digestPassword: true,
    });

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