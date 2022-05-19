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

GITHUB_URL=https://raw.githubusercontent.com/emilianscheel/diamat-defaults/main

mkdir $BASE/
mkdir $BASE/$NAME/
mkdir $BASE/$NAME/mongodb-init/
mkdir $BASE/$NAME/mongodb-init/data/
mkdir $BASE/$NAME/mongodb/

mkdir $BASE/$NAME/diamat-data/
mkdir $BASE/$NAME/diamat-data/documents/
mkdir $BASE/$NAME/diamat-data/templates/

# begriffe.json
# gruppen.json
# nutzer.json
# hilfen.json
# quellen.json

# Lade alle Templatedateien für die Datenbank
declare -a data_template_files=("begriffe.json" "gruppen.json" "nutzer.json" "hilfen.json" "quellen.json")

for i in "${data_template_files[@]}" 
do   
   curl $GITHUB_URL/$TEMPLATE/$i -o $BASE/$NAME/mongodb-init/data/$i
done

# Lade die mongo-init.sh
curl $GITHUB_URL/mongo-init.sh -o $BASE/$NAME/mongodb-init/mongo-init.sh





# Lade die .env.local Datein aus dem Template
declare -a env_template_files=(".env.local" ".env.development.local" ".env.production.local")

for i in "${env_template_files[@]}" 
do   
   curl $GITHUB_URL/$TEMPLATE/$i -o $BASE/$NAME/$i
done




# Lade die docker-compose Dateien
declare -a docker_compose_template_files=("diamat-dev.yml" "diamat-prod.yml" "diamat-mongodb.yml")

for i in "${docker_compose_template_files[@]}" 
do   
   curl $GITHUB_URL/docker-compose/$i -o $BASE/$NAME/$i
done



# Lade die Dateien für den diamat-data Ordner
declare -a diamat_data_documents_files=("datenschutz.html" "impressum.html" "nutzungsbedingungen.html")
for i in "${diamat_data_documents_files[@]}" 
do   
   curl $GITHUB_URL/$TEMPLATE/diamat-data/documents/$i -o $BASE/$NAME/diamat-data/documents/$i
done

declare -a diamat_data_templates_files=("contact.hjs" "verify.hjs")
for i in "${diamat_data_templates_files[@]}" 
do   
   curl $GITHUB_URL/$TEMPLATE/diamat-data/templates/$i -o $BASE/$NAME/diamat-data/templates/$i
done

declare -a diamat_data_json_files=("config.json" "logs.json")
for i in "${diamat_data_json_files[@]}" 
do   
   curl $GITHUB_URL/$TEMPLATE/diamat-data/$i -o $BASE/$NAME/diamat-data/$i
done

