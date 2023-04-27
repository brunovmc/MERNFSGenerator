# MERN Stack File Structure Generator

This script generates a basic MERN stack file structure, including a React app generated using `create-react-app` in the `client` directory and an Express server in the `server` directory with Mongoose for MongoDB integration.

## Usage

To use this script, run the following command in your terminal:

```bash
sh create_mern_structure.sh <main_file_name> [<directory_path>]
```

- `<main_file_name>`: Required argument. The name of your main file. This will be used as the name of your project directory and also as the name of the MongoDB database.
- `[<directory_path>]`: Optional argument. The path where the project directory will be created. If not provided, the project directory will be created in the current directory. If the provided directory does not exist, the project directory will be created in the current directory.

Examples:

```bash
sh create_mern_structure.sh myapp                      # Creates the directory 'myapp' in the current directory
sh create_mern_structure.sh myapp /path/to/directory   # Creates the directory 'myapp' in the '/path/to/directory' directory
```

## Running the Client and Server

After running the script and entering the created directory, you can run the following command in the main directory to start the client and server:

```
npm start
```

This will create two terminals, one for the client and one for the server.

## Credits

This script was created by Bruno Vidigal.
