#! /bin/bash

# Lade die mitgegebenen Parameter 
while getopts n:t: flag
do
    case "${flag}" in
        n) NAME=${OPTARG};;
        t) TEMPLATE=${OPTARG};;
    esac
done

# Erstelle einen Ordner für die Installation
BASE=~/.diamat

mkdir $BASE/
mkdir $BASE/$NAME/
mkdir $BASE/$NAME/mongodb-init/
mkdir $BASE/$NAME/mongodb-init/data/
mkdir $BASE/$NAME/mongodb/

# begriffe.json
# gruppen.json
# nutzer.json
# hilfen.json
# quellen.json

# Lade alle Templatedateien für die Datenbank
declare -a data_template_files=("begriffe.json" "gruppen.json" "nutzer.json" "hilfen.json" "quellen.json")

for i in "${data_template_files[@]}" 
do   
   curl https://raw.githubusercontent.com/emilianscheel/diamat-defaults/main/$TEMPLATE/$i -o $BASE/$NAME/mongodb-init/data/$i
done

# Lade die mongo-init.sh
curl https://raw.githubusercontent.com/emilianscheel/diamat-defaults/main/mongo-init.sh -o $BASE/$NAME/mongodb-init/mongo-init.sh





# Lade die .env.local Datein aus dem Template
declare -a env_template_files=(".env.local" ".env.development.local" ".env.production.local")

for i in "${env_template_files[@]}" 
do   
   curl https://raw.githubusercontent.com/emilianscheel/diamat-defaults/main/$TEMPLATE/$i -o $BASE/$NAME/$i
done




# Lade die docker-compose Dateien
declare -a docker_compose_template_files=("diamat-dev.yml" "diamat-prod.yml" "diamat-mongodb.yml")

for i in "${docker_compose_template_files[@]}" 
do   
   curl https://raw.githubusercontent.com/emilianscheel/diamat-defaults/main/docker-compose/$i -o $BASE/$NAME/$i
done

