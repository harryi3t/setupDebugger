# setupDebugger
setups nodeinspector in multiple docker container

#### Installation Steps
 - run setUpDebugger.sh `PATH/TO/SHIPPABLE_ONE_DIR`
   - This will add 2 ports numbers in each of the env files in one/components
 - update the docker file
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
