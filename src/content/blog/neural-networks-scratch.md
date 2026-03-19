---
title: Neural Networks from Scratch
date: '2024-12-10'
description: Building a neural network engine with NumPy and CS 499 independent study.
---

# Neural Networks from Scratch

For my CS 499 independent study, I implemented a neural network engine using only NumPy. The goal was to understand the fundamentals without relying on frameworks like PyTorch or TensorFlow.

A neural network consists of layers of neurons. Each neuron computes a weighted sum of its inputs, adds a bias, and applies an activation function. Forward propagation computes the network output by passing input through each layer sequentially. I represented layers as matrices of weights and vectors of biases.

Activation functions introduce non-linearity. I implemented sigmoid, tanh, ReLU, and softmax. Sigmoid squashes values between 0 and 1. ReLU is zero for negative inputs and the identity for positive inputs. Softmax converts a vector of numbers into probabilities that sum to one.

Training requires backpropagation - computing gradients of the loss with respect to each parameter using the chain rule. The chain rule states that the derivative of a composition is the product of derivatives. For a multi-layer network, gradients propagate backward from the output layer to the input layer.

Loss functions measure how far the network's predictions are from the true values. Mean squared error is common for regression. Cross-entropy loss is used for classification. The optimizer updates weights using the gradients - stochastic gradient descent is simple, while Adam adds momentum and adaptive learning rates.

Vectorization is critical for performance. Instead of looping over examples, I compute operations on entire matrices at once. NumPy's broadcasting rules handle different shapes automatically. This makes Python code run fast because the heavy lifting happens in optimized C libraries.

I implemented feedforward networks for classification, convolutional neural networks (CNNs) for images, and recurrent neural networks (RNNs) for sequences. CNNs use convolutional layers that slide filters over the input, detecting features at different positions. RNNs maintain hidden state that carries information across time steps.

Training without GPU acceleration is slow, but it forces you to understand the computational cost of each operation. Every matrix multiplication, every activation function call, every gradient computation adds up. This understanding helps when using frameworks - you know what operations are expensive and which optimizations matter.
