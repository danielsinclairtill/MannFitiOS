# MannFitiOS
The MannFit System is defined as a fitness exercising method that utilizes Integral Kinematic exercise. This MannFit System was researched and developed by University of Toronto’s professor Steve Mann and a team of his peers. In most sports and fitness training, the goal in terms of fitness metrics is to maximize speed, acceleration, or distance. Integral Kinematics is an alternative concept which refers to the integrals of displacement. With Integral Kinematics, the goal is to minimize absement (time integral of displacement) or the distance from a fixed point. The MannFit System fitness metrics are therefore based on Integral Kinematics which emphasizes strength, dexterity, and endurance to minimize absement. We can imagine one example as trying to balance a rotatable pull up bar to be parallel to the ground, minimizing angle change, by using one’s muscles for a long period of time. What the MannFit System lacked and required was an accessible technological interface to guide, train, and interact with a user utilizing this fitness method. Therefore the proposed project for our final year engineering design university course (ECE496) our team undertook was to develop a fitness trainer game smartphone iOS application to interface for the MannFit System. 

## Demo Video
To view a demo video of the application in use, please refer to the following directoy:


## Games
The application contains four playable games, such that to perform these games one user must be performing an Integral Kinetic exercise. Each game pairs with a plankboard or pull up bar exercise apparatus. Each game’s cursor or player in some form is controlled by the accelerometer data provided by the smartphone’s motion sensors and iOS software library CoreMotion. During game / exercise the application guides and live feeds the user's absement, workout time, and relative game score. The goal of each game is to minimize absement by keeping the cursor in a designated position. The white number on the top right of the smartphone displays the current absement, while the red number below it displays the overall session’s absement / game score. The objective of the games are to the keep the red number as small as possible. An additional feature in the games involves music playing during exercise, and if the player deviates from the intended position the music gets distorted to notify the user. Games can be viewed in the “Games” tab bar view. Tapping upon a specific game displays a pre-game guide and user input for duration of exercise in seconds. Upon completion of each session, the application will store these data points into the local storage.

## Workouts
The “Workouts” tab bar view presents all stored exercise game workout sessions as items in a list, ordered by most recent, and sectioned by month. Items are also available to be filtered by specific game type. Each item in the list shows the type of game, absement score, and date of the workout session. Each item is tappable to go into a separate workout detail view which will give more information on that specific item. Each item is also deletable. The detail view for a specific workout history item displays:
- time stamp
- time duration
- game type
- game / absement score
- high score overall of specific game type
- improvement since last same game type session (in percentage)
- absement over time of entire session through graph

## History
The “History” tab bar view shows the summed up and progress in absement / score values based on days through the use of a calendar. Blue highlighted days indicate days that have recorded session scores.

## Settings / More
The “More” tab bar view gives an array of options the user can customize:
sensitivity of accelerometer data / smartphone motion sensors
- music ON / OFF
- music volume
- game #4 ping pong, ball speed
- graph functionality for sessions ON / OFF
- sample rate for graph functionality
