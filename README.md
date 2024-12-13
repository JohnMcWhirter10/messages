# Message App

![Logo](logo.png)

This application stores videos onto an S3 bucket. Each video can have a Title, Description, Thumbnail and many tags. Tags can be used to filter the videos on the Home screen.

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/JohnMcWhirter10/messages.git
   cd messages
   ```

2. Install dependencies:

   ```bash
   bundle install
   ```

3. Set up the database:
   ```bash
   rails db:create db:migrate
   ```

## Setting Up Local MySQL Server

To configure a local MySQL server for this application, follow these steps:

### Install MySQL

This application was developed in wsl on Windows.

1. **macOS**:

   ```bash
   brew install mysql
   brew services start mysql
   ```

2. **Linux**:

   ```bash
   sudo apt update
   sudo apt install mysql-server
   sudo service mysql start
   ```

3. **Windows**:
   Download and install MySQL from [MySQL Downloads](https://dev.mysql.com/downloads/installer/).

### Configure MySQL User and Database

1. Log in to the MySQL server as the root user:

   ```bash
   mysql -u root -p
   ```

2. Create the database and user:

   ```sql
   CREATE DATABASE watermark_dev;
   CREATE USER 'your_user'@'localhost' IDENTIFIED BY 'your_password';
   GRANT ALL PRIVILEGES ON watermark_dev.* TO 'your_user'@'localhost';
   FLUSH PRIVILEGES;
   ```

3. Test the connection:
   ```bash
   mysql -u your_user -p -h localhost watermark_dev
   ```

### Update Rails Configuration

Update `config/database.yml`:

```yaml
development:
  adapter: mysql2
  encoding: utf8mb4
  pool: 5
  username: your_user
  password: your_password
  host: localhost
  database: watermark_dev
```

Run the database setup commands again:

```bash
rails db:create db:migrate
```

For a trace to help with debugging use this:

```bash
rails db:create db:migrate --trace
```

## Running the Application

1. Start the Rails server:

   ```bash
   rails server
   ```

   For a custom port use this:

   ```bash
   rails s -p 4001
   ```

2. Open your browser and navigate to:
   ```
   http://localhost:3000
   ```
