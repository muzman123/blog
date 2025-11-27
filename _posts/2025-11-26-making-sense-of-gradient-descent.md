# Making Sense of Gradient Descent: A Learning Journey

I've been diving deep into neural networks, and gradient descent kept coming up as this fundamental concept. The textbook explanations made sense on paper, but I didn't *really* get it until I started sketching things out. Here's how I figured it out, the questions I had, and the "aha!" moments along the way.

Let me start with the breakthrough moment. I was stuck trying to understand how neural networks actually learn when I drew this simple sketch of a bowl with contour lines. This one drawing made everything click.

**The error surface is literally a bowl.**

Imagine you have a neuron with 2 weights (w₁, w₂). For any combination of these weights, you get error, a measure of how wrong your predictions are. If you plot this in 3D with weight 1 on the X-axis, weight 2 on the Y-axis, and error on the Z-axis, you get a bowl shape! The bottom of the bowl is where error = 0 (perfect weights). The sides of the bowl are where your weights give you a high error.

The whole idea of gradient descent is simple: you're a blind person trying to find the most efficient way down to the bottom of this bowl.

When you flatten the bowl into 2D and draw contour lines (like a topographic map), gradient descent moves **exactly perpendicular** to these contours.

Why? Because perpendicular is the direction of steepest change. Moving parallel to a contour wouldn't change your error at all. Instead, you'd just be walking around the bowl at the same height!

## How Do You Descend?

If you're blind and standing somewhere on this bowl, how do you find your way down efficiently? You feel the ground around your feet to figure out which direction slopes down the steepest, take a step in that direction, and repeat until you reach the bottom.

That's literally gradient descent. You evaluate your current position by calculating the current error, find the direction of steepest descent by calculating the gradient ∂E/∂w, take a step in that direction by updating weights (Δw = -ε∂E/∂w), and repeat. The "gradient" is just the direction that makes the error increase fastest. Since we want to *decrease* error, we go the opposite direction which is why there's a negative sign in the formula.

## Why Not Just Solve It?

When I first saw the error function E = ½Σ(tᵢ - yᵢ)², I thought: "Can't we just solve this mathematically?" For **linear neurons**, technically yes! It's just a system of equations. You could solve it directly.

**But linear neurons suck.** They can't learn complex patterns. Linear neurons can only draw straight lines to classify data, meanwhile real-life classification and pattern recognition may require all sorts of shapes and curves. That's why we use non-linear activation functions like sigmoid or ReLU.

And once you add non-linearity, you can't just "solve" it anymore. The error surface becomes complex and high-dimensional (like that 3D bowl) that you have to navigate step by step. Hence, gradient descent.

## The Three Ways to Descend (And My Confusion)

The textbook mentioned three different gradient descent methods. I thought: "Wait, do you use all three together?" **No.** You pick ONE. They're just different strategies for the same goal.

**Batch Gradient Descent** uses your entire dataset to calculate the error surface, then takes one step based on the average gradient from all examples. The problem? It can get stuck in flat regions (saddle points) that look like minima but aren't. It's also slow with huge datasets.

**Stochastic Gradient Descent (SGD)** uses ONE random example at a time. The error surface is now dynamic and changes with each example! The jittery path helps avoid saddle points, but one example isn't a good approximation of the true error surface.

**Minibatch Gradient Descent** is what everyone actually uses. You use a small random subset (like 32, 64, 128 examples) and update weights after each mini-batch. Best of both worlds; efficient AND escapes saddle points. This introduces a new hyperparameter though: batch size.

## The PyTorch Question That Bugged Me

Here's what really confused me. From using PyTorch earlier, i remember the optimizer i used to train a neural network was `SGD`, however my 'DataLoader' had minibatches which confused me. Turns out, the DataLoader is responsible for defining the KIND of Gradient Descent that takes place on the data.

```python
optimizer = torch.optim.SGD(model.parameters(), lr=0.01)

# Then you train with minibatches
for batch in dataloader:  # batch_size = 32
    optimizer.zero_grad()
    loss.backward()
    optimizer.step()  # Updates using this batch of 32
```

## Learning Rate:

Simply put, the learning rate is a hyperparameter that defines how big each step of the gradient descent will be. This is a parameter that can be tuned to make the learning process better or worse for your model.

I drew two different bowls to understand it. A steeper bowl where contours are close together means you're far from the minimum. A flatter bowl where contours are spread out means you're near the minimum.

With a small learning rate, you get safe, stable steps, but it could take forever to reach the bottom. With a large learning rate, you make fast progress when far from minimum, but you could overshoot and diverge when you're close!

The ideal approach? Start with a larger learning rate, then decrease it as you get closer to the minimum. This is called learning rate scheduling.

## The Key Takeaway

Gradient descent isn't magic. It's just this: you're in a bowl (the error surface), you want to reach the bottom (minimum error), you can only feel the slope locally (the gradient), so you take steps downhill (weight updates) and repeat until you're at the bottom (convergence).

The bowl metaphor made everything click for me. Once I could visualize it, the math stopped being abstract formulas and became geometric intuition.

---

*This post is part of my deep learning journey. I'm currently working through "Fundamentals of Deep Learning" and documenting my understanding as I go.