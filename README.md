# Hardware-implementation-of-Neural-Network-for-MNIST-using-verilog
This is a hardware implementation of Neural Network for MNIST using verilog.

# Introduction

Multi-Layer Perceptron (MLP) -The most common form of neural networks is the Feed-Forward  Multi-Layer Perceptron  (MLP).A  feed-forward  neural  network  is  an ANNwherein  connections  between  the neurons do not form a cycle.An n-layer MLP consists of one input layer, n-2 intermediate (hidden layers), and one output layer. Each layer consists of a set of basic processing elements or neurons. An individual neuron  is  connected  to  several  neurons  in  the  previous  layer, from  which  it  receives  data,  and also  it is connected to several neurons in the next layer, to which it sends data.Except for the input nodes, each neuron uses a nonlinear activation function.

The output of each neuron in hidden layers is the weighted sum of the neuron inputs,and it is presented as input to the next layer after passing through a nonlinear function.The data is finally propagated to the output layer after passing through one or more hidden layers.So, inhidden and output layers, eachneuron has the computation formula as Relation.1.

𝒚𝒋=𝒇(∑𝑾𝒊𝒋×𝒙𝒊+𝒃𝒋)𝒏𝒊=𝟏𝑹𝒆𝒍𝒂𝒕𝒊𝒐𝒏.𝟏

𝒙𝒊and 𝒚𝒋are the input and output values of the neuron. 𝑾𝒊𝒋and 𝒃𝒋showsthe value ofneuronweights and biases, respectively. Function f (.)represents the nonlinear activationfunction.

Today, artificial neural networks are used in various criticalapplications such as classification,pattern recognition,clustering, optimization, etc. Image classificationis the process of analyzing the image toidentify the 'class'of it.
