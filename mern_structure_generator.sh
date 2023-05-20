#!/bin/bash

create_server_directory() {
    mkdir server
    cd server
    npm init -y
    npm install express cors mongoose dotenv
    npm install --save-dev nodemon
    mkdir models public routes services
    cat <<EOF > index.js
const express = require('express');
const cors = require('cors');
const mongoose = require('mongoose');

const app = express();
const port = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());

mongoose.connect('mongodb://127.0.0.1:27017/$main_file_name');
const connection = mongoose.connection;
connection.once('open', () => {
    console.log('MongoDB database connection established successfully');
});

app.listen(port, () => {
    console.log('Server is running on port: ' + port);
});
EOF
    cd models
    cat <<EOF > index.js
const mongoose = require('mongoose');
const ExampleSchema = require('./example');

const connect = () => {
    mongoose.connect(process.env.MONGO_URL);
};

module.exports = {
    Example,
    connect,
};
EOF
    cat <<EOF > example.js
const { Schema } = require('mongoose');

const Example = new Schema({
    id: {
        type: Number,
        required: true,
    },
    nome: {
        type: String,
        required: true,
    },
});

module.exports = Example;
EOF

    cd ..
    cd routes
    mkdir api auth midddlewares
    echo $'const express = require("express");\n\nconst router = express.Router();\n\nrouter.get("/", (_, res) => {\n    res.send("<h1>Home</h1>");\n});\n\nmodule.exports = router;' > home.js
    cd ..
}

create_client_directory() {
    npm install create-react-app
    npx create-react-app client
}

create_readme() {
    echo "# $main_file_name" > README.md
    echo "" >> README.md
    echo "## Basic Features" >> README.md
    echo "Here are some of the basic features included in this project:" >> README.md
    echo "- Feature 1: Node.js/Express server." >> README.md
    echo "- Feature 2: MongoDB database." >> README.md
    echo "- Feature 3: React-create-app for Frontend." >> README.md
    echo "" >> README.md
    echo "README file created successfully!"
}

if [ -z "$1" ]; then
    read -p "Please provide a main file name: " main_file_name
    if [ -z "$main_file_name" ]; then
        echo "Error: Must provide a directory name"
        exit 1
    fi
else
    main_file_name=$1
fi

if [ $# -gt 1 ]; then
    if ! [ -d "$2" ]; then
        echo "Invalid path, creating in current directory"
    else
        cd $2
    fi
fi

mkdir $main_file_name
cd $main_file_name

touch .env .env.example
npm init -y

echo "Creating client directory..."
create_client_directory

echo "Creating server directory..."
create_server_directory

echo "Creating start command..."
sed -i '/exit 1\"/s/$/,\n    "start": "start cmd.exe \/c \\"cd client \&\& start cmd.exe \/k npm start\\" \& start cmd.exe \/c \\"cd server \&\& start cmd.exe \/k node index.js\\"" /' package.json

echo "Initializing Git repository..."
git init

echo "Creating README file..."
create_readme

echo "Committing initial files to Git..."
git add .
git commit -m "Initial commit"

echo "Creating GitHub repository..."
gh repo create $main_file_name --confirm

echo "Pushing to remote repository..."
git push origin main

echo "Basic MERN stack file structure created successfully!"
echo "Script executed in $(($SECONDS / 3600))h$((($SECONDS / 60) % 60))m$(($SECONDS % 60))s"
