# setupDebugger
setups nodeinspector in multiple docker container

### Installation Steps

#### Step 1: Update Environment files
 - run setUpDebugger.sh `PATH/TO/SHIPPABLE_ONE_DIR`
   - This will add 2 ports numbers in each of the env files in one/components `NODEINSPECTOR_DEBUG_PORT` & `NODEINSPECTOR_PORT`

#### Step 2: Save Alias
 ```bash
 debug () {
	COMPONENT=$1 
	ENV_PATH="/home/harry/shippable/one/components/${COMPONENT}.env" 
	if [ ! -f $ENV_PATH ]
	then
		echo "${COMPONENT} is not a valid component."
		echo 'exiting...'
	else
		PORT=$(grep NODEINSPECTOR_PORT $ENV_PATH | awk -F = '{print $2}') 
		DEBUG_PORT=$(grep NODEINSPECTOR_DEBUG_PORT  $ENV_PATH | awk -F = '{print $2}') 
		echo $PORT $DEBUG_PORT
		google-chrome http://localhost:$PORT/\?port\=$DEBUG_PORT
	fi
 }
```

#### Step 3: Update the docker file
  - add line `FROM harryi3t/appbase:latest.nodeinspector`
  - or, instead you can update the `shipimg/appbase:latest` to add node-inspector module
  - update boot.sh file
  - Update the line 
  ```
  forever -w -v FILE_NAME.js
  ```
  to these 2 lines
  ```
  forever -w -v -c "node --debug=$NODEINSPECTOR_DEBUG_PORT" FILE_NAME.js &
  node-inspector -p $NODEINSPECTOR_PORT
  ```

### Usage
 - Complete step 1 and 2
 - Go to the component folder which you want to debug
 - Create a new branch `debug`
 - Complete step 3 (so that your master branch won't be polluted)
 - Come back to master branch
 - Execute command `debug COMPONENT` like `debug www` or `debug nf`
 - A chrome tab will open, now you can place your break points

Happy Debugging !
  
  
