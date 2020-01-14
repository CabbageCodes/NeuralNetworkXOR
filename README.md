# NeuralNetworkXOR
Trains a three layer, feed forward, fully connected artificial neural network to replicate an XOR gate.
he algorithm used to minimise the error was the Metropolis algorithm. 
This uses a Markov chain which starts with a random configuration with a certain energy. 
A small change is then proposed to the configuration, and the energy of this is compared with the original. 
If the change results in a lower energy configuration then the change is accepted, otherwise the change is accepted 
with a probability of exp(−∆E/kT).This means that higher energy configurations can be accepted in order to help avoid l
ocal minimum. Replacing energy with the error in the output produced by neural network results in the error being minimised. 
The weights were incremented in each iteration by a random number between 1 and --1, multiplied by a fixed step size. 
The step size allowed me to adjust the size of the increment to further minimise the error. 
Instead of temperature, I used a variable β to represent the inverse of temperature which increased with each iteration 
to simulate cooling. Through testing, I found that a high initial temperature of 120, and a step size of 0.1, produced 
results with the smallest error. 
