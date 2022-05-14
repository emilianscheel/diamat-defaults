mongo -- "$MONGO_INITDB_DATABASE" -u "$MONGO_INITDB_ROOT_USERNAME" -p "$MONGO_INITDB_ROOT_PASSWORD" <<EOF
  db.createUser({
    user: "$MONGO_USERNAME",
    pwd: "$MONGO_PASSWORD",
    roles: [
      { role: 'readWrite', db: "$MONGO_INITDB_DATABASE" }
    ]
  });

  use diamat-db;

  db.createCollection('begriffe', { capped: false });
  db.createCollection('gruppen', { capped: false });
  db.createCollection('nutzer', { capped: false });
  db.createCollection('hilfen', { capped: false });
  db.createCollection('quellen', { capped: false });
EOF

# begriffe.json
# gruppen.json
# nutzer.json
# hilfen.json
# quellen.json

# every of those files (or a directory within those files) need to be mapped as volumes in the mongodb container, so that they are accessable from this script (mongo-init.sh), which gets of course executed in the container.

# Importiere alle Dateien in die Collections
declare -a data_template_files=("begriffe.json" "gruppen.json" "nutzer.json" "hilfen.json" "quellen.json")

for i in "${data_template_files[@]}" 
do   
   mongoimport --db diamat-db --collection begriffe --drop --file ~/docker-entrypoint-initdb.d/data/$i --jsonArray
done