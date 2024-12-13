# CS350_Project_02 Instructions

Step-by-step instructions for installing Apache Superset using your WSL


1. Update Ubuntu/Debian
```
sudo apt update -y & sudo apt upgrade -y
```

2. Install dependencies
```
sudo apt-get install build-essential libssl-dev libffi-dev python3-dev python3-pip libsasl2-dev libldap2-dev default-libmysqlclient-dev python3.10-venv
```


3. Create app directory for superset and dependencies using the follow commands
```
sudo mkdir /app
sudo chown user /app
cd /app
```


4. Create python environment using the following commands
```
mkdir superset
cd superset
python3 -m venv superset_env
. superset_env/bin/activate
pip install --upgrade setuptools pip
```


5. Install Required dependencies
```
pip install pillow
pip install apache-superset
```


6. Create superset config file and set environment variable
```
touch superset_config.py
export SUPERSET_CONFIG_PATH=/app/superset/superset_config.py
```

7. Edit and paste following code in it
```
# Superset specific config
ROW_LIMIT = 5000

# Flask App Builder configuration
# Your App secret key will be used for securely signing the session cookie
# and encrypting sensitive information on the database
# Make sure you are changing this key for your deployment with a strong key.
# Alternatively you can set it with `SUPERSET_SECRET_KEY` environment variable.
# You MUST set this for production environments or the server will not refuse
# to start and you will see an error in the logs accordingly.
SECRET_KEY = 'YOUR_OWN_RANDOM_GENERATED_SECRET_KEY'

# The SQLAlchemy connection string to your database backend
# This connection defines the path to the database that stores your
# superset metadata (slices, connections, tables, dashboards, ...).
# Note that the connection information to connect to the datasources
# you want to explore are managed directly in the web UI
# The check_same_thread=false property ensures the sqlite client does not attempt
# to enforce single-threaded access, which may be problematic in some edge cases
SQLALCHEMY_DATABASE_URI = 'sqlite:////app/superset/superset.db?check_same_thread=false'

TALISMAN_ENABLED = False
WTF_CSRF_ENABLED = False

# Set this API key to enable Mapbox visualizations
MAPBOX_API_KEY = ''
```


8. Please replace YOUR_OWN_RANDOM_GENERATED_SECRET_KEY in above file with the code returned by following command
```
openssl rand -base64 42
```

9. Once Done let us inititlize database with following commands
```
# Create an admin user in your metadata database (use `admin` as username to be able to load the examples)
export FLASK_APP=superset

superset db upgrade

superset fab create-admin

# As this is going to be production I have commented load example part but if you need you can run this superset load_examples

# Create default roles and permissions

superset init
```


10. Now Our environment is ready lets try running it. To run superset I have created a sh script that you can run in order to run the server. To create create script using following command.
```
nano run_superset.sh
```


11. Then paste following code in it.
```
#!/bin/bash
export SUPERSET_CONFIG_PATH=/app/superset/superset_config.py
 . /app/superset/superset_env/bin/activate
gunicorn \
      -w 10 \
      -k gevent \
      --timeout 120 \
      -b  0.0.0.0:8088 \
      --limit-request-line 0 \
      --limit-request-field_size 0 \
      --statsd-host localhost:8125 \
      "superset.app:create_app()"
```


12. In order to run it we need to grant it run permission. To do that lets run following command.
```
chmod +x run_superset.sh
```


13. Lets run and test if it works
```
sh run_superset.sh
```
**NOTE:** If you run into an error that says 'ModuleNotFoundError: No module named 'gevent'' use the following command 'pip install gevent', then run the command above again.


14. Check if you are able to login using admin creds on server-ip-address:8088. If everything is working fine then we can go ahead and create service that will start automatically as soon 
as server starts or in case it reboots. You can use the link 'http://localhost:8088' to login to superset.


15. Lets create service called superset using following command
```
sudo nano /etc/systemd/system/superset.service
```


16. Then paste following code in it
```
[Unit]
Description = Apache Superset Webserver Daemon
After = network.target

[Service]
PIDFile = /app/superset/superset-webserver.PIDFile
Environment=SUPERSET_HOME=/app/superset
Environment=PYTHONPATH=/app/superset
WorkingDirectory = /app/superset
limit-re>
ExecStart = /app/superset/run_superset.sh
ExecStop = /bin/kill -s TERM $MAINPID


[Install]
WantedBy=multi-user.target
```


17. Once copied run following commands to enable and start service
```
sudo systemctl daemon-reload
sudo systemctl enable superset.service
sudo systemctl start superset.service
```
