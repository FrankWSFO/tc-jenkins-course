# Print the current working directory and list its contents
pwd
ls -al

# Echo the NAME parameter
echo "Hello my name is $NAME!"

# Start the ROS script that MOVES the robot around in the background
# Capture the process ID of that script in MOVE_ID
# Wait for MOVE seconds and then kill the process
case $ENABLE_MOVE in 
  true)
    roslaunch publisher_example move.launch &
    MOVE_ID=$!
    sleep ${MOVE}s
    kill $MOVE_ID
    ;;
  false)
  	echo "No moving this time."
    ;;
esac

# Start the ROS script that STOPS the robot in the background
# Capture the process ID of that script in STOP_ID
# Wait for 5 seconds and then kill the process
roslaunch publisher_example stop.launch &
STOP_ID=$!
sleep 15s
kill $STOP_ID

# Call the Gazebo service that resets the simulation
# ...if enabled
case $RESET_SIMULATION in
  true)    
    rosservice call /gazebo/reset_simulation "{}"
    echo "Simulation has been reset."
    ;;
  false)   
    echo "Not resetting the simulation."
    ;;
esac

# Print the text that indicates that we are done here
echo "Job finished"
